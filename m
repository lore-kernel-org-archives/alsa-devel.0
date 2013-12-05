From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Thu, 5 Dec 2013 15:24:09 +0800
Message-ID: <CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0887730459=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: John Ettedgui <john.ettedgui@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============0887730459==
Content-Type: multipart/alternative; boundary=047d7bdc15e868d34a04ecc46ad4

--047d7bdc15e868d34a04ecc46ad4
Content-Type: text/plain; charset=UTF-8

>>>> I just changed my RadeonHD 4670 for a 7870, and now when I type "aplay
>>>> -l"  I get many HDMI codecs instead of just one like for the previous card.
>>>>
>>>
How many hdmi , dvi or display port connectors do your card have ?


Specification seem support up to 6 displays


>>>
>>> Oh interesting, but I was just using the standard HDMI connector of the
>> VGA card without connecting my card to the motherboard by more than PCI-E.
>> Also, spdif would not get me 6 channels in LCPM, so I don't think that
>> was it but I could be wrong.
>>
>>>
>>>
>>>
Is there any reason for you to disable on-board hda controller and alc888
as you don't have any capture device anymore ?

pactl list

Do pulseaudio server select null sink or hdmi.monitor as the default source
?


>>>> When I type "aplay -L" I get one more codec that I can see it in the
>>>> pavucontrol profile (not sure which one as the names are irrelevant)
>>>>
>>>>
>>>> if in default.pa I specify the alsa sink device=hw:0,3 directly, I do
>>>> get sound, but then in pavucontrol I do not get the advanced sub-menu
>>>> anymore which makes me think something is not working properly...
>>>>
>>>> For now I have settled on this hack instead:
>>>>
>>>>
>>>> I changed the extra-hdmi.conf in
>>>> /usr/share/pulseaudio/alsa-mixer/profile-sets file to :
>>>>
>>>> [Mapping hdmi-surround-extra0]
>>>> description = Digital Surround 5.1 (HDMI 0)
>>>> device-strings = hdmi:%f,0
>>>> paths-output = hdmi-output-0
>>>> channel-map =
>>>> front-left,front-right,rear-left,rear-right,front-center,lfe
>>>> priority = 1
>>>> direction = output
>>>>
>>>> [Mapping hdmi-surround-extra3]
>>>> description = Digital Surround 5.1 (HDMI 3)
>>>> device-strings = hdmi:%f,0
>>>> paths-output = hdmi-output-3
>>>> channel-map =
>>>> front-left,front-right,rear-left,rear-right,front-center,lfe
>>>> priority = 1
>>>> direction = output
>>>>
>>>> I only need one of these two, somehow they both work...
>>>>
>>>> Now everything works for me, but since it's not out of the box, I am
>>>> guessing there might be something out there to fix.
>>>>
>>>>
>>>>
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=5a61358433b1f89b500f2c365746c73cb7a27e2f
>>>
>>> Hmmm I am not sure what you meant by that.
>>
>>
> Here is the alsa-info.
>


strange that all jacks return true
    control.1 {
        iface CARD
        name 'HDMI/DP,pcm=3 Jack'
        value true
        comment {
            access read
            type BOOLEAN
            count 1
        }
    }
    ...

    control.31 {
        iface CARD
        name 'HDMI/DP,pcm=11 Jack'
        value true
        comment {
            access read
            type BOOLEAN
            count 1
        }
    }


cat /proc/asound/card0/eld#*.0

does your hdmi montior name appear in one of the six eld


[    5.468413] [drm] Connector 2:
[    5.468414] [drm]   HDMI-A-1
[    5.468415] [drm]   HPD1


Does the graphic driver show which hdmi monitor connect to which ports in
system log ?

--047d7bdc15e868d34a04ecc46ad4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
><div><div class=3D"gmail_extra">

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><p =
style=3D"font-family:sans-serif;border:0px none;margin:0px;padding:7px 0px;=
color:rgb(51,51,51);font-size:13.1429px;line-height:19px;background-color:r=
gb(252,253,254)">




I just changed my RadeonHD 4670 for a 7870, and now when I type &quot;aplay=
 -l&quot;=C2=A0 I get many HDMI codecs instead of just one like for the pre=
vious card.</p></div></blockquote></div></div></div></div></blockquote></di=
v>
</div></div></div></blockquote></div></div></div></div></div></blockquote><=
div><br></div><div>How many hdmi , dvi or display port connectors do your c=
ard have ?<br></div><div><br>=C2=A0<br></div><div>Specification seem suppor=
t up to 6 displays <br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><div><div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra">
<div class=3D"gmail_quote"><br><div><br></div></div></div></div></blockquot=
e></div>Oh interesting, but I was just using the standard HDMI connector of=
 the VGA card without connecting my card to the motherboard by more than PC=
I-E.<div>

Also, spdif would not get me 6 channels in LCPM, so I don&#39;t think that =
was it but I could be wrong.</div>
<div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div>

</div><br><div><div><br></div></div></div></div></div></blockquote></div></=
div></div></div></blockquote></div></div></div></div></div></blockquote><di=
v><br></div><div>Is there any reason for you to disable on-board hda contro=
ller and alc888 <br>

</div><div>as you don&#39;t have any capture device anymore ?<br></div><div=
><br></div><div>pactl list <br></div><div><br></div><div>Do pulseaudio serv=
er select null sink or hdmi.monitor as the default source ?<br></div><div>

<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><div><div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><p style=3D"font-family:sans-serif;border:0px none;=
margin:0px;padding:7px 0px;color:rgb(51,51,51);font-size:13.1429px;line-hei=
ght:19px;background-color:rgb(252,253,254)">





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
</div></blockquote><div><br><br></div><div>strange that all jacks return tr=
ue <br></div>=C2=A0=C2=A0=C2=A0 control.1 {<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 iface CARD<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 name &#39;HDM=
I/DP,pcm=3D3 Jack&#39;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 value true<=
br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 comment {<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 access read<br>
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
v><div class=3D"gmail_extra">does your hdmi montior name appear in one of t=
he six eld <br>
<br><br>[=C2=A0=C2=A0=C2=A0 5.468413] [drm] Connector 2:<br>[=C2=A0=C2=A0=
=C2=A0 5.468414] [drm]=C2=A0=C2=A0 HDMI-A-1<br>[=C2=A0=C2=A0=C2=A0 5.468415=
] [drm]=C2=A0=C2=A0 HPD1<br><br></div><div class=3D"gmail_extra"><br>Does t=
he graphic driver show which hdmi monitor connect to which ports in system =
log ?<br>
<br><br></div></div>

--047d7bdc15e868d34a04ecc46ad4--

--===============0887730459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0887730459==--
