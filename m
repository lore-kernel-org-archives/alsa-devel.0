From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [Question about DPCM] dpcm_run_new_update races
	again xrun
Date: Mon, 03 Nov 2014 13:32:04 +0000
Message-ID: <1415021524.2471.16.camel@loki>
References: <B2A7C617B3AB7F44B7B44C7D374B431E38E5070E70@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B3823260488
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:32:09 +0100 (CET)
In-Reply-To: <B2A7C617B3AB7F44B7B44C7D374B431E38E5070E70@sc-vexch3.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, Wilbur Wang <wwang27@marvell.com>, Mark Brown <broonie@kernel.org>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-03 at 03:28 -0800, Qiao Zhou wrote:
> Hi Mark, Liam
> 
> I met one BE not-function issue when developing DPCM feature, and found
> dpcm_run_new_update is not protected well against xrun(interrupt context).
> Could you help to give some suggestions?
> 

I'm wondering if this would be better solved by improving the locking so
that an XRUN could not run at the same time as the runtime update. Both
functions are async, but are only protected by a mutex atm (like the
rest of PCM ops except trigger which is atomic). We maybe need to add a
spinlock to both runtime_update() and dpcm_fe_dai_trigger() 

Liam

> The scenario is like this, taking audio playback for example:
> 1, FE1 <-> BE1, working well for some time.
> 2, disconnect BE1 and connect BE2(FE1 <-> BE2)
> 3, during FE1 connecting BE2, FE1 is still streaming data normally. Then an
> under-run happens. Below are the code sequence.
>     
> soc_dpcm_runtime_update() {
>     ...
>     dpcm_connect_be() // connect FE1 & BE2
>     dpcm_run_new_update(fe, stream) {
>       fe->dpcm.runtime_update = SND_SOC_DPCM_UPDATE_BE
>       dpcm_run_update_startup(fe, stream) {
>         dpcm_be_dai_startup(fe, stream)
>     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
>    |    // under-run happens (interrupt context)                       |
>    |    snd_pcm_stop(substream) {                                      |
>    |        dpcm_fe_dai_trigger(STOP) {                                |
>    |            fe->dpcm.runtime_update = SND_SOC_DPCM_UPDATE_FE       |
>    |            // trigger stop FE1, BE2                               |
>    |            fe->dpcm.runtime_update = SND_SOC_DPCM_UPDATE_NO       |
>    |        }                                                          |
>    |    }                                                              |
>    |_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
>         dpcm_be_dai_hw_params(fe, stream)
>         dpcm_be_dai_prepare(fe, stream)
>         if(fe state == STOP)
>             return 0;
>         dpcm_be_dai_trigger(fe, ....)
>       fe->dpcm.runtime_update = SND_SOC_DPCM_UPDATE_NO
>     ...
>     }
> }
> 
> After xrun handler finishes, the FE runtime update staus is UPDATE_NO. Then
> the following dpcm_be_dai_hw_params & dpcm_be_dai_prepare skip related driver
> API excuting with this FE runtime status, and return 0 to end runtime-startup.
> 
> When user APP(ALSA lib/TinyALSA) detects xrun, usually it will do the substream
> prepare and write data again. Due to BE dai has not been ready for hw_params,
> the BE dai can't work properly after substream prepare and trigger start. After
> that system has no sound and can't be recovered, maybe due to FE1 doesn't know
> what's going on inside BE2.
> 
> The under-run is random, and under-run handler does what's necessary to be done,
> though trigger-stop a BE which has not been started yet is not good in my opinion.
> 
> I did an experiment to avoid be udpate checking in dpcm_be_dai_hw_params by
> Commenting out "if(!snd_soc_dpcm_be_can_update()}". This change is verified OK
> since APP will do the prepare & trigger start to resume the under-run. The patch
> is also attached. 
> 
> From current code, dpcm_be_dai_hw_params is only callded by fe_hw_params & this
> runtime startup. This be update checking might be redundant or unnecessary in
> current code context.
> 
> Could you help to give some suggestions? Please help to correct me if anything
> wrong. Thanks in advance.
> 
> ---
>  sound/soc/soc-pcm.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 002311a..dfeb1e7 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1697,10 +1697,6 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
>  		struct snd_pcm_substream *be_substream =
>  			snd_soc_dpcm_get_substream(be, stream);
>  
> -		/* is this op for this BE ? */
> -		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
> -			continue;
> -
>  		/* only allow hw_params() if no connected FEs are running */
>  		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
>  			continue;


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
