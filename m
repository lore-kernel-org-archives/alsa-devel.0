From: "Eoff, Ullysses A" <ullysses.a.eoff@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - skip runtime PM if
	async	probe is not finished
Date: Tue, 28 Jul 2015 21:37:57 +0000
Message-ID: <8B5BDC21C48FAF4CA5D7E3FE1A63A90870B84A5A@ORSMSX111.amr.corp.intel.com>
References: <1438032894-8472-1-git-send-email-ullysses.a.eoff@intel.com>
 <s5hr3nsg7sj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F02652656F0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 23:38:00 +0200 (CEST)
In-Reply-To: <s5hr3nsg7sj.wl-tiwai@suse.de>
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
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lee,
 Zhuo-hao" <zhuo-hao.lee@intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Monday, July 27, 2015 10:39 PM
> To: Eoff, Ullysses A
> Cc: Yang, Libin; alsa-devel@alsa-project.org; Lee, Zhuo-hao
> Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: hda - skip runtime PM if async probe is not finished
> 
> On Mon, 27 Jul 2015 23:34:53 +0200,
> U. Artie Eoff wrote:
> >
> > Crash can occur if runtime PM is triggered before the async probe
> > finishes via the azx_firmware_cb when CONFIG_SND_HDA_PATCH_LOADER
> > is defined.
> >
> > Don't execute PM ops if the async probe has not completed yet.
> >
> > The probe is finished when chip->running is true.
> >
> > Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> > ---
> >  sound/pci/hda/hda_intel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 735bdcb04ce8..b729b25a6ad6 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1023,7 +1023,7 @@ static int azx_runtime_idle(struct device *dev)
> >
> >  	chip = card->private_data;
> >  	hda = container_of(chip, struct hda_intel, chip);
> > -	if (chip->disabled || hda->init_failed)
> > +	if (chip->disabled || hda->init_failed || !chip->running)
> >  		return 0;
> 
> For !chip->running, it's better to return -EBUSY.
> 
> The disabled and init_failed flags are checked in runtime_suspend()
> and runtime_resume() to skip the whole procedures, too.
> 
> And I guess the check of chip->running should suffice even without the
> second patch.  It assures that the bus is powered on.
> 

Hmm... wait a second.  I think we still need to check bus->chip_init
as in the second patch.  I just noticed that the async probe 
finishes (i.e. chip->running = 1) before chip init executes (i.e. before
bus->chip_init is set).  This allows a small window for the issue
I described in my second patch to occur.

I already sent another patch to replace these two... but I didn't
add the check for bus->chip_init in that patch.  I'll create a v2
for that but will wait for your feedback first.

> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
