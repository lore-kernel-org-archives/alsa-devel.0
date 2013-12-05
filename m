From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Thu, 5 Dec 2013 20:20:13 +0800
Message-ID: <CAN8cciYmd4tK4Ep9VQ-4u_kYCwpmBxhYBJ9JWK6D75wGtCW42w@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
	<CAJ3TwYTyHKTNX0Db78pUG9Phkk8O6TH4wNRp-x5tLYR1SyErtw@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0235249876=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYTyHKTNX0Db78pUG9Phkk8O6TH4wNRp-x5tLYR1SyErtw@mail.gmail.com>
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

--===============0235249876==
Content-Type: multipart/alternative; boundary=089e0149bc243424e804ecc88d60

--089e0149bc243424e804ecc88d60
Content-Type: text/plain; charset=UTF-8

>
>>>>>>>>> I just changed my RadeonHD 4670 for a 7870, and now when I type
>>>>>>>>> "aplay -l"  I get many HDMI codecs instead of just one like for the
>>>>>>>>> previous card.
>>>>>>>>>
>>>>>>>>
>>>>> How many hdmi , dvi or display port connectors do your card have ?
>>>>>
>>>>> 1 hdmi, 1 vga, 2 tiny ports that I cannot name.
>>>>
>>>
are these mini display port ?

http://en.wikipedia.org/wiki/Mini_DisplayPort


>
>>>>> Specification seem support up to 6 displays
>>>>>
>>>> I believe these are virtual HDMI ouputs, not physical ones and total
>>>> for 6 in aplay -l and for 4 in aplay -L.
>>>>
>>>
>>> are you using latest alsa-lib ?
>>>
>>>
>>> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=383912ef83cb2d5835239a23f6afc6198697a587
>>>
>>> Good point, I'm on a 3.13-rc2 kernel but totally forgot about the lib
>> part.
>> I have the 1.0.27.2 lib, let me get the git version.
>>
>
> Alright exactly the same behavior with -git.
>

--089e0149bc243424e804ecc88d60
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra">
<div class=3D"gmail_quote"><div class=3D"im"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=
=3D"gmail_quote">
<div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div><div><div class=3D"gmail_extra"><div class=3D"=
gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
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
div><br></div></div><div>How many hdmi , dvi or display port connectors do =
your card have ?<br></div><div><br></div></div></div></div></blockquote>




</div><div>1 hdmi, 1 vga, 2 tiny ports that I cannot name.=C2=A0</div></div=
></div></div></blockquote></div></div></div></div></blockquote></div></div>=
</div></div></blockquote></div></div></div></div></blockquote><div><br></di=
v>
<div>are these mini display port ?<br></div><div><br><a href=3D"http://en.w=
ikipedia.org/wiki/Mini_DisplayPort">http://en.wikipedia.org/wiki/Mini_Displ=
ayPort</a><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
 class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div class=3D"gmail_extra">
<div class=3D"gmail_quote"><div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">



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



<br></div></div></div></div></blockquote></div><div>Good point, I&#39;m on =
a 3.13-rc2 kernel but totally forgot about the lib part.</div><div>I have t=
he 1.0.27.2 lib, let me get the git version.</div></div></div></div></block=
quote>

<div><br></div></div><div>Alright exactly the same behavior with -git.</div=
></div></div></div>
</blockquote></div><br></div></div>

--089e0149bc243424e804ecc88d60--

--===============0235249876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0235249876==--
