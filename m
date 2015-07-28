From: "Eoff, Ullysses A" <ullysses.a.eoff@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Fix race condition between
 HDA driver and runtime PM
Date: Tue, 28 Jul 2015 05:37:52 +0000
Message-ID: <8B5BDC21C48FAF4CA5D7E3FE1A63A90870B82061@ORSMSX111.amr.corp.intel.com>
References: <1438057171-18045-1-git-send-email-ullysses.a.eoff@intel.com>
 <96A12704CE18D347B625EE2D4A099D196C8427@SHSMSX103.ccr.corp.intel.com>
 <8B5BDC21C48FAF4CA5D7E3FE1A63A90870B82023@ORSMSX111.amr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D196C8460@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4632F26525B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:38:00 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D196C8460@SHSMSX103.ccr.corp.intel.com>
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
To: "Yang, Libin" <libin.yang@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Lee, Zhuo-hao" <zhuo-hao.lee@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Yang, Libin
> Sent: Monday, July 27, 2015 10:30 PM
> To: Eoff, Ullysses A; tiwai@suse.de; alsa-devel@alsa-project.org
> Cc: Lee, Zhuo-hao
> Subject: RE: [PATCH v2] ALSA: hda - Fix race condition between HDA driver and runtime PM
> 
> Hi Ullysses,
> 
> > -----Original Message-----
> > From: Eoff, Ullysses A
> > Sent: Tuesday, July 28, 2015 1:27 PM
> > To: Yang, Libin; tiwai@suse.de; alsa-devel@alsa-project.org
> > Cc: Lee, Zhuo-hao
> > Subject: RE: [PATCH v2] ALSA: hda - Fix race condition between HDA
> > driver and runtime PM
> >
> >
> > > -----Original Message-----
> > > From: Yang, Libin
> > > Sent: Monday, July 27, 2015 10:20 PM
> > > To: Eoff, Ullysses A; tiwai@suse.de; alsa-devel@alsa-project.org
> > > Cc: Lee, Zhuo-hao
> > > Subject: RE: [PATCH v2] ALSA: hda - Fix race condition between HDA
> > driver and runtime PM
> > >
> > >
> > > Hi Ullysses,
> > >
> > > > -----Original Message-----
> > > > From: Eoff, Ullysses A
> > > > Sent: Tuesday, July 28, 2015 12:20 PM
> > > > To: tiwai@suse.de; alsa-devel@alsa-project.org
> > > > Cc: Lee, Zhuo-hao; Yang, Libin; Eoff, Ullysses A
> > > > Subject: [PATCH v2] ALSA: hda - Fix race condition between HDA
> > driver
> > > > and runtime PM
> > > >
> > > > Don't execute runtime suspend if HDA is not finished initializing.
> > > > Otherwise, the following errors can occur in hda:
> > > >
> > > > snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP =
> > 65535
> > > > snd_hda_intel 0000:00:1b.0: no codecs initialized
> > > >
> > > > Debugged and root-cause found by zhuo-hao.lee@intel.com
> > > >
> > > > v2: remove unnecessary extra check for chip init (libin)
> > > >
> > > > Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> > > > ---
> > > >  sound/pci/hda/hda_intel.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > index b729b25a6ad6..15d4e28fc64e 100644
> > > > --- a/sound/pci/hda/hda_intel.c
> > > > +++ b/sound/pci/hda/hda_intel.c
> > > > @@ -1017,17 +1017,19 @@ static int azx_runtime_idle(struct
> > device
> > > > *dev)
> > > >  	struct snd_card *card = dev_get_drvdata(dev);
> > > >  	struct azx *chip;
> > > >  	struct hda_intel *hda;
> > > > +	struct hdac_bus *bus;
> > > >
> > > >  	if (!card)
> > > >  		return 0;
> > > >
> > > >  	chip = card->private_data;
> > > >  	hda = container_of(chip, struct hda_intel, chip);
> > > > +	bus = azx_bus(chip);
> > > >  	if (chip->disabled || hda->init_failed || !chip->running)
> > >
> > > I mean we don't need '!chip->running' either. Otherwise,
> > > initialization may be interrupted.
> >
> > !chip->running condition comes from patch 1/2 and is needed to
> > avoid race with async probe.  Are you saying we don't need
> > patch 1/2?
> 
> Do you mean removing patch 1/2 will cause race?

Yes. PM ops could trigger before azx_probe_continue finishes
which results in a NULL deref kernel crash.

> 
> >
> > >
> > > >  		return 0;
> > > >
> > > >  	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
> > > > -	    azx_bus(chip)->codec_powered)
> > > > +	    bus->codec_powered || !bus->chip_init)
> > > >  		return -EBUSY;
> > > >
> > > >  	return 0;
> > > > --
> > > > 1.9.3
