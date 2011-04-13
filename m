From: Valerio tesei <valerio.tesei@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Wed, 13 Apr 2011 13:08:11 +0200
Message-ID: <BANLkTi=4wGJSDGOWwrFHMhd9w17tWvbrNQ@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
	<BANLkTimcFQRMmjT9+FhJXnkNqNQPTMHZNQ@mail.gmail.com>
	<BANLkTikX4FtPEdsPKP-2wa=aLVyU3ibJHA@mail.gmail.com>
	<4DA3566E.6000600@gmail.com>
	<BANLkTimpWyUR5H7DRk3JEg+qMcZp45=2=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8A4A92432E
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 13:08:13 +0200 (CEST)
Received: by fxm5 with SMTP id 5so416482fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 04:08:11 -0700 (PDT)
In-Reply-To: <BANLkTimpWyUR5H7DRk3JEg+qMcZp45=2=A@mail.gmail.com>
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

2011/4/13 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/4/12 Valerio Tesei <valerio.tesei@gmail.com>
>
>> Il 11/04/2011 10:21, Valerio tesei ha scritto:
>>
>> > 2011/4/10 Raymond Yau <superquad.vortex2@gmail.com>
>>
>> >>
>>
>> >> 2011/4/8 Valerio tesei <valerio.tesei@gmail.com>
>>
>> >>
>>
>> >>> Hi Raymond,
>>
>> >>>
>>
>> >>> I spent a little time reading sound documentation but doesn't find
>> anything
>>
>> >>> about how to apply a patch to snd-hda-intel, but it is needed? there=
 is
>> no
>>
>> >>> an "patch auto detect"? i enable the patch option in HDA-Intel kernel
>>
>> >>> config, this WE i will study more, Takashi could you please give me
>>
>> >>> documentation about patch applying?
>>
>> >>>
>>
>> >>
>>
>> >>
>>
>> >> The easy way is to use Takashi 's daily snapshot
>>
>> >> since there are a few patches related to alc892
>>
>> >
>>
>> > I'm using it.
>>
>> > I must wait for a patch, hoping in Takashi? :)
>>
>> > I think i will make some experiment on patch_realtek.c :)
>>
>> > For the noise problem if i understand a little, could be a connection
>>
>> > problem, i will try to graph it.
>>
>> > For the capture problem i need to read more :)
>>
>> >
>>
>> >>
>>
>> >>
>>
>> >>>
>>
>> >>> About the NVIDIA video card, do you think that the hdmi on NVIDIA co=
uld
>>
>> >>> conflicts with the one in motherboard, creating the problem that I'm
>>
>> >>> experiencing?
>>
>> >>> I didn't check anything on kernel regarding HDMI, and i use an "edit=
ed"
>>
>> >>> NVIDIA driver (by me) to build against 2.6.39 (only rename smp_lock.h
>> to
>>
>> >>> smp.h in the code) version is 270, taken from gentoo repos.
>>
>> >>>
>>
>> >>
>>
>> >> you have to ask nvidia hdmi expert or asus forum
>>
>> >>
>>
>> >
>>
>> > Seems to be a common problem from 2.6.37 with 267.10 driver, for the
>>
>> > moment i will hope this does not create any problem.
>>
>> > I'm not using hdmi on Mobo neither the one on Video card.
>>
>> >
>>
>> >>
>>
>> >>
>>
>> >>> To clarify my self
>>
>> >>> - I *need* to apply alc662 patch to snd-hda-intel to test if commits
>> work?
>>
>> >>> - I *need* to solve problems with NVIDIA drivers to make my sound ca=
rd
>>
>> >>> work?
>>
>> >>> (and if i must specify witch port nvidia must use how i could do tha=
t?)
>>
>> >>> - alsaconf doesn't find my sound card, even when it works (crackly b=
ut
>>
>> >>> works) is this problem linked to capture streams problems ?
>>
>> >>>
>>
>> >>>
>>
>> >> No need to do anything if Takashi mention that model=3D"auto" is used=
 to
