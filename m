From: John Ettedgui <john.ettedgui@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Tue, 10 Dec 2013 06:18:29 -0800
Message-ID: <CAJ3TwYTQC0QFYhReUpLyR=S-VOJZsk7iCWb7H=Eg2sF0oyyHAA@mail.gmail.com>
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
	<CAN8cciZZhve=-BYNorv1Fhxr6P6-ZD47HY_gSx2DMXdRwQ+fbA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bf0c66464e35804ed2ec9ed
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAN8cciZZhve=-BYNorv1Fhxr6P6-ZD47HY_gSx2DMXdRwQ+fbA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

--047d7bf0c66464e35804ed2ec9ed
Content-Type: multipart/alternative; boundary=047d7bf0c66464e35504ed2ec9eb

--047d7bf0c66464e35504ed2ec9eb
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 10, 2013 at 5:54 AM, Raymond Yau <superquad.vortex2@gmail.com>wrote:

>
>  Codec: ATI R6xx HDMI
>>> Address: 0
>>> AFG Function Id: 0x1 (unsol 0)
>>> Vendor Id: 0x1002aa01
>>> Subsystem Id: 0x00aa0100
>>> Revision Id: 0x100300
>>>
>>> seem that your codec may get Audio-Video Association Port ID and Sink
>>> Information for your DENON-AVAMP
>>>
>>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_eld.c?id=89250f84644676c1ed6a09acef1033e14596a402
>
> Revision ID 3 and later (0x100300 as reported by procfs codec#X) have
> support for providing more information than the previous revisions (but
> only if supported by the display driver).
>
>
> manufacture_id        0x0
> product_id        0x0
> port_id            0x0
>
> you have to find out those values return by hda_codec_read
> ATI_VERB_GET_SINK_INFO_DATA as your codec are revision 3 and your graphic
> driver got the product_id, manufacture_id, port_id
>
>
> Manufacturer: DON Model 26 Serial Number 16843009
> Made week 0 of 2011
> Monitor name: DENON
>
> Audio data block
>     Linear PCM, max channels 7
>
    Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1 32
>
    Supported sample sizes (bits): 24 20 16
>     DTS, max channels 5
>     Supported sample rates (kHz): 96 88.2 48 44.1
>     Maximum bit rate: 1016 kHz
>     AC-3, max channels 5
>     Supported sample rates (kHz): 48 44.1 32
>     Maximum bit rate: 1016 kHz
>     DTS-HD, max channels 7
>     Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
>     Dolby Digital+, max channels 7
>     Supported sample rates (kHz): 48 44.1
>     MAT (MLP), max channels 7
>     Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
>   Speaker allocation data block
>
> Do those SAD in EDID in xorg.log  match with the specification of your
> Denon HDMI receiver ?
>
> I was not able to find all of these, but I found most of these and they do
match the receiver spec.

speakers        [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
> sad_count        6
> sad0_coding_type    [0x1] LPCM
> sad0_channels        8
> sad0_rates        [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
> sad0_bits        [0xe0000] 16 20 24
> sad1_coding_type    [0x2] AC-3
> sad1_channels        6
> sad1_rates        [0xe0] 32000 44100 48000
> sad1_max_bitrate    640000
> sad2_coding_type    [0x7] DTS
> sad2_channels        6
> sad2_rates        [0x6c0] 44100 48000 88200 96000
> sad2_max_bitrate    1536000
> sad3_coding_type    [0xa] E-AC-3/DD+ (Dolby Digital Plus)
> sad3_channels        8
> sad3_rates        [0xc0] 44100 48000
> sad4_coding_type    [0xb] DTS-HD
> sad4_channels        8
> sad4_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000
> sad5_coding_type    [0xc] MLP (Dolby TrueHD)
> sad5_channels        8
> sad5_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000
>
> seem emulated ELD 's max bitrate are different from those in SAD of EDID
>
>
> Do AC3 or DTS passthrough  hdmi work (using alsa and pulseaudio) or not ?
>
> Yes with both alsa and pulseaudio (in PA, I'm using my hacked extra hdmi
conf file and not the default one)

> Do your Denon HDMI receiver support 7.1 ?
>
> yes, but I have only have it setup for 5.1

>     Profiles:
>         output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1,
> sources: 0, priority: 400)
>         output:hdmi-surround: Digital Surround 5.1 (HDMI) Output (sinks:
> 1, sources: 0, priority: 3300)
>         output:hdmi-stereo-extra1: Digital Stereo (HDMI) Output (sinks: 1,
> sources: 0, priority: 200)
>         output:hdmi-surround-extra1: Digital Surround 5.1 (HDMI) Output
> (sinks: 1, sources: 0, priority: 3100)
>         output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output (sinks: 1,
> sources: 0, priority: 200)
>         output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI) Output
> (sinks: 1, sources: 0, priority: 3100)
>         output:hdmi-stereo-extra3: Digital Stereo (HDMI) Output (sinks: 1,
> sources: 0, priority: 200)
>         output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI) Output
> (sinks: 1, sources: 0, priority: 3100)
>
> seem no 7.1 in pulseaudio ?
>
> I setup pulse to 6 channels, maybe that is why?
Or maybe it is unrelated?

>
> Do pulseaudio select the first HDMI as active port the default sink ?
>
> I am not sure.
>>
>
> seem no output of pactl stat
>
Ooops

>
>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa/mixer/profile-sets/extra-hdmi.conf
>
> you may comment the last three hdmi devices until monitor_presence bug is
> fixed
>
> Oh I have already a hacked version of this file that works for me as
mentioned in first email, I will attach it.
John

--047d7bf0c66464e35504ed2ec9eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Dec 10, 2013 at 5:54 AM, Raymond Yau <span dir=3D"ltr">&lt;=
<a href=3D"mailto:superquad.vortex2@gmail.com" target=3D"_blank">superquad.=
vortex2@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><div class=3D"im"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra">

<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e">


<div>Codec: ATI R6xx HDMI<br>Address: 0<br>AFG Function Id: 0x1 (unsol 0)<b=
r>Vendor Id: 0x1002aa01<br>Subsystem Id: 0x00aa0100<br>Revision Id: 0x10030=
0<br><br></div><div>seem that your codec may get Audio-Video Association Po=
rt ID and Sink Information for your DENON-AVAMP <br>


