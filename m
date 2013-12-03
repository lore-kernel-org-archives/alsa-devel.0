From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa: Disable timer-scheduling for
 PCMs with the BATCH flag
Date: Tue, 3 Dec 2013 08:47:07 +0800
Message-ID: <CAN8ccib1Z-uA3vH0EDf_gtVm8kKaCkjhnZq1Kr=MitnRYpS1PA@mail.gmail.com>
References: <1385831244-30750-1-git-send-email-lars@metafoo.de>
	<CAN8cciYz=ZFJNW_FNqKTceCV4S=pz3CwkbwKcTeZb4AM=7bWzw@mail.gmail.com>
	<529C5980.60408@metafoo.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1976855261=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <529C5980.60408@metafoo.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Lars-Peter Clausen <lars@metafoo.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============1976855261==
Content-Type: multipart/alternative; boundary=001a1135f6a8ceed6904ec96a233

--001a1135f6a8ceed6904ec96a233
Content-Type: text/plain; charset=UTF-8

> >
> >     PCM Devices which have the BATCH flag set update the PCM pointer
> only with
> >     period size granularity. Using timer based scheduling does not have
> any
> >     advantage in this mode. For one devices which have that flag set
> usually
> >     update
> >     the position pointer in software after getting the period interrupt.
> So
> >     disabling the period interrupt is not possible for this kind of
> devices.
> >     Furthermore writing to or reading from the buffer slice for the
> current
> >     period
> >     is not possible since the position inside the buffer is not known. On
> >     the other
> >     hand the tsched algorithm seems to get easily confused for this kind
> of
> >     hardware, which results in garbled audio output. This typically means
> >     that timer
> >     based scheduling needs to be manually disabled on systems with such
> devices.
> >     Auto disabling tsched in this case allows these systems to run with
> the
> >     default
> >     configuration.
> >
> >
> > If the playback position is reported in steps instead of monotonic
> increasing ?
> >
> > does this mean that you also need to increase rewind_safeguard to one
> period
> > or modifiy snd_pcm_rewindable ?
>
>
> Yes that makes sense. The safeguard should probably be 1.5 periods or 1
> period + fixed value, since it will always take some time from when the
> hardware reaches the next period to when userspace is notified about this.
>
> I'm unfortunately not that familiar with pulseaudio. Maybe there is a
> better
> way to fix this problem then to disable tsched. If anybody wants to
> recreate
> the issue it can easily be emulated by applying the following patch to your
> kernel:
>
>
does all alsa drivers with SNDRV_PCM_INFO_PATCH update the playback/capture
position in period interrupt ?

usb-audio seem update when each URB send/receive (in 1ms intervals)

ymfpci driver also update hwptr in 5ms interval but no SNDRV_PCM_INFO_PATCH
and no constraint in period time must be interval of 5 ms

the rewind_safeguard is affected by the size of FIFO buffer as you cannot
rewind any data in FIFO buffer of DSP/ sound controller

--001a1135f6a8ceed6904ec96a233
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br><div><div cla=
ss=3D"h5">&gt;<br>
&gt; =C2=A0 =C2=A0 PCM Devices which have the BATCH flag set update the PCM=
 pointer only with<br>
&gt; =C2=A0 =C2=A0 period size granularity. Using timer based scheduling do=
es not have any<br>
&gt; =C2=A0 =C2=A0 advantage in this mode. For one devices which have that =
flag set usually<br>
&gt; =C2=A0 =C2=A0 update<br>
&gt; =C2=A0 =C2=A0 the position pointer in software after getting the perio=
d interrupt. So<br>
&gt; =C2=A0 =C2=A0 disabling the period interrupt is not possible for this =
kind of devices.<br>
&gt; =C2=A0 =C2=A0 Furthermore writing to or reading from the buffer slice =
for the current<br>
&gt; =C2=A0 =C2=A0 period<br>
&gt; =C2=A0 =C2=A0 is not possible since the position inside the buffer is =
not known. On<br>
&gt; =C2=A0 =C2=A0 the other<br>
&gt; =C2=A0 =C2=A0 hand the tsched algorithm seems to get easily confused f=
or this kind of<br>
&gt; =C2=A0 =C2=A0 hardware, which results in garbled audio output. This ty=
pically means<br>
&gt; =C2=A0 =C2=A0 that timer<br>
&gt; =C2=A0 =C2=A0 based scheduling needs to be manually disabled on system=
s with such devices.<br>
&gt; =C2=A0 =C2=A0 Auto disabling tsched in this case allows these systems =
to run with the<br>
&gt; =C2=A0 =C2=A0 default<br>
&gt; =C2=A0 =C2=A0 configuration.<br>
&gt;<br>
&gt;<br>
&gt; If the playback position is reported in steps instead of monotonic inc=
reasing ?<br>
&gt;<br>
&gt; does this mean that you also need to increase rewind_safeguard to one =
period<br>
&gt; or modifiy snd_pcm_rewindable ?<br>
<br>
<br>
</div></div>Yes that makes sense. The safeguard should probably be 1.5 peri=
ods or 1<br>
period + fixed value, since it will always take some time from when the<br>
hardware reaches the next period to when userspace is notified about this.<=
br>
<br>
I&#39;m unfortunately not that familiar with pulseaudio. Maybe there is a b=
etter<br>
way to fix this problem then to disable tsched. If anybody wants to recreat=
e<br>
the issue it can easily be emulated by applying the following patch to your=
<br>
kernel:<br>
<br></blockquote><br></div>does all alsa drivers with SNDRV_PCM_INFO_PATCH =
update the playback/capture position in period interrupt ? <br><br></div><d=
iv class=3D"gmail_extra">usb-audio seem update when each URB send/receive (=
in 1ms intervals)<br>
<br></div><div class=3D"gmail_extra">ymfpci driver also update hwptr in 5ms=
 interval but no SNDRV_PCM_INFO_PATCH and no constraint in period time must=
 be interval of 5 ms <br><br></div><div class=3D"gmail_extra">the rewind_sa=
feguard is affected by the size of FIFO buffer as you cannot rewind any dat=
a in FIFO buffer of DSP/ sound controller<br>
</div><div class=3D"gmail_extra"><br></div></div>

--001a1135f6a8ceed6904ec96a233--

--===============1976855261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1976855261==--
