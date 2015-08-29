From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: sound is distorted when pulseaudio system
 timer scheduling is used (tsched=1)
Date: Sat, 29 Aug 2015 19:41:41 +0800
Message-ID: <CAN8cciaC87FAf=tOhSFC=FOG9rc9CvuH_6+HNqC15+R7TzeUSg@mail.gmail.com>
References: <55E026D8.5040905@mentor.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1802371185=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <55E026D8.5040905@mentor.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1802371185==
Content-Type: multipart/alternative; boundary=001a11c2f102248704051e71afcf

--001a11c2f102248704051e71afcf
Content-Type: text/plain; charset=UTF-8

>
> I am having issue with pulseaudiosink,
> I used following command to play a wav file
> gst-launch filesrc location=<wav file path> ! wavparse ! pulseaudiosink
>
> if tsched is enabled, then play of wav file via pulseaudiosink gives me
lots of Underrun, and the sound is distorted, following is the pulseaudio
log when --log-level=3
>
> I: [pulseaudio] protocol-native.c: Got credentials: uid=0 gid=0 success=1
> I: [pulseaudio] sink-input.c: Trying to change sample rate
> I: [pulseaudio] alsa-sink.c: Updating rate for device hw:0, new rate is
48000
> I: [pulseaudio] source.c: Changed sampling rate successfully
> I: [pulseaudio] sink.c: Changed sampling rate successfully
> I: [pulseaudio] sink-input.c: Rate changed to 48000 Hz
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Trying resume...
> I: [alsa-sink-HiFi wm8962-0] alsa-util.c: cannot disable ALSA period
wakeups
> I: [alsa-sink-HiFi wm8962-0] alsa-util.c: ALSA period wakeups were not
disabled
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Time scheduling watermark is
18.38ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Resumed successfully...
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Starting playback.
> I: [pulseaudio] sink-input.c: Created input 0 "pulsesink probe" on
alsa_output.platform-sound.analog-s
> tereo with sample spec s16le 2ch 48000Hz and channel map
front-left,front-right
> I: [pulseaudio] sink-input.c:     media.name = "pulsesink probe"
> I: [pulseaudio] sink-input.c:     application.name = "gst-launch-0.10"
> I: [pulseaudio] sink-input.c:     native-protocol.peer = "UNIX socket
client"
> I: [pulseaudio] sink-input.c:     native-protocol.version = "29"
> I: [pulseaudio] sink-input.c:     application.process.id = "985"
> I: [pulseaudio] sink-input.c:     application.process.user = "root"
> I: [pulseaudio] sink-input.c:     application.process.host = "mx6q"
> I: [pulseaudio] sink-input.c:     application.process.binary =
"gst-launch-0.10"
> I: [pulseaudio] sink-input.c:     application.language = "C"
> I: [pulseaudio] sink-input.c:     application.process.machine_id =
"0aa7a9566c734f608cbd36f187de8645"
> I: [pulseaudio] sink-input.c:     module-stream-restore.id =
"sink-input-by-application-name:gst-launc
> h-0.10"
> I: [pulseaudio] protocol-native.c: Requested tlength=250.00 ms,
minreq=20.00 ms
> I: [pulseaudio] protocol-native.c: Final latency 250.00 ms = 105.00 ms +
2*20.00 ms + 105.00 ms
> I: [pulseaudio] sink-input.c: Freeing input 0 "pulsesink probe"
> I: [pulseaudio] sink-input.c: Created input 1 "Playback Stream" on
alsa_output.platform-sound.analog-s
> tereo with sample spec s16le 2ch 48000Hz and channel map
front-left,front-right
> I: [pulseaudio] sink-input.c:     media.name = "Playback Stream"
> I: [pulseaudio] sink-input.c:     application.name = "gst-launch-0.10"
> I: [pulseaudio] sink-input.c:     native-protocol.peer = "UNIX socket
client"
> I: [pulseaudio] sink-input.c:     native-protocol.version = "29"
> I: [pulseaudio] sink-input.c:     application.process.id = "985"
> I: [pulseaudio] sink-input.c:     application.process.user = "root"
> I: [pulseaudio] sink-input.c:     application.process.host = "mx6q"
> I: [pulseaudio] sink-input.c:     application.process.binary =
"gst-launch-0.10"
> I: [pulseaudio] sink-input.c:     application.language = "C"
> I: [pulseaudio] sink-input.c:     application.process.machine_id =
"0aa7a9566c734f608cbd36f187de8645"
> I: [pulseaudio] sink-input.c:     module-stream-restore.id =
"sink-input-by-application-name:gst-launc
> h-0.10"
> I: [pulseaudio] protocol-native.c: Requested tlength=200.00 ms,
minreq=10.00 ms
> I: [pulseaudio] protocol-native.c: Final latency 200.00 ms = 90.00 ms +
2*10.00 ms + 90.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
28.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
38.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
48.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
58.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
68.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
78.38 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
80.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
1.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
2.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
4.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
8.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
16.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
26.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
36.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
46.00 ms
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: ALSA woke us up to write new
data to the device, but there w
> as actually nothing to write!
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Most likely this is a bug in
the ALSA driver '(null)'. Pleas
> e report this issue to the ALSA developers.
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: We were woken up with POLLOUT
set -- however a subsequent sn
> d_pcm_avail() returned 0 or another value < min_avail.
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
56.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
66.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
76.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
86.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
96.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
86.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
106.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
96.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
116.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
106.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
126.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
116.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
136.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
126.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
146.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
136.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
156.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
146.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
166.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark to
156.00 ms
> I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency to
176.00 ms
> I: [pulseaudio] sink-input.c: Freeing input 1 "Playback Stream"
> I: [pulseaudio] client.c: Freed 4 "gst-launch-0.10"
> I: [pulseaudio] protocol-native.c: Connection died.
>
> from the log it seems like, when system timer based scheduling is used,
then pulseaudio will try to keep minimum watermark/latency, only when
Underrun occurs, it will increase watermark/latency.
>
> Is this the expected behaviour of pulseaudio 'glict free' feature?

