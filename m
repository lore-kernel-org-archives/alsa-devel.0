From: John Ettedgui <john.ettedgui@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Thu, 5 Dec 2013 00:38:20 -0800
Message-ID: <CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1961206646=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============1961206646==
Content-Type: multipart/alternative; boundary=047d7bf0c664b601ac04ecc57378

--047d7bf0c664b601ac04ecc57378
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 5, 2013 at 12:22 AM, Raymond Yau <superquad.vortex2@gmail.com>wrote:

>
>
>>>
>>>
>>>>>>> I just changed my RadeonHD 4670 for a 7870, and now when I type
>>>>>>> "aplay -l"  I get many HDMI codecs instead of just one like for the
>>>>>>> previous card.
>>>>>>>
>>>>>>
>>> How many hdmi , dvi or display port connectors do your card have ?
>>>
>>> 1 hdmi, 1 vga, 2 tiny ports that I cannot name.
>>
>>>
>>> Specification seem support up to 6 displays
>>>
>> I believe these are virtual HDMI ouputs, not physical ones and total for
>> 6 in aplay -l and for 4 in aplay -L.
>>
>
> are you using latest alsa-lib ?
>
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=383912ef83cb2d5835239a23f6afc6198697a587
>
> Good point, I'm on a 3.13-rc2 kernel but totally forgot about the lib part.
I have the 1.0.27.2 lib, let me get the git version.

 HDA-Intel: present up to 8 HDMI/DP outputs via "hdmi" device
>
>
>  Is there any reason for you to disable on-board hda controller and
>>> alc888
>>>
>> Hmmm, I don't really remember why I did it back then, but probably
>> because using alsamixer and alsamixer -c0 felt easier than alsamixer and
>> alsamixer-c1 or something like that.
>>
>>>  as you don't have any capture device anymore?
>>>
>> Yup, but I haven't use any in years anyway.
>>
>>>
>>> pactl list
>>>
>>> attached to this mail.
>>
>
> strange that only two ports are available
>
> Active Profile: output:hdmi-surround-extra0
>     Ports:
>         hdmi-output-0: HDMI / DisplayPort (priority: 5900, latency offset:
> 0 usec, available)
>             Properties:
>                 device.icon_name = "video-display"
>             Part of profile(s): output:hdmi-surround-extra0
>         hdmi-output-3: HDMI / DisplayPort 4 (priority: 5600, latency
> offset: 0 usec, available)
>             Properties:
>                 device.icon_name = "video-display"
>             Part of profile(s): output:hdmi-surround-extra3
>
>
>
>>  Do pulseaudio server select null sink or hdmi.monitor as the default
>>> source ?
>>>
>> The way I read it in the log hdmi.monitor:
>> " Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon HD
>> 7700/7800 Series] Digital Surround 5.1 (HDMI 0)"
>> "device.class = "monitor""
>>
>
>
> pactl stat
>
>
>
>>
>>>
>>>
>>>
>>>
>>> cat /proc/asound/card0/eld#*.0
>>>
>>> attached
>>
>
>
>
>
>>  does your hdmi montior name appear in one of the six eld
>>>
>>> It appears exactly in the 0 one you mentioned above.:
>> "monitor_present         1
>> eld_valid               1
>> monitor_name
>> connection_type         HDMI"
>>
>
> is these emulated ELD since monitor name, manufacture id, product id are
> absent ?
>
> No idea

> did you find your hdmi monitor/TV 's EDID in graphic driver ?
>
> I found this:
[     7.987] (II) RADEON(0): EDID for output HDMI-0
[     7.987] (II) RADEON(0): Manufacturer: DON  Model: 26  Serial#: 16843009
[     7.987] (II) RADEON(0): Year: 2011  Week: 0
[     7.987] (II) RADEON(0): EDID Version: 1.3

Thanks!

--047d7bf0c664b601ac04ecc57378
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Thu, Dec 5, 2013 at 12:22 AM, Raymond Yau <span dir=3D"ltr">&lt;=
<a href=3D"mailto:superquad.vortex2@gmail.com" target=3D"_blank">superquad.=
vortex2@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=
=3D"gmail_quote">
<div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_ext=
ra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div =
class=3D"gmail_extra">
<br><div class=3D"gmail_quote">

<div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div><div><div class=3D"gmail_extra"=
>


<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"=
gmail_extra">

<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">

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


