From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Tue, 10 Dec 2013 21:54:11 +0800
Message-ID: <CAN8cciZZhve=-BYNorv1Fhxr6P6-ZD47HY_gSx2DMXdRwQ+fbA@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
	<CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>
	<CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>
	<CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>
	<CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>
	<CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>
	<CAJ3TwYTJnGb7C_TZrGOVTsPPb1kB6Kzqge4suh2B_QAdNUMWgw@mail.gmail.com>
	<CAN8cciZTuP8Y-nvv8ecJZBoJZBgsucb2p0sd-2dmyMWGxDgifQ@mail.gmail.com>
	<CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>
	<CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>
	<52A55CAD.3080007@iki.fi> <52A55E4D.1050906@iki.fi>
	<CAJ3TwYSQHSTF0QyFn35db2FGAwpGgT3wKNa44eVMsrgFW95BJg@mail.gmail.com>
	<CAN8ccibt-pbWY0roHVjkhRz5eoOGMhbZRmL5Ce4fQLFOnZ0GaA@mail.gmail.com>
	<CAJ3TwYSqGYbYM=UZv2kpc8QRYteBz63utE6g6uecmdTcw7cwJA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1212735271=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYSqGYbYM=UZv2kpc8QRYteBz63utE6g6uecmdTcw7cwJA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: John Ettedgui <john.ettedgui@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

--===============1212735271==
Content-Type: multipart/alternative; boundary=089e010d9d407dce7104ed2e7252

--089e010d9d407dce7104ed2e7252
Content-Type: text/plain; charset=UTF-8

>  Codec: ATI R6xx HDMI
>> Address: 0
>> AFG Function Id: 0x1 (unsol 0)
>> Vendor Id: 0x1002aa01
>> Subsystem Id: 0x00aa0100
>> Revision Id: 0x100300
>>
>> seem that your codec may get Audio-Video Association Port ID and Sink
>> Information for your DENON-AVAMP
>>
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_eld.c?id=89250f84644676c1ed6a09acef1033e14596a402

Revision ID 3 and later (0x100300 as reported by procfs codec#X) have
support for providing more information than the previous revisions (but
only if supported by the display driver).

manufacture_id        0x0
product_id        0x0
port_id            0x0

you have to find out those values return by hda_codec_read
ATI_VERB_GET_SINK_INFO_DATA as your codec are revision 3 and your graphic
driver got the product_id, manufacture_id, port_id

Manufacturer: DON Model 26 Serial Number 16843009
Made week 0 of 2011
Monitor name: DENON

Audio data block
    Linear PCM, max channels 7
    Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1 32
    Supported sample sizes (bits): 24 20 16
    DTS, max channels 5
    Supported sample rates (kHz): 96 88.2 48 44.1
    Maximum bit rate: 1016 kHz
    AC-3, max channels 5
    Supported sample rates (kHz): 48 44.1 32
    Maximum bit rate: 1016 kHz
    DTS-HD, max channels 7
    Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
    Dolby Digital+, max channels 7
    Supported sample rates (kHz): 48 44.1
    MAT (MLP), max channels 7
    Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
  Speaker allocation data block

Do those SAD in EDID in xorg.log  match with the specification of your
Denon HDMI receiver ?

speakers        [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
sad_count        6
sad0_coding_type    [0x1] LPCM
sad0_channels        8
sad0_rates        [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
sad0_bits        [0xe0000] 16 20 24
sad1_coding_type    [0x2] AC-3
sad1_channels        6
sad1_rates        [0xe0] 32000 44100 48000
sad1_max_bitrate    640000
sad2_coding_type    [0x7] DTS
sad2_channels        6
sad2_rates        [0x6c0] 44100 48000 88200 96000
sad2_max_bitrate    1536000
sad3_coding_type    [0xa] E-AC-3/DD+ (Dolby Digital Plus)
sad3_channels        8
sad3_rates        [0xc0] 44100 48000
sad4_coding_type    [0xb] DTS-HD
sad4_channels        8
sad4_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000
sad5_coding_type    [0xc] MLP (Dolby TrueHD)
sad5_channels        8
sad5_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000

seem emulated ELD 's max bitrate are different from those in SAD of EDID


Do AC3 or DTS passthrough  hdmi work (using alsa and pulseaudio) or not ?

Do your Denon HDMI receiver support 7.1 ?

    Profiles:
        output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1,
sources: 0, priority: 400)
        output:hdmi-surround: Digital Surround 5.1 (HDMI) Output (sinks: 1,
sources: 0, priority: 3300)
        output:hdmi-stereo-extra1: Digital Stereo (HDMI) Output (sinks: 1,
sources: 0, priority: 200)
        output:hdmi-surround-extra1: Digital Surround 5.1 (HDMI) Output
(sinks: 1, sources: 0, priority: 3100)
        output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output (sinks: 1,
sources: 0, priority: 200)
        output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI) Output
(sinks: 1, sources: 0, priority: 3100)
        output:hdmi-stereo-extra3: Digital Stereo (HDMI) Output (sinks: 1,
sources: 0, priority: 200)
        output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI) Output
