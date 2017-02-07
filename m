From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/6] ALSA: x86: Support S16 format
Date: Tue, 7 Feb 2017 10:48:59 -0600
Message-ID: <566784cb-0fb9-fba5-337a-d7ed8618631a@linux.intel.com>
References: <20170207131122.6345-1-tiwai@suse.de>
 <20170207131122.6345-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 71293266569
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 17:49:10 +0100 (CET)
In-Reply-To: <20170207131122.6345-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org



On 02/07/2017 07:11 AM, Takashi Iwai wrote:
> Now we support S16 PCM format in addition.  For this, we need to set
> packet_mode=1 in AUD_CONFIG register.
While I think of it, there is a hidden benefit here. If this mode works, 
then most likely we can push IEC61937 data formatted as S16 PCM 
directly. For passthrough we needed to left-shit the data, if this mode 
does what it says it should make some people happy. The U,C,V should not 
be added in the data stream however (as done by the hdmi: plugin), there 
is a separate register to program then.

>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/x86/intel_hdmi_audio.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> index a0401476cd93..5697552f489a 100644
> --- a/sound/x86/intel_hdmi_audio.c
> +++ b/sound/x86/intel_hdmi_audio.c
> @@ -136,7 +136,8 @@ static const struct snd_pcm_hardware had_pcm_hardware = {
>   		SNDRV_PCM_INFO_MMAP|
>   		SNDRV_PCM_INFO_MMAP_VALID |
>   		SNDRV_PCM_INFO_BATCH),
> -	.formats = (SNDRV_PCM_FMTBIT_S24_LE |
> +	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
> +		    SNDRV_PCM_FMTBIT_S24_LE |
>   		    SNDRV_PCM_FMTBIT_S32_LE),
>   	.rates = SNDRV_PCM_RATE_32000 |
>   		SNDRV_PCM_RATE_44100 |
> @@ -308,12 +309,10 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
>   			   AUD_CH_STATUS_0, ch_stat0.regval);
>   
>   	switch (substream->runtime->format) {
> -#if 0 /* FIXME: not supported yet */
>   	case SNDRV_PCM_FORMAT_S16_LE:
>   		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_20;
>   		ch_stat1.regx.wrd_len = SMPL_WIDTH_16BITS;
>   		break;
> -#endif
>   	case SNDRV_PCM_FORMAT_S24_LE:
>   	case SNDRV_PCM_FORMAT_S32_LE:
>   		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_24;
> @@ -354,6 +353,9 @@ static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
>   	else
>   		cfg_val.regx.layout = LAYOUT1;
>   
> +	if (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE)
> +		cfg_val.regx.packet_mode = 1;
> +
>   	if (substream->runtime->format == SNDRV_PCM_FORMAT_S32_LE)
>   		cfg_val.regx.left_align = 1;
>   
