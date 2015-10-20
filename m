From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: dapm: Add kcontrol support for
 PGAs
Date: Tue, 20 Oct 2015 17:58:46 +0200
Message-ID: <562664B6.7090807@metafoo.de>
References: <1445355532-28310-1-git-send-email-vinod.koul@intel.com>
 <1445355532-28310-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id A8CE02665D4
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:58:48 +0200 (CEST)
In-Reply-To: <1445355532-28310-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Mythri P K <mythri.p.k@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/20/2015 05:38 PM, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> For DSPs we can define processing blocks as DAPM PGA widgets.
> Some of these proceesing blocks can be configured by usermode
> like EQ etc. So we need to add support of kcontrol for PGA
> widgets.
> 
> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> Signed-off-by: Mythri P K <mythri.p.k@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

This looks ok ...

> ---
>  sound/soc/soc-dapm.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index ff8bda471b25..746800380eb7 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -779,8 +779,8 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
>   * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
>   * create it. Either way, add the widget into the control's widget list
>   */
> -static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
> -	int kci)
> +static int dapm_create_or_share_mixmuxpga_kcontrol(

... but maybe just call it dapm_create_or_share_kcontrol()

> +		struct snd_soc_dapm_widget *w, int kci)
>  {
>  	struct snd_soc_dapm_context *dapm = w->dapm;
>  	struct snd_card *card = dapm->card->snd_card;
> @@ -822,6 +822,10 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
>  				wname_in_long_name = true;
>  				kcname_in_long_name = false;
>  				break;
> +			case snd_soc_dapm_pga:

This should have the same behavior as mixers and switches, just add the case
there instead having a different path.

> +				wname_in_long_name = true;
> +				kcname_in_long_name = true;
> +				break;
>  			default:
>  				return -EINVAL;
