From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: codec: hdac_hdmi add device_link to
 card device
Date: Thu, 11 Apr 2019 22:00:20 -0500
Message-ID: <8c33f4c2-39ce-a620-b540-c933e4157b83@linux.intel.com>
References: <1555036832-2850-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CA5DF89616
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 05:00:17 +0200 (CEST)
In-Reply-To: <1555036832-2850-1-git-send-email-libin.yang@intel.com>
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

On 4/11/19 9:40 PM, libin.yang@intel.com wrote:
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
> ---
>   sound/soc/codecs/hdac_hdmi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 5eeb0fe..8bb883e 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1855,6 +1855,15 @@ static int hdmi_codec_probe(struct snd_soc_component *component)
>   	hdmi->card = dapm->card->snd_card;
>   
>   	/*
> +	 * Setup a device_link between card device and HDMI codec device.
> +	 * The card device is the consumer and the HDMI codec device is
> +	 * the supplier. With this setting, we can make sure that the audio
> +	 * domain in display power will be always turned on before operating
> +	 * on the HDMI audio codec registers.
> +	 */
> +	device_link_add(component->card->dev, &hdev->dev, DL_FLAG_RPM_ACTIVE |
> +			DL_FLAG_AUTOREMOVE_CONSUMER);

Should device_link_free() be added to hdmi_codec_remove then?
Thanks!
