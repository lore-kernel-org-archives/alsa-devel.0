From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: Re: intel-hda patch for Dell Latitude D531
Date: Tue, 16 Oct 2007 09:38:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0710160918480.16064@stud1.fbihome.de>
References: <20071011185456.3qrqlh5dt4hwkwsk@stud.fbi.h-da.de>
	<s5hodf061ea.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fbihome.de (stud.fbi.h-da.de [141.100.40.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 363FF24493
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 09:38:20 +0200 (CEST)
In-Reply-To: <s5hodf061ea.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > 1. patch_sigmatel.c.diff
> >
> > I have a Latitude D531 which has a ATI SB600 with a STAC 9205. The
> > chip is detected, but no config was read with the latest drivers. The
> > problems are the dmic_nids arrays, which are ignored for auto config
> > lookup. This calles is_in_nid_list, which expects a 0 terminated list,
> > but these arrays are not.
>
> Oh thanks, I queued the fix on to my local tree.
> I'll apply it soon after releasing 1.0.15.

Any reason, why the array fix can't go into 1.0.15?

> > Additionally I updated the dell_9205_m43_pin_configs with values from
> > the latest win drivers.
>
> Hm, I'm not pretty about this.  Does this change work for your machine
> well (I suppose you have a Dell Precision).

Should I try to get sound running with the old config? The real probem
with the driver where the unterminated arrays, which I found after
adapting the pin configs. I have no idea, if the driver can work with the
old values. Is there real chance, even if the driver is working with my
adapted values?

I have no knowledge about all the Dell product lines, but mine is a Dell
Latitude D531 and is AMD + ATI based (it's a model from the german
municipal administration page of Dell).

> > 3. patch_sigmatel_dell.h
> >
> > Output from running create_dell_tables.pl on the latest drivers for my
> > D531 from  Dell.
>
> That'll certainly help for debugging although we may need to tidy up a
> bit.

The perl script is GPL so just help yourself. The script tries to identify
duplicateds and merge these into one value. I know there are also some
GPIO information in the INI files of the driver.

BTW - the windows driver identifies the Dell notebook by the complete PCI
ID of of the sound device, while the linux driver just uses the SUB IDs.

Jan-Marek
