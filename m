From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 10:55:28 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0805221052050.971@fbirervta.pbzchgretzou.qr>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org> <4834B5E2.3040301@keyaccess.nl> <s5hy7623fqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936006AbYEVIzl@vger.kernel.org>
In-Reply-To: <s5hy7623fqs.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


On Thursday 2008-05-22 10:27, Takashi Iwai wrote:
>> 
>>> Speaking as a former OSS driver maintainer, I always preferred
>>> drivers/sound.
>>> 
>>> Though Rene's suggestion (use both sound/ and drivers/sound/)
>>> might make sense if the subsystem code is huge -- I supported the
>>> drivers/block/ -> block/ code movement for example.
>> 
>> Well, not _huge_ but ALSA is very much structured like that; large
>> middle layer with "miniport" drivers (I do by the way expect this
>> was also Takashi plan originally due to him using sound/* and not
>> just "sound/"; that is, I took the * to be shorthand for isa, pci,
>> usb and so on)
>
>Well, no, I originally thought moving all $LINUX/sound to
>$LINUX/drivers/sound.  The sound core stuff is already in
>sound/core, so it can be peacefully in drivers/sound/core, just like
>other drivers like USB, V4L, etc.

I am in favor of keeping /sound around with the
non-hardware-dependent code, much like /block does with regard to
/drivers/block.

So that's /sound for PCM/mixer etc. and /drivers/sound with the
actual driver parts like cs46xx.

Just like:

>>  From a structural view, the PCM core is just as much not a driver as 
>> the IP protocol isn't one and moving all of sound/ to drivers/ would 
>> trade the current "why are the drivers not under drivers/?" issue for a 
>> "why is all this non-driver code under drivers/?".
>> 
>> This "net model" of sound/ and drivers/sound/ would be cleanest I feel.
>
>I think it's a question of the balance.  The net stuff is huge, 10
>times more codes than the sound core.
>
>An argument for keeping the sound core in /sound is that this is used
>not only by sound drivers but also by some video drivers.


PS. But then again, I could also imagine
	/block (core)
	/block/drivers (drivers)
	/net (core)
	/net/drivers
	/sound
	/sound/drivers
And the sound parts are already mostly there.