</div></div></div></div></blockquote></div></div></div></div></blockquote><=
/div><div><br><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai=
/sound.git/commit/sound/pci/hda/hda_eld.c?id=3D89250f84644676c1ed6a09acef10=
33e14596a402" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/gi=
t/tiwai/sound.git/commit/sound/pci/hda/hda_eld.c?id=3D89250f84644676c1ed6a0=
9acef1033e14596a402</a><br>


<br>Revision ID 3
and later (0x100300 as reported by procfs codec#X) have support for
providing more information than the previous revisions (but only if
supported by the display driver).<div class=3D"im"><br><br>manufacture_id=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x0<br>product_id=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 0x0<br>port_id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 0x0<br><br></div>you have to find out those values return b=
y hda_codec_read ATI_VERB_GET_SINK_INFO_DATA as your codec are revision 3 a=
nd your graphic driver got the product_id, manufacture_id, port_id<div clas=
s=3D"im">
<br>
<br>Manufacturer: DON Model 26 Serial Number 16843009<br>Made week 0 of 201=
1<br>
</div></div><div>Monitor name: DENON<br>
<div><div class=3D"im"><br>Audio data block<br>=C2=A0=C2=A0=C2=A0 Linear PC=
M, max channels 7</div></div></div></div></div></div></blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div><div class=3D"im">=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 19=
2 176.4 96 88.2 48 44.1 32<span style=3D"color:rgb(34,34,34)">=C2=A0</span>=
</div></div></div></div></div>
</div></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><div><div class=3D"im">=
=C2=A0=C2=A0=C2=A0 Supported sample sizes (bits): 24 20 16<br>
=C2=A0=C2=A0=C2=A0 DTS, max channels 5<br>=C2=A0=C2=A0=C2=A0 Supported samp=
le rates (kHz): 96 88.2 48 44.1<br>
=C2=A0=C2=A0=C2=A0 Maximum bit rate: 1016 kHz<br>=C2=A0=C2=A0=C2=A0 AC-3, m=
ax channels 5<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 48 44.1 3=
2<br>=C2=A0=C2=A0=C2=A0 Maximum bit rate: 1016 kHz<br>=C2=A0=C2=A0=C2=A0 DT=
S-HD, max channels 7<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 19=
2 176.4 96 88.2 48 44.1<br>

=C2=A0=C2=A0=C2=A0 Dolby Digital+, max channels 7<br>=C2=A0=C2=A0=C2=A0 Sup=
ported sample rates (kHz): 48 44.1<br>=C2=A0=C2=A0=C2=A0 MAT (MLP), max cha=
nnels 7<br>=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 192 176.4 96 88=
.2 48 44.1<br>=C2=A0 Speaker allocation data block<br><br></div>
Do those SAD in EDID in xorg.log=C2=A0 match with the specification of your=
 Denon HDMI receiver ?<div class=3D"im"><br></div></div></div></div></div><=
/div></blockquote><div>I was not able to find all of these, but I found mos=
t of these and they do match the receiver spec.=C2=A0</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div><div class=3D"im">spe=
akers=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x5f] FL/FR LFE FC RL/RR RC RLC=
/RRC<br>
sad_count=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 6<br>sad0_coding_type=C2=A0=
=C2=A0=C2=A0 [0x1] LPCM<br>sad0_channels=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 8<br>sad0_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x1ee0] 32000 441=
00 48000 88200 96000 176400 192000<br>sad0_bits=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 [0xe0000] 16 20 24<br>
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
r>sad4_channels=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8<br>
sad4_rates=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [0x1ec0] 44100 48000 88200 =
96000 176400 192000<br>
sad5_coding_type=C2=A0=C2=A0=C2=A0 [0xc] MLP (Dolby TrueHD)<br>sad5_channel=
s=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8<br>sad5_rates=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 [0x1ec0] 44100 48000 88200 96000 176400 192000<br><br></=
div></div><div>seem emulated ELD &#39;s max bitrate are different from thos=
e in SAD of EDID<br>

</div><div><br><br></div><div>Do AC3 or DTS passthrough=C2=A0 hdmi work (us=
ing alsa and pulseaudio) or not ?<br></div><br></div></div></div></div></bl=
ockquote><div>Yes with both alsa and pulseaudio (in PA, I&#39;m using my ha=
cked extra hdmi conf file and not the default one)=C2=A0</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra">=
<div class=3D"gmail_quote"><div>Do your Denon HDMI receiver support 7.1 ?<b=
r><br>
</div></div></div></div></blockquote><div>yes, but I have only have it setu=
p for 5.1=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div c=
lass=3D"gmail_extra">
<div class=3D"gmail_quote"><div>=C2=A0=C2=A0=C2=A0 Profiles:<br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:hdmi-stereo: Digital Stereo (HDMI) Outp=
ut (sinks: 1, sources: 0, priority: 400)<br>
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


<br></div><div>seem no 7.1 in pulseaudio ?<div class=3D"im"><br></div></div=
></div></div></div></blockquote><div>I setup pulse to 6 channels, maybe tha=
t is why?</div><div>Or maybe it is unrelated?=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div class=3D"im"><br><div dir=3D"ltr"><div class=3D"gmail_extra">Do pulse=
audio select the first HDMI as active port the default sink ?<br>

<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div>I am no=
t sure.</div>


</div></div></div></blockquote><div><br></div></div><div>seem no output of =
pactl stat <br></div></div></div></div></div></blockquote><div>Ooops=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div></div><br><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudi=
o/plain/src/modules/alsa/mixer/profile-sets/extra-hdmi.conf" target=3D"_bla=
nk">http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/als=
a/mixer/profile-sets/extra-hdmi.conf</a><br>


<br></div><div>you may comment the last three hdmi devices until monitor_pr=
esence bug is fixed <br></div><div><br></div></div></div></div></blockquote=
><div>Oh I have already a hacked version of this file that works for me as =
mentioned in first email, I will attach it.=C2=A0</div>
</div>John</div></div>

--047d7bf0c66464e35504ed2ec9eb--

--047d7bf0c66464e35804ed2ec9ed
Content-Type: text/plain; charset=UTF-8; name="pactllist.txt"
Content-Disposition: attachment; filename="pactllist.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hp18gz740

