From: =?UTF-8?B?5ZGo5ZC05Yab?= <zwj.echo@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 6 Jul 2009 09:46:10 +0800
Message-ID: <7a0659170907051846m16ac86f3o785ceed2c3e0fa74@mail.gmail.com>
References: <1246384544.6380.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id CF245103837
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 03:46:11 +0200 (CEST)
Received: by pxi30 with SMTP id 30so168422pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 05 Jul 2009 18:46:10 -0700 (PDT)
In-Reply-To: <1246384544.6380.6.camel@ubuntu.ubuntu-domain>
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
Cc: mdiehl.os@gmx.de
List-Id: alsa-devel@alsa-project.org

I also use the ubuntu 904 64bit,and a similar hardware,
 it works for me pretty well .now I can hear 5.1 sound just like the windows
driver  offer

have you intslled soundcard driver?
I use the following install stage
$./configure --with-card=ctxfi
$make
$sudo  make modules install

and then restart(if not the old alsa code will make snd-ctxfi driver module
unloadable)
$sudo modprobe snd-ctxfi

and if it still not work please give some information about $dmesg

here's what lspci | grep audio says:
01:00.1 Audio device: ATI Technologies Inc HD48x0 audio
03:02.0 Multimedia audio controller: Creative Labs SB X-Fi

cat /proc/asound/cards says:
0 [XFi            ]: SB-XFi - Creative X-Fi
                      Creative X-Fi 20K1 Unknown
lsmod|grep xfi
snd_ctxfi             102376  3
snd_pcm                99336  2 snd_ctxfi,snd_pcm_oss
snd                    77256  15
snd_ctxfi,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_seq,snd_timer,snd_seq_device




On Wed, Jul 1, 2009 at 1:55 AM, Matthias Diehl <mdiehl.os@gmx.de> wrote:

> > At Tue, 30 Jun 2009 16:10:45 +0200,
> > Matthias Diehl wrote:
> > >
> > > hi,
> > >
> > > i guess you dont speak german, do you? well, i'll try it in
> > english ;-)
> > >
> > > i tried to install your newest x-fi "hack" in ubuntu 9.04 64bit.
> > it's an x-fi extreme music. i downloaded this snapshot:
> >>
> >
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> >
> > Use alsa-driver-snapshot.tar.gz instead of the unstable one.
> >
> > > while the installation process there are some warnings. after
> > replacing the demon.conf and reboot there was no sound.
> > >
> > > then i noticed the sentence "Note that the ctxfi driver might
> > conflict with the HD-audio driver" in the description. i think my
> > problem is the hdmi soundchip from my graphics adapter (sapphire
> > radeon hd 4870) which was automatically installed at the
> > ubuntu-installation
> > ("hda intel sound").
> >
> > You are likely looking at irrelevant things.
> >
> > There are several variants of X-Fi boards. Many of them are equipped
> > with emu20k1 or emu20k2 chip. Some of these models can behave as
> > HD-audio compatible, too. These are supported by snd-ctxfi driver.
> >
> > In addition, there is X-Fi models that are without emu20k1/emu20k2
> > chips. Some of them (CA0110-IBG) behave only as a HD-audio device,
> > and some others are with CA0106 chip. The former is supported by
> > snd-hda-intel driver and the latter by snd-ca0106 driver.
> >
> > So, they cannot be deactivated. The only question is whether you have
> > emu20k1/emu20k2 chip on your board. And this can be checked when you
> > load snd-ctxfi driver. If the driver is properly loaded and the
> > card instance is created (see /proc/asound/cards), then it's good.
> > Otherwise, your board is no such one. You need other drivers.
> >
> > Please ask further questions on alsa-devel ML (you can add me to Cc,
> > though) so that other people with your board can advice better.
> >
> >
> > HTH,
> >
> > Takashi
>
> hi there,
>
> i now tried to install the stable version, but i have still no sound.
> here's what lspci | grep audio says:
> 01:00.1 Audio device: ATI Technologies Inc HD48x0 audio
> 05:00.0 Multimedia audio controller: Creative Labs SB X-Fi
>
> lsmod | grep snd says:
> snd_hda_intel         557492  1
> snd_pcm_oss            52352  0
> snd_mixer_oss          24960  2 snd_pcm_oss
> snd_pcm                99336  2 snd_hda_intel,snd_pcm_oss
> snd_seq_dummy          11524  0
> snd_seq_oss            41984  0
> snd_seq_midi           15744  0
> snd_rawmidi            33920  1 snd_seq_midi
> snd_seq_midi_event     16512  2 snd_seq_oss,snd_seq_midi
> snd_seq                66272  6
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
> snd_timer              34064  2 snd_pcm,snd_seq
> snd_seq_device         16276  5
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
> snd                    78792  9
> snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> soundcore              16800  2 snd
> snd_page_alloc         18704  2 snd_hda_intel,snd_pcm
>
> cat /proc/asound/cards says:
>  0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
>                      HDA ATI HDMI at 0xf7dfc000 irq 17
>
> i hope, someone can help me ...
> greetings from germany,
> matthias
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
