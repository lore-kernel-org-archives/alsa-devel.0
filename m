From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v4 22/22] sound/usb: Use Media Controller API to share
 media resources
Date: Wed, 2 Mar 2016 09:59:43 -0700
Message-ID: <56D71BFF.2020104@osg.samsung.com>
References: <1456725482-4849-1-git-send-email-shuahkh@osg.samsung.com>
 <2166908.Ghbrb0Anbr@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <2166908.Ghbrb0Anbr@avalon>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: mchehab@osg.samsung.com, tiwai@suse.com, clemens@ladisch.de, hans.verkuil@cisco.com, sakari.ailus@linux.intel.com, javier@osg.samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, arnd@arndb.de, dan.carpenter@oracle.com, tvboxspy@gmail.com, crope@iki.fi, ruchandani.tina@gmail.com, corbet@lwn.net, chehabrafael@gmail.com, k.kozlowski@samsung.com, stefanr@s5r6.in-berlin.de, inki.dae@samsung.com, jh1009.sung@samsung.com, elfring@users.sourceforge.net, prabhakar.csengg@gmail.com, sw0312.kim@samsung.com, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, pierre-louis.bossart@linux.intel.com, ricard.wanderlof@axis.com, julian@jusst.de, takamichiho@gmail.com, dominic.sacre@gmx.de, misterpib@gmail.com, daniel@zonque.org, gtmkramer@xs4all.nl, normalperson@yhbt.net, joe@oampo.co.uk, linuxbugs@vittgam.netjo
List-Id: alsa-devel@alsa-project.org

On 03/01/2016 12:53 PM, Laurent Pinchart wrote:
> Hi Shuah,
> 
> Thank you for the patch.
> 

snip

>> +struct media_mixer_ctl {
>> +	struct media_device *media_dev;
>> +	struct media_entity media_entity;
>> +	struct media_intf_devnode *intf_devnode;
>> +	struct media_link *intf_link;
>> +	struct media_pad media_pad[MEDIA_MIXER_PAD_MAX];
>> +	struct media_pipeline media_pipe;
>> +};
>> +
>> +int media_device_create(struct snd_usb_audio *chip,
>> +			struct usb_interface *iface);
>> +void media_device_delete(struct snd_usb_audio *chip);
>> +int media_stream_init(struct snd_usb_substream *subs, struct snd_pcm *pcm,
>> +			int stream);
>> +void media_stream_delete(struct snd_usb_substream *subs);
>> +int media_start_pipeline(struct snd_usb_substream *subs);
>> +void media_stop_pipeline(struct snd_usb_substream *subs);
> 
> As this API is sound-specific, would it make sense to call the functions 
> media_snd_* or something similar ? The names are very generic now, and could 
> clash with core media code.

Thanks. I renamed the interfaces. Please see patch v5
that was sent out a little while ago.

-- Shuah

> 
>> +#else
>> +static inline int media_device_create(struct snd_usb_audio *chip,
>> +				      struct usb_interface *iface)
>> +						{ return 0; }
>> +static inline void media_device_delete(struct snd_usb_audio *chip) { }
>> +static inline int media_stream_init(struct snd_usb_substream *subs,
>> +					struct snd_pcm *pcm, int stream)
>> +						{ return 0; }
>> +static inline void media_stream_delete(struct snd_usb_substream *subs) { }
>> +static inline int media_start_pipeline(struct snd_usb_substream *subs)
>> +					{ return 0; }
>> +static inline void media_stop_pipeline(struct snd_usb_substream *subs) { }
>> +#endif
>> +#endif /* __MEDIA_H */
> 


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