TW9kdWxlICMwCglOYW1lOiBtb2R1bGUtZGV2aWNlLXJlc3RvcmUKCUFyZ3VtZW50OiAKCVVzYWdl
IGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkxlbm5hcnQgUG9l
dHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiQXV0b21hdGljYWxseSByZXN0b3JlIHRo
ZSB2b2x1bWUvbXV0ZSBzdGF0ZSBvZiBkZXZpY2VzIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0y
NzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzEKCU5hbWU6IG1vZHVsZS1zdHJlYW0tcmVzdG9yZQoJ
QXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1vZHVsZS5hdXRo
b3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9ICJBdXRvbWF0
aWNhbGx5IHJlc3RvcmUgdGhlIHZvbHVtZS9tdXRlL2RldmljZSBzdGF0ZSBvZiBzdHJlYW1zIgoJ
CW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzIKCU5hbWU6
IG1vZHVsZS1jYXJkLXJlc3RvcmUKCUFyZ3VtZW50OiAKCVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJv
cGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkxlbm5hcnQgUG9ldHRlcmluZyIKCQltb2R1bGUu
ZGVzY3JpcHRpb24gPSAiQXV0b21hdGljYWxseSByZXN0b3JlIHByb2ZpbGUgb2YgY2FyZHMiCgkJ
bW9kdWxlLnZlcnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAjMwoJTmFtZTog
bW9kdWxlLWF1Z21lbnQtcHJvcGVydGllcwoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9h
CglQcm9wZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1v
ZHVsZS5kZXNjcmlwdGlvbiA9ICJBdWdtZW50IHRoZSBwcm9wZXJ0eSBzZXRzIG9mIHN0cmVhbXMg
d2l0aCBhZGRpdGlvbmFsIHN0YXRpYyBpbmZvcm1hdGlvbiIKCQltb2R1bGUudmVyc2lvbiA9ICI0
LjAtMjcxLWcwOWU4LWRpcnR5IgoKTW9kdWxlICM0CglOYW1lOiBtb2R1bGUtc3dpdGNoLW9uLXBv
cnQtYXZhaWxhYmxlCglBcmd1bWVudDogCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6
CgkJCgpNb2R1bGUgIzUKCU5hbWU6IG1vZHVsZS11ZGV2LWRldGVjdAoJQXJndW1lbnQ6IHRzY2hl
ZD0wCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhvciA9ICJM
ZW5uYXJ0IFBvZXR0ZXJpbmciCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIkRldGVjdCBhdmFpbGFi
bGUgYXVkaW8gaGFyZHdhcmUgYW5kIGxvYWQgbWF0Y2hpbmcgZHJpdmVycyIKCQltb2R1bGUudmVy
c2lvbiA9ICI0LjAtMjcxLWcwOWU4LWRpcnR5IgoKTW9kdWxlICM2CglOYW1lOiBtb2R1bGUtYWxz
YS1jYXJkCglBcmd1bWVudDogZGV2aWNlX2lkPSIwIiBuYW1lPSJwY2ktMDAwMF8wMV8wMC4xIiBj
YXJkX25hbWU9ImFsc2FfY2FyZC5wY2ktMDAwMF8wMV8wMC4xIiBuYW1lcmVnX2ZhaWw9ZmFsc2Ug
dHNjaGVkPW5vIGZpeGVkX2xhdGVuY3lfcmFuZ2U9bm8gaWdub3JlX2RCPW5vIGRlZmVycmVkX3Zv
bHVtZT15ZXMgdXNlX3VjbT15ZXMgY2FyZF9wcm9wZXJ0aWVzPSJtb2R1bGUtdWRldi1kZXRlY3Qu
ZGlzY292ZXJlZD0xIgoJVXNhZ2UgY291bnRlcjogMAoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0
aG9yID0gIkxlbm5hcnQgUG9ldHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiQUxTQSBD
YXJkIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzcK
CU5hbWU6IG1vZHVsZS1qYWNrZGJ1cy1kZXRlY3QKCUFyZ3VtZW50OiBjaGFubmVscz0yCglVc2Fn
ZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhvciA9ICJEYXZpZCBIZW5u
aW5nc3NvbiIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiQWRkcyBKQUNLIHNpbmsvc291cmNlIHBv
cnRzIHdoZW4gSkFDSyBpcyBzdGFydGVkIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5
ZTgtZGlydHkiCgpNb2R1bGUgIzgKCU5hbWU6IG1vZHVsZS1ibHVldG9vdGgtcG9saWN5CglBcmd1
bWVudDogCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhvciA9
ICJGcsOpZMOpcmljIERhbGxlYXUiCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIldoZW4gYSBibHVl
dG9vdGggc2luayBvciBzb3VyY2UgaXMgYWRkZWQsIGxvYWQgbW9kdWxlLWxvb3BiYWNrIgoJCW1v
ZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzkKCU5hbWU6IG1v
ZHVsZS1ibHVldG9vdGgtZGlzY292ZXIKCUFyZ3VtZW50OiAKCVVzYWdlIGNvdW50ZXI6IG4vYQoJ
UHJvcGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkpvw6NvIFBhdWxvIFJlY2hpIFZpdGEiCgkJ
bW9kdWxlLmRlc2NyaXB0aW9uID0gIkRldGVjdCBhdmFpbGFibGUgQmx1ZXRvb3RoIGRhZW1vbiBh
bmQgbG9hZCB0aGUgY29ycmVzcG9uZGluZyBkaXNjb3ZlcnkgbW9kdWxlIgoJCW1vZHVsZS52ZXJz
aW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzEwCglOYW1lOiBtb2R1bGUtYmx1
ZXo1LWRpc2NvdmVyCglBcmd1bWVudDogCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6
CgkJbW9kdWxlLmF1dGhvciA9ICJKb8OjbyBQYXVsbyBSZWNoaSBWaXRhIgoJCW1vZHVsZS5kZXNj
cmlwdGlvbiA9ICJEZXRlY3QgYXZhaWxhYmxlIEJsdWVaIDUgQmx1ZXRvb3RoIGF1ZGlvIGRldmlj
ZXMgYW5kIGxvYWQgQmx1ZVogNSBCbHVldG9vdGggYXVkaW8gZHJpdmVycyIKCQltb2R1bGUudmVy
c2lvbiA9ICI0LjAtMjcxLWcwOWU4LWRpcnR5IgoKTW9kdWxlICMxMQoJTmFtZTogbW9kdWxlLWJs
dWV6NC1kaXNjb3ZlcgoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVz
OgoJCW1vZHVsZS5hdXRob3IgPSAiSm/Do28gUGF1bG8gUmVjaGkgVml0YSIKCQltb2R1bGUuZGVz
Y3JpcHRpb24gPSAiRGV0ZWN0IGF2YWlsYWJsZSBCbHVlWiA0IEJsdWV0b290aCBhdWRpbyBkZXZp
Y2VzIGFuZCBsb2FkIEJsdWVaIDQgQmx1ZXRvb3RoIGF1ZGlvIGRyaXZlcnMiCgkJbW9kdWxlLnZl
cnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAjMTIKCU5hbWU6IG1vZHVsZS1l
c291bmQtcHJvdG9jb2wtdW5peAoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9w
ZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5k
ZXNjcmlwdGlvbiA9ICJFU09VTkQgcHJvdG9jb2wgKFVOSVggc29ja2V0cykiCgkJbW9kdWxlLnZl
cnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAjMTMKCU5hbWU6IG1vZHVsZS1u
YXRpdmUtcHJvdG9jb2wtdW5peAoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9w
ZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5k
ZXNjcmlwdGlvbiA9ICJOYXRpdmUgcHJvdG9jb2wgKFVOSVggc29ja2V0cykiCgkJbW9kdWxlLnZl
cnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAjMTQKCU5hbWU6IG1vZHVsZS1n
Y29uZgoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1vZHVs
ZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9ICJH
Q29uZiBBZGFwdGVyIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpN
b2R1bGUgIzE1CglOYW1lOiBtb2R1bGUtZGVmYXVsdC1kZXZpY2UtcmVzdG9yZQoJQXJndW1lbnQ6
IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVu
bmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9ICJBdXRvbWF0aWNhbGx5IHJl
c3RvcmUgdGhlIGRlZmF1bHQgc2luayBhbmQgc291cmNlIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQu
MC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzE2CglOYW1lOiBtb2R1bGUtcmVzY3VlLXN0cmVh
bXMKCUFyZ3VtZW50OiAKCVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUu
YXV0aG9yID0gIkxlbm5hcnQgUG9ldHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiV2hl
biBhIHNpbmsvc291cmNlIGlzIHJlbW92ZWQsIHRyeSB0byBtb3ZlIGl0cyBzdHJlYW1zIHRvIHRo
ZSBkZWZhdWx0IHNpbmsvc291cmNlIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgt
ZGlydHkiCgpNb2R1bGUgIzE3CglOYW1lOiBtb2R1bGUtYWx3YXlzLXNpbmsKCUFyZ3VtZW50OiAK
CVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkNvbGlu
IEd1dGhyaWUiCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIkFsd2F5cyBrZWVwcyBhdCBsZWFzdCBv
bmUgc2luayBsb2FkZWQgZXZlbiBpZiBpdCdzIGEgbnVsbCBvbmUiCgkJbW9kdWxlLnZlcnNpb24g
PSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAjMTgKCU5hbWU6IG1vZHVsZS1pbnRlbmRl
ZC1yb2xlcwoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1v
ZHVsZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9
ICJBdXRvbWF0aWNhbGx5IHNldCBkZXZpY2Ugb2Ygc3RyZWFtcyBiYXNlZCBvbiBpbnRlbmRlZCBy
b2xlcyBvZiBkZXZpY2VzIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHki
CgpNb2R1bGUgIzE5CglOYW1lOiBtb2R1bGUtc3VzcGVuZC1vbi1pZGxlCglBcmd1bWVudDogCglV
c2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhvciA9ICJMZW5uYXJ0
IFBvZXR0ZXJpbmciCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIldoZW4gYSBzaW5rL3NvdXJjZSBp
cyBpZGxlIGZvciB0b28gbG9uZywgc3VzcGVuZCBpdCIKCQltb2R1bGUudmVyc2lvbiA9ICI0LjAt
MjcxLWcwOWU4LWRpcnR5IgoKTW9kdWxlICMyMAoJTmFtZTogbW9kdWxlLWNvbnNvbGUta2l0CglB
cmd1bWVudDogCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhv
ciA9ICJMZW5uYXJ0IFBvZXR0ZXJpbmciCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIkNyZWF0ZSBh
IGNsaWVudCBmb3IgZWFjaCBDb25zb2xlS2l0IHNlc3Npb24gb2YgdGhpcyB1c2VyIgoJCW1vZHVs
ZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzIxCglOYW1lOiBtb2R1
bGUtc3lzdGVtZC1sb2dpbgoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0
aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVubmFydCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNj
cmlwdGlvbiA9ICJDcmVhdGUgYSBjbGllbnQgZm9yIGVhY2ggbG9naW4gc2Vzc2lvbiBvZiB0aGlz
IHVzZXIiCgkJbW9kdWxlLnZlcnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAj
MjIKCU5hbWU6IG1vZHVsZS1wb3NpdGlvbi1ldmVudC1zb3VuZHMKCUFyZ3VtZW50OiAKCVVzYWdl
IGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkxlbm5hcnQgUG9l
dHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiUG9zaXRpb24gZXZlbnQgc291bmRzIGJl
dHdlZW4gTCBhbmQgUiBkZXBlbmRpbmcgb24gdGhlIHBvc2l0aW9uIG9uIHNjcmVlbiBvZiB0aGUg
d2lkZ2V0IHRyaWdnZXJpbmcgdGhlbS4iCgkJbW9kdWxlLnZlcnNpb24gPSAiNC4wLTI3MS1nMDll
OC1kaXJ0eSIKCk1vZHVsZSAjMjMKCU5hbWU6IG1vZHVsZS1yb2xlLWNvcmsKCUFyZ3VtZW50OiAK
CVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0aG9yID0gIkxlbm5h
cnQgUG9ldHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiTXV0ZSAmIGNvcmsgc3RyZWFt
cyB3aXRoIGNlcnRhaW4gcm9sZXMgd2hpbGUgb3RoZXJzIGV4aXN0IgoJCW1vZHVsZS52ZXJzaW9u
ID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzI0CglOYW1lOiBtb2R1bGUtZmlsdGVy
LWhldXJpc3RpY3MKCUFyZ3VtZW50OiAKCVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoK
CQltb2R1bGUuYXV0aG9yID0gIkNvbGluIEd1dGhyaWUiCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0g
IkRldGVjdCB3aGVuIHZhcmlvdXMgZmlsdGVycyBhcmUgZGVzaXJhYmxlIgoJCW1vZHVsZS52ZXJz
aW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzI1CglOYW1lOiBtb2R1bGUtZmls
dGVyLWFwcGx5CglBcmd1bWVudDogCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJ
bW9kdWxlLmF1dGhvciA9ICJDb2xpbiBHdXRocmllIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9ICJM
b2FkIGZpbHRlciBzaW5rcyBhdXRvbWF0aWNhbGx5IHdoZW4gbmVlZGVkIgoJCW1vZHVsZS52ZXJz
aW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHkiCgpNb2R1bGUgIzI2CglOYW1lOiBtb2R1bGUtZGJ1
cy1wcm90b2NvbAoJQXJndW1lbnQ6IAoJVXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJ
CW1vZHVsZS5hdXRob3IgPSAiVGFudSBLYXNraW5lbiIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAi
RC1CdXMgaW50ZXJmYWNlIgoJCW1vZHVsZS52ZXJzaW9uID0gIjQuMC0yNzEtZzA5ZTgtZGlydHki
CgpTaW5rICMwCglTdGF0ZTogU1VTUEVOREVECglOYW1lOiBhbHNhX291dHB1dC5wY2ktMDAwMF8w
MV8wMC4xLmhkbWktc3Vycm91bmQtZXh0cmExCglEZXNjcmlwdGlvbjogQ2FwZSBWZXJkZS9QaXRj
YWlybiBIRE1JIEF1ZGlvIFtSYWRlb24gSEQgNzcwMC83ODAwIFNlcmllc10gRGlnaXRhbCBTdXJy
b3VuZCA1LjEgKEhETUkpCglEcml2ZXI6IG1vZHVsZS1hbHNhLWNhcmQuYwoJU2FtcGxlIFNwZWNp
ZmljYXRpb246IHMxNmxlIDZjaCA0ODAwMEh6CglDaGFubmVsIE1hcDogZnJvbnQtbGVmdCxmcm9u
dC1yaWdodCxyZWFyLWxlZnQscmVhci1yaWdodCxmcm9udC1jZW50ZXIsbGZlCglPd25lciBNb2R1
bGU6IDYKCU11dGU6IG5vCglWb2x1bWU6IGZyb250LWxlZnQ6IDY1NTM2IC8gMTAwJSAvIDAuMDAg
ZEIsICAgZnJvbnQtcmlnaHQ6IDY1NTM2IC8gMTAwJSAvIDAuMDAgZEIsICAgcmVhci1sZWZ0OiA2
NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIHJlYXItcmlnaHQ6IDY1NTM2IC8gMTAwJSAvIDAuMDAg
ZEIsICAgZnJvbnQtY2VudGVyOiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIGxmZTogNjU1MzYg
LyAxMDAlIC8gMC4wMCBkQgoJICAgICAgICBiYWxhbmNlIDAuMDAKCUJhc2UgVm9sdW1lOiA2NTUz
NiAvIDEwMCUgLyAwLjAwIGRCCglNb25pdG9yIFNvdXJjZTogYWxzYV9vdXRwdXQucGNpLTAwMDBf
MDFfMDAuMS5oZG1pLXN1cnJvdW5kLWV4dHJhMS5tb25pdG9yCglMYXRlbmN5OiAwIHVzZWMsIGNv
bmZpZ3VyZWQgMCB1c2VjCglGbGFnczogSEFSRFdBUkUgREVDSUJFTF9WT0xVTUUgTEFURU5DWSBT
RVRfRk9STUFUUyAKCVByb3BlcnRpZXM6CgkJYWxzYS5yZXNvbHV0aW9uX2JpdHMgPSAiMTYiCgkJ
ZGV2aWNlLmFwaSA9ICJhbHNhIgoJCWRldmljZS5jbGFzcyA9ICJzb3VuZCIKCQlhbHNhLmNsYXNz
ID0gImdlbmVyaWMiCgkJYWxzYS5zdWJjbGFzcyA9ICJnZW5lcmljLW1peCIKCQlhbHNhLm5hbWUg
PSAiSERNSSAxIgoJCWFsc2EuaWQgPSAiSERNSSAxIgoJCWFsc2Euc3ViZGV2aWNlID0gIjAiCgkJ
YWxzYS5zdWJkZXZpY2VfbmFtZSA9ICJzdWJkZXZpY2UgIzAiCgkJYWxzYS5kZXZpY2UgPSAiNyIK
CQlhbHNhLmNhcmQgPSAiMCIKCQlhbHNhLmNhcmRfbmFtZSA9ICJIREEgQVRJIEhETUkiCgkJYWxz
YS5sb25nX2NhcmRfbmFtZSA9ICJIREEgQVRJIEhETUkgYXQgMHhmYmNmYzAwMCBpcnEgNDciCgkJ
YWxzYS5kcml2ZXJfbmFtZSA9ICJzbmRfaGRhX2ludGVsIgoJCWRldmljZS5idXNfcGF0aCA9ICJw
Y2ktMDAwMDowMTowMC4xIgoJCXN5c2ZzLnBhdGggPSAiL2RldmljZXMvcGNpMDAwMDowMC8wMDAw
OjAwOjAzLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQwIgoJCWRldmljZS5idXMgPSAicGNpIgoJ
CWRldmljZS52ZW5kb3IuaWQgPSAiMTAwMiIKCQlkZXZpY2UudmVuZG9yLm5hbWUgPSAiQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0iCgkJZGV2aWNlLnByb2R1Y3QuaWQgPSAi
YWFiMCIKCQlkZXZpY2UucHJvZHVjdC5uYW1lID0gIkNhcGUgVmVyZGUvUGl0Y2Fpcm4gSERNSSBB
dWRpbyBbUmFkZW9uIEhEIDc3MDAvNzgwMCBTZXJpZXNdIgoJCWRldmljZS5zdHJpbmcgPSAiaGRt
aTowLDEiCgkJZGV2aWNlLmJ1ZmZlcmluZy5idWZmZXJfc2l6ZSA9ICI1NzYwMCIKCQlkZXZpY2Uu
YnVmZmVyaW5nLmZyYWdtZW50X3NpemUgPSAiMTE1MjAiCgkJZGV2aWNlLmFjY2Vzc19tb2RlID0g
Im1tYXAiCgkJZGV2aWNlLnByb2ZpbGUubmFtZSA9ICJoZG1pLXN1cnJvdW5kLWV4dHJhMSIKCQlk
ZXZpY2UucHJvZmlsZS5kZXNjcmlwdGlvbiA9ICJEaWdpdGFsIFN1cnJvdW5kIDUuMSAoSERNSSki
CgkJZGV2aWNlLmRlc2NyaXB0aW9uID0gIkNhcGUgVmVyZGUvUGl0Y2Fpcm4gSERNSSBBdWRpbyBb
UmFkZW9uIEhEIDc3MDAvNzgwMCBTZXJpZXNdIERpZ2l0YWwgU3Vycm91bmQgNS4xIChIRE1JKSIK
CQlhbHNhLm1peGVyX25hbWUgPSAiQVRJIFI2eHggSERNSSIKCQlhbHNhLmNvbXBvbmVudHMgPSAi
SERBOjEwMDJhYTAxLDAwYWEwMTAwLDAwMTAwMzAwIgoJCW1vZHVsZS11ZGV2LWRldGVjdC5kaXNj
b3ZlcmVkID0gIjEiCgkJZGV2aWNlLmljb25fbmFtZSA9ICJhdWRpby1jYXJkLXBjaSIKCVBvcnRz
OgoJCWhkbWktb3V0cHV0LTE6IEhETUkgLyBEaXNwbGF5UG9ydCAyIChwcmlvcml0eTogNTgwMCwg
YXZhaWxhYmxlKQoJQWN0aXZlIFBvcnQ6IGhkbWktb3V0cHV0LTEKCUZvcm1hdHM6CgkJcGNtCgpT
b3VyY2UgIzAKCVN0YXRlOiBTVVNQRU5ERUQKCU5hbWU6IGFsc2Ffb3V0cHV0LnBjaS0wMDAwXzAx
XzAwLjEuaGRtaS1zdXJyb3VuZC1leHRyYTEubW9uaXRvcgoJRGVzY3JpcHRpb246IE1vbml0b3Ig
b2YgQ2FwZSBWZXJkZS9QaXRjYWlybiBIRE1JIEF1ZGlvIFtSYWRlb24gSEQgNzcwMC83ODAwIFNl
cmllc10gRGlnaXRhbCBTdXJyb3VuZCA1LjEgKEhETUkpCglEcml2ZXI6IG1vZHVsZS1hbHNhLWNh
cmQuYwoJU2FtcGxlIFNwZWNpZmljYXRpb246IHMxNmxlIDZjaCA0ODAwMEh6CglDaGFubmVsIE1h
cDogZnJvbnQtbGVmdCxmcm9udC1yaWdodCxyZWFyLWxlZnQscmVhci1yaWdodCxmcm9udC1jZW50
ZXIsbGZlCglPd25lciBNb2R1bGU6IDYKCU11dGU6IG5vCglWb2x1bWU6IGZyb250LWxlZnQ6IDY1
NTM2IC8gMTAwJSAvIDAuMDAgZEIsICAgZnJvbnQtcmlnaHQ6IDY1NTM2IC8gMTAwJSAvIDAuMDAg
ZEIsICAgcmVhci1sZWZ0OiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIHJlYXItcmlnaHQ6IDY1
NTM2IC8gMTAwJSAvIDAuMDAgZEIsICAgZnJvbnQtY2VudGVyOiA2NTUzNiAvIDEwMCUgLyAwLjAw
IGRCLCAgIGxmZTogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQgoJICAgICAgICBiYWxhbmNlIDAuMDAK
CUJhc2UgVm9sdW1lOiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCCglNb25pdG9yIG9mIFNpbms6IGFs
c2Ffb3V0cHV0LnBjaS0wMDAwXzAxXzAwLjEuaGRtaS1zdXJyb3VuZC1leHRyYTEKCUxhdGVuY3k6
IDAgdXNlYywgY29uZmlndXJlZCAwIHVzZWMKCUZsYWdzOiBERUNJQkVMX1ZPTFVNRSBMQVRFTkNZ
IAoJUHJvcGVydGllczoKCQlkZXZpY2UuZGVzY3JpcHRpb24gPSAiTW9uaXRvciBvZiBDYXBlIFZl
cmRlL1BpdGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3NzAwLzc4MDAgU2VyaWVzXSBEaWdp
dGFsIFN1cnJvdW5kIDUuMSAoSERNSSkiCgkJZGV2aWNlLmNsYXNzID0gIm1vbml0b3IiCgkJYWxz
YS5jYXJkID0gIjAiCgkJYWxzYS5jYXJkX25hbWUgPSAiSERBIEFUSSBIRE1JIgoJCWFsc2EubG9u
Z19jYXJkX25hbWUgPSAiSERBIEFUSSBIRE1JIGF0IDB4ZmJjZmMwMDAgaXJxIDQ3IgoJCWFsc2Eu
ZHJpdmVyX25hbWUgPSAic25kX2hkYV9pbnRlbCIKCQlkZXZpY2UuYnVzX3BhdGggPSAicGNpLTAw
MDA6MDE6MDAuMSIKCQlzeXNmcy5wYXRoID0gIi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDow
My4wLzAwMDA6MDE6MDAuMS9zb3VuZC9jYXJkMCIKCQlkZXZpY2UuYnVzID0gInBjaSIKCQlkZXZp
Y2UudmVuZG9yLmlkID0gIjEwMDIiCgkJZGV2aWNlLnZlbmRvci5uYW1lID0gIkFkdmFuY2VkIE1p
Y3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIgoJCWRldmljZS5wcm9kdWN0LmlkID0gImFhYjAi
CgkJZGV2aWNlLnByb2R1Y3QubmFtZSA9ICJDYXBlIFZlcmRlL1BpdGNhaXJuIEhETUkgQXVkaW8g
W1JhZGVvbiBIRCA3NzAwLzc4MDAgU2VyaWVzXSIKCQlkZXZpY2Uuc3RyaW5nID0gIjAiCgkJbW9k
dWxlLXVkZXYtZGV0ZWN0LmRpc2NvdmVyZWQgPSAiMSIKCQlkZXZpY2UuaWNvbl9uYW1lID0gImF1
ZGlvLWNhcmQtcGNpIgoJRm9ybWF0czoKCQlwY20KCkNsaWVudCAjMAoJRHJpdmVyOiBtb2R1bGUt
c3lzdGVtZC1sb2dpbi5jCglPd25lciBNb2R1bGU6IDIxCglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0
aW9uLm5hbWUgPSAiTG9naW4gU2Vzc2lvbiAxIgoJCXN5c3RlbWQtbG9naW4uc2Vzc2lvbiA9ICIx
IgoKQ2xpZW50ICMzCglEcml2ZXI6IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBNb2R1bGU6IDEz
CglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0aW9uLm5hbWUgPSAicGFjdGwiCgkJbmF0aXZlLXByb3Rv
Y29sLnBlZXIgPSAiVU5JWCBzb2NrZXQgY2xpZW50IgoJCW5hdGl2ZS1wcm90b2NvbC52ZXJzaW9u
ID0gIjI4IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuaWQgPSAiNDI0NSIKCQlhcHBsaWNhdGlvbi5w
cm9jZXNzLnVzZXIgPSAiam9obiIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLmhvc3QgPSAiSFRQQyIK
CQlhcHBsaWNhdGlvbi5wcm9jZXNzLmJpbmFyeSA9ICJwYWN0bCIKCQlhcHBsaWNhdGlvbi5sYW5n
dWFnZSA9ICJlbl9VUy5VVEYtOCIKCQl3aW5kb3cueDExLmRpc3BsYXkgPSAiOjAiCgkJYXBwbGlj
YXRpb24ucHJvY2Vzcy5tYWNoaW5lX2lkID0gIjVjZDNlYmI4ODQyOThmOGRmNTdiMWU0MzAwMDAw
M2JjIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3Muc2Vzc2lvbl9pZCA9ICIxIgoKQ2FyZCAjMAoJTmFt
ZTogYWxzYV9jYXJkLnBjaS0wMDAwXzAxXzAwLjEKCURyaXZlcjogbW9kdWxlLWFsc2EtY2FyZC5j
CglPd25lciBNb2R1bGU6IDYKCVByb3BlcnRpZXM6CgkJYWxzYS5jYXJkID0gIjAiCgkJYWxzYS5j
YXJkX25hbWUgPSAiSERBIEFUSSBIRE1JIgoJCWFsc2EubG9uZ19jYXJkX25hbWUgPSAiSERBIEFU
SSBIRE1JIGF0IDB4ZmJjZmMwMDAgaXJxIDQ3IgoJCWFsc2EuZHJpdmVyX25hbWUgPSAic25kX2hk
YV9pbnRlbCIKCQlkZXZpY2UuYnVzX3BhdGggPSAicGNpLTAwMDA6MDE6MDAuMSIKCQlzeXNmcy5w
YXRoID0gIi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMy4wLzAwMDA6MDE6MDAuMS9zb3Vu
ZC9jYXJkMCIKCQlkZXZpY2UuYnVzID0gInBjaSIKCQlkZXZpY2UudmVuZG9yLmlkID0gIjEwMDIi
CgkJZGV2aWNlLnZlbmRvci5uYW1lID0gIkFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FN
RC9BVEldIgoJCWRldmljZS5wcm9kdWN0LmlkID0gImFhYjAiCgkJZGV2aWNlLnByb2R1Y3QubmFt
ZSA9ICJDYXBlIFZlcmRlL1BpdGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3NzAwLzc4MDAg
U2VyaWVzXSIKCQlkZXZpY2Uuc3RyaW5nID0gIjAiCgkJZGV2aWNlLmRlc2NyaXB0aW9uID0gIkNh
cGUgVmVyZGUvUGl0Y2Fpcm4gSERNSSBBdWRpbyBbUmFkZW9uIEhEIDc3MDAvNzgwMCBTZXJpZXNd
IgoJCW1vZHVsZS11ZGV2LWRldGVjdC5kaXNjb3ZlcmVkID0gIjEiCgkJZGV2aWNlLmljb25fbmFt
ZSA9ICJhdWRpby1jYXJkLXBjaSIKCVByb2ZpbGVzOgoJCW91dHB1dDpoZG1pLXN0ZXJlbzogRGln
aXRhbCBTdGVyZW8gKEhETUkpIE91dHB1dCAoc2lua3M6IDEsIHNvdXJjZXM6IDAsIHByaW9yaXR5
OiA0MDApCgkJb3V0cHV0OmhkbWktc3Vycm91bmQ6IERpZ2l0YWwgU3Vycm91bmQgNS4xIChIRE1J
KSBPdXRwdXQgKHNpbmtzOiAxLCBzb3VyY2VzOiAwLCBwcmlvcml0eTogMzMwMCkKCQlvdXRwdXQ6
aGRtaS1zdGVyZW8tZXh0cmExOiBEaWdpdGFsIFN0ZXJlbyAoSERNSSkgT3V0cHV0IChzaW5rczog
MSwgc291cmNlczogMCwgcHJpb3JpdHk6IDIwMCkKCQlvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRy
YTE6IERpZ2l0YWwgU3Vycm91bmQgNS4xIChIRE1JKSBPdXRwdXQgKHNpbmtzOiAxLCBzb3VyY2Vz
OiAwLCBwcmlvcml0eTogMzEwMCkKCQlvdXRwdXQ6aGRtaS1zdGVyZW8tZXh0cmEyOiBEaWdpdGFs
IFN0ZXJlbyAoSERNSSkgT3V0cHV0IChzaW5rczogMSwgc291cmNlczogMCwgcHJpb3JpdHk6IDIw
MCkKCQlvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTI6IERpZ2l0YWwgU3Vycm91bmQgNS4xIChI
RE1JKSBPdXRwdXQgKHNpbmtzOiAxLCBzb3VyY2VzOiAwLCBwcmlvcml0eTogMzEwMCkKCQlvdXRw
dXQ6aGRtaS1zdGVyZW8tZXh0cmEzOiBEaWdpdGFsIFN0ZXJlbyAoSERNSSkgT3V0cHV0IChzaW5r
czogMSwgc291cmNlczogMCwgcHJpb3JpdHk6IDIwMCkKCQlvdXRwdXQ6aGRtaS1zdXJyb3VuZC1l
eHRyYTM6IERpZ2l0YWwgU3Vycm91bmQgNS4xIChIRE1JKSBPdXRwdXQgKHNpbmtzOiAxLCBzb3Vy
Y2VzOiAwLCBwcmlvcml0eTogMzEwMCkKCQlvZmY6IE9mZiAoc2lua3M6IDAsIHNvdXJjZXM6IDAs
IHByaW9yaXR5OiAwKQoJQWN0aXZlIFByb2ZpbGU6IG91dHB1dDpoZG1pLXN1cnJvdW5kLWV4dHJh
MQoJUG9ydHM6CgkJaGRtaS1vdXRwdXQtMDogSERNSSAvIERpc3BsYXlQb3J0IChwcmlvcml0eTog
NTkwMCwgbGF0ZW5jeSBvZmZzZXQ6IDAgdXNlYywgYXZhaWxhYmxlKQoJCQlQcm9wZXJ0aWVzOgoJ
CQkJZGV2aWNlLmljb25fbmFtZSA9ICJ2aWRlby1kaXNwbGF5IgoJCQlQYXJ0IG9mIHByb2ZpbGUo
cyk6IG91dHB1dDpoZG1pLXN0ZXJlbywgb3V0cHV0OmhkbWktc3Vycm91bmQKCQloZG1pLW91dHB1
dC0xOiBIRE1JIC8gRGlzcGxheVBvcnQgMiAocHJpb3JpdHk6IDU4MDAsIGxhdGVuY3kgb2Zmc2V0
OiAwIHVzZWMsIGF2YWlsYWJsZSkKCQkJUHJvcGVydGllczoKCQkJCWRldmljZS5pY29uX25hbWUg
PSAidmlkZW8tZGlzcGxheSIKCQkJUGFydCBvZiBwcm9maWxlKHMpOiBvdXRwdXQ6aGRtaS1zdGVy
ZW8tZXh0cmExLCBvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTEKCQloZG1pLW91dHB1dC0yOiBI
RE1JIC8gRGlzcGxheVBvcnQgMyAocHJpb3JpdHk6IDU3MDAsIGxhdGVuY3kgb2Zmc2V0OiAwIHVz
ZWMsIGF2YWlsYWJsZSkKCQkJUHJvcGVydGllczoKCQkJCWRldmljZS5pY29uX25hbWUgPSAidmlk
ZW8tZGlzcGxheSIKCQkJUGFydCBvZiBwcm9maWxlKHMpOiBvdXRwdXQ6aGRtaS1zdGVyZW8tZXh0
cmEyLCBvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTIKCQloZG1pLW91dHB1dC0zOiBIRE1JIC8g
RGlzcGxheVBvcnQgNCAocHJpb3JpdHk6IDU2MDAsIGxhdGVuY3kgb2Zmc2V0OiAwIHVzZWMsIGF2
YWlsYWJsZSkKCQkJUHJvcGVydGllczoKCQkJCWRldmljZS5pY29uX25hbWUgPSAidmlkZW8tZGlz
cGxheSIKCQkJUGFydCBvZiBwcm9maWxlKHMpOiBvdXRwdXQ6aGRtaS1zdGVyZW8tZXh0cmEzLCBv
dXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTMK
--047d7bf0c66464e35804ed2ec9ed
Content-Type: application/octet-stream; name="extra-hdmi.conf.mygood"
Content-Disposition: attachment; filename="extra-hdmi.conf.mygood"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hp18i7lz1

