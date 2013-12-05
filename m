From: John Ettedgui <john.ettedgui@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Wed, 4 Dec 2013 23:40:50 -0800
Message-ID: <CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1136780210bf1904ecc4a68d
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
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

--001a1136780210bf1904ecc4a68d
Content-Type: multipart/alternative; boundary=001a1136780210bf1604ecc4a68b

--001a1136780210bf1604ecc4a68b
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 4, 2013 at 11:24 PM, Raymond Yau <superquad.vortex2@gmail.com>wrote:

>
>
>
>>>>> I just changed my RadeonHD 4670 for a 7870, and now when I type "aplay
>>>>> -l"  I get many HDMI codecs instead of just one like for the previous card.
>>>>>
>>>>
> How many hdmi , dvi or display port connectors do your card have ?
>
> 1 hdmi, 1 vga, 2 tiny ports that I cannot name.

>
> Specification seem support up to 6 displays
>
I believe these are virtual HDMI ouputs, not physical ones and total for 6
in aplay -l and for 4 in aplay -L.

>
>
>>>>
>>>> Oh interesting, but I was just using the standard HDMI connector of the
>>> VGA card without connecting my card to the motherboard by more than PCI-E.
>>> Also, spdif would not get me 6 channels in LCPM, so I don't think that
>>> was it but I could be wrong.
>>>
>>>>
>>>>
>>>>
> Is there any reason for you to disable on-board hda controller and alc888
>
Hmmm, I don't really remember why I did it back then, but probably because
using alsamixer and alsamixer -c0 felt easier than alsamixer and
alsamixer-c1 or something like that.

> as you don't have any capture device anymore?
>
Yup, but I haven't use any in years anyway.

>
> pactl list
>
> attached to this mail.

> Do pulseaudio server select null sink or hdmi.monitor as the default
> source ?
>
The way I read it in the log hdmi.monitor:
" Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon HD
7700/7800 Series] Digital Surround 5.1 (HDMI 0)"
"device.class = "monitor""

>
>
>>>>> When I type "aplay -L" I get one more codec that I can see it in the
>>>>> pavucontrol profile (not sure which one as the names are irrelevant)
>>>>>
>>>>>
>>>>> if in default.pa I specify the alsa sink device=hw:0,3 directly, I do
>>>>> get sound, but then in pavucontrol I do not get the advanced sub-menu
>>>>> anymore which makes me think something is not working properly...
>>>>>
>>>>> For now I have settled on this hack instead:
>>>>>
>>>>>
>>>>> I changed the extra-hdmi.conf in
>>>>> /usr/share/pulseaudio/alsa-mixer/profile-sets file to :
>>>>>
>>>>> [Mapping hdmi-surround-extra0]
>>>>> description = Digital Surround 5.1 (HDMI 0)
>>>>> device-strings = hdmi:%f,0
>>>>> paths-output = hdmi-output-0
>>>>> channel-map =
>>>>> front-left,front-right,rear-left,rear-right,front-center,lfe
>>>>> priority = 1
>>>>> direction = output
>>>>>
>>>>> [Mapping hdmi-surround-extra3]
>>>>> description = Digital Surround 5.1 (HDMI 3)
>>>>> device-strings = hdmi:%f,0
>>>>> paths-output = hdmi-output-3
>>>>> channel-map =
>>>>> front-left,front-right,rear-left,rear-right,front-center,lfe
>>>>> priority = 1
>>>>> direction = output
>>>>>
>>>>> I only need one of these two, somehow they both work...
>>>>>
>>>>> Now everything works for me, but since it's not out of the box, I am
>>>>> guessing there might be something out there to fix.
>>>>>
>>>>>
>>>>>
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=5a61358433b1f89b500f2c365746c73cb7a27e2f
>>>>
>>>> Hmmm I am not sure what you meant by that.
>>>
>>>
>> Here is the alsa-info.
>>
>
>
> strange that all jacks return true
>     control.1 {
>         iface CARD
>         name 'HDMI/DP,pcm=3 Jack'
>         value true
>         comment {
>             access read
>             type BOOLEAN
>             count 1
>         }
>     }
>     ...
>
>     control.31 {
>         iface CARD
>         name 'HDMI/DP,pcm=11 Jack'
>         value true
>         comment {
>             access read
>             type BOOLEAN
>             count 1
>         }
>     }
>
>
> cat /proc/asound/card0/eld#*.0
>
> attached

> does your hdmi montior name appear in one of the six eld
>
> It appears exactly in the 0 one you mentioned above.:
"monitor_present         1
eld_valid               1
monitor_name
connection_type         HDMI"

>
> [    5.468413] [drm] Connector 2:
> [    5.468414] [drm]   HDMI-A-1
> [    5.468415] [drm]   HPD1
>
>
> Does the graphic driver show which hdmi monitor connect to which ports in
> system log ?
>
> I cannot find anything like that in dmesg, but I see this in Xorg.log if
> that helps:
>
"[   8.292] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=9 (/dev/input/event8)
[     8.292] (II) No input driver specified, ignoring this device.
[     8.292] (II) This device may have been added with another device file.
[     8.293] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=10 (/dev/input/event7)
[     8.293] (II) No input driver specified, ignoring this device.
[     8.293] (II) This device may have been added with another device file.
[     8.293] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=11 (/dev/input/event6)
[     8.293] (II) No input driver specified, ignoring this device.
[     8.293] (II) This device may have been added with another device file.
[     8.293] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=3 (/dev/input/event11)
[     8.293] (II) No input driver specified, ignoring this device.
[     8.293] (II) This device may have been added with another device file.
[     8.293] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=7 (/dev/input/event10)
[     8.293] (II) No input driver specified, ignoring this device.
[     8.293] (II) This device may have been added with another device file.
[     8.294] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=8 (/dev/input/event9)
[     8.294] (II) No input driver specified, ignoring this device."


Thank you!

--001a1136780210bf1604ecc4a68b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Dec 4, 2013 at 11:24 PM, Raymond Yau <span dir=3D"ltr">&lt;=
<a href=3D"mailto:superquad.vortex2@gmail.com" target=3D"_blank">superquad.=
vortex2@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">
<div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div class=3D=
"gmail_extra">


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
<div>1 hdmi, 1 vga, 2 tiny ports that I cannot name.=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>=C2=A0<br></div><div>Specification seem support up to 6 displays <br></div=
></div></div></div></blockquote><div>I believe these are virtual HDMI ouput=
s, not physical ones and total for 6 in aplay -l and for 4 in aplay -L.</di=
v>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"=
gmail_quote">
<div>
<br></div><div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-l=
eft-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><di=
v class=3D"gmail_extra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra">
<div class=3D"gmail_quote"><br><div><br></div></div></div></div></blockquot=
e></div>Oh interesting, but I was just using the standard HDMI connector of=
 the VGA card without connecting my card to the motherboard by more than PC=
I-E.<div>


Also, spdif would not get me 6 channels in LCPM, so I don&#39;t think that =
was it but I could be wrong.</div>
<div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"=
gmail_quote">
<div>

</div><br><div><div><br></div></div></div></div></div></blockquote></div></=
div></div></div></blockquote></div></div></div></div></div></blockquote><di=
v><br></div></div><div>Is there any reason for you to disable on-board hda =
controller and alc888 <br>
</div></div></div></div></blockquote><div>Hmmm, I don&#39;t really remember=
 why I did it back then, but probably because using alsamixer and alsamixer=
 -c0 felt easier than alsamixer and alsamixer-c1 or something like that.=C2=
=A0</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"=
gmail_quote">
<div>

