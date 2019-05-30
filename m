From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: hda: increment codec device refcount
 when it is added to the card
Date: Thu, 30 May 2019 16:00:10 -0500
Message-ID: <684fe069-d2fb-f716-bd3e-67f0c7a52de0@linux.intel.com>
References: <20190530201828.2648-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 183FAF8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 23:00:15 +0200 (CEST)
In-Reply-To: <20190530201828.2648-1-ranjani.sridharan@linux.intel.com>
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
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/30/19 3:18 PM, Ranjani Sridharan wrote:
> Calling snd_device_new() makes the codec devices managed by the card.
> So, when the card is removed, the refcount for the codec
> device is decremented and results in the codec device's kobject
> being cleaned up if the refcount is 0. But, this leads to a NULL
> pointer exception while attempting to remove the symlinks when the
> codec driver is released later on. Therefore, increment the codec
> device's refcount before adding it to the card to prevent this.

Ranjani, you should add a bit of context for the rest of the list...

This patch suggest a solution to a set of sightings occurring when 
removing/adding modules in a loop, and the current analysis points to a 
difference between the way the HDMI and HDaudio codecs are handled.

https://github.com/thesofproject/linux/issues/981
https://github.com/thesofproject/linux/issues/966
https://github.com/thesofproject/linux/pull/988

Since it's not SOF specific it's better to get feedback directly from 
the large ALSA community/maintainers. We probably want to focus on the 
platform-specific/vendor-specific stuff on GitHub and use the mailing 
list for such framework-level changes.

> 
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>   sound/pci/hda/hda_codec.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index b20eb7fc83eb..0d5d95b07e19 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -985,6 +985,14 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
>   		codec->core.subsystem_id, codec->core.revision_id);
>   	snd_component_add(card, component);
>   
> +	/*
> +	 * snd_device_new() makes the codec device managed by the card.
> +	 * When the card is removed, the device reference count is
> +	 * decremented. Therefore, increment it here to prevent removing
> +	 * the codec device's kobject when the card is removed.
> +	 */
> +	get_device(hda_codec_dev(codec));
> +
>   	err = snd_device_new(card, SNDRV_DEV_CODEC, codec, &dev_ops);
>   	if (err < 0)
>   		goto error;
> 
