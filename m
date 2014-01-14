From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Surround sound not working on
	ALC887 based motherboard
Date: Tue, 14 Jan 2014 14:34:47 +0800
Message-ID: <CAN8cciZ2BUdE+V0SrADBvcTqGdKeqtPk+Us9jUxUcDRJPsfK=g@mail.gmail.com>
References: <1389286414.4661.13.camel@TesterBox>
	<CAN8cciaoEwYvqDCGiR5jjgK78GMMG6dVSnzJN2_D9D4H6RWusA@mail.gmail.com>
	<1389643950.28960.6.camel@TesterTop4>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1456338461=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1389643950.28960.6.camel@TesterTop4>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: =?UTF-8?Q?Olivier_Cr=C3=AAte?= <olivier.crete@ocrete.ca>, pulseaudio-discuss@lists.freedesktop.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1456338461==
Content-Type: multipart/alternative; boundary=089e010d9d40814fea04efe8637f

--089e010d9d40814fea04efe8637f
Content-Type: text/plain; charset=UTF-8

> >         I have a Asus P5G41T-M LX Plus motherboard which is ICH7 +
> >         Realtek
> >         ALC887-VD, alsa only lets me access the first 2 channels
> >         (stereo), but
> >         not the 6 other ones. It works fine in Windows.
> >
> >         Trying to run this after killing pulseaudio fails:
> >
> >         $ aplay -D surround40:0 -f S16_LE -r 44100 -c 4 /dev/zero -v
> >         Playing raw data '/dev/zero' : Signed 16 bit Little Endian,
> >         Rate 44100 Hz, Channels 4
> >         aplay: set_params:1239: Channels count non available
> >
> >
> >         Output from alsa-info:
> >
http://www.alsa-project.org/db/?f=fe378d28f0dbb5a427b005d20866a762fd37d31a
>
> > you have to change channel mode from 2ch to 6ch to retask the input
> > jacks as output if your motherboard only have three audio jacks at
> > rear panel

> > Simple mixer control 'Channel Mode',0
> >   Capabilities: enum
> >   Items: '2ch' '4ch' '6ch'
> >   Item0: '2ch'
>
> How would one do that ? Pulseaudio only offers Stereo profiles.


amixer -c0 set "Channel  Mode" "6ch"

you can logout and login after you set the channel mode to 6ch so that
pulseaudio is restarted.

this also require

alsactl store this setting before computer shutdown

alsactl restore this setting after computer boot


> >
> > post output of pactl list or pulseaudio verbose log
>
> http://www.ocrete.ca/surround/pactl-list.txt
> http://www.ocrete.ca/surround/pulseaudio-vv.txt
>
>
> > do you mean pulseaudio cannot probe the surroun40 or surround51
> > profile ?
>
> Yes, but I can't use it with aplay even without pulseaudio running.
>


try speaker-test -c 6 -t wav -Dhw:0,0 after you set the channel mode to 6ch

--089e010d9d40814fea04efe8637f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p></p>
<p>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have a Asus P5G41T-M LX Plus mot=
herboard which is ICH7 +<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Realtek<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALC887-VD, alsa only lets me access t=
he first 2 channels<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (stereo), but<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 not the 6 other ones. It works fine i=
n Windows.<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Trying to run this after killing puls=
eaudio fails:<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ aplay -D surround40:0 -f S16_LE -r =
44100 -c 4 /dev/zero -v<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Playing raw data &#39;/dev/zero&#39; =
: Signed 16 bit Little Endian,<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Rate 44100 Hz, Channels 4<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 aplay: set_params:1239: Channels coun=
t non available<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Output from alsa-info:<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www.alsa-project.or=
g/db/?f=3Dfe378d28f0dbb5a427b005d20866a762fd37d31a" target=3D"_blank">http:=
//www.alsa-project.org/db/?f=3Dfe378d28f0dbb5a427b005d20866a762fd37d31a</a>=
<br>
&gt;<br>
&gt; &gt; you have to change channel mode from 2ch to 6ch to retask the inp=
ut<br>
&gt; &gt; jacks as output if your motherboard only have three audio jacks a=
t<br>
&gt; &gt; rear panel</p><p>&gt; &gt; Simple mixer control &#39;Channel Mode=
&#39;,0<br>
&gt; &gt; =C2=A0 Capabilities: enum<br>
&gt; &gt; =C2=A0 Items: &#39;2ch&#39; &#39;4ch&#39; &#39;6ch&#39;<br>
&gt; &gt; =C2=A0 Item0: &#39;2ch&#39;<br>
&gt;<br>
&gt; How would one do that ? Pulseaudio only offers Stereo profiles.<br></p=
><pre><br>amixer -c0 set &quot;Channel  Mode&quot; &quot;6ch&quot;</pre><p>=
you can logout and login after you set the channel mode to 6ch so that puls=
eaudio is restarted.<br>

</p><p>this also require <br></p><p>alsactl store this setting before compu=
ter shutdown<br></p><p>alsactl restore this setting after computer boot<br>=
</p><p><br>
&gt; &gt;<br>
&gt; &gt; post output of pactl list or pulseaudio verbose log<br>
&gt;<br>
&gt; <a href=3D"http://www.ocrete.ca/surround/pactl-list.txt" target=3D"_bl=
ank">http://www.ocrete.ca/surround/pactl-list.txt</a><br>
&gt; <a href=3D"http://www.ocrete.ca/surround/pulseaudio-vv.txt" target=3D"=
_blank">http://www.ocrete.ca/surround/pulseaudio-vv.txt</a><br>
&gt;<br>
&gt;<br>
&gt; &gt; do you mean pulseaudio cannot probe the surroun40 or surround51<b=
r>
&gt; &gt; profile ?<br>
&gt;<br>
&gt; Yes, but I can&#39;t use it with aplay even without pulseaudio running=
.<br>
&gt;</p><p><br></p><p>try speaker-test -c 6 -t wav -Dhw:0,0 after you set t=
he channel mode to 6ch <br>
</p>
<p><br><br><br></p>
</div>

--089e010d9d40814fea04efe8637f--

--===============1456338461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1456338461==--