> And from the log there is some error message complain about ALSA driver
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: ALSA woke us up to write new
data to the device, but there w
> as actually nothing to write!
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Most likely this is a bug in
the ALSA driver '(null)'. Pleas
> e report this issue to the ALSA developers.
> E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: We were woken up with POLLOUT
set -- however a subsequent sn
> d_pcm_avail() returned 0 or another value < min_avail.
>
> does this mean, there is some bug in ALSA driver, or it just indicates
the ALSA driver doesn't support glitch free feature very well

The timer base scheduling require sound card driver provide accurate
hw_ptr position at any time.

So far only two sound card drivers snd-hda-intel and snd-oxygen can provide
accurate hw_ptr position from hardware register

static snd_pcm_uframes_t dmaengine_pcm_pointer(
struct snd_pcm_substream *substream)
{
struct snd_soc_pcm_runtime *rtd = substream->private_data;
struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);

if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
return snd_dmaengine_pcm_pointer_no_residue(substream);
else
return snd_dmaengine_pcm_pointer(substream);
}

http://lxr.free-electrons.com/ident?i=dmaengine_tx_status

Seem none of soc sound drivers can report position accurate than period
size

Is there any reason to enable timer based scheduling by default ?

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081501.html

You can try alexandra 's program to find out how accuate hw_ptr can your
sound card driver can report ?

--001a11c2f102248704051e71afcf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; I am having issue with pulseaudiosink,<br>
&gt; I used following command to play a wav file<br>
&gt; gst-launch filesrc location=3D&lt;wav file path&gt; ! wavparse ! pulse=
audiosink<br>
&gt;<br>
&gt; if tsched is enabled, then play of wav file via pulseaudiosink gives m=
e lots of Underrun, and the sound is distorted, following is the pulseaudio=
 log when --log-level=3D3<br>
