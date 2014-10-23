From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with timing and USB scanning...
Date: Thu, 23 Oct 2014 13:13:19 +0800
Message-ID: <CAN8ccibDFnqzYjh64zgF-9SiBn0m-MvQ+Jhg9q=3NGJ=YO4ZMg@mail.gmail.com>
References: <5078808.P2JmJn6G2E@hosanna>
 <CAN8ccibJ=HKhXdjTaRbtXjBjJKUXHQ5WpJ_vjW_ZVsKWqV-KUQ@mail.gmail.com>
 <6193432.QnYu1kqnSE@hosanna>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410716787=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <6193432.QnYu1kqnSE@hosanna>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: "Joshua J. Kugler" <joshua@azariah.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============1410716787==
Content-Type: multipart/alternative; boundary=089e015369246064c00506101f75

--089e015369246064c00506101f75
Content-Type: text/plain; charset=UTF-8

> > > Howdy! I have a situation where PulseAudio is "grabbing" a usb headset
> >
> > before
> >
> > > fully initialized, thus not all features are being recognized.
> >
> > > More details here:
> >
https://askubuntu.com/questions/537166/usb%2daudio%2ddevice%2dnot%2dfully%2d
> > working%2dafter%2dhotplug
> >
> > You have to post output of alsa-info.sh and pactl list before and after
the
> > hot plug
>
> This does not have my web cam attached.
>
> Files attached. I also did a pulse restart, and captured the pactl list
output
> after that too.
>
> > This look like priority issue if you have usb web cam mic and hotplug
usb
> > headset
> >
> >
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9fcd0ab130579d9742538340edda3225f2b49a3e
>
> This happens even without the USB web cam plugged in.
>
> > Another issue is some usb devices only obtained dB scale at a later time
> > after the control is created
> >
> > This may need some delay for pulseaudio to get dB scale
> >
> > You can add printk statement to find out how much time you need
>
> I've done zero kernel hacking, so can't really help there, sorry!
>

Unfotunately, you need to fix many things in kernel

Is this a notebook with internal 5.1 speakers with three jacks at rear
panel (headphone , mic and line in) ?

1) large volume range of mic capture
Volume and speaker playback volume

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9b4ef97757953c6071563b7cbfc689e3dd771603

2) your 5.1 internal speaker have same priority

--089e015369246064c00506101f75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p></p>
<p>&gt; &gt; &gt; Howdy! I have a situation where PulseAudio is &quot;grabb=
ing&quot; a usb headset<br>
&gt; &gt;<br>
&gt; &gt; before<br>
&gt; &gt;<br>
&gt; &gt; &gt; fully initialized, thus not all features are being recognize=
d.<br>
&gt; &gt;<br>
&gt; &gt; &gt; More details here:<br>
&gt; &gt;<a href=3D"https://askubuntu.com/questions/537166/usb%2daudio%2dde=
vice%2dnot%2dfully%2d">https://askubuntu.com/questions/537166/usb%2daudio%2=
ddevice%2dnot%2dfully%2d</a><br>
&gt; &gt; working%2dafter%2dhotplug<br>
&gt; &gt;<br>
&gt; &gt; You have to post output of alsa-info.sh and pactl list before and=
 after the<br>
&gt; &gt; hot plug<br>
&gt;<br>
&gt; This does not have my web cam attached.<br>
&gt;<br>
&gt; Files attached. I also did a pulse restart, and captured the pactl lis=
t output<br>
&gt; after that too.<br>
&gt;<br>
&gt; &gt; This look like priority issue if you have usb web cam mic and hot=
plug usb<br>
&gt; &gt; headset<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git=
/commit/sound/usb/mixer.c?id=3D9fcd0ab130579d9742538340edda3225f2b49a3e">ht=
tps://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb=
/mixer.c?id=3D9fcd0ab130579d9742538340edda3225f2b49a3e</a><br>
&gt;<br>
&gt; This happens even without the USB web cam plugged in.<br>
&gt;<br>
&gt; &gt; Another issue is some usb devices only obtained dB scale at a lat=
er time<br>
&gt; &gt; after the control is created<br>
&gt; &gt;<br>
&gt; &gt; This may need some delay for pulseaudio to get dB scale<br>
&gt; &gt;<br>
&gt; &gt; You can add printk statement to find out how much time you need<b=
r>
&gt;<br>
&gt; I&#39;ve done zero kernel hacking, so can&#39;t really help there, sor=
ry!<br>
&gt;</p>
<p>Unfotunately, you need to fix many things in kernel</p>
<p>Is this a notebook with internal 5.1 speakers with three jacks at rear p=
anel (headphone , mic and line in) ?</p>
<p>1) large volume range of mic capture<br>
Volume and speaker playback volume</p>
<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
commit/sound/usb/mixer.c?id=3D9b4ef97757953c6071563b7cbfc689e3dd771603">htt=
ps://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/=
mixer.c?id=3D9b4ef97757953c6071563b7cbfc689e3dd771603</a></p>
<p>2) your 5.1 internal speaker have same priority <br>
</p>

--089e015369246064c00506101f75--

--===============1410716787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1410716787==--
