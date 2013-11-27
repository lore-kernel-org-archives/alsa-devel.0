From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - suspend codecs in parallel
Date: Wed, 27 Nov 2013 04:14:58 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141C930@SHSMSX101.ccr.corp.intel.com>
References: <66cb89707dd2109e0cfa2f80561eb25f7bbd686d.1385350212.git.mengdong.lin@intel.com>
 <80986b9a2c4a68e7d537a3c3010cdecda1f8f9fc.1385446616.git.mengdong.lin@intel.com>
 <s5hiovf8dim.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 60FA12619F7
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 05:15:04 +0100 (CET)
In-Reply-To: <s5hiovf8dim.wl%tiwai@suse.de>
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
> Sent: Tuesday, November 26, 2013 10:05 PM

> > +#ifdef CONFIG_PM
> > +	bus->pm_wq = create_workqueue("hda-pm-workq");
> 
> Better to use a unique name, e.g. with a card number suffix.

Ok.

> > +	if (!bus->pm_wq) {
> > +		snd_printk(KERN_ERR "cannot create PM workqueue\n");
> > +		snd_hda_bus_free(bus);
> > +		return -ENOMEM;
> > +	}
> > +	workqueue_set_max_active(bus->pm_wq, HDA_MAX_NUM_CODECS);
> 
> As mentioned in another post, this can be set dynamically, e.g. at
> snd_hda_suspend() with bus->num_codecs.

Can I move this to snd_hda_codec_new() like this? 
	list_add_tail(&codec->list, &bus->codec_list);
   +bus->num_codecs++;
   +workqueue_set_max_active(bus->pm_wq, bus->num_codecs);

The codec number does not change after initialization, and usually 1 or 2 codecs are connected to the bus.
 
> >  	err = snd_device_new(card, SNDRV_DEV_BUS, bus, &dev_ops);
> >  	if (err < 0) {
> >  		snd_hda_bus_free(bus);
> > @@ -1434,6 +1451,8 @@ int snd_hda_codec_new(struct hda_bus *bus,
> >  	 */
> >  	hda_keep_power_on(codec);
> >  	hda_call_pm_notify(bus, true);
> > +
> > +	INIT_WORK(&codec->pm_work, hda_pm_work);
> 
> Better to put this before hda_keep_power_on() call.

Ok.

> >  	if (codec->bus->modelname) {
> > @@ -1445,6 +1464,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
> >  	}
> >
> >  	list_add_tail(&codec->list, &bus->codec_list);
> > +	bus->num_codecs++;
> >  	bus->caddr_tbl[codec_addr] = codec;
> >
> >  	codec->vendor_id = snd_hda_param_read(codec, AC_NODE_ROOT,
> 
> Also decrease bus->num_codecs in snd_hda_codec_free(), just to be sure.

Can I decrease bus->num_codecs in snd_hda_bus_free(), after the codec is freed? 
	list_for_each_entry_safe(codec, n, &bus->codec_list, list) {
		snd_hda_codec_free(codec);
+		bus->num_codecs--;
	}

> 
> > @@ -5032,6 +5052,14 @@ int snd_hda_check_amp_list_power(struct
> hda_codec *codec,
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_HDA(snd_hda_check_amp_list_power);
> > +
> > +static void hda_pm_work(struct work_struct *work) {
> > +	struct hda_codec *codec =
> > +		container_of(work, struct hda_codec, pm_work);
> > +
> > +	hda_call_codec_suspend(codec, false); }
> >  #endif
> >
> >  /*
> > @@ -5595,11 +5623,27 @@
> EXPORT_SYMBOL_HDA(snd_hda_add_imux_item);
> >  int snd_hda_suspend(struct hda_bus *bus)  {
> >  	struct hda_codec *codec;
> > +	unsigned int mask = 0;
> >
> >  	list_for_each_entry(codec, &bus->codec_list, list) {
> >  		cancel_delayed_work_sync(&codec->jackpoll_work);
> > -		if (hda_codec_is_power_on(codec))
> > -			hda_call_codec_suspend(codec, false);
> > +		if (hda_codec_is_power_on(codec)) {
> > +			if (bus->num_codecs == 1)
> > +				hda_call_codec_suspend(codec, false);
> > +			else {
> > +				mask |= 1 << codec->addr;
> > +				queue_work(bus->pm_wq, &codec->pm_work);
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!mask)
> > +		return 0;
> > +
> > +	list_for_each_entry(codec, &bus->codec_list, list) {
> > +		if (mask & (1 << codec->addr))
> > +			flush_work(&codec->pm_work);
> > +
> >  	}
> 
> You can drop the mask bit things, and here can be replaced with just a
> single call like:
> 	if (bus->num_codecs > 1)
> 		flush_workqueue(bus->pm_wq);

Ok. This is much better.

Thanks again!
Mengdong
