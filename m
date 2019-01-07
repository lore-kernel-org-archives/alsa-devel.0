From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
 suspend/resume
Date: Mon, 7 Jan 2019 10:58:16 -0600
Message-ID: <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E16A3266A89
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 17:58:19 +0100 (CET)
In-Reply-To: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: libin.yang@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


On 1/6/19 8:22 PM, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
>
> hdmi_codec_prepare() will trigger hdmi runtime resume, which will set
> the bitmask of hdev->addr. And skl_suspend() will clear the bitmask of
> HDA_CODEC_IDX_CONTROLLER. HDMI codec idx is not the same as
> HDA_CODEC_IDX_CONTROLLER, which means i915 power will not be released
> when suspend.
>
> On the other hand, hdmi_codec_prepare() don't need to call
> pm_runtime_get_sync() to wake up the audio subsystem (HDMI auido)
> for setting the codec registers. Turning display power on with
> snd_hdac_display_power() is enough.
>
> Let's use S3 without playback as an example:
> hdmi_codec_prepare() invokes the runtime resume of codec =>
>    snd_hdac_display_power(bus, hdev->addr, true)
> skl runtime resume
> skl_suspend() =>
>    snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
>
> THis means hdev->addr will never release the display power when
> suspend.
>
> The new sequence will be:
> hdmi_codec_prepare() =>
>    snd_hdac_display_power(bus, hdev->addr, true)
>    snd_hdac_display_power(bus, hdev->addr, false)
> skl runtime resume
> skl suspned

I for one find this RFC difficult to follow. The documentation of "Power 
management sequences" seems obsolete after Takashi's changes, you may 
want to start with an update of the documentation which might help point 
out what is broken in the sequences. I also don't see the point in 
trying to bypass the runtime_pm code in codec_prepare and 
codec_complete. if we have the display on/off sequence only in 
probe/remove and suspend/resume it makes it easy to track states, and I 
wonder if it makes sense anyways to be in suspend with the display on or 
vice-versa in D0 with the display off. Simple state machines always win.

>
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>   sound/soc/codecs/hdac_hdmi.c  | 6 ++++--
>   sound/soc/intel/skylake/skl.c | 7 -------
>   2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 3ab2949..782b323 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1895,7 +1895,7 @@ static int hdmi_codec_prepare(struct device *dev)
>   {
>   	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>   
> -	pm_runtime_get_sync(&hdev->dev);
> +	snd_hdac_display_power(hdev->bus, hdev->addr, true);
>   
>   	/*
>   	 * Power down afg.
> @@ -1906,6 +1906,7 @@ static int hdmi_codec_prepare(struct device *dev)
>   	 */
>   	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
>   							AC_PWRST_D3);
> +	snd_hdac_display_power(hdev->bus, hdev->addr, false);
>   
>   	return 0;
>   }
> @@ -1915,6 +1916,7 @@ static void hdmi_codec_complete(struct device *dev)
>   	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>   	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>   
> +	snd_hdac_display_power(hdev->bus, hdev->addr, true);
>   	/* Power up afg */
>   	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
>   							AC_PWRST_D0);
> @@ -1930,7 +1932,7 @@ static void hdmi_codec_complete(struct device *dev)
>   	 */
>   	hdac_hdmi_present_sense_all_pins(hdev, hdmi, false);
>   
> -	pm_runtime_put_sync(&hdev->dev);
> +	snd_hdac_display_power(hdev->bus, hdev->addr, false);
>   }
>   #else
>   #define hdmi_codec_prepare NULL
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 60c9483..89f4d66 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -336,9 +336,6 @@ static int skl_suspend(struct device *dev)
>   		skl->skl_sst->fw_loaded = false;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
> -		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
> -
>   	return 0;
>   }
>   
> @@ -350,10 +347,6 @@ static int skl_resume(struct device *dev)
>   	struct hdac_ext_link *hlink = NULL;
>   	int ret;
>   
> -	/* Turned OFF in HDMI codec driver after codec reconfiguration */
> -	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
> -		snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
> -
>   	/*
>   	 * resume only when we are not in suspend active, otherwise need to
>   	 * restore the device
