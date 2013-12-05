From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Thu, 5 Dec 2013 20:20:04 +0800
Message-ID: <CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208522776=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============1208522776==
Content-Type: multipart/alternative; boundary=20cf303dd358b4247004ecc88cd7

--20cf303dd358b4247004ecc88cd7
Content-Type: text/plain; charset=UTF-8

>
>
>>>>>>>> I just changed my RadeonHD 4670 for a 7870, and now when I type
>>>>>>>> "aplay -l"  I get many HDMI codecs instead of just one like for the
>>>>>>>> previous card.
>>>>>>>>
>>>>>>>
>>>> How many hdmi , dvi or display port connectors do your card have ?
>>>>
>>>> 1 hdmi, 1 vga, 2 tiny ports that I cannot name.
>>>
>>

are these mini display port ?

http://en.wikipedia.org/wiki/Mini_DisplayPort

strange that only two ports are available

>
>> Active Profile: output:hdmi-surround-extra0
>>     Ports:
>>         hdmi-output-0: HDMI / DisplayPort (priority: 5900, latency
>> offset: 0 usec, available)
>>             Properties:
>>                 device.icon_name = "video-display"
>>             Part of profile(s): output:hdmi-surround-extra0
>>         hdmi-output-3: HDMI / DisplayPort 4 (priority: 5600, latency
>> offset: 0 usec, available)
>>             Properties:
>>                 device.icon_name = "video-display"
>>             Part of profile(s): output:hdmi-surround-extra3
>>
>>
>>
>>>  Do pulseaudio server select null sink or hdmi.monitor as the default
>>>> source ?
>>>>
>>> The way I read it in the log hdmi.monitor:
>>> " Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon HD
>>> 7700/7800 Series] Digital Surround 5.1 (HDMI 0)"
>>> "device.class = "monitor""
>>>
>>
>>
>> pactl stat
>>
>


is these emulated ELD since monitor name, manufacture id, product id are
absent ?

>
>> No idea
>
>> did you find your hdmi monitor/TV 's EDID in graphic driver ?
>>
>> I found this:
> [     7.987] (II) RADEON(0): EDID for output HDMI-0
> [     7.987] (II) RADEON(0): Manufacturer: DON  Model: 26  Serial#:
> 16843009
> [     7.987] (II) RADEON(0): Year: 2011  Week: 0
> [     7.987] (II) RADEON(0): EDID Version: 1.3
>


you have to post  raw EDID of your HDMI monitor


http://cgit.freedesktop.org/xorg/app/edid-decode/plain/edid-decode.c

are you using latest alsa-driver ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_hdmi.c?id=89250f84644676c1ed6a09acef1033e14596a402

did you configure alsa-driver --with-debug=full ?

post the output of six eld in /proc/asound/card0/

are monitor_present =1 and eld_valid = 1 for all six eld ?

monitor_present         1
eld_valid               1

--20cf303dd358b4247004ecc88cd7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_extra">
<div class=3D"gmail_quote"><div class=3D"im"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=
=3D"gmail_quote">
<div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">

<div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v><div><div class=3D"gmail_extra">


<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_extra">

<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><br><p style=3D"font-family:sans-serif;border:0px none;mar=
gin:0px;padding:7px 0px;color:rgb(51,51,51);font-size:13.1429px;line-height=
:19px;background-color:rgb(252,253,254)">




I just changed my RadeonHD 4670 for a 7870, and now when I type &quot;aplay=
 -l&quot;=C2=A0 I get many HDMI codecs instead of just one like for the pre=
vious card.</p></div></blockquote></div></div></div></div></blockquote></di=
v>




</div></div></div></blockquote></div></div></div></div></div></blockquote><=
div><br></div></div><div>How many hdmi , dvi or display port connectors do =
your card have ?<br></div><div><br></div></div></div></div></blockquote>



</div><div>1 hdmi, 1 vga, 2 tiny ports that I cannot name.=C2=A0</div></div=
></div></div></blockquote></div></div></div></div></blockquote></div></div>=
</div></div></blockquote><div><br><div><br></div><div>are these mini displa=
y port ?<br>
</div><div><br><a href=3D"http://en.wikipedia.org/wiki/Mini_DisplayPort">ht=
tp://en.wikipedia.org/wiki/Mini_DisplayPort</a><br>=C2=A0</div></div>strang=
e that only two ports are available <br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div class=3D"h5"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr">
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><br>Active Profi=
le: output:hdmi-surround-extra0<br>=C2=A0=C2=A0=C2=A0 Ports:<br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hdmi-output-0: HDMI / DisplayPort (priority: 5=
900, latency offset: 0 usec, available)<br>

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Properties:<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 de=
vice.icon_name =3D &quot;video-display&quot;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Part of profile(s): output:hdmi-surround-ex=
tra0<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hdmi-output-3: HDMI / Display=
Port 4 (priority: 5600, latency offset: 0 usec, available)<br>


=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Properties:<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 de=
vice.icon_name =3D &quot;video-display&quot;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Part of profile(s): output:hdmi-surround-ex=
tra3<br><br>=C2=A0</div><div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">


<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
></div><div>Do pulseaudio server select null sink or hdmi.monitor as the de=
fault source ?<br></div></div></div></div></blockquote></div><div>The way I=
 read it in the log hdmi.monitor:</div>



<div>&quot; Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon =
HD 7700/7800 Series] Digital Surround 5.1 (HDMI 0)&quot;</div><div>&quot;de=
vice.class =3D &quot;monitor&quot;&quot;</div></div></div></div></blockquot=
e>


<div><br><br></div></div><div>pactl stat<br></div></div></div></div></block=
quote></div></div></div></div></div></blockquote><div><br><br>=C2=A0</div>i=
s these emulated ELD since monitor name, manufacture id, product id are abs=
ent ?<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"h5"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div><br></div></div></div></div></div></blockquote></div></div><div>No id=
ea=C2=A0</div><div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div>did you find your hdmi monitor/TV &#39;s EDID in graphic driver ? <br=
></div><br></div></div></div></div></blockquote></div><div>I found this:</d=
iv>
<div>
[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): EDID for output HDMI-0</div><div>[ =
=C2=A0 =C2=A0 7.987] (II) RADEON(0): Manufacturer: DON =C2=A0Model: 26 =C2=
=A0Serial#: 16843009</div><div>[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): Year:=
 2011 =C2=A0Week: 0</div><div>[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): EDID V=
ersion: 1.3</div>
</div></div></div></blockquote><div><br><br></div><div>you have to post=C2=
=A0 raw EDID of your HDMI monitor <br><br><br><a href=3D"http://cgit.freede=
sktop.org/xorg/app/edid-decode/plain/edid-decode.c">http://cgit.freedesktop=
.org/xorg/app/edid-decode/plain/edid-decode.c</a><br>
<br></div><div>are you using latest alsa-driver ?<br><br><a href=3D"https:/=
/git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/=
patch_hdmi.c?id=3D89250f84644676c1ed6a09acef1033e14596a402">https://git.ker=
nel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_hd=
mi.c?id=3D89250f84644676c1ed6a09acef1033e14596a402</a><br>
<br></div><div>did you configure alsa-driver --with-debug=3Dfull ?<br><br><=
/div><div>post the output of six eld in /proc/asound/card0/<br></div></div>=
<br>are monitor_present =3D1 and eld_valid =3D 1 for all six eld ?<br><br>m=
onitor_present =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<div>
eld_valid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1</div><br></div=
></div>

--20cf303dd358b4247004ecc88cd7--

--===============1208522776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1208522776==--
