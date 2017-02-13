From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/4] ALSA: x86: Enable keep-link feature
Date: Mon, 13 Feb 2017 11:05:37 -0600
Message-ID: <0a093d50-6be3-2282-5d3d-015557b8a8f4@linux.intel.com>
References: <20170213143919.19543-1-tiwai@suse.de>
 <20170213143919.19543-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 053112669C8
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 18:05:40 +0100 (CET)
In-Reply-To: <20170213143919.19543-5-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/13/17 8:39 AM, Takashi Iwai wrote:
> This patch enables the "keep-link" feature experimentally.  It's a
> feature where the device keeps the link and sending the silent output
> even after the PCM device is closed.  Then the receiver will be
> resumed quickly once when a PCM is opened and a stream is sent again.
>
> The stream link is turned off when the device goes to the auto
> suspend, and it's set to two seconds after the PCM close.  This
> timeout value can be changed dynamically in a standard way via sysfs
> like other drivers.  For example, to make it 10 seconds, run like:
>
>   echo 10000 > /sys/bus/platform/devices/hdmi-lpe-audio/power/autosuspend_delay_ms

Keeping the link active has really a limited impact on power since the 
source provides power to the sink and will also drive the display. For 
people who rely on HDMI for system sounds/beeps/notifications it'd make 
more sense to make that value something like 15-30mn (i.e. aligned with 
display screen saver timeout), otherwise for every sound the receiver 
will have to spend 1-2 seconds figuring out if the data is PCM or 
compressed.
PulseAudio has a 5s timeout on idle, 2s seems really low to me.

>
> This new keep-link feature itself is controlled via a new module
> option, keep_link.  You can turn it on/off, again, via sysfs like:
>
>   echo 0 > /sys/module/snd_hdmi_lpe_audio/parameters/keep_link
>
> As default, the feature is turned on.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/x86/intel_hdmi_audio.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> index 95b07a260d54..506cff306b5c 100644
> --- a/sound/x86/intel_hdmi_audio.c
> +++ b/sound/x86/intel_hdmi_audio.c
> @@ -52,6 +52,10 @@ module_param_named(id, hdmi_card_id, charp, 0444);
>  MODULE_PARM_DESC(id,
>  		"ID string for INTEL Intel HDMI Audio controller.");
>
> +static bool keep_link = true;
> +module_param(keep_link, bool, 0644);
> +MODULE_PARM_DESC(keep_link, "Keep link on after the stream is closed.");
> +
>  /*
>   * ELD SA bits in the CEA Speaker Allocation data block
>   */
> @@ -217,8 +221,12 @@ static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
>  static void had_enable_audio(struct snd_intelhad *intelhaddata,
>  			     bool enable)
>  {
> +	if (intelhaddata->aud_config.regx.aud_en == enable)
> +		return;
> +
>  	/* update the cached value */
>  	intelhaddata->aud_config.regx.aud_en = enable;
> +	intelhaddata->aud_config.regx.underrun = keep_link;
>  	had_write_register(intelhaddata, AUD_CONFIG,
>  			   intelhaddata->aud_config.regval);
>  }
> @@ -901,6 +909,21 @@ static void had_init_ringbuf(struct snd_pcm_substream *substream,
>  	intelhaddata->bd_head = 0; /* reset at head again before starting */
>  }
>
> +/* Set up the silent output after PCM close */
> +static void had_keep_silent(struct snd_intelhad *intelhaddata)
> +{
> +	int i;
> +
> +	if (!(keep_link && intelhaddata->connected &&
> +	      intelhaddata->aud_config.regval))
> +		return;
> +
> +	for (i = 0; i < HAD_NUM_OF_RING_BUFS; i++)
> +		had_invalidate_bd(intelhaddata, i);
> +	intelhaddata->need_reset = true; /* reset at next */
> +	had_enable_audio(intelhaddata, true);
> +}
> +
>  /* process a bd, advance to the next */
>  static void had_advance_ringbuf(struct snd_pcm_substream *substream,
>  				struct snd_intelhad *intelhaddata)
> @@ -1007,6 +1030,9 @@ static void had_do_reset(struct snd_intelhad *intelhaddata)
>  	if (!intelhaddata->need_reset)
>  		return;
>
> +	/* disable the silent output */
> +	had_enable_audio(intelhaddata, false);
> +
>  	/* Reset buffer pointers */
>  	had_reset_audio(intelhaddata);
>  	wait_clear_underrun_bit(intelhaddata);
> @@ -1101,6 +1127,8 @@ static int had_pcm_close(struct snd_pcm_substream *substream)
>  	}
>  	spin_unlock_irq(&intelhaddata->had_spinlock);
>
> +	had_keep_silent(intelhaddata);
> +
>  	pm_runtime_mark_last_busy(intelhaddata->dev);
>  	pm_runtime_put_autosuspend(intelhaddata->dev);
>  	return 0;
> @@ -1626,6 +1654,9 @@ static int hdmi_lpe_audio_runtime_suspend(struct device *dev)
>  		had_substream_put(ctx);
>  	}
>
> +	/* disable the silent output */
> +	had_enable_audio(ctx, false);
> +
>  	return 0;
>  }
>
> @@ -1642,6 +1673,9 @@ static int __maybe_unused hdmi_lpe_audio_suspend(struct device *dev)
>
>  static int hdmi_lpe_audio_runtime_resume(struct device *dev)
>  {
> +	struct snd_intelhad *ctx = dev_get_drvdata(dev);
> +
> +	had_keep_silent(ctx);
>  	pm_runtime_mark_last_busy(dev);
>  	return 0;
>  }
> @@ -1799,6 +1833,10 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
>  	pdata->notify_pending = false;
>  	spin_unlock_irq(&pdata->lpe_audio_slock);
>
> +	/* set a relatively long autosuspend delay (2 seconds) for making
> +	 * keep_link feature working reasonably
> +	 */
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_mark_last_busy(&pdev->dev);
>
>
