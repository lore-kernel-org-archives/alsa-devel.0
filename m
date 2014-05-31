From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Bug report: [alsa-sink-USB
 Audio] alsa-sink.c: Most likely this is a bug in the ALSA driver '(null)'.
 Please report this issue to the ALSA
Date: Sat, 31 May 2014 12:58:54 +0800
Message-ID: <CAN8cciauEUo4A5z7E-0f7EhehRaTJmNjo7Ok7R1GAGQphehjHQ@mail.gmail.com>
References: <001401cf7818$4be327c0$e3a97740$@lucidpixels.com>
 <CAN8cciZwbNVu7LO_muaynfbudxTB8qRS0aPyxwnd28yupCxSEA@mail.gmail.com>
 <001201cf7be2$dfbb1980$9f314c80$@lucidpixels.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0293178301=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <001201cf7be2$dfbb1980$9f314c80$@lucidpixels.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============0293178301==
Content-Type: multipart/alternative; boundary=001a11c27e38d9852704faab04a1

--001a11c27e38d9852704faab04a1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>
>
>
> As requested=E2=80=94
>
>
>
> http://home.comcast.net/~jpiszcz/20140530/lsusb-vvvv.txt
>
> http://home.comcast.net/~jpiszcz/20140530/full-pulse-audio-log.txt

>
> http://home.comcast.net/~jpiszcz/20140530/alsa-info.txt
>

control.6 {
iface MIXER
name 'Speaker Playback Volume'
value.0 151
value.1 151
comment {
access 'read write'
type INTEGER
count 2
range '0 - 151'
dbmin -2837
dbmax -6
dbvalue.0 -6
dbvalue.1 -6
}
}

You have to specify log_info=3Ddebug in daemon.conf

Check the pulseaudio debug log whether pulseaudio calculated  software
volume is accurate enough (VOLUME_ACCURACY=3DPA_VOLUME_NORM/100) since your
Max dB  -0.06 are quite close to PA_VOLUME_NORM

>
>
> =C3=98  step to reproduce your problem when you report the bug

>
> I often SSH to my machine or use X remotely and not locally=E2=80=94 this=
 is the
first time I have seen this in logs that I can remember and I=E2=80=99ve no=
t
changed anything locally.
>

> > =3D=3D> /var/log/user.log <=3D=3D
> >
> > May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio]
alsa-sink.c:
> > ALSA woke us up to write new data to the device, but there was actually
> > nothing to write!
> >
> > May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio]
alsa-sink.c:
> > Most likely this is a bug in the ALSA driver '(null)'. Please report
this
> > issue to the ALSA developers.
>
> Name of alsa sink seem changed from USB-audio to null,  did you find any
unplug event if USB audio device in system log
>
> Any error message related to USB controllers and your audio card
>
> >
> > May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio]
alsa-sink.c: We
> > were woken up with POLLOUT set -- however a subsequent snd_pcm_avail()
> > returned 0 or another value < min_avail.
> >
> >

http://www.alsa-project.org/main/index.php/XRUN_Debug

/proc/asound/card#/pcm0p/xrun_debug

Replace '#' with your card number (usually 0). This proc file can enable
various debugging tools. The CONFIG_SND_PCM_XRUN_DEBUG,
CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG options must be enabled in your
kernel (if xrun_debug proc file is present - this feature is enabled).

# Enable basic debugging and dump stack, check hardware pointer on the
period update
# Usefull to just see, if PCM stream is stopped for a reason (usually wrong
audio process timing from scheduler)
# And to check the values from driver
echo 11 > /proc/asound/card0/pcm0p/xrun_debug

