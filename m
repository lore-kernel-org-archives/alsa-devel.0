From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 01/11] ALSA: hda - add id table support for
 hdac device/driver
Date: Tue, 14 Apr 2015 10:04:11 +0530
Message-ID: <20150414043411.GD2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5hiod0p7xq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9892619BF
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:39:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiod0p7xq.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 01:46:25PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:08 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
> > index 519914a..8899c56 100644
> > --- a/sound/hda/hda_bus_type.c
> > +++ b/sound/hda/hda_bus_type.c
> > @@ -19,6 +19,8 @@ static int hda_bus_match(struct device *dev, struct device_driver *drv)
> >  		return 0;
> >  	if (hdrv->match)
> >  		return hdrv->match(hdev, hdrv);
> > +	if (hdrv->id_table)
> > +		return snd_hdac_bus_match_id(hdev, hdrv);
> >  	return 1;
> >  }
> >  
> > diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
> > index 3294fd4..f0ee295 100644
> > --- a/sound/hda/hdac_bus.c
> > +++ b/sound/hda/hdac_bus.c
> > @@ -195,3 +195,27 @@ void snd_hdac_bus_remove_device(struct hdac_bus *bus,
> >  	bus->num_codecs--;
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hdac_bus_remove_device);
> > +
> > +/**
> > + * snd_hdac_bus_match_id - bind hdac device to hdac driver.
> > + * @hdev: device.
> > + * @hdrv: driver.
> > + *
> > + */
> > +int snd_hdac_bus_match_id(struct hdac_device *dev,
> > +		 struct hdac_driver *drv)
> > +{
> > +	if (drv->id_table) {
> > +		struct hdac_device_id *id = drv->id_table;
> > +
> > +		while (id->name[0]) {
> > +			if (dev->vendor_id == id->id) {
> > +				dev->id_entry = id;
> > +				return 1;
> > +			}
> > +			id++;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hdac_bus_match_id);
> 
> Please make these rather ASoC specific.  These ID checks aren't needed
> for the legacy driver as they need more other fields checks like
> revision id.
> 
> For example,
> 
> struct hda_soc_device {
> 	struct hdac_device core;
> 	const struct hda_soc_device_id *id_entry;
> 	....
> };
> 
> and give the match ops to hdac_driver for checking the ID.
Okay, will move these to asoc then. I am planning to move this to generic
asoc layer and not in skl driver specfic

-- 
~Vinod