</div><div>1 hdmi, 1 vga, 2 tiny ports that I cannot name.=C2=A0</div><div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>=C2=A0<br></div><div>Specification seem support up to 6 displays <br></div=
></div></div></div></blockquote></div><div>I believe these are virtual HDMI=
 ouputs, not physical ones and total for 6 in aplay -l and for 4 in aplay -=
L.</div>

</div></div></div></blockquote><div><br></div></div><div>are you using late=
st alsa-lib ? <br><br><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.=
git;a=3Dcommit;h=3D383912ef83cb2d5835239a23f6afc6198697a587" target=3D"_bla=
nk">http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommit;h=3D383912ef83=
cb2d5835239a23f6afc6198697a587</a><br>

<br></div></div></div></div></blockquote><div>Good point, I&#39;m on a 3.13=
-rc2 kernel but totally forgot about the lib part.</div><div>I have the 1.0=
.27.2 lib, let me get the git version.</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
>
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>=C2=A0HDA-Intel: present up to 8 HDMI/DP outputs via &quot;hdmi&quot; devi=
ce<br><br><div><br></div></div><div class=3D"im"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra">
<div class=3D"gmail_quote"><div>Is there any reason for you to disable on-b=
oard hda controller and alc888 <br>
</div></div></div></div></blockquote></div><div>Hmmm, I don&#39;t really re=
member why I did it back then, but probably because using alsamixer and als=
amixer -c0 felt easier than alsamixer and alsamixer-c1 or something like th=
at.=C2=A0</div>

<div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"=
gmail_quote">

<div>

</div><div>as you don&#39;t have any capture device anymore?</div></div></d=
iv></div></blockquote></div><div>Yup, but I haven&#39;t use any in years an=
yway.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">


<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><br></div><div>pactl list <br></div><div><br></div></div></div></div></blo=
ckquote><div>attached to this mail.</div></div></div></div></blockquote><di=
v>

<br></div></div><div>strange that only two ports are available <br></div><d=
iv><br>Active Profile: output:hdmi-surround-extra0<br>=C2=A0=C2=A0=C2=A0 Po=
rts:<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hdmi-output-0: HDMI / Display=
Port (priority: 5900, latency offset: 0 usec, available)<br>

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
tra3<br><br>=C2=A0</div><div class=3D"im"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
></div><div>Do pulseaudio server select null sink or hdmi.monitor as the de=
fault source ?<br></div></div></div></div></blockquote></div><div>The way I=
 read it in the log hdmi.monitor:</div>


<div>&quot; Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon =
HD 7700/7800 Series] Digital Surround 5.1 (HDMI 0)&quot;</div><div>&quot;de=
vice.class =3D &quot;monitor&quot;&quot;</div></div></div></div></blockquot=
e>

<div><br><br></div></div><div>pactl stat<br><br></div><div class=3D"im"><di=
v dir=3D"ltr">=C2=A0<br>

</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote">
<div><div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div><br><br></div></div><br></div><br></div><div class=3D"gmail_extra"><b=
r>cat /proc/asound/card0/eld#*.0<br><br></div></div></blockquote></div></di=
v><div>

attached=C2=A0</div></div></div></div></blockquote><div><br></div><br><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"></div><div class=3D"gmail_extra=
">does your hdmi montior name appear in one of the six eld <br>
<br></div></div></blockquote></div><div>It appears exactly in the 0 one you=
 mentioned above.:</div><div>&quot;monitor_present =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1</div><div>eld_valid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
1</div><div>monitor_name</div><div>connection_type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HDMI&quot;</div>

</div></div></div></blockquote></div><div><br><div>is these emulated ELD si=
nce monitor name, manufacture id, product id are absent ?<br><br></div></di=
v></div></div></div></blockquote><div>No idea=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div>did you find your hdmi monitor/TV &#39;s EDID in graphic driver ? <br=
></div><br></div></div></div></div></blockquote><div>I found this:</div><di=
v>
[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): EDID for output HDMI-0</div><div>[ =
=C2=A0 =C2=A0 7.987] (II) RADEON(0): Manufacturer: DON =C2=A0Model: 26 =C2=
=A0Serial#: 16843009</div><div>[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): Year:=
 2011 =C2=A0Week: 0</div><div>[ =C2=A0 =C2=A0 7.987] (II) RADEON(0): EDID V=
ersion: 1.3</div>
<div><br></div><div>Thanks!=C2=A0</div></div><br></div></div>

--047d7bf0c664b601ac04ecc57378--

--===============1961206646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1961206646==--
