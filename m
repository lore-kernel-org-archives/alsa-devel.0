From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/3] ALSA: hda - WAKEEN feature enabling
	for runtime pm
Date: Tue, 23 Jul 2013 08:09:02 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011850663@SHSMSX104.ccr.corp.intel.com>
References: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
 <1374477558-14074-2-git-send-email-xingchao.wang@linux.intel.com>
 <51EE327E.1070407@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id A71CD261ADF
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 10:09:16 +0200 (CEST)
In-Reply-To: <51EE327E.1070407@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >   sound/pci/hda/hda_intel.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 8860dd5..a7ac7fd 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2970,6 +2970,11 @@ static int azx_runtime_suspend(struct device
> *dev)
> >   {
> >   	struct snd_card *card = dev_get_drvdata(dev);
> >   	struct azx *chip = card->private_data;
> > +	int status;
> > +
> > +	/* enable controller wake up event */
> > +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
> > +		  STATESTS_INT_MASK);
> >
> >   	azx_stop_chip(chip);
> >   	azx_enter_link_reset(chip);
> > @@ -2983,11 +2988,31 @@ static int azx_runtime_resume(struct device
> *dev)
> >   {
> >   	struct snd_card *card = dev_get_drvdata(dev);
> >   	struct azx *chip = card->private_data;
> > +	struct hda_bus *bus;
> > +	struct hda_codec *codec;
> > +	int status;
> >
> >   	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >   		hda_display_power(true);
> > +
> > +	/* Read STATESTS before controller reset */
> > +	status = azx_readw(chip, STATESTS);
> > +
> >   	azx_init_pci(chip);
> >   	azx_init_chip(chip, 1);
> > +
> > +	bus = chip->bus;
> > +	if (status && bus) {
> > +		list_for_each_entry(codec, &bus->codec_list, list)
> > +			if (status & (1 << codec->addr))
> > +				queue_delayed_work(codec->bus->workq,
> > +						   &codec->jackpoll_work,
> codec->jackpoll_interval);
> 
> Is there a reason you want to move the jack detection to a delayed work, i e,
> why can't we just call:
> 
>   	snd_hda_jack_set_dirty_all(codec);
>   	snd_hda_jack_poll_all(codec);
> 
> ...from here?

In fact it doesnot work for me, It will again call runtime_resume() and caused dead loop.

--xingchao
> 
> > +	}
> > +
> > +	/* disable controller Wake Up event*/
> > +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
> > +			~STATESTS_INT_MASK);
> > +
> >   	return 0;
> >   }
> >
> >
> 
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
