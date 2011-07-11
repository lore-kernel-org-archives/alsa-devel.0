From: Alex <xenogenesi@virgilio.it>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Mon, 11 Jul 2011 21:25:57 +0200
Message-ID: <201107112125.57804.xenogenesi@virgilio.it>
References: <CAN8cciZG=Cx8_9W7DNtCgde9Xy9h=ZBA0cXh1sni6VQhy-veeg@mail.gmail.com>
Reply-To: xenogenesi@virgilio.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vsmtp4.tin.it (vsmtp4.tin.it [212.216.176.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EE7F245F1
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 21:26:02 +0200 (CEST)
Received: from hellspawn.localnet (82.52.0.61) by vsmtp4.tin.it (8.5.132)
	id 4D513E500D030B32 for alsa-devel@alsa-project.org;
	Mon, 11 Jul 2011 21:26:01 +0200
In-Reply-To: <CAN8cciZG=Cx8_9W7DNtCgde9Xy9h=ZBA0cXh1sni6VQhy-veeg@mail.gmail.com>
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

> > My knowledge of audio/alsa programming is really poor, but if someone
> > suggest a patch I can setup the thing and do some debug.
> 
> Try Takashi 's daily snapshot tarball
> 
> you should able to get "Headphone Playback Volume" after this patch
> "ALSA: hda - Code consolidation for ALC88x and ALC662 auto-parsers"
> 
> using hda-emu and it seem the driver support 6 channels even when the
> pink and blue jacks are not retasked

Hi Raymond, thanks for your support

built and installed the daily snapshot, the driver tarball only, now the mixer 
applications show adjustable headphone volume level, but still hear nothing. 
Should upgrade alsa lib or something else too?

Just a note, in the bios there's some related option:
Audio Controller: [Azalia]/Disable all
Front panel Support type: AC97/[HD Audio]

I checkd both AC97 and HD with the new alsa-driver with the same result.
