From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Sun, 10 Apr 2011 09:21:35 +0800
Message-ID: <BANLkTimcFQRMmjT9+FhJXnkNqNQPTMHZNQ@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4B6F7243A5
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Apr 2011 03:21:36 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3405917fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 09 Apr 2011 18:21:35 -0700 (PDT)
In-Reply-To: <BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/8 Valerio tesei <valerio.tesei@gmail.com>

> Hi Raymond,
>
> I spent a little time reading sound documentation but doesn't find anything
> about how to apply a patch to snd-hda-intel, but it is needed? there is no
> an "patch auto detect"? i enable the patch option in HDA-Intel kernel
> config, this WE i will study more, Takashi could you please give me
> documentation about patch applying?
>


The easy way is to use Takashi 's daily snapshot
since there are a few patches related to alc892



>
> About the NVIDIA video card, do you think that the hdmi on NVIDIA could
> conflicts with the one in motherboard, creating the problem that I'm
> experiencing?
> I didn't check anything on kernel regarding HDMI, and i use an "edited"
> NVIDIA driver (by me) to build against 2.6.39 (only rename smp_lock.h to
> smp.h in the code) version is 270, taken from gentoo repos.
>

you have to ask nvidia hdmi expert or asus forum



> To clarify my self
> - I *need* to apply alc662 patch to snd-hda-intel to test if commits work?
> - I *need* to solve problems with NVIDIA drivers to make my sound card
> work?
> (and if i must specify witch port nvidia must use how i could do that?)
> - alsaconf doesn't find my sound card, even when it works (crackly but
> works) is this problem linked to capture streams problems ?
>
>
No need to do anything if Takashi mention that model="auto" is used to
support 6stack motherboard


> Some news:
> - after module loading I hear a big noise
> - after upgrade to Takashi's sound-2.6 kernel tree, i hear dx louder than
> sx
> - some times the sounds mute, after 7/10 seconds sound come back (no
> changes
> in alsamixer)
>
> I know that I'm completely usefulness and a little bit annoying, I'm
> reading
> about alsa devel but I gess is a little bit hard for me.
>
>

[    7.111176] SKU: override=0x1
[    7.111385] hda_codec: ALC892: BIOS auto-probing.
[    7.111389] autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
--
[    7.116998] Cannot find slave PCM Playback Switch, skipped
[    7.117657] input: HDA Intel Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input4

As you have specifed in BIOS setup that "Front Panel Connector" is [AC97]
and the BIOS seem set "Misc=NO_PRESENCE"

why does the driver still create
/devices/pci0000:00/0000:00:1b.0/sound/card0/input4 for jack reporting ?

Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x02214120: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