</div><div>as you don&#39;t have any capture device anymore?</div></div></d=
iv></div></blockquote><div>Yup, but I haven&#39;t use any in years anyway.=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><br></div><div>pactl list <br></div><div><br></div></div></div></div></blo=
ckquote><div>attached to this mail.</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
></div><div>Do pulseaudio server select null sink or hdmi.monitor as the de=
fault source ?<br></div></div></div></div></blockquote><div>The way I read =
it in the log hdmi.monitor:</div>
<div>&quot; Description: Monitor of Cape Verde/Pitcairn HDMI Audio [Radeon =
HD 7700/7800 Series] Digital Surround 5.1 (HDMI 0)&quot;</div><div>&quot;de=
vice.class =3D &quot;monitor&quot;&quot;</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-co=
lor:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
></div><div class=3D"im"><div>

<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div class=3D"gmail_e=
xtra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><p style=
=3D"font-family:sans-serif;border:0px none;margin:0px;padding:7px 0px;color=
:rgb(51,51,51);font-size:13.1429px;line-height:19px;background-color:rgb(25=
2,253,254)">






<br>When I type &quot;aplay -L&quot; I get one more codec that I can see it=
 in the pavucontrol profile (not sure which one as the names are irrelevant=
)<br>
</p><p style=3D"font-family:sans-serif;border:0px none;margin:0px;padding:7=
px 0px;color:rgb(51,51,51);font-size:13.1429px;line-height:19px;background-=
color:rgb(252,253,254)"><br>if in <a href=3D"http://default.pa" target=3D"_=
blank">default.pa</a> I specify the alsa sink device=3Dhw:0,3 directly, I d=
o get sound, but then in pavucontrol I do not get the advanced sub-menu any=
more which makes me think something is not working properly...</p>







<p style=3D"font-family:sans-serif;border:0px none;margin:0px;padding:7px 0=
px;color:rgb(51,51,51);font-size:13.1429px;line-height:19px;background-colo=
r:rgb(252,253,254)">For now I have settled on this hack instead:</p>
<p style=3D"font-family:sans-serif;border:0px none;margin:0px;padding:7px 0=
px;color:rgb(51,51,51);font-size:13.1429px;line-height:19px;background-colo=
r:rgb(252,253,254)"><br></p><p style=3D"font-family:sans-serif;border:0px n=
one;margin:0px;padding:7px 0px;color:rgb(51,51,51);font-size:13.1429px;line=
-height:19px;background-color:rgb(252,253,254)">







I changed the extra-hdmi.conf in /usr/share/pulseaudio/alsa-mixer/profile-s=
ets file to :</p><div style=3D"font-family:sans-serif;border-width:1px 1px =
1px 3px;border-style:solid;border-color:rgb(187,204,221);margin:0.75em 1em;=
padding:0px 0.75em;background-color:rgb(246,249,252);color:rgb(68,68,68);fo=
nt-size:13.1429px;line-height:19px">







<blockquote style=3D"border:0px none;margin:0px;padding:0px;overflow:hidden=
;width:673.357px"><div style=3D"border:0px none;margin:0px;padding:0px"><p =
style=3D"font-family:Verdana,Arial,Helvetica,sans-serif;border:0px none;mar=
gin:0px;padding:7px 0px">







[Mapping hdmi-surround-extra0]<br style=3D"font-family:sans-serif!important=
">description =3D Digital Surround 5.1 (HDMI 0)<br style=3D"font-family:san=
s-serif!important">device-strings =3D hdmi:%f,0<br style=3D"font-family:san=
s-serif!important">







paths-output =3D hdmi-output-0<br style=3D"font-family:sans-serif!important=
">channel-map =3D front-left,front-right,rear-left,rear-right,front-center,=
lfe<br style=3D"font-family:sans-serif!important">priority =3D 1<br style=
=3D"font-family:sans-serif!important">







direction =3D output</p><p style=3D"font-family:Verdana,Arial,Helvetica,san=
s-serif;border:0px none;margin:0px;padding:7px 0px">[Mapping hdmi-surround-=
extra3]<br style=3D"font-family:sans-serif!important">description =3D Digit=
al Surround 5.1 (HDMI 3)<br style=3D"font-family:sans-serif!important">







device-strings =3D hdmi:%f,0<br style=3D"font-family:sans-serif!important">=
paths-output =3D hdmi-output-3<br style=3D"font-family:sans-serif!important=
">channel-map =3D front-left,front-right,rear-left,rear-right,front-center,=
lfe<br style=3D"font-family:sans-serif!important">







priority =3D 1<br style=3D"font-family:sans-serif!important">direction =3D =
output</p></div></blockquote></div><p style=3D"font-family:sans-serif;borde=
r:0px none;margin:0px;padding:7px 0px;color:rgb(51,51,51);font-size:13.1429=
px;line-height:19px;background-color:rgb(252,253,254)">







I only need one of these two, somehow they both work...</p><p style=3D"font=
-family:sans-serif;border:0px none;margin:0px;padding:7px 0px;color:rgb(51,=
51,51);font-size:13.1429px;line-height:19px;background-color:rgb(252,253,25=
4)">







Now everything works for me, but since it&#39;s not out of the box, I am gu=
essing there might be something out there to fix.</p><br></div><br></blockq=
uote></div><div><br><a href=3D"https://git.kernel.org/cgit/linux/kernel/git=
/tiwai/sound.git/commit/sound/pci/hda?id=3D5a61358433b1f89b500f2c365746c73c=
b7a27e2f" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/ti=
wai/sound.git/commit/sound/pci/hda?id=3D5a61358433b1f89b500f2c365746c73cb7a=
27e2f</a> <br>





</div></div><br></div></div>
</blockquote></div></div>Hmmm I am not sure what you meant by that.</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"></div></div><=
/blockquote></div><br></div></div></div><div class=3D"gmail_extra">Here is =
the alsa-info.</div>

