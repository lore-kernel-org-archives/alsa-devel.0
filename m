From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume
	trigger
Date: Tue, 1 Aug 2017 09:00:06 +0530
Message-ID: <20170801033006.GL3053@localhost>
References: <20170731104734.5776-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD3C266B02
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 05:27:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170731104734.5776-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "U . Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 31, 2017 at 06:47:34PM +0800, Cheng-Yi Chiang wrote:
> From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
> 
> Reset the hw_ptr before queuing the restore_stream_context
> work to eradicate a nasty white audio noise on resume.

Liam, Jie? This on legacy BYT driver..

> 
> Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
> Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  sound/soc/intel/baytrail/sst-baytrail-pcm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> index 4765ad474544..e0db7070cd42 100644
> --- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> +++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> @@ -187,8 +187,10 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  		sst_byt_stream_start(byt, pcm_data->stream, 0);
>  		break;
>  	case SNDRV_PCM_TRIGGER_RESUME:
> -		if (pdata->restore_stream == true)
> +		if (pdata->restore_stream == true) {
> +			pcm_data->hw_ptr = 0;
>  			schedule_work(&pcm_data->work);
> +		}
>  		else
>  			sst_byt_stream_resume(byt, pcm_data->stream);
>  		break;
> -- 
> 2.12.2
> 

-- 
~Vinod
