From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: how to enumerate useful ALSA devices?
Date: Wed, 4 Jan 2012 15:04:58 -0600
Message-ID: <20120104210458.GG9868@foghorn.codeweavers.com>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<4F04BAF8.6010701@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id D58C3103874
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 22:05:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F04BAF8.6010701@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2012 at 10:47:52PM +0200, Anssi Hannula wrote:
> > Then it occurred to me that this list also contains neither "default"
> > nor the "pulse" device in my asound.conf[1]. Both of these work when
> > passed to aplay.
> 
> AFAIK this is because that file is missing the "hint" statement for the
> devices, which are present on my system (Mageia), and also in upstream ALSA:
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/50-pulseaudio.conf;h=dd85dab835168bde84d7b8a3be78fb896ece8ea8;hb=HEAD
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/99-pulseaudio-default.conf.example;h=4f5885806898a76f5a5c9b3ec76b804fe54e2480;hb=HEAD
> 

Ah ha! That does fix it. If I remove the asound.conf entirely, then
"default:CARD=SB" shows up.  If I replace the file and add the hints
fields as you suggest, then both virtual devices show up.  I wonder
how common this error is across distros. I'll have to test a bit...

In the meantime I've opened an Arch Linux bug.
https://bugs.archlinux.org/task/27829

> > Looking to other projects for help, I find that VLC uses the snd_card_
> > functions, just like Wine currently does. Of course, that fails to
> > find the "pulse" device from asound.conf. And mplayer's libao2 uses a
> > couple of hard-coded device names, which is even worse (right?).
> > 
> > So I'm really stuck here. Where am I supposed to get a list of devices
> > that I can present to the user, including their Bluetooth devices and
> > virtual devices from asound.conf?
> 
> I guess the preferred one is 'snd_device_name_hint()', but I don't
> really know if the caller is supposed to then handle surroundXX stuff
> themself.
> 
> However, note that on systems using pulseaudio (i.e. the default on most
> distros), an automatically (i.e. via bluetooth "add device" wizard of
> their desktop) configured bluetooth headset may be handled by pulse
> directly and not appear as a distinct device in ALSA at all. At least
> this seems to be the case on my system.
> 

Really, on a pulse-using machine, we only ever want to use "default",
since PA should handle endpoint selection. It would be ideal not to
present the user with any options at all, but perhaps that can't be
done.

Thanks very much for the tips,
Andrew