(sinks: 1, sources: 0, priority: 3100)

seem no 7.1 in pulseaudio ?

Do pulseaudio select the first HDMI as active port the default sink ?

I am not sure.
>

seem no output of pactl stat

http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa/mixer/profile-sets/extra-hdmi.conf

you may comment the last three hdmi devices until monitor_presence bug is
fixed

--089e010d9d407dce7104ed2e7252
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra">

<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e">


<div>Codec: ATI R6xx HDMI<br>Address: 0<br>AFG Function Id: 0x1 (unsol 0)<b=
r>Vendor Id: 0x1002aa01<br>Subsystem Id: 0x00aa0100<br>Revision Id: 0x10030=
0<br><br></div><div>seem that your codec may get Audio-Video Association Po=
rt ID and Sink Information for your DENON-AVAMP <br>

</div></div></div></div></blockquote></div></div></div></div></blockquote><=
div><br><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound=
.git/commit/sound/pci/hda/hda_eld.c?id=3D89250f84644676c1ed6a09acef1033e145=
96a402" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/tiwa=
i/sound.git/commit/sound/pci/hda/hda_eld.c?id=3D89250f84644676c1ed6a09acef1=
033e14596a402</a><br>

<br>Revision ID 3
and later (0x100300 as reported by procfs codec#X) have support for
providing more information than the previous revisions (but only if
supported by the display driver).<br><br>manufacture_id=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 0x0<br>product_id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0=
x0<br>port_id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x0<b=
r><br>you have to find out those values return by hda_codec_read ATI_VERB_G=
ET_SINK_INFO_DATA as your codec are revision 3 and your graphic driver got =
the product_id, manufacture_id, port_id<br>
<br>Manufacturer: DON Model 26 Serial Number 16843009<br>Made week 0 of 201=
1<br>
</div><div>Monitor name: DENON<br>
<div><br>Audio data block<br>=C2=A0=C2=A0=C2=A0 Linear PCM, max channels 7<=
br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 192 176.4 96 88.2 48 44=
.1 32<br>=C2=A0=C2=A0=C2=A0 Supported sample sizes (bits): 24 20 16<br>=C2=
=A0=C2=A0=C2=A0 DTS, max channels 5<br>=C2=A0=C2=A0=C2=A0 Supported sample =
rates (kHz): 96 88.2 48 44.1<br>
=C2=A0=C2=A0=C2=A0 Maximum bit rate: 1016 kHz<br>=C2=A0=C2=A0=C2=A0 AC-3, m=
ax channels 5<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 48 44.1 3=
2<br>=C2=A0=C2=A0=C2=A0 Maximum bit rate: 1016 kHz<br>=C2=A0=C2=A0=C2=A0 DT=
S-HD, max channels 7<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 19=
2 176.4 96 88.2 48 44.1<br>
=C2=A0=C2=A0=C2=A0 Dolby Digital+, max channels 7<br>=C2=A0=C2=A0=C2=A0 Sup=
ported sample rates (kHz): 48 44.1<br>=C2=A0=C2=A0=C2=A0 MAT (MLP), max cha=
nnels 7<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 192 176.4 96 88=
.2 48 44.1<br>=C2=A0 Speaker allocation data block<br><br>Do those SAD in E=
DID in xorg.log=C2=A0 match with the specification of your Denon HDMI recei=
ver ?<br>
<br>speakers=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x5f] FL/FR LFE FC RL/RR=
 RC RLC/RRC<br>sad_count=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 6<br>sad0_cod=
