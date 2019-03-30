From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: hdmi: add device PM dependency
Date: Fri, 29 Mar 2019 21:32:56 -0400
Message-ID: <044dca38-efbf-0ef9-8ada-327e959a7aee@linux.intel.com>
References: <1553836982-10653-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D2BFF80766
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2019 02:36:20 +0100 (CET)
In-Reply-To: <1553836982-10653-1-git-send-email-libin.yang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: libin.yang@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 3/29/19 1:23 AM, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> HDMI audio codec register operation depends on the display audio power
> domain. The hdmi audio codec dapm event callback must be called after
> display audio power is turned on.
> 
> Add hdac_hdmi_device_link_add() in HDMI audio codec driver. The customer
> audio driver can call the function to set the audio power dependency.

Can you clarify what the 'customer audio driver(s)' are, and in the case 
where you meant the cAVS/SST driver all a patch that makes use of this 
new routine?

Also the patch subject should be ASoC: hdac_hdmi: ...



> 
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>   sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
>   sound/soc/codecs/hdac_hdmi.h |  6 ++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 5eeb0fe..c991407 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1792,6 +1792,18 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
>   }
>   EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
>   
> +struct device_link *
> +hdac_hdmi_device_link_add(struct device *consumer,
> +			  struct snd_soc_component *component,
> +			  u32 flags)
> +{
> +	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
> +	struct hdac_device *hdev = hdmi->hdev;
> +
> +	return device_link_add(consumer, &hdev->dev, flags);
> +}
> +EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_add);
> +
>   static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
>   			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
>   {
> diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
> index 4fa2fc9..9239c6b 100644
> --- a/sound/soc/codecs/hdac_hdmi.h
> +++ b/sound/soc/codecs/hdac_hdmi.h
> @@ -7,4 +7,10 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
>   
>   int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
>   			struct snd_soc_dapm_context *dapm);
> +
> +struct device_link *
> +hdac_hdmi_device_link_add(struct device *consumer,
> +			  struct snd_soc_component *component,
> +			  u32 flags);
> +
>   #endif /* __HDAC_HDMI_H__ */
> 