>>
>> >> support 6stack motherboard
>>
>> >>
>>
>> >
>>
>> > This mean that tecnicaly my sound card/motherboard must work with the
>>
>> > patches that Takashi commited?
>>
>> >
>>
>> >>
>>
>> >>> Some news:
>>
>> >>> - after module loading I hear a big noise
>>
>> >>> - after upgrade to Takashi's sound-2.6 kernel tree, i hear dx louder
>> than
>>
>> >>> sx
>>
>> >>> - some times the sounds mute, after 7/10 seconds sound come back (no
>>
>> >>> changes
>>
>> >>> in alsamixer)
>>
>> >>>
>>
>> >>> I know that I'm completely usefulness and a little bit annoying, I'm
>>
>> >>> reading
>>
>> >>> about alsa devel but I gess is a little bit hard for me.
>>
>> >>>
>>
>> >>>
>>
>> >>
>>
>> >> [ =A0 =A07.111176] SKU: override=3D0x1
>>
>> >> [ =A0 =A07.111385] hda_codec: ALC892: BIOS auto-probing.
>>
>> >> [ =A0 =A07.111389] autoconfig: line_outs=3D4 (0x14/0x15/0x16/0x17/0x0)
>>
>> >> --
>>
>> >> [ =A0 =A07.116998] Cannot find slave PCM Playback Switch, skipped
>>
>> >> [ =A0 =A07.117657] input: HDA Intel Headphone as
>>
>> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input4
>>
>> >>
>>
>> >> As you have specifed in BIOS setup that "Front Panel Connector" is
>> [AC97]
>>
>> >> and the BIOS seem set "Misc=3DNO_PRESENCE"
>>
>> >>
>>
>> >> why does the driver still create
>>
>> >> /devices/pci0000:00/0000:00:1b.0/sound/card0/input4 for jack reportin=
g ?
>>
>> >>
>>
>> >> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>>
>> >> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>
>> >> =A0Amp-In vals: =A0[0x00 0x00]
>>
>> >> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>
>> >> =A0Amp-Out vals: =A0[0x00 0x00]
>>
>> >> =A0Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
>>
>> >> =A0 =A0Vref caps: HIZ 50 GRD 80 100
>>
>> >> =A0EAPD 0x2: EAPD
>>
>> >> =A0Pin Default 0x02214120: [Jack] HP Out at Ext Front
>>
>> >> =A0 =A0Conn =3D 1/8, Color =3D Green
>>
>> >> =A0 =A0DefAssociation =3D 0x2, Sequence =3D 0x0
>>
>> >> =A0 =A0Misc =3D NO_PRESENCE
>>
>> >> =A0Pin-ctls: 0xc0: OUT HP VREF_HIZ
>>
>> >> =A0Unsolicited: tag=3D00, enabled=3D0
>>
>> >> =A0Power states: =A0D0 D1 D2 D3 EPSS
>>
>> >> =A0Power: setting=3DD0, actual=3DD0
>>
>> >> =A0Connection: 5
>>
>> >> =A0 =A0 0x0c 0x0d 0x0e 0x0f 0x26*
>>
>> >>
>>
>> >
>>
>> > I disconnected the front panel, before install windows 7 to test if
>>
>> > soundcard work, i was thinking that te problem was a short circuit.
>>
>> > ___________________________________________
>>
>> >> Alsa-devel mailing list
>>
>> >> Alsa-devel@alsa-project.org
>>
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>> >
>>
>> > Takashi if you need debug or something else just ask.
>>
>> I put "more verbose debug" into my kernel config, I'm starting to descri=
be
>> the issue:
>>
>> my player is mplayer, I'm playing a divx by alsa output.
>>
>> I tried the patch suggested by Raymond
>>
>> =A0 =A0 =A0 =A0if (codec->vendor_id =3D=3D 0x10ec0892)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->stream_analog_alt_capture =3D
>> &alc880_pcm_analog_alt_capture;
>>
>> Putted into sound/pci/hda/patch_realtek.c , =A0function patch_acl662, but
>> nothing changed, issues are the same.
>>
>> After module is loaded big noise starts, at first right channel is muted=
, I
>> hear realy disturbed and bass are crackly, after 10 minutes right channel
>> start crack, after 10 minutes, right channel is low but sounds, only bass
>> cracks, and high frequencies are clear.
>>
>> Front-Panel is physicaly detached from motherboard, in bios is setted as
>> "AC97", and S/P-DIF is setted as S/P-DIF
>>
>> New alsa-info are this:
>>
>> http://www.alsa-project.org/db/?f=3Dcef5e8099352f29c70b20ae2853714a200cb=
37a4
>>
>> --
>>
>
>
> http://thread.gmane.org/gmane.linux.alsa.devel/79348
>
> your info is different from =A0hda-emu/codecs/alc892-asus-p7h55
>
> http://git.kernel.org/pub/scm/linux/kernel/git/tiwai/hda-emu.git
>
> 2010-08-16 =A0 =A0 Takashi Iwai =A0 =A0Add alsa-info of ASUS P7H55 M-Pro =
with ALC892
> codec
>
> Codec: Intel IbexPeak HDMI 491
> Address: 3
>
> http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#standa=
rds
>
>
> =A0 =A0 =A0 =A0snd_hda_codec_write(codec, srcs[i], 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC_VERB_SET_AMP_GAIN_MUTE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AMP_IN_UNMUTE(1));
>
> The noise may be due to umute of connection 0x0b in 0x0c, 0x0d, 0x0e and
> 0x0f by alc662_auto_set_output_and_unmute() since those input pins (e.g.
> Front mic, line and rear mic) =A0's =A0"playback switch" in audio mixer 0=
x0b is
> not muted by alc662_auto_init_analog_input() or alc662_auto_init_input_sr=
c()
>
>
> http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multis=
tream
>
> It depend on whether you want your voice record from front mic appear in
> speakers connected to all rear panel jacks when ummute "front mic playback
> switch" if you use it as karaoke or multistreaming playback
>
>
> Do you get the correct sound from the rear panel and front HP when running
> "speaker-test -c 8 -t wav -Dhw:0,0" ?
>
>
> Two set of input sources,capture volume/switches since the number of
> connections is different in node 0x22 and 0x23 as node 0x22 has the digit=
al
> mic node 0x12
>
>
> ode 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> =A0Control: name=3D"Input Source", index=3D0, device=3D0
> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-In vals: =A0[0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 =
0x80]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> [0x80 0x80]
> =A0Connection: 12
> =A0 =A0 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> =A0Control: name=3D"Input Source", index=3D1, device=3D0
> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-In vals: =A0[0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 =
0x80]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> =A0Connection: 11
> =A0 =A0 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Yes but my motherboard is ASUS P7H55D-M PRO not ASUS P7H55-M PRO i
dont know the exact differences between h55d and h55 (i think only a
'deluxe' on the package)
On Asus compare, differences are about gigabit lan (realtek obviusly)
on p7h55d-pro and more "asus unique features" on p7h55d-pro (wasted
money to get nothing more than value mobo)
This is my back panel :
http://img40.imageshack.us/img40/8864/asusp7h55dmpro1156ddr3m.jpg
seems the same as p7h55-pro
 are out of my skills.
I will revert sound-2.6-git changes (printk and patch you suggested
above), create a new alsa-info, dump the graph by hda-analyzer tool, I
will post all these things later (when back home)
Anyway, all of you make a great work. I realy appreciate. Thanks All.
