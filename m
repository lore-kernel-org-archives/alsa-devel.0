From: Alex <xenogenesi@virgilio.it>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Wed, 13 Jul 2011 20:43:27 +0200
Message-ID: <201107132043.28014.xenogenesi@virgilio.it>
References: <CAN8cciZG=Cx8_9W7DNtCgde9Xy9h=ZBA0cXh1sni6VQhy-veeg@mail.gmail.com>
	<201107112125.57804.xenogenesi@virgilio.it>
	<CAN8cciZsQ0C0kMFVWPLN-U6gNH2=t_uN7p2MzcEwpEc3GkeotA@mail.gmail.com>
Reply-To: xenogenesi@virgilio.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vsmtp2.tin.it (vsmtp2.tin.it [212.216.176.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 47280103908
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 20:43:32 +0200 (CEST)
Received: from hellspawn.localnet (79.24.36.125) by vsmtp2.tin.it (8.5.113)
	id 4DF7114F02FAA167 for alsa-devel@alsa-project.org;
	Wed, 13 Jul 2011 20:43:31 +0200
In-Reply-To: <CAN8cciZsQ0C0kMFVWPLN-U6gNH2=t_uN7p2MzcEwpEc3GkeotA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> 2011/7/12 Alex <xenogenesi@virgilio.it>:
> >> > My knowledge of audio/alsa programming is really poor, but if someone
> >> > suggest a patch I can setup the thing and do some debug.
> >> 
> >> Try Takashi 's daily snapshot tarball
> >> 
> >> you should able to get "Headphone Playback Volume" after this patch
> >> "ALSA: hda - Code consolidation for ALC88x and ALC662 auto-parsers"
> >> 
> >> using hda-emu and it seem the driver support 6 channels even when the
> >> pink and blue jacks are not retasked
> > 
> > Hi Raymond, thanks for your support
> > 
> > built and installed the daily snapshot, the driver tarball only, now the
> > mixer applications show adjustable headphone volume level, but still
> > hear nothing. Should upgrade alsa lib or something else too?
> 
> you may need to provide output of alsa-info.sh
> 
> configure --with-debug=verbose
> 
> > Just a note, in the bios there's some related option:
> > Audio Controller: [Azalia]/Disable all
> > Front panel Support type: AC97/[HD Audio]
> > 
> > I checkd both AC97 and HD with the new alsa-driver with the same result.
> 
> Do your computer chassis have a HD Front Audio Panel ?
> 
> http://www.intel.com/support/motherboards/desktop/sb/CS-020642.htm#standard
> s

Sorry I was missing all this stuff, for some unknown reason I was also sure 
everything working with windows but have checked today and it isn't

The chassis seem to support HD Audio
http://www.coolermaster.com/product.php?product_id=5239

> You can also physically check the audio cable of the front panel audio
> solution. If there is a cable connected to Pin 4, you have an HD Audio
> module; if there is no cable to Pin 4, you have an AC97 module.

You got it, guess something wrong here, I'll double check the cable and 
connections soon in few days then back here and let you know

> The difference between AC97 and HD Audio  "Front panel Support type:"
> in BIOS setup
> is Misc[11:8] of Configuration Default  is a bit field used to
> indicate other information about the jack.
> If bit 0 is set, it indicates that the jack has no presence detect
> capability, so even if a Pin Complex indicates that the codec hardware
> supports the presence detect functionality on the jack, the external
> circuitry is not capable of supporting the functionality
> 
> 
> you can use hda-jack-sense-test
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/85051

Currently it work with the rear panel only

Pin 0x14 (Green Line Out): present = Yes
Pin 0x18 (Pink Mic): present = No
Pin 0x1a (Blue Line In): present = No



Thanks!
