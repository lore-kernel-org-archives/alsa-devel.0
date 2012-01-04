From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: how to enumerate useful ALSA devices?
Date: Wed, 4 Jan 2012 13:49:56 -0600
Message-ID: <20120104194956.GB9868@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F6C82443E
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 20:50:02 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

> The 2008 audio guide recommends
> http://0pointer.de/blog/projects/guide-to-sound-apis.html
> "Do not use the snd_card_xxx() APIs. For enumerating use
>  snd_device_name_hint() (and related functions).
>  snd_card_xxx() is obsolete... Bluetooth audio are not included"
> 
> Is that correct advice?
> 
> Wine still uses snd_card, so it knows only about "default" and
> "plughw:x,y".  I believe that's wrong but don't know what should be
> used instead in order not to come up with a long list of artificial
> names mentioned in /usr/share/alsa/alsa.conf such as surround51 when
> the poor on-board card knows nothing but 16 bit stereo.
> 
> I'm looking for a list of working devices on this machine, which likely
> should contain "default" (usually leading to PA on a recent Ubuntu machine),
> "plug:dmix" (PA getting out of the way when trying to use other devices),
> "hw:0,0" and presumably not much more.

Bump, still hoping for an answer to this.

I tried experimenting with snd_device_name_hint(). It gave me what
looked like a promising list, consisting of:

null
front:CARD=SB,DEV=0
surround40:CARD=SB,DEV=0
surround41:CARD=SB,DEV=0
surround50:CARD=SB,DEV=0
surround51:CARD=SB,DEV=0
surround71:CARD=SB,DEV=0
iec958:CARD=SB,DEV=0

This is identical to the list from "aplay -L".

But, passing these to aplay fails if I have PulseAudio running
("device in use"). If I kill PA, then they don't fail, but give
warnings about rate conversion and suggest the plug plugin. So I stick
"plug:" in front of the device name, and they fail again ("unknown
parameter front:CARD"). Clearly I'm doing something very wrong. But I
don't know what!

Then it occurred to me that this list also contains neither "default"
nor the "pulse" device in my asound.conf[1]. Both of these work when
passed to aplay.

Looking to other projects for help, I find that VLC uses the snd_card_
functions, just like Wine currently does. Of course, that fails to
find the "pulse" device from asound.conf. And mplayer's libao2 uses a
couple of hard-coded device names, which is even worse (right?).

So I'm really stuck here. Where am I supposed to get a list of devices
that I can present to the user, including their Bluetooth devices and
virtual devices from asound.conf?

[1] asound.conf from Arch Linux pulseaudio-alsa package:
http://projects.archlinux.org/svntogit/packages.git/tree/trunk/asound.conf?h=packages/pulseaudio-alsa

Andrew
