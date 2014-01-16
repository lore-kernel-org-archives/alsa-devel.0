From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Need help with audio gain on an Intel HDA
 equipt ASUS M2N-SLI Deluxe
Date: Thu, 16 Jan 2014 16:23:19 +0800
Message-ID: <CAN8cciZLRy6DE_K9v2eVGxpdF_=aL+d+dXRRpbXEgXdgxB=seQ@mail.gmail.com>
References: <201401150017.59498.gheskett@wdtv.com>
	<201401151817.06046.gheskett@wdtv.com>
	<CAN8ccib-LkLFrngsNwaFFuAW97JiQVu7R25g7yrtgfDVe_mM=g@mail.gmail.com>
	<2406669.07WltcfjcV@t520.axxite.internal>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0766314244=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <2406669.07WltcfjcV@t520.axxite.internal>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0766314244==
Content-Type: multipart/alternative; boundary=90e6ba1efbf454bd2004f01223ad

--90e6ba1efbf454bd2004f01223ad
Content-Type: text/plain; charset=UTF-8

2014/1/16 Axel Braun <axel.braun@gmx.de>

> Am Donnerstag, 16. Januar 2014, 09:03:25 schrieb Raymond Yau:
> > Post the output of
> >
> > pactl list
> >
> > pulseaudio verbose log
>
> I jump in here as well, same problem on a ThinkPad T520, sound volume is
> way
> too low - watching movie via loudspeakers is fairly impossible.
>
> Any hint you could give me?
>

post the output of alsa-info.sh , there is a bug in alsa-driver which treat
dock headphone and headphone to support surround 4.0


    Profile:
        input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1,
priority: 60, available: yes)
        output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,
priority: 6000, available: yes)
        output:analog-stereo+input:analog-stereo: Analog Stereo Duplex
(sinks: 1, sources: 1, priority: 6060, available: yes)
        output:analog-surround-40: Analog Surround 4.0 Output (sinks: 1,
sources: 0, priority: 700, available: yes)
        output:analog-surround-40+input:analog-stereo: Analog Surround 4.0
Output + Analog Stereo Input (sinks: 1, sources: 1, priority: 760,
available: yes)

--90e6ba1efbf454bd2004f01223ad
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">2014/1/16 Axel Braun <span dir=3D"ltr">&lt;<a href=3D"mailto:axel.b=
raun@gmx.de" target=3D"_blank">axel.braun@gmx.de</a>&gt;</span><br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
Am Donnerstag, 16. Januar 2014, 09:03:25 schrieb Raymond Yau:<br>
<div class=3D"im">&gt; Post the output of<br>
&gt;<br>
&gt; pactl list<br>
&gt;<br>
&gt; pulseaudio verbose log<br>
<br>
</div>I jump in here as well, same problem on a ThinkPad T520, sound volume=
 is way<br>
too low - watching movie via loudspeakers is fairly impossible.<br>
<br>
Any hint you could give me?<br></blockquote><div><br></div><div>post the ou=
tput of alsa-info.sh , there is a bug in alsa-driver which treat dock headp=
hone and headphone to support surround 4.0 <br><br><br>=C2=A0=C2=A0=C2=A0 P=
rofile:
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 input:analog-stereo: Analog Stere=
o Input (sinks: 0, sources: 1, priority: 60, available: yes)
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:analog-stereo: Analog Ster=
eo Output (sinks: 1, sources: 0, priority: 6000, available: yes)
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:analog-stereo+input:analog=
-stereo: Analog Stereo Duplex (sinks: 1, sources: 1, priority: 6060, availa=
ble: yes)
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:analog-surround-40: Analog=
 Surround 4.0 Output (sinks: 1, sources: 0, priority: 700, available: yes)
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 output:analog-surround-40+input:a=
nalog-stereo: Analog Surround 4.0 Output + Analog Stereo Input (sinks: 1, s=
ources: 1, priority: 760, available: yes)<br><br></div><div>=C2=A0<br></div=
></div><br></div></div>

--90e6ba1efbf454bd2004f01223ad--

--===============0766314244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0766314244==--
