From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: codec: hdac_hdmi add device_link
 to card device
Date: Fri, 19 Apr 2019 10:17:18 -0500
Message-ID: <a399619c-bb78-26c2-8fc4-7f99df4a6ea6@linux.intel.com>
References: <1555161492-9143-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5143F896E2
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 17:17:32 +0200 (CEST)
In-Reply-To: <1555161492-9143-1-git-send-email-libin.yang@intel.com>
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

On 4/13/19 8:18 AM, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> In resume from S3, HDAC HDMI codec driver dapm event callback may be
> operated before HDMI codec driver turns on the display audio power
> domain because of the contest between display driver and hdmi codec driver.
> 
> This patch adds the device_link between soc card device (consumer) and
> hdmi codec device (supplier) to make sure the sequence is always correct.
> 
> Signed-off-by: Libin Yang <libin.yang@intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Libin, please follow-up on the question from Takashi on CC:ing to 
stable. I would guess this probably would be needed for 4.14+, older 
stuff is unlikely to work anyways due to other issues.

> ---
>   sound/soc/codecs/hdac_hdmi.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 5eeb0fe..4de1fbf 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1855,6 +1855,17 @@ static int hdmi_codec_probe(struct snd_soc_component *component)
>   	hdmi->card = dapm->card->snd_card;
>   
>   	/*
> +	 * Setup a device_link between card device and HDMI codec device.
> +	 * The card device is the consumer and the HDMI codec device is
> +	 * the supplier. With this setting, we can make sure that the audio
> +	 * domain in display power will be always turned on before operating
> +	 * on the HDMI audio codec registers.
> +	 * Let's use the flag DL_FLAG_AUTOREMOVE_CONSUMER. This can make
> +	 * sure the device link is freed when the machine driver is removed.
> +	 */
> +	device_link_add(component->card->dev, &hdev->dev, DL_FLAG_RPM_ACTIVE |
> +			DL_FLAG_AUTOREMOVE_CONSUMER);
> +	/*
>   	 * hdac_device core already sets the state to active and calls
>   	 * get_noresume. So enable runtime and set the device to suspend.
>   	 */
> 
