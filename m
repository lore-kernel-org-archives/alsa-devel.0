From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: hda: increment codec device refcount
 when it is added to the card
Date: Fri, 31 May 2019 08:43:53 -0700
Message-ID: <d62f5761b8fb4c156dc775fb0e0426c262d6bdcc.camel@linux.intel.com>
References: <20190530201828.2648-1-ranjani.sridharan@linux.intel.com>
 <684fe069-d2fb-f716-bd3e-67f0c7a52de0@linux.intel.com>
 <s5hftovtaq0.wl-tiwai@suse.de>
 <e8bdeb7b299a11932ec98df805045a2871c0f79d.camel@linux.intel.com>
 <s5hef4en4ct.wl-tiwai@suse.de>
 <0f75caffee97f7cec5a1bd31e9f3eb3ea1a12948.camel@linux.intel.com>
 <s5hr28esow9.wl-tiwai@suse.de> <s5hmuj2sno7.wl-tiwai@suse.de>
 <6e0653565e70e877974f92e94cf4ae49caee3e15.camel@linux.intel.com>
 <s5h5zpqskhw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56DCAF896E4
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 17:44:04 +0200 (CEST)
In-Reply-To: <s5h5zpqskhw.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> > Hi Takashi,
> > 
> > No, this actually comes at the second step in the case of SOF (ie
> > after
> > the machine driver is unregistered).
> >  
> > Actually, I just found out what's causing the issue. It is the call
> > to
> > snd_hda_codec_dev_free() which calls put_device() when
> > snd_card_free()
> > is invoked. So, adding a get_device() in snd_hda_codec_device_new()
> > would make the refcount balanced. 
> > 
> > On the other hand, removing the put_device() in
> > snd_hda_codec_dev_free() would also address the problem. I'm not
> > sure
> > which would be the preferred route.
> 
> The latter one, I'd say.
> 
> Actually the difference between ASoC and the legacy HDA bus is who
> releases the device object.  For HDA legacy bus, it's supposed to be
> done via snd_device_free() chain, while ASoC bus releases explicitly
> as shown in my previous post.
> 
> So, if any, I'd paper over it like below.
OK, makes sense. Let me send a V2 with the change. 

Also, should I also look into adding the change to make hdac_hdmi codec
card managed as well?

Thanks,
Ranjani

> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -840,7 +840,12 @@ static int snd_hda_codec_dev_free(struct
> snd_device *device)
>  	if (codec->core.type == HDA_DEV_LEGACY)
>  		snd_hdac_device_unregister(&codec->core);
>  	codec_display_power(codec, false);
> -	put_device(hda_codec_dev(codec));
> +	/*
> +	 * again, ASoC HD-audio bus manages differently; it's released
> in
> +	 * snd_hdac_ext_bus_device_remove() explicitly
> +	 */
> +	if (codec->core.type == HDA_DEV_LEGACY)
> +		put_device(hda_codec_dev(codec));
>  	return 0;
>  }
>  