&gt;<br>
&gt; I: [pulseaudio] protocol-native.c: Got credentials: uid=3D0 gid=3D0 su=
ccess=3D1<br>
&gt; I: [pulseaudio] sink-input.c: Trying to change sample rate<br>
&gt; I: [pulseaudio] alsa-sink.c: Updating rate for device hw:0, new rate i=
s 48000<br>
&gt; I: [pulseaudio] source.c: Changed sampling rate successfully<br>
&gt; I: [pulseaudio] sink.c: Changed sampling rate successfully<br>
&gt; I: [pulseaudio] sink-input.c: Rate changed to 48000 Hz<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Trying resume...<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-util.c: cannot disable ALSA period w=
akeups<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-util.c: ALSA period wakeups were not=
 disabled<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Time scheduling watermark is=
 18.38ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Resumed successfully...<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Starting playback.<br>
&gt; I: [pulseaudio] sink-input.c: Created input 0 &quot;pulsesink probe&qu=
ot; on alsa_output.platform-sound.analog-s<br>
&gt; tereo with sample spec s16le 2ch 48000Hz and channel map front-left,fr=
ont-right<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://med=
ia.name">media.name</a> =3D &quot;pulsesink probe&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://app=
lication.name">application.name</a> =3D &quot;gst-launch-0.10&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0native-protocol.peer =
=3D &quot;UNIX socket client&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0native-protocol.versi=
on =3D &quot;29&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://app=
lication.process.id">application.process.id</a> =3D &quot;985&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.u=
ser =3D &quot;root&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.h=
ost =3D &quot;mx6q&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.b=
inary =3D &quot;gst-launch-0.10&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.language =
=3D &quot;C&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.m=
achine_id =3D &quot;0aa7a9566c734f608cbd36f187de8645&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://mod=
ule-stream-restore.id">module-stream-restore.id</a> =3D &quot;sink-input-by=
-application-name:gst-launc<br>
&gt; h-0.10&quot;<br>
&gt; I: [pulseaudio] protocol-native.c: Requested tlength=3D250.00 ms, minr=
eq=3D20.00 ms<br>
&gt; I: [pulseaudio] protocol-native.c: Final latency 250.00 ms =3D 105.00 =
ms + 2*20.00 ms + 105.00 ms<br>
&gt; I: [pulseaudio] sink-input.c: Freeing input 0 &quot;pulsesink probe&qu=
ot;<br>
&gt; I: [pulseaudio] sink-input.c: Created input 1 &quot;Playback Stream&qu=
ot; on alsa_output.platform-sound.analog-s<br>
&gt; tereo with sample spec s16le 2ch 48000Hz and channel map front-left,fr=
ont-right<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://med=
ia.name">media.name</a> =3D &quot;Playback Stream&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://app=
lication.name">application.name</a> =3D &quot;gst-launch-0.10&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0native-protocol.peer =
=3D &quot;UNIX socket client&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0native-protocol.versi=
on =3D &quot;29&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://app=
lication.process.id">application.process.id</a> =3D &quot;985&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.u=
ser =3D &quot;root&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.h=
ost =3D &quot;mx6q&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.b=
inary =3D &quot;gst-launch-0.10&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.language =
=3D &quot;C&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0application.process.m=
achine_id =3D &quot;0aa7a9566c734f608cbd36f187de8645&quot;<br>
&gt; I: [pulseaudio] sink-input.c:=C2=A0 =C2=A0 =C2=A0<a href=3D"http://mod=
ule-stream-restore.id">module-stream-restore.id</a> =3D &quot;sink-input-by=
-application-name:gst-launc<br>
&gt; h-0.10&quot;<br>
&gt; I: [pulseaudio] protocol-native.c: Requested tlength=3D200.00 ms, minr=
eq=3D10.00 ms<br>
&gt; I: [pulseaudio] protocol-native.c: Final latency 200.00 ms =3D 90.00 m=
s + 2*10.00 ms + 90.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 28.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 38.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 48.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 58.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 68.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 78.38 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 80.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 1.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 2.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 4.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 8.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 16.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 26.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 36.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 46.00 ms<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: ALSA woke us up to write new=
 data to the device, but there w<br>