ing_type=C2=A0=C2=A0=C2=A0 [0x1] LPCM<br>sad0_channels=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 8<br>sad0_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x=
1ee0] 32000 44100 48000 88200 96000 176400 192000<br>sad0_bits=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 [0xe0000] 16 20 24<br>
sad1_coding_type=C2=A0=C2=A0=C2=A0 [0x2] AC-3<br>sad1_channels=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 6<br>sad1_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 [0xe0] 32000 44100 48000<br>sad1_max_bitrate=C2=A0=C2=A0=C2=A0 640000<b=
r>sad2_coding_type=C2=A0=C2=A0=C2=A0 [0x7] DTS<br>sad2_channels=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 6<br>sad2_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 [0x6c0] 44100 48000 88200 96000<br>
sad2_max_bitrate=C2=A0=C2=A0=C2=A0 1536000<br>sad3_coding_type=C2=A0=C2=A0=
=C2=A0 [0xa] E-AC-3/DD+ (Dolby Digital Plus)<br>sad3_channels=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 8<br>sad3_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 [0xc0] 44100 48000<br>sad4_coding_type=C2=A0=C2=A0=C2=A0 [0xb] DTS-HD<b=
r>sad4_channels=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8<br>sad4_rates=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x1ec0] 44100 48000 88200 96000 176400 192=
000<br>
sad5_coding_type=C2=A0=C2=A0=C2=A0 [0xc] MLP (Dolby TrueHD)<br>sad5_channel=
s=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8<br>sad5_rates=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 [0x1ec0] 44100 48000 88200 96000 176400 192000<br><br></=
div><div>seem emulated ELD &#39;s max bitrate are different from those in S=
AD of EDID<br>
</div><div><br><br></div><div>Do AC3 or DTS passthrough=C2=A0 hdmi work (us=
ing alsa and pulseaudio) or not ?<br></div><br>Do your Denon HDMI receiver =
support 7.1 ?<br><br>=C2=A0=C2=A0=C2=A0 Profiles:<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1,=
 sources: 0, priority: 400)<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-surround: Digital Surroun=
d 5.1 (HDMI) Output (sinks: 1, sources: 0, priority: 3300)<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-stereo-extra1: Digital St=
ereo (HDMI) Output (sinks: 1, sources: 0, priority: 200)<br>=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-surround-extra1: Digital Surround 5.1 (H=
DMI) Output (sinks: 1, sources: 0, priority: 3100)<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output =
(sinks: 1, sources: 0, priority: 200)<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-surround-extra2: Digital =
Surround 5.1 (HDMI) Output (sinks: 1, sources: 0, priority: 3100)<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-stereo-extra3: Digital Stereo (=
HDMI) Output (sinks: 1, sources: 0, priority: 200)<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI)=
 Output (sinks: 1, sources: 0, priority: 3100)<br>

<br></div><div>seem no 7.1 in pulseaudio ?<br><br><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra">Do pulseaudio select the first HDMI as active port the d=
efault sink ?<br>

<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div>I am no=
t sure.</div>

</div></div></div></blockquote><div><br></div><div>seem no output of pactl =
stat <br></div><br><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulsea=
udio/plain/src/modules/alsa/mixer/profile-sets/extra-hdmi.conf" target=3D"_=
blank">http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/=
alsa/mixer/profile-sets/extra-hdmi.conf</a><br>

<br></div><div>you may comment the last three hdmi devices until monitor_pr=
esence bug is fixed <br></div><div><br></div>=C2=A0<br></div></div></div>

--089e010d9d407dce7104ed2e7252--

--===============1212735271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1212735271==--
