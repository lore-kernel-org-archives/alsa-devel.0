From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 17/53] ALSA: x86: Drop unused hw_silence
 field
Date: Thu, 2 Feb 2017 13:11:10 -0600
Message-ID: <110ce179-24f5-9898-3d26-44e4c559e55a@linux.intel.com>
References: <20170202170307.24484-1-tiwai@suse.de>
 <20170202170307.24484-19-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CB86265AF3
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 20:11:12 +0100 (CET)
In-Reply-To: <20170202170307.24484-19-tiwai@suse.de>
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

On 2/2/17 11:02 AM, Takashi Iwai wrote:
> It's nowhere used.  Let's drop it.

That's one of the things I wanted to add. When you start playback there 
is a 1-2s period where the receiver is still looking at the data to 
figure out if it's PCM or compressed, and you lose those 1-2s of audio. 
The hw silence mode is a way to keep the link active.
But I guess we can remove first and re-add later so no objections.

>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/x86/intel_hdmi_audio.c | 1 -
>  sound/x86/intel_hdmi_audio.h | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> index e08691110a48..efc56544af17 100644
> --- a/sound/x86/intel_hdmi_audio.c
> +++ b/sound/x86/intel_hdmi_audio.c
> @@ -1696,7 +1696,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
>  	pm_runtime_set_active(intelhaddata->dev);
>  	pm_runtime_enable(intelhaddata->dev);
>
> -	intelhaddata->hw_silence = 1;
>  	*had_ret = intelhaddata;
>
>  	return 0;
> diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
> index da0a927d37fe..32a2fb766e47 100644
> --- a/sound/x86/intel_hdmi_audio.h
> +++ b/sound/x86/intel_hdmi_audio.h
> @@ -118,7 +118,6 @@ struct had_pvt_data {
>   * @kctl: holds kctl ptrs used for channel map
>   * @chmap: holds channel map info
>   * @audio_reg_base: hdmi audio register base offset
> - * @hw_silence: flag indicates SoC support for HW silence/Keep alive
>   * @underrun_count: PCM stream underrun counter
>   */
>  struct snd_intelhad {
> @@ -142,7 +141,6 @@ struct snd_intelhad {
>  	struct snd_pcm_chmap *chmap;
>  	unsigned int	*audio_reg_base;
>  	unsigned int	audio_cfg_offset;
> -	bool		hw_silence;
>  	int underrun_count;
>  };
>
>
