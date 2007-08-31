From: "paul blakeley" <pblakeley@gmail.com>
Subject: Re: azx driver compilation query
Date: Fri, 31 Aug 2007 13:43:50 +0100
Message-ID: <27342b300708310543r2a7f3454u1f469355417d2259@mail.gmail.com>
References: <27342b300708310341j7b7b0e0fic48806ecf944bf33@mail.gmail.com>
	<s5hmyw8ez3j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id DB1E9244E6
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 14:43:52 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so922619wag
	for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2007 05:43:51 -0700 (PDT)
In-Reply-To: <s5hmyw8ez3j.wl%tiwai@suse.de>
Content-Disposition: inline
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

First of all thanks for replying.  Version 1.0.15rc1 successfully
compiled and I was able to insert the modules without any trouble.  I
noticed that the alsamixer didnt work for some reason, although I
navigated through the asound.state file.

Unfortunately with version of ALSA I am experiencing the same issues
as with the version 1.0.12rc2.  I think from memory this was when the
ALC888 chipset was properly introduced in ALSA.  Anyway the mixer
controls are very similar to previous versions and for the life of me
I cant figure out how these mixer controls map onto the chipset!  The
chipset block diagram can be found here:

ftp://202.65.194.211/pc/audio/ALC888_DataSheet_1.1.pdf

Can someone help?

Also the other issues I having with this chipset is:

1. Line-in signal is distorted.
2. With a signal input and the 'front' mixer control set to zero you
can still here the signal output, although be it very low.
3. Capture mixer controls dont seem to do anything.
4. Line select between mic and line doesnt seem to do anything.

I would be extremely grateful if anybody could help with these.

Thanks.
            Paul.

On 8/31/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 31 Aug 2007 11:41:34 +0100,
> paul blakeley wrote:
> >
> > Hi, I am trying to compile ALSA 1.0.14 and have compiled it but there
> > are problems.  How do you find out which ALSA driver is associated
> > with a chipset?  The chipset is ALC888, but when I run the ./configure
> > script what do I pass in to the '--with-cards' parameter?  I have
> > compiled with 'hda-intel' but I dont think this correct?
>
> It is correct.  ALC888 is a codec chip controlled by a HD-audio
> controller, which corresponds to snd-hda-intel driver.
>
> Anyway, try the new ALSA 1.0.15rc1 instead of 1.0.14, especially for
> HD-audio stuff.
>
>
> Takashi
>
