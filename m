From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - suspend codecs in parallel
Date: Tue, 26 Nov 2013 05:44:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8014197F7@SHSMSX101.ccr.corp.intel.com>
References: <66cb89707dd2109e0cfa2f80561eb25f7bbd686d.1385350212.git.mengdong.lin@intel.com>
 <s5hbo18bvq3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 24462260818
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 06:44:48 +0100 (CET)
In-Reply-To: <s5hbo18bvq3.wl%tiwai@suse.de>
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

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, November 25, 2013 6:51 PM

> >  int snd_hda_suspend(struct hda_bus *bus)  {
> >  	struct hda_codec *codec;
> > +	unsigned int mask = 0;
> >
> >  	list_for_each_entry(codec, &bus->codec_list, list) {
> >  		cancel_delayed_work_sync(&codec->jackpoll_work);
> > -		if (hda_codec_is_power_on(codec))
> > -			hda_call_codec_suspend(codec, false);
> > +		if (hda_codec_is_power_on(codec)) {
> > +			if (codec->epss || bus->num_codecs == 1)
> > +				hda_call_codec_suspend(codec, false);
> 
> What's the reason for codec->epss check exceptionally?

Check on codec->epss should be removed here. It's better to always parallel if there are multiple codecs.
I had thought codec with EPSS support can change power state quickly and so we can tolerate not paralleling. 

> > +			else {
> > +				mask |= 1 << codec->addr;
> > +				queue_work(codec->pm_wq, &codec->pm_work);
> > +			}
> > +		}
> > +	}
> > +
> > +	list_for_each_entry(codec, &bus->codec_list, list) {
> > +		if (mask & (1 << codec->addr))
> > +			flush_work(&codec->pm_work);
> > +
> >  	}
> 
> I thought that the recent workqueue is performed asynchronously as
> default (unless an ordered workqueue is used), so it should be enough to
> have a single workqueue in the bus, and flush it.

If using the single work queue in the bus, I observe that the codecs are suspended one after one, not in parallel. 

Thanks
Mengdong