&gt; as actually nothing to write!<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Most likely this is a bug in=
 the ALSA driver &#39;(null)&#39;. Pleas<br>
&gt; e report this issue to the ALSA developers.<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: We were woken up with POLLOU=
T set -- however a subsequent sn<br>
&gt; d_pcm_avail() returned 0 or another value &lt; min_avail.<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 56.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 66.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 76.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 86.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 96.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 86.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 106.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 96.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 116.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 106.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 126.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 116.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 136.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 126.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 146.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 136.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Underrun!<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 156.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 146.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 166.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing wakeup watermark =
to 156.00 ms<br>
&gt; I: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Increasing minimal latency t=
o 176.00 ms<br>
&gt; I: [pulseaudio] sink-input.c: Freeing input 1 &quot;Playback Stream&qu=
ot;<br>
&gt; I: [pulseaudio] client.c: Freed 4 &quot;gst-launch-0.10&quot;<br>
&gt; I: [pulseaudio] protocol-native.c: Connection died.<br>
&gt;<br>
&gt; from the log it seems like, when system timer based scheduling is used=
, then pulseaudio will try to keep minimum watermark/latency, only when Und=
errun occurs, it will increase watermark/latency.<br>
&gt;<br>
&gt; Is this the expected behaviour of pulseaudio &#39;glict free&#39; feat=
ure?</p>
<p>&gt; And from the log there is some error message complain about ALSA dr=
iver<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: ALSA woke us up to write new=
 data to the device, but there w<br>
&gt; as actually nothing to write!<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: Most likely this is a bug in=
 the ALSA driver &#39;(null)&#39;. Pleas<br>
&gt; e report this issue to the ALSA developers.<br>
&gt; E: [alsa-sink-HiFi wm8962-0] alsa-sink.c: We were woken up with POLLOU=
T set -- however a subsequent sn<br>
&gt; d_pcm_avail() returned 0 or another value &lt; min_avail.<br>
&gt;<br>
&gt; does this mean, there is some bug in ALSA driver, or it just indicates=
 the ALSA driver doesn&#39;t support glitch free feature very well<br><br><=
/p>
<p>The timer base scheduling require sound card driver provide accurate=C2=
=A0 hw_ptr position at any time.</p>
<p>So far only two sound card drivers snd-hda-intel and snd-oxygen can prov=
ide accurate hw_ptr position from hardware register</p>
<p>static snd_pcm_uframes_t dmaengine_pcm_pointer(<br>
	struct snd_pcm_substream *substream)<br>
{<br>
	struct snd_soc_pcm_runtime *rtd =3D substream-&gt;private_data;<br>
	struct dmaengine_pcm *pcm =3D soc_platform_to_pcm(rtd-&gt;platform);</p>
<p>	if (pcm-&gt;flags &amp; SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)<br>
		return snd_dmaengine_pcm_pointer_no_residue(substream);<br>
	else<br>
		return snd_dmaengine_pcm_pointer(substream);<br>
}</p>
<p><a href=3D"http://lxr.free-electrons.com/ident?i=3Ddmaengine_tx_status">=
http://lxr.free-electrons.com/ident?i=3Ddmaengine_tx_status</a></p>
<p>Seem none of soc sound drivers can report position accurate than period =
size </p>
<p>Is there any reason to enable timer based scheduling by default ?<br></p=
>
<p><a href=3D"http://mailman.alsa-project.org/pipermail/alsa-devel/2014-Sep=
tember/081501.html">http://mailman.alsa-project.org/pipermail/alsa-devel/20=
14-September/081501.html</a></p>
<p>You can try alexandra &#39;s program to find out how accuate hw_ptr can =
your sound card driver can report ?</p>

--001a11c2f102248704051e71afcf--

--===============1802371185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1802371185==--
