From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/3] ALSA: hda - add flags and routines
 to get devices selection info for DP1.2 MST
Date: Fri, 23 Aug 2013 15:24:54 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801321BDD@SHSMSX101.ccr.corp.intel.com>
References: <1377233796-10095-1-git-send-email-mengdong.lin@intel.com>
 <s5hli3siomt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EBDD26559C
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 17:24:58 +0200 (CEST)
In-Reply-To: <s5hli3siomt.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, August 23, 2013 8:22 PM
> > +/**
> > + * snd_hda_get_devices - copy device list without cache
> > + * @codec: the HDA codec
> > + * @nid: NID of the pin to parse
> > + * @dev_list: device list array
> > + * @max_devices: max. number of devices to store
> > + *
> > + * Copy the device list. This info is dynamic and so not cached.
> > + * Currently called only from hda_proc.c, so not exported.
> > + */
> > +int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
> > +			union hda_devlist_entry *dev_list, int max_devices) {
> > +	unsigned int parm;
> > +	int i, dev_len, devices;
> > +
> > +	parm = get_num_devices(codec, nid);
> > +	if (!parm)	/* not multi-stream capable */
> > +		return 0;
> > +
> > +	dev_len = parm + 1;
> 
> Check dev_len with max_devices here.

Will fix it. Sorry, I forgot to check.

> 
> > +	devices = 0;
> > +
> > +	while (devices < dev_len) {
> > +		parm = snd_hda_codec_read(codec, nid, 0,
> > +					  AC_VERB_GET_DEVICE_LIST, devices);
> > +		if (parm == -1 && codec->bus->rirb_error)
> > +			break;
> > +
> > +		for (i = 0; i < 8; i++) {
> > +			dev_list[devices].value = parm & 0x7;
> > +			parm >>= 4;
> > +			devices++;
> > +			if (devices >= dev_len)
> > +				break;
> > +		}
> > +	}
> > +	return devices;
> > +}
> > +
> >  /**
> >   * snd_hda_queue_unsol_event - add an unsolicited event to queue
> >   * @bus: the BUS
> > diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> > index 701c2e0..736b55a 100644
> > --- a/sound/pci/hda/hda_codec.h
> > +++ b/sound/pci/hda/hda_codec.h
> > @@ -94,6 +94,8 @@ enum {
> >  #define AC_VERB_GET_HDMI_DIP_XMIT		0x0f32
> >  #define AC_VERB_GET_HDMI_CP_CTRL		0x0f33
> >  #define AC_VERB_GET_HDMI_CHAN_SLOT		0x0f34
> > +#define AC_VERB_GET_DEVICE_SEL			0xf35
> > +#define AC_VERB_GET_DEVICE_LIST			0xf36
> >
> >  /*
> >   * SET verbs
> > @@ -133,6 +135,7 @@ enum {
> >  #define AC_VERB_SET_HDMI_DIP_XMIT		0x732
> >  #define AC_VERB_SET_HDMI_CP_CTRL		0x733
> >  #define AC_VERB_SET_HDMI_CHAN_SLOT		0x734
> > +#define AC_VERB_SET_DEVICE_SEL			0x735
> >
> >  /*
> >   * Parameter IDs
> > @@ -154,6 +157,7 @@ enum {
> >  #define AC_PAR_GPIO_CAP			0x11
> >  #define AC_PAR_AMP_OUT_CAP		0x12
> >  #define AC_PAR_VOL_KNB_CAP		0x13
> > +#define AC_PAR_DEVLIST_LEN		0x15
> >  #define AC_PAR_HDMI_LPCM_CAP		0x20
> >
> >  /*
> > @@ -795,6 +799,19 @@ struct hda_pcm {
> >  	bool own_chmap;		/* codec driver provides own channel maps */
> >  };
> >
> > +/* display pin's device list entry */ union  hda_devlist_entry {
> > +	unsigned int value;
> > +	struct  {
> > +		unsigned int present_detect:1;
> > +		unsigned int eld_valid:1;
> > +		unsigned int inactive:1;
> > +	} bits;
> > +};
> 
> The bit fields are not really portable.
> Please use the explicit bit operation instead.

You're right. It's compiler-dependent. I'll revise and verify the patch next Monday.

Thanks for the review!
Mengdong