IyBUaGlzIGZpbGUgaXMgcGFydCBvZiBQdWxzZUF1ZGlvLgojCiMgUHVsc2VBdWRpbyBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMK
IyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNp
b24gMi4xIG9mIHRoZQojIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uCiMKIyBQdWxzZUF1ZGlvIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsIGJ1dAojIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKIyBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1Ig
QSBQQVJUSUNVTEFSIFBVUlBPU0UuIFNlZSB0aGUgR05VCiMgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBmb3IgbW9yZSBkZXRhaWxzLgojCiMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBv
ZiB0aGUgR05VIExlc3NlciBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiMgYWxvbmcgd2l0aCBQdWxz
ZUF1ZGlvOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sCiMg
SW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBV
U0EuCgo7IFRoaXMgaXMgYSBwcm9maWxlIGZvciBOdmlkaWEgYW5kIEludGVsIGNhcmRzIC0gc29t
ZSBjYXJkcyBoYXZlIGZvdXIgSERNSSBjb2RlY3MsCjsgYW5kIHdoaWNoIG9uZXMgYXJlIHdvcmtp
bmcgc2VlbXMgdG8gdmFyeSBhIGxvdCBiZXR3ZWVuIEdQVSBib2FyZHMuIEluIGFkZGl0aW9uLAo7
IE52aWRpYSBhbmQgSW50ZWwgbWFrZSBzb3V0aGJyaWRnZXMgYXMgd2VsbCwgc28gd2UgbmVlZCB0
byBrZWVwIHRoZSBleGlzdGluZwo7IGFuYWxvZyBwcm9maWxlcy4KOyAoQW5kIGJ5IG5vdCBhZGRp
bmcgYWxsIHRoZXNlIGV4dHJhIHByb2ZpbGVzIHRvIGRlZmF1bHQuY29uZiwgd2UgbWFrZSBzdXJl
CjsgdGhlcmUgaXMgbm8gcGVyZm9ybWFuY2UgaGl0IGZvciBub24tTnZpZGlhL0ludGVsIGNhcmRz
LikKCltHZW5lcmFsXQphdXRvLXByb2ZpbGVzID0geWVzCgpbTWFwcGluZyBoZG1pLXN1cnJvdW5k
LWV4dHJhMF0KZGVzY3JpcHRpb24gPSBEaWdpdGFsIFN1cnJvdW5kIDUuMSAoSERNSSAwKQpkZXZp
Y2Utc3RyaW5ncyA9IGhkbWk6JWYsMApwYXRocy1vdXRwdXQgPSBoZG1pLW91dHB1dC0wCmNoYW5u
ZWwtbWFwID0gZnJvbnQtbGVmdCxmcm9udC1yaWdodCxyZWFyLWxlZnQscmVhci1yaWdodCxmcm9u
dC1jZW50ZXIsbGZlCnByaW9yaXR5ID0gMQpkaXJlY3Rpb24gPSBvdXRwdXQKCltNYXBwaW5nIGhk
bWktc3Vycm91bmQtZXh0cmEzXQpkZXNjcmlwdGlvbiA9IERpZ2l0YWwgU3Vycm91bmQgNS4xIChI
RE1JIDMpCmRldmljZS1zdHJpbmdzID0gaGRtaTolZiwwCnBhdGhzLW91dHB1dCA9IGhkbWktb3V0
cHV0LTMKY2hhbm5lbC1tYXAgPSBmcm9udC1sZWZ0LGZyb250LXJpZ2h0LHJlYXItbGVmdCxyZWFy
LXJpZ2h0LGZyb250LWNlbnRlcixsZmUKcHJpb3JpdHkgPSAxCmRpcmVjdGlvbiA9IG91dHB1dAoK
--047d7bf0c66464e35804ed2ec9ed
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--047d7bf0c66464e35804ed2ec9ed--