--001a11c27e38d9852704faab04a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt; As requested=E2=80=94<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt; <a href=3D"http://home.comcast.net/~jpiszcz/20140530/lsusb-vvvv.txt">h=
ttp://home.comcast.net/~jpiszcz/20140530/lsusb-vvvv.txt</a><br>
&gt;<br>
&gt; <a href=3D"http://home.comcast.net/~jpiszcz/20140530/full-pulse-audio-=
log.txt">http://home.comcast.net/~jpiszcz/20140530/full-pulse-audio-log.txt=
</a></p>
<p>&gt;<br>
&gt; <a href=3D"http://home.comcast.net/~jpiszcz/20140530/alsa-info.txt">ht=
tp://home.comcast.net/~jpiszcz/20140530/alsa-info.txt</a><br>
&gt;</p>
<p>control.6 {<br>
iface MIXER<br>
name &#39;Speaker Playback Volume&#39;<br>
value.0 151<br>
value.1 151<br>
comment {<br>
access &#39;read write&#39;<br>
type INTEGER<br>
count 2<br>
range &#39;0 - 151&#39;<br>
dbmin -2837<br>
dbmax -6<br>
dbvalue.0 -6<br>
dbvalue.1 -6<br>
}<br>
}</p>
<p>You have to specify log_info=3Ddebug in daemon.conf</p>
<p>Check the pulseaudio debug log whether pulseaudio calculated=C2=A0 softw=
are volume is accurate enough (VOLUME_ACCURACY=3DPA_VOLUME_NORM/100) since =
your=C2=A0 Max dB=C2=A0 -0.06 are quite close to PA_VOLUME_NORM</p>
<p>&gt; =C2=A0<br>
&gt;<br>
&gt; =C3=98=C2=A0 step to reproduce your problem when you report the bug</p=
>
<p>&gt;<br>
&gt; I often SSH to my machine or use X remotely and not locally=E2=80=94 t=
his is the first time I have seen this in logs that I can remember and I=E2=
=80=99ve not changed anything locally.<br>
&gt;</p>
<p>&gt; &gt; =3D=3D&gt; /var/log/user.log &lt;=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa=
-sink.c:<br>
&gt; &gt; ALSA woke us up to write new data to the device, but there was ac=
tually<br>
&gt; &gt; nothing to write!<br>
&gt; &gt;<br>
&gt; &gt; May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa=
-sink.c:<br>
&gt; &gt; Most likely this is a bug in the ALSA driver &#39;(null)&#39;. Pl=
ease report this<br>
&gt; &gt; issue to the ALSA developers.<br>
&gt;<br>
&gt; Name of alsa sink seem changed from USB-audio to null,=C2=A0 did you f=
ind any unplug event if USB audio device in system log<br>
&gt;<br>
&gt; Any error message related to USB controllers and your audio card<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa=
-sink.c: We<br>
&gt; &gt; were woken up with POLLOUT set -- however a subsequent snd_pcm_av=
ail()<br>
&gt; &gt; returned 0 or another value &lt; min_avail.<br>
&gt; &gt;<br>
&gt; &gt;</p>
<p><a href=3D"http://www.alsa-project.org/main/index.php/XRUN_Debug">http:/=
/www.alsa-project.org/main/index.php/XRUN_Debug</a></p>
<p>/proc/asound/card#/pcm0p/xrun_debug</p>
<p>Replace &#39;#&#39; with your card number (usually 0). This proc file ca=
n enable various debugging tools. The CONFIG_SND_PCM_XRUN_DEBUG, CONFIG_SND=
_VERBOSE_PROCFS, CONFIG_SND_DEBUG options must be enabled in your kernel (i=
f xrun_debug proc file is present - this feature is enabled).</p>

<p># Enable basic debugging and dump stack, check hardware pointer on the p=
eriod update<br>
# Usefull to just see, if PCM stream is stopped for a reason (usually wrong=
 audio process timing from scheduler)<br>
# And to check the values from driver<br>
echo 11 &gt; /proc/asound/card0/pcm0p/xrun_debug<br>
</p>

--001a11c27e38d9852704faab04a1--

--===============0293178301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0293178301==--