</div></blockquote><div><br><br></div></div><div>strange that all jacks ret=
urn true <br></div>=C2=A0=C2=A0=C2=A0 control.1 {<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 iface CARD<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 name &#=
39;HDMI/DP,pcm=3D3 Jack&#39;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 value=
 true<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 comment {<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 access read<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 type BOOLEAN<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 count 1<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=
=C2=A0 ...<br><br>=C2=A0=C2=A0=C2=A0 control.31 {<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 iface CARD<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 name &#=
39;HDMI/DP,pcm=3D11 Jack&#39;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 valu=
e true<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 comment {<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 access read<br>

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 type BOOLEAN<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 count 1<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=C2=A0 }<br></div><br></di=
v><div class=3D"gmail_extra"><br>cat /proc/asound/card0/eld#*.0<br><br></di=
v></div></blockquote><div>attached=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-co=
lor:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"></div><div class=3D"gmail_extra=
">does your hdmi montior name appear in one of the six eld <br>
<br></div></div></blockquote><div>It appears exactly in the 0 one you menti=
oned above.:</div><div>&quot;monitor_present =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<=
/div><div>eld_valid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1</div=
><div>monitor_name</div><div>connection_type =C2=A0 =C2=A0 =C2=A0 =C2=A0 HD=
MI&quot;</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><br>[=C2=A0=C2=
=A0=C2=A0 5.468413] [drm] Connector 2:<br>
[=C2=A0=C2=A0=C2=A0 5.468414] [drm]=C2=A0=C2=A0 HDMI-A-1<br>[=C2=A0=C2=A0=
=C2=A0 5.468415] [drm]=C2=A0=C2=A0 HPD1<br><br></div><div class=3D"gmail_ex=
tra"><br>Does the graphic driver show which hdmi monitor connect to which p=
orts in system log ?<br>
<br>I cannot find anything like that in dmesg, but I see this in Xorg.log i=
f that helps:</div></div></blockquote><div>&quot;[ =C2=A0 8.292] (II) confi=
g/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D9 (/dev/input/event8=
)</div>
<div>[ =C2=A0 =C2=A0 8.292] (II) No input driver specified, ignoring this d=
evice.</div><div>[ =C2=A0 =C2=A0 8.292] (II) This device may have been adde=
d with another device file.</div><div>[ =C2=A0 =C2=A0 8.293] (II) config/ud=
ev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D10 (/dev/input/event7)</=
div>
<div>[ =C2=A0 =C2=A0 8.293] (II) No input driver specified, ignoring this d=
evice.</div><div>[ =C2=A0 =C2=A0 8.293] (II) This device may have been adde=
d with another device file.</div><div>[ =C2=A0 =C2=A0 8.293] (II) config/ud=
ev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D11 (/dev/input/event6)</=
div>
<div>[ =C2=A0 =C2=A0 8.293] (II) No input driver specified, ignoring this d=
evice.</div><div>[ =C2=A0 =C2=A0 8.293] (II) This device may have been adde=
d with another device file.</div><div>[ =C2=A0 =C2=A0 8.293] (II) config/ud=
ev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D3 (/dev/input/event11)</=
div>
<div>[ =C2=A0 =C2=A0 8.293] (II) No input driver specified, ignoring this d=
evice.</div><div>[ =C2=A0 =C2=A0 8.293] (II) This device may have been adde=
d with another device file.</div><div>[ =C2=A0 =C2=A0 8.293] (II) config/ud=
ev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D7 (/dev/input/event10)</=
div>
<div>[ =C2=A0 =C2=A0 8.293] (II) No input driver specified, ignoring this d=
evice.</div><div>[ =C2=A0 =C2=A0 8.293] (II) This device may have been adde=
d with another device file.</div><div>[ =C2=A0 =C2=A0 8.294] (II) config/ud=
ev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D8 (/dev/input/event9)</d=
iv>
<div>[ =C2=A0 =C2=A0 8.294] (II) No input driver specified, ignoring this d=
evice.&quot;</div></div><br></div><div class=3D"gmail_extra"><br></div><div=
 class=3D"gmail_extra">Thank you!</div></div>

--001a1136780210bf1604ecc4a68b--

--001a1136780210bf1904ecc4a68d
Content-Type: text/plain; charset=UTF-8; name="pactl.txt"
Content-Disposition: attachment; filename="pactl.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hotorhni0

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
ZGlzY292ZXJlZD0xIgoJVXNhZ2UgY291bnRlcjogMgoJUHJvcGVydGllczoKCQltb2R1bGUuYXV0
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
CgpNb2R1bGUgIzI3CglOYW1lOiBtb2R1bGUteDExLXB1Ymxpc2gKCUFyZ3VtZW50OiBkaXNwbGF5
PTowCglVc2FnZSBjb3VudGVyOiBuL2EKCVByb3BlcnRpZXM6CgkJbW9kdWxlLmF1dGhvciA9ICJM
ZW5uYXJ0IFBvZXR0ZXJpbmciCgkJbW9kdWxlLmRlc2NyaXB0aW9uID0gIlgxMSBjcmVkZW50aWFs
IHB1Ymxpc2hlciIKCQltb2R1bGUudmVyc2lvbiA9ICI0LjAtMjcxLWcwOWU4LWRpcnR5IgoKTW9k
dWxlICMyOAoJTmFtZTogbW9kdWxlLXgxMS1wdWJsaXNoCglBcmd1bWVudDogZGlzcGxheT06MAoJ
VXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiTGVubmFy
dCBQb2V0dGVyaW5nIgoJCW1vZHVsZS5kZXNjcmlwdGlvbiA9ICJYMTEgY3JlZGVudGlhbCBwdWJs
aXNoZXIiCgkJbW9kdWxlLnZlcnNpb24gPSAiNC4wLTI3MS1nMDllOC1kaXJ0eSIKCk1vZHVsZSAj
MjkKCU5hbWU6IG1vZHVsZS1kZXZpY2UtbWFuYWdlcgoJQXJndW1lbnQ6IGRvX3JvdXRpbmc9MQoJ
VXNhZ2UgY291bnRlcjogbi9hCglQcm9wZXJ0aWVzOgoJCW1vZHVsZS5hdXRob3IgPSAiQ29saW4g
R3V0aHJpZSIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiS2VlcCB0cmFjayBvZiBkZXZpY2VzIChh
bmQgdGhlaXIgZGVzY3JpcHRpb25zKSBib3RoIHBhc3QgYW5kIHByZXNlbnQgYW5kIHByaW9yaXRp
c2UgYnkgcm9sZSIKCQltb2R1bGUudmVyc2lvbiA9ICI0LjAtMjcxLWcwOWU4LWRpcnR5IgoKTW9k
dWxlICMzMAoJTmFtZTogbW9kdWxlLXgxMS14c21wCglBcmd1bWVudDogZGlzcGxheT06MCBzZXNz
aW9uX21hbmFnZXI9bG9jYWwvSFRQQzpAL3RtcC8uSUNFLXVuaXgvNjgwLHVuaXgvSFRQQzovdG1w
Ly5JQ0UtdW5peC82ODAKCVVzYWdlIGNvdW50ZXI6IG4vYQoJUHJvcGVydGllczoKCQltb2R1bGUu
YXV0aG9yID0gIkxlbm5hcnQgUG9ldHRlcmluZyIKCQltb2R1bGUuZGVzY3JpcHRpb24gPSAiWDEx
IHNlc3Npb24gbWFuYWdlbWVudCIKCQltb2R1bGUudmVyc2lvbiA9ICI0LjAtMjcxLWcwOWU4LWRp
cnR5IgoKU2luayAjMAoJU3RhdGU6IFJVTk5JTkcKCU5hbWU6IGFsc2Ffb3V0cHV0LnBjaS0wMDAw
XzAxXzAwLjEuaGRtaS1zdXJyb3VuZC1leHRyYTAKCURlc2NyaXB0aW9uOiBDYXBlIFZlcmRlL1Bp
dGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3NzAwLzc4MDAgU2VyaWVzXSBEaWdpdGFsIFN1
cnJvdW5kIDUuMSAoSERNSSAwKQoJRHJpdmVyOiBtb2R1bGUtYWxzYS1jYXJkLmMKCVNhbXBsZSBT
cGVjaWZpY2F0aW9uOiBzMTZsZSA2Y2ggNDgwMDBIegoJQ2hhbm5lbCBNYXA6IGZyb250LWxlZnQs
ZnJvbnQtcmlnaHQscmVhci1sZWZ0LHJlYXItcmlnaHQsZnJvbnQtY2VudGVyLGxmZQoJT3duZXIg
TW9kdWxlOiA2CglNdXRlOiBubwoJVm9sdW1lOiBmcm9udC1sZWZ0OiA2NTUzNiAvIDEwMCUgLyAw
LjAwIGRCLCAgIGZyb250LXJpZ2h0OiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIHJlYXItbGVm
dDogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQiwgICByZWFyLXJpZ2h0OiA2NTUzNiAvIDEwMCUgLyAw
LjAwIGRCLCAgIGZyb250LWNlbnRlcjogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQiwgICBsZmU6IDY1
NTM2IC8gMTAwJSAvIDAuMDAgZEIKCSAgICAgICAgYmFsYW5jZSAwLjAwCglCYXNlIFZvbHVtZTog
NjU1MzYgLyAxMDAlIC8gMC4wMCBkQgoJTW9uaXRvciBTb3VyY2U6IGFsc2Ffb3V0cHV0LnBjaS0w
MDAwXzAxXzAwLjEuaGRtaS1zdXJyb3VuZC1leHRyYTAubW9uaXRvcgoJTGF0ZW5jeTogOTk5Nzgg
dXNlYywgY29uZmlndXJlZCAxMDAwMDAgdXNlYwoJRmxhZ3M6IEhBUkRXQVJFIERFQ0lCRUxfVk9M
VU1FIExBVEVOQ1kgU0VUX0ZPUk1BVFMgCglQcm9wZXJ0aWVzOgoJCWFsc2EucmVzb2x1dGlvbl9i
aXRzID0gIjE2IgoJCWRldmljZS5hcGkgPSAiYWxzYSIKCQlkZXZpY2UuY2xhc3MgPSAic291bmQi
CgkJYWxzYS5jbGFzcyA9ICJnZW5lcmljIgoJCWFsc2Euc3ViY2xhc3MgPSAiZ2VuZXJpYy1taXgi
CgkJYWxzYS5uYW1lID0gIkhETUkgMCIKCQlhbHNhLmlkID0gIkhETUkgMCIKCQlhbHNhLnN1YmRl
dmljZSA9ICIwIgoJCWFsc2Euc3ViZGV2aWNlX25hbWUgPSAic3ViZGV2aWNlICMwIgoJCWFsc2Eu
ZGV2aWNlID0gIjMiCgkJYWxzYS5jYXJkID0gIjAiCgkJYWxzYS5jYXJkX25hbWUgPSAiSERBIEFU
SSBIRE1JIgoJCWFsc2EubG9uZ19jYXJkX25hbWUgPSAiSERBIEFUSSBIRE1JIGF0IDB4ZmJjZmMw
MDAgaXJxIDQ2IgoJCWFsc2EuZHJpdmVyX25hbWUgPSAic25kX2hkYV9pbnRlbCIKCQlkZXZpY2Uu
YnVzX3BhdGggPSAicGNpLTAwMDA6MDE6MDAuMSIKCQlzeXNmcy5wYXRoID0gIi9kZXZpY2VzL3Bj
aTAwMDA6MDAvMDAwMDowMDowMy4wLzAwMDA6MDE6MDAuMS9zb3VuZC9jYXJkMCIKCQlkZXZpY2Uu
YnVzID0gInBjaSIKCQlkZXZpY2UudmVuZG9yLmlkID0gIjEwMDIiCgkJZGV2aWNlLnZlbmRvci5u
YW1lID0gIkFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIgoJCWRldmljZS5w
cm9kdWN0LmlkID0gImFhYjAiCgkJZGV2aWNlLnByb2R1Y3QubmFtZSA9ICJDYXBlIFZlcmRlL1Bp
dGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3NzAwLzc4MDAgU2VyaWVzXSIKCQlkZXZpY2Uu
c3RyaW5nID0gImhkbWk6MCwwIgoJCWRldmljZS5idWZmZXJpbmcuYnVmZmVyX3NpemUgPSAiNTc2
MDAiCgkJZGV2aWNlLmJ1ZmZlcmluZy5mcmFnbWVudF9zaXplID0gIjExNTIwIgoJCWRldmljZS5h
Y2Nlc3NfbW9kZSA9ICJtbWFwIgoJCWRldmljZS5wcm9maWxlLm5hbWUgPSAiaGRtaS1zdXJyb3Vu
ZC1leHRyYTAiCgkJZGV2aWNlLnByb2ZpbGUuZGVzY3JpcHRpb24gPSAiRGlnaXRhbCBTdXJyb3Vu
ZCA1LjEgKEhETUkgMCkiCgkJZGV2aWNlLmRlc2NyaXB0aW9uID0gIkNhcGUgVmVyZGUvUGl0Y2Fp
cm4gSERNSSBBdWRpbyBbUmFkZW9uIEhEIDc3MDAvNzgwMCBTZXJpZXNdIERpZ2l0YWwgU3Vycm91
bmQgNS4xIChIRE1JIDApIgoJCWFsc2EubWl4ZXJfbmFtZSA9ICJBVEkgUjZ4eCBIRE1JIgoJCWFs
c2EuY29tcG9uZW50cyA9ICJIREE6MTAwMmFhMDEsMDBhYTAxMDAsMDAxMDAzMDAiCgkJbW9kdWxl
LXVkZXYtZGV0ZWN0LmRpc2NvdmVyZWQgPSAiMSIKCQlkZXZpY2UuaWNvbl9uYW1lID0gImF1ZGlv
LWNhcmQtcGNpIgoJUG9ydHM6CgkJaGRtaS1vdXRwdXQtMDogSERNSSAvIERpc3BsYXlQb3J0IChw
cmlvcml0eTogNTkwMCwgYXZhaWxhYmxlKQoJQWN0aXZlIFBvcnQ6IGhkbWktb3V0cHV0LTAKCUZv
cm1hdHM6CgkJYWMzLWllYzYxOTM3LCBmb3JtYXQucmF0ZSA9ICJbIDMyMDAwLCA0NDEwMCwgNDgw
MDAsIDg4MjAwLCA5NjAwMCwgMTc2NDAwLCAxOTIwMDAgXSIKCQlkdHMtaWVjNjE5MzcsIGZvcm1h
dC5yYXRlID0gIlsgMzIwMDAsIDQ0MTAwLCA0ODAwMCwgODgyMDAsIDk2MDAwLCAxNzY0MDAsIDE5
MjAwMCBdIgoJCXBjbQoKU291cmNlICMwCglTdGF0ZTogSURMRQoJTmFtZTogYWxzYV9vdXRwdXQu
cGNpLTAwMDBfMDFfMDAuMS5oZG1pLXN1cnJvdW5kLWV4dHJhMC5tb25pdG9yCglEZXNjcmlwdGlv
bjogTW9uaXRvciBvZiBDYXBlIFZlcmRlL1BpdGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3
NzAwLzc4MDAgU2VyaWVzXSBEaWdpdGFsIFN1cnJvdW5kIDUuMSAoSERNSSAwKQoJRHJpdmVyOiBt
b2R1bGUtYWxzYS1jYXJkLmMKCVNhbXBsZSBTcGVjaWZpY2F0aW9uOiBzMTZsZSA2Y2ggNDgwMDBI
egoJQ2hhbm5lbCBNYXA6IGZyb250LWxlZnQsZnJvbnQtcmlnaHQscmVhci1sZWZ0LHJlYXItcmln
aHQsZnJvbnQtY2VudGVyLGxmZQoJT3duZXIgTW9kdWxlOiA2CglNdXRlOiBubwoJVm9sdW1lOiBm
cm9udC1sZWZ0OiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIGZyb250LXJpZ2h0OiA2NTUzNiAv
IDEwMCUgLyAwLjAwIGRCLCAgIHJlYXItbGVmdDogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQiwgICBy
ZWFyLXJpZ2h0OiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCLCAgIGZyb250LWNlbnRlcjogNjU1MzYg
LyAxMDAlIC8gMC4wMCBkQiwgICBsZmU6IDY1NTM2IC8gMTAwJSAvIDAuMDAgZEIKCSAgICAgICAg
YmFsYW5jZSAwLjAwCglCYXNlIFZvbHVtZTogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQgoJTW9uaXRv
ciBvZiBTaW5rOiBhbHNhX291dHB1dC5wY2ktMDAwMF8wMV8wMC4xLmhkbWktc3Vycm91bmQtZXh0
cmEwCglMYXRlbmN5OiAwIHVzZWMsIGNvbmZpZ3VyZWQgMTAwMDAwIHVzZWMKCUZsYWdzOiBERUNJ
QkVMX1ZPTFVNRSBMQVRFTkNZIAoJUHJvcGVydGllczoKCQlkZXZpY2UuZGVzY3JpcHRpb24gPSAi
TW9uaXRvciBvZiBDYXBlIFZlcmRlL1BpdGNhaXJuIEhETUkgQXVkaW8gW1JhZGVvbiBIRCA3NzAw
Lzc4MDAgU2VyaWVzXSBEaWdpdGFsIFN1cnJvdW5kIDUuMSAoSERNSSAwKSIKCQlkZXZpY2UuY2xh
c3MgPSAibW9uaXRvciIKCQlhbHNhLmNhcmQgPSAiMCIKCQlhbHNhLmNhcmRfbmFtZSA9ICJIREEg
QVRJIEhETUkiCgkJYWxzYS5sb25nX2NhcmRfbmFtZSA9ICJIREEgQVRJIEhETUkgYXQgMHhmYmNm
YzAwMCBpcnEgNDYiCgkJYWxzYS5kcml2ZXJfbmFtZSA9ICJzbmRfaGRhX2ludGVsIgoJCWRldmlj
ZS5idXNfcGF0aCA9ICJwY2ktMDAwMDowMTowMC4xIgoJCXN5c2ZzLnBhdGggPSAiL2RldmljZXMv
cGNpMDAwMDowMC8wMDAwOjAwOjAzLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQwIgoJCWRldmlj
ZS5idXMgPSAicGNpIgoJCWRldmljZS52ZW5kb3IuaWQgPSAiMTAwMiIKCQlkZXZpY2UudmVuZG9y
Lm5hbWUgPSAiQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0iCgkJZGV2aWNl
LnByb2R1Y3QuaWQgPSAiYWFiMCIKCQlkZXZpY2UucHJvZHVjdC5uYW1lID0gIkNhcGUgVmVyZGUv
UGl0Y2Fpcm4gSERNSSBBdWRpbyBbUmFkZW9uIEhEIDc3MDAvNzgwMCBTZXJpZXNdIgoJCWRldmlj
ZS5zdHJpbmcgPSAiMCIKCQltb2R1bGUtdWRldi1kZXRlY3QuZGlzY292ZXJlZCA9ICIxIgoJCWRl
dmljZS5pY29uX25hbWUgPSAiYXVkaW8tY2FyZC1wY2kiCglGb3JtYXRzOgoJCXBjbQoKU2luayBJ
bnB1dCAjMjcKCURyaXZlcjogcHJvdG9jb2wtbmF0aXZlLmMKCU93bmVyIE1vZHVsZTogMTMKCUNs
aWVudDogMzUKCVNpbms6IDAKCVNhbXBsZSBTcGVjaWZpY2F0aW9uOiBzMTZsZSAyY2ggNDQxMDBI
egoJQ2hhbm5lbCBNYXA6IGZyb250LWxlZnQsZnJvbnQtcmlnaHQKCUZvcm1hdDogcGNtLCBmb3Jt
YXQuc2FtcGxlX2Zvcm1hdCA9ICJcInMxNmxlXCIiICBmb3JtYXQucmF0ZSA9ICI0NDEwMCIgIGZv
cm1hdC5jaGFubmVscyA9ICIyIiAgZm9ybWF0LmNoYW5uZWxfbWFwID0gIlwiZnJvbnQtbGVmdCxm
cm9udC1yaWdodFwiIgoJQ29ya2VkOiBubwoJTXV0ZTogbm8KCVZvbHVtZTogZnJvbnQtbGVmdDog
NjU1MzYgLyAxMDAlIC8gMC4wMCBkQiwgICBmcm9udC1yaWdodDogNjU1MzYgLyAxMDAlIC8gMC4w
MCBkQgoJICAgICAgICBiYWxhbmNlIDAuMDAKCUJ1ZmZlciBMYXRlbmN5OiAxMDMwMTUgdXNlYwoJ
U2luayBMYXRlbmN5OiA5OTk4NSB1c2VjCglSZXNhbXBsZSBtZXRob2Q6IHNwZWV4LWZsb2F0LTkK
CVByb3BlcnRpZXM6CgkJbWVkaWEubmFtZSA9ICJTaW1wbGUgRGlyZWN0TWVkaWEgTGF5ZXIiCgkJ
YXBwbGljYXRpb24ubmFtZSA9ICJndGstZ25hc2giCgkJbmF0aXZlLXByb3RvY29sLnBlZXIgPSAi
VU5JWCBzb2NrZXQgY2xpZW50IgoJCW5hdGl2ZS1wcm90b2NvbC52ZXJzaW9uID0gIjI4IgoJCWFw
cGxpY2F0aW9uLnByb2Nlc3MuaWQgPSAiNDYzOSIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLnVzZXIg
PSAiam9obiIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLmhvc3QgPSAiSFRQQyIKCQlhcHBsaWNhdGlv
bi5wcm9jZXNzLmJpbmFyeSA9ICJndGstZ25hc2giCgkJd2luZG93LngxMS5kaXNwbGF5ID0gIjow
IgoJCWFwcGxpY2F0aW9uLmxhbmd1YWdlID0gImVuX1VTLlVURi04IgoJCWFwcGxpY2F0aW9uLnBy
b2Nlc3MubWFjaGluZV9pZCA9ICI1Y2QzZWJiODg0Mjk4ZjhkZjU3YjFlNDMwMDAwMDNiYyIKCQlh
cHBsaWNhdGlvbi5wcm9jZXNzLnNlc3Npb25faWQgPSAiMSIKCQltb2R1bGUtc3RyZWFtLXJlc3Rv
cmUuaWQgPSAic2luay1pbnB1dC1ieS1hcHBsaWNhdGlvbi1uYW1lOmd0ay1nbmFzaCIKClNpbmsg
SW5wdXQgIzI5CglEcml2ZXI6IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBNb2R1bGU6IDEzCglD
bGllbnQ6IDM3CglTaW5rOiAwCglTYW1wbGUgU3BlY2lmaWNhdGlvbjogZmxvYXQzMmxlIDZjaCA0
ODAwMEh6CglDaGFubmVsIE1hcDogZnJvbnQtbGVmdCxmcm9udC1yaWdodCxyZWFyLWxlZnQscmVh
ci1yaWdodCxmcm9udC1jZW50ZXIsbGZlCglGb3JtYXQ6IHBjbSwgZm9ybWF0LnNhbXBsZV9mb3Jt
YXQgPSAiXCJmbG9hdDMybGVcIiIgIGZvcm1hdC5yYXRlID0gIjQ4MDAwIiAgZm9ybWF0LmNoYW5u
ZWxzID0gIjYiICBmb3JtYXQuY2hhbm5lbF9tYXAgPSAiXCJmcm9udC1sZWZ0LGZyb250LXJpZ2h0
LHJlYXItbGVmdCxyZWFyLXJpZ2h0LGZyb250LWNlbnRlcixsZmVcIiIKCUNvcmtlZDogeWVzCglN
dXRlOiBubwoJVm9sdW1lOiBmcm9udC1sZWZ0OiA1MjQyOCAvICA4MCUgLyAtNS44MSBkQiwgICBm
cm9udC1yaWdodDogNTI0MjggLyAgODAlIC8gLTUuODEgZEIsICAgcmVhci1sZWZ0OiA1MjQyOCAv
ICA4MCUgLyAtNS44MSBkQiwgICByZWFyLXJpZ2h0OiA1MjQyOCAvICA4MCUgLyAtNS44MSBkQiwg
ICBmcm9udC1jZW50ZXI6IDUyNDI4IC8gIDgwJSAvIC01LjgxIGRCLCAgIGxmZTogNTI0MjggLyAg
ODAlIC8gLTUuODEgZEIKCSAgICAgICAgYmFsYW5jZSAwLjAwCglCdWZmZXIgTGF0ZW5jeTogMjc2
NDU4IHVzZWMKCVNpbmsgTGF0ZW5jeTogOTk5ODQgdXNlYwoJUmVzYW1wbGUgbWV0aG9kOiBjb3B5
CglQcm9wZXJ0aWVzOgoJCW1lZGlhLm5hbWUgPSAiWWVzIE1hbiAoMjAwOCkubWt2IgoJCWFwcGxp
Y2F0aW9uLm5hbWUgPSAiTVBsYXllciIKCQluYXRpdmUtcHJvdG9jb2wucGVlciA9ICJVTklYIHNv
Y2tldCBjbGllbnQiCgkJbmF0aXZlLXByb3RvY29sLnZlcnNpb24gPSAiMjgiCgkJYXBwbGljYXRp
b24ucHJvY2Vzcy5pZCA9ICI1NDIxIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MudXNlciA9ICJqb2hu
IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuaG9zdCA9ICJIVFBDIgoJCWFwcGxpY2F0aW9uLnByb2Nl
c3MuYmluYXJ5ID0gIm1wbGF5ZXIiCgkJYXBwbGljYXRpb24ubGFuZ3VhZ2UgPSAiQyIKCQl3aW5k
b3cueDExLmRpc3BsYXkgPSAiOjAiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5tYWNoaW5lX2lkID0g
IjVjZDNlYmI4ODQyOThmOGRmNTdiMWU0MzAwMDAwM2JjIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3Mu
c2Vzc2lvbl9pZCA9ICIxIgoJCWFwcGxpY2F0aW9uLmljb25fbmFtZSA9ICJtcGxheWVyIgoJCW1v
ZHVsZS1zdHJlYW0tcmVzdG9yZS5pZCA9ICJzaW5rLWlucHV0LWJ5LWFwcGxpY2F0aW9uLW5hbWU6
TVBsYXllciIKCkNsaWVudCAjMAoJRHJpdmVyOiBtb2R1bGUtc3lzdGVtZC1sb2dpbi5jCglPd25l
ciBNb2R1bGU6IDIxCglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0aW9uLm5hbWUgPSAiTG9naW4gU2Vz
c2lvbiAxIgoJCXN5c3RlbWQtbG9naW4uc2Vzc2lvbiA9ICIxIgoKQ2xpZW50ICMzCglEcml2ZXI6
IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBNb2R1bGU6IDEzCglQcm9wZXJ0aWVzOgoJCWFwcGxp
Y2F0aW9uLm5hbWUgPSAiS01peCBLREUgNCIKCQluYXRpdmUtcHJvdG9jb2wucGVlciA9ICJVTklY
IHNvY2tldCBjbGllbnQiCgkJbmF0aXZlLXByb3RvY29sLnZlcnNpb24gPSAiMjgiCgkJYXBwbGlj
YXRpb24ucHJvY2Vzcy5pZCA9ICI3NzMiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy51c2VyID0gImpv
aG4iCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5ob3N0ID0gIkhUUEMiCgkJYXBwbGljYXRpb24ucHJv
Y2Vzcy5iaW5hcnkgPSAia2RlaW5pdDQiCgkJYXBwbGljYXRpb24ubGFuZ3VhZ2UgPSAiZW5fVVMu
VVRGLTgiCgkJd2luZG93LngxMS5kaXNwbGF5ID0gIjowIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3Mu
bWFjaGluZV9pZCA9ICI1Y2QzZWJiODg0Mjk4ZjhkZjU3YjFlNDMwMDAwMDNiYyIKCQlhcHBsaWNh
dGlvbi5wcm9jZXNzLnNlc3Npb25faWQgPSAiMSIKCkNsaWVudCAjNwoJRHJpdmVyOiBtb2R1bGUt
eDExLXhzbXAuYwoJT3duZXIgTW9kdWxlOiAzMAoJUHJvcGVydGllczoKCQlhcHBsaWNhdGlvbi5u
YW1lID0gIlhTTVAgU2Vzc2lvbiBvbiBLREUgYXMgMTA0ODU0NTA0MzAwMDEzODYxNjExMDIwMDAw
MDAwNjgwMDAwNyIKCQl4c21wLnZlbmRvciA9ICJLREUiCgkJeHNtcC5jbGllbnQuaWQgPSAiMTA0
ODU0NTA0MzAwMDEzODYxNjExMDIwMDAwMDAwNjgwMDAwNyIKCkNsaWVudCAjOAoJRHJpdmVyOiBw
cm90b2NvbC1uYXRpdmUuYwoJT3duZXIgTW9kdWxlOiAxMwoJUHJvcGVydGllczoKCQlhcHBsaWNh
dGlvbi5uYW1lID0gIkNocm9tZSBpbnB1dCIKCQluYXRpdmUtcHJvdG9jb2wucGVlciA9ICJVTklY
IHNvY2tldCBjbGllbnQiCgkJbmF0aXZlLXByb3RvY29sLnZlcnNpb24gPSAiMjgiCgkJYXBwbGlj
YXRpb24ucHJvY2Vzcy5pZCA9ICI5MTkiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy51c2VyID0gImpv
aG4iCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5ob3N0ID0gIkhUUEMiCgkJYXBwbGljYXRpb24ucHJv
Y2Vzcy5iaW5hcnkgPSAiY2hyb21pdW0iCgkJd2luZG93LngxMS5kaXNwbGF5ID0gIjowIgoJCWFw
cGxpY2F0aW9uLmxhbmd1YWdlID0gImVuX1VTLlVURi04IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3Mu
bWFjaGluZV9pZCA9ICI1Y2QzZWJiODg0Mjk4ZjhkZjU3YjFlNDMwMDAwMDNiYyIKCQlhcHBsaWNh
dGlvbi5wcm9jZXNzLnNlc3Npb25faWQgPSAiMSIKCQlhcHBsaWNhdGlvbi5pY29uX25hbWUgPSAi
Y2hyb21pdW0iCgpDbGllbnQgIzEyCglEcml2ZXI6IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBN
b2R1bGU6IDEzCglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0aW9uLm5hbWUgPSAiQ2hyb21pdW0iCgkJ
bmF0aXZlLXByb3RvY29sLnBlZXIgPSAiVU5JWCBzb2NrZXQgY2xpZW50IgoJCW5hdGl2ZS1wcm90
b2NvbC52ZXJzaW9uID0gIjI4IgoJCXdpbmRvdy54MTEuZGlzcGxheSA9ICI6MCIKCQl3aW5kb3cu
eDExLnNjcmVlbiA9ICIwIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuaWQgPSAiOTE5IgoJCWFwcGxp
Y2F0aW9uLnByb2Nlc3MudXNlciA9ICJqb2huIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuaG9zdCA9
ICJIVFBDIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuYmluYXJ5ID0gImNocm9taXVtIgoJCWFwcGxp
Y2F0aW9uLmxhbmd1YWdlID0gImVuX1VTLlVURi04IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MubWFj
aGluZV9pZCA9ICI1Y2QzZWJiODg0Mjk4ZjhkZjU3YjFlNDMwMDAwMDNiYyIKCQlhcHBsaWNhdGlv
bi5wcm9jZXNzLnNlc3Npb25faWQgPSAiMSIKCQlhcHBsaWNhdGlvbi5pY29uX25hbWUgPSAiY2hy
b21pdW0iCgpDbGllbnQgIzM1CglEcml2ZXI6IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBNb2R1
bGU6IDEzCglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0aW9uLm5hbWUgPSAiZ3RrLWduYXNoIgoJCW5h
dGl2ZS1wcm90b2NvbC5wZWVyID0gIlVOSVggc29ja2V0IGNsaWVudCIKCQluYXRpdmUtcHJvdG9j
b2wudmVyc2lvbiA9ICIyOCIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLmlkID0gIjQ2MzkiCgkJYXBw
bGljYXRpb24ucHJvY2Vzcy51c2VyID0gImpvaG4iCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5ob3N0
ID0gIkhUUEMiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5iaW5hcnkgPSAiZ3RrLWduYXNoIgoJCXdp
bmRvdy54MTEuZGlzcGxheSA9ICI6MCIKCQlhcHBsaWNhdGlvbi5sYW5ndWFnZSA9ICJlbl9VUy5V
VEYtOCIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLm1hY2hpbmVfaWQgPSAiNWNkM2ViYjg4NDI5OGY4
ZGY1N2IxZTQzMDAwMDAzYmMiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5zZXNzaW9uX2lkID0gIjEi
CgpDbGllbnQgIzM3CglEcml2ZXI6IHByb3RvY29sLW5hdGl2ZS5jCglPd25lciBNb2R1bGU6IDEz
CglQcm9wZXJ0aWVzOgoJCWFwcGxpY2F0aW9uLm5hbWUgPSAiTVBsYXllciIKCQluYXRpdmUtcHJv
dG9jb2wucGVlciA9ICJVTklYIHNvY2tldCBjbGllbnQiCgkJbmF0aXZlLXByb3RvY29sLnZlcnNp
b24gPSAiMjgiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5pZCA9ICI1NDIxIgoJCWFwcGxpY2F0aW9u
LnByb2Nlc3MudXNlciA9ICJqb2huIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuaG9zdCA9ICJIVFBD
IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuYmluYXJ5ID0gIm1wbGF5ZXIiCgkJYXBwbGljYXRpb24u
bGFuZ3VhZ2UgPSAiQyIKCQl3aW5kb3cueDExLmRpc3BsYXkgPSAiOjAiCgkJYXBwbGljYXRpb24u
cHJvY2Vzcy5tYWNoaW5lX2lkID0gIjVjZDNlYmI4ODQyOThmOGRmNTdiMWU0MzAwMDAwM2JjIgoJ
CWFwcGxpY2F0aW9uLnByb2Nlc3Muc2Vzc2lvbl9pZCA9ICIxIgoJCWFwcGxpY2F0aW9uLmljb25f
bmFtZSA9ICJtcGxheWVyIgoKQ2xpZW50ICMzOQoJRHJpdmVyOiBwcm90b2NvbC1uYXRpdmUuYwoJ
T3duZXIgTW9kdWxlOiAxMwoJUHJvcGVydGllczoKCQlhcHBsaWNhdGlvbi5uYW1lID0gInBhY3Rs
IgoJCW5hdGl2ZS1wcm90b2NvbC5wZWVyID0gIlVOSVggc29ja2V0IGNsaWVudCIKCQluYXRpdmUt
cHJvdG9jb2wudmVyc2lvbiA9ICIyOCIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLmlkID0gIjE4NDAz
IgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MudXNlciA9ICJqb2huIgoJCWFwcGxpY2F0aW9uLnByb2Nl
c3MuaG9zdCA9ICJIVFBDIgoJCWFwcGxpY2F0aW9uLnByb2Nlc3MuYmluYXJ5ID0gInBhY3RsIgoJ
CWFwcGxpY2F0aW9uLmxhbmd1YWdlID0gImVuX1VTLlVURi04IgoJCXdpbmRvdy54MTEuZGlzcGxh
eSA9ICI6MCIKCQlhcHBsaWNhdGlvbi5wcm9jZXNzLm1hY2hpbmVfaWQgPSAiNWNkM2ViYjg4NDI5
OGY4ZGY1N2IxZTQzMDAwMDAzYmMiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5zZXNzaW9uX2lkID0g
IjEiCgpTYW1wbGUgIzAKCU5hbWU6IGRpYWxvZy13YXJuaW5nCglTYW1wbGUgU3BlY2lmaWNhdGlv
bjogczE2bGUgMmNoIDQ0MTAwSHoKCUNoYW5uZWwgTWFwOiBmcm9udC1sZWZ0LGZyb250LXJpZ2h0
CglWb2x1bWU6IChpbnZhbGlkKQoJICAgICAgICBiYWxhbmNlIDAuMDAKCUR1cmF0aW9uOiAwLjVz
CglTaXplOiA4Ni4wIEtpQgoJTGF6eTogbm8KCUZpbGVuYW1lOiBuL2EKCVByb3BlcnRpZXM6CgkJ
bWVkaWEucm9sZSA9ICJldmVudCIKCQlldmVudC5kZXNjcmlwdGlvbiA9ICJNZXNzYWdlIGRpYWxv
ZyBzaG93biIKCQlldmVudC5pZCA9ICJkaWFsb2ctd2FybmluZyIKCQltZWRpYS5uYW1lID0gImRp
YWxvZy13YXJuaW5nIgoJCW1lZGlhLmZpbGVuYW1lID0gIi91c3Ivc2hhcmUvc291bmRzL2ZyZWVk
ZXNrdG9wL3N0ZXJlby9kaWFsb2ctd2FybmluZy5vZ2EiCgkJYXBwbGljYXRpb24ubmFtZSA9ICJD
aHJvbWl1bSIKCQluYXRpdmUtcHJvdG9jb2wucGVlciA9ICJVTklYIHNvY2tldCBjbGllbnQiCgkJ
bmF0aXZlLXByb3RvY29sLnZlcnNpb24gPSAiMjgiCgkJd2luZG93LngxMS5kaXNwbGF5ID0gIjow
IgoJCXdpbmRvdy54MTEuc2NyZWVuID0gIjAiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5pZCA9ICI5
MTkiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy51c2VyID0gImpvaG4iCgkJYXBwbGljYXRpb24ucHJv
Y2Vzcy5ob3N0ID0gIkhUUEMiCgkJYXBwbGljYXRpb24ucHJvY2Vzcy5iaW5hcnkgPSAiY2hyb21p
dW0iCgkJYXBwbGljYXRpb24ubGFuZ3VhZ2UgPSAiZW5fVVMuVVRGLTgiCgkJYXBwbGljYXRpb24u
cHJvY2Vzcy5tYWNoaW5lX2lkID0gIjVjZDNlYmI4ODQyOThmOGRmNTdiMWU0MzAwMDAwM2JjIgoJ
CWFwcGxpY2F0aW9uLnByb2Nlc3Muc2Vzc2lvbl9pZCA9ICIxIgoJCWFwcGxpY2F0aW9uLmljb25f
bmFtZSA9ICJjaHJvbWl1bSIKCkNhcmQgIzAKCU5hbWU6IGFsc2FfY2FyZC5wY2ktMDAwMF8wMV8w
MC4xCglEcml2ZXI6IG1vZHVsZS1hbHNhLWNhcmQuYwoJT3duZXIgTW9kdWxlOiA2CglQcm9wZXJ0
aWVzOgoJCWFsc2EuY2FyZCA9ICIwIgoJCWFsc2EuY2FyZF9uYW1lID0gIkhEQSBBVEkgSERNSSIK
CQlhbHNhLmxvbmdfY2FyZF9uYW1lID0gIkhEQSBBVEkgSERNSSBhdCAweGZiY2ZjMDAwIGlycSA0
NiIKCQlhbHNhLmRyaXZlcl9uYW1lID0gInNuZF9oZGFfaW50ZWwiCgkJZGV2aWNlLmJ1c19wYXRo
ID0gInBjaS0wMDAwOjAxOjAwLjEiCgkJc3lzZnMucGF0aCA9ICIvZGV2aWNlcy9wY2kwMDAwOjAw
LzAwMDA6MDA6MDMuMC8wMDAwOjAxOjAwLjEvc291bmQvY2FyZDAiCgkJZGV2aWNlLmJ1cyA9ICJw
Y2kiCgkJZGV2aWNlLnZlbmRvci5pZCA9ICIxMDAyIgoJCWRldmljZS52ZW5kb3IubmFtZSA9ICJB
ZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSIKCQlkZXZpY2UucHJvZHVjdC5p
ZCA9ICJhYWIwIgoJCWRldmljZS5wcm9kdWN0Lm5hbWUgPSAiQ2FwZSBWZXJkZS9QaXRjYWlybiBI
RE1JIEF1ZGlvIFtSYWRlb24gSEQgNzcwMC83ODAwIFNlcmllc10iCgkJZGV2aWNlLnN0cmluZyA9
ICIwIgoJCWRldmljZS5kZXNjcmlwdGlvbiA9ICJDYXBlIFZlcmRlL1BpdGNhaXJuIEhETUkgQXVk
aW8gW1JhZGVvbiBIRCA3NzAwLzc4MDAgU2VyaWVzXSIKCQltb2R1bGUtdWRldi1kZXRlY3QuZGlz
Y292ZXJlZCA9ICIxIgoJCWRldmljZS5pY29uX25hbWUgPSAiYXVkaW8tY2FyZC1wY2kiCglQcm9m
aWxlczoKCQlvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTA6IERpZ2l0YWwgU3Vycm91bmQgNS4x
IChIRE1JIDApIE91dHB1dCAoc2lua3M6IDEsIHNvdXJjZXM6IDAsIHByaW9yaXR5OiAzMTAwKQoJ
CW91dHB1dDpoZG1pLXN1cnJvdW5kLWV4dHJhMzogRGlnaXRhbCBTdXJyb3VuZCA1LjEgKEhETUkg
MykgT3V0cHV0IChzaW5rczogMSwgc291cmNlczogMCwgcHJpb3JpdHk6IDMxMDApCgkJb2ZmOiBP
ZmYgKHNpbmtzOiAwLCBzb3VyY2VzOiAwLCBwcmlvcml0eTogMCkKCUFjdGl2ZSBQcm9maWxlOiBv
dXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTAKCVBvcnRzOgoJCWhkbWktb3V0cHV0LTA6IEhETUkg
LyBEaXNwbGF5UG9ydCAocHJpb3JpdHk6IDU5MDAsIGxhdGVuY3kgb2Zmc2V0OiAwIHVzZWMsIGF2
YWlsYWJsZSkKCQkJUHJvcGVydGllczoKCQkJCWRldmljZS5pY29uX25hbWUgPSAidmlkZW8tZGlz
cGxheSIKCQkJUGFydCBvZiBwcm9maWxlKHMpOiBvdXRwdXQ6aGRtaS1zdXJyb3VuZC1leHRyYTAK
CQloZG1pLW91dHB1dC0zOiBIRE1JIC8gRGlzcGxheVBvcnQgNCAocHJpb3JpdHk6IDU2MDAsIGxh
dGVuY3kgb2Zmc2V0OiAwIHVzZWMsIGF2YWlsYWJsZSkKCQkJUHJvcGVydGllczoKCQkJCWRldmlj
ZS5pY29uX25hbWUgPSAidmlkZW8tZGlzcGxheSIKCQkJUGFydCBvZiBwcm9maWxlKHMpOiBvdXRw
dXQ6aGRtaS1zdXJyb3VuZC1leHRyYTMK
--001a1136780210bf1904ecc4a68d
Content-Type: text/plain; charset=US-ASCII; name="eld00.txt"
Content-Disposition: attachment; filename="eld00.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hotox67e1

bW9uaXRvcl9wcmVzZW50CQkxCmVsZF92YWxpZAkJMQptb25pdG9yX25hbWUJCQpjb25uZWN0aW9u
X3R5cGUJCUhETUkKZWxkX3ZlcnNpb24JCVsweDJdIENFQS04NjFEIG9yIGJlbG93CmVkaWRfdmVy
c2lvbgkJWzB4MF0gbm8gQ0VBIEVESUQgVGltaW5nIEV4dGVuc2lvbiBibG9jayBwcmVzZW50Cm1h
bnVmYWN0dXJlX2lkCQkweDAKcHJvZHVjdF9pZAkJMHgwCnBvcnRfaWQJCQkweDAKc3VwcG9ydF9o
ZGNwCQkwCnN1cHBvcnRfYWkJCTAKYXVkaW9fc3luY19kZWxheQkwCnNwZWFrZXJzCQlbMHg1Zl0g
RkwvRlIgTEZFIEZDIFJML1JSIFJDIFJMQy9SUkMKc2FkX2NvdW50CQk2CnNhZDBfY29kaW5nX3R5
cGUJWzB4MV0gTFBDTQpzYWQwX2NoYW5uZWxzCQk4CnNhZDBfcmF0ZXMJCVsweDFlZTBdIDMyMDAw
IDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAKc2FkMF9iaXRzCQlbMHhlMDAw
MF0gMTYgMjAgMjQKc2FkMV9jb2RpbmdfdHlwZQlbMHgyXSBBQy0zCnNhZDFfY2hhbm5lbHMJCTYK
c2FkMV9yYXRlcwkJWzB4ZTBdIDMyMDAwIDQ0MTAwIDQ4MDAwCnNhZDFfbWF4X2JpdHJhdGUJNjQw
MDAwCnNhZDJfY29kaW5nX3R5cGUJWzB4N10gRFRTCnNhZDJfY2hhbm5lbHMJCTYKc2FkMl9yYXRl
cwkJWzB4NmMwXSA0NDEwMCA0ODAwMCA4ODIwMCA5NjAwMApzYWQyX21heF9iaXRyYXRlCTE1MzYw
MDAKc2FkM19jb2RpbmdfdHlwZQlbMHhhXSBFLUFDLTMvREQrIChEb2xieSBEaWdpdGFsIFBsdXMp
CnNhZDNfY2hhbm5lbHMJCTgKc2FkM19yYXRlcwkJWzB4YzBdIDQ0MTAwIDQ4MDAwCnNhZDRfY29k
aW5nX3R5cGUJWzB4Yl0gRFRTLUhECnNhZDRfY2hhbm5lbHMJCTgKc2FkNF9yYXRlcwkJWzB4MWVj
MF0gNDQxMDAgNDgwMDAgODgyMDAgOTYwMDAgMTc2NDAwIDE5MjAwMApzYWQ1X2NvZGluZ190eXBl
CVsweGNdIE1MUCAoRG9sYnkgVHJ1ZUhEKQpzYWQ1X2NoYW5uZWxzCQk4CnNhZDVfcmF0ZXMJCVsw
eDFlYzBdIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAK
--001a1136780210bf1904ecc4a68d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--001a1136780210bf1904ecc4a68d--
