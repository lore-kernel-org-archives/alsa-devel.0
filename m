From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with timing and USB scanning...
Date: Wed, 22 Oct 2014 12:10:46 +0800
Message-ID: <CAN8ccibJ=HKhXdjTaRbtXjBjJKUXHQ5WpJ_vjW_ZVsKWqV-KUQ@mail.gmail.com>
References: <5078808.P2JmJn6G2E@hosanna>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1385061886=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <5078808.P2JmJn6G2E@hosanna>
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

--===============1385061886==
Content-Type: multipart/alternative; boundary=001a1135234ed7e7a10505fb216a

--001a1135234ed7e7a10505fb216a
Content-Type: text/plain; charset=UTF-8

>
> Howdy! I have a situation where PulseAudio is "grabbing" a usb headset
before
> fully initialized, thus not all features are being recognized.
>
> More details here:
>
>
https://askubuntu.com/questions/537166/usb%2daudio%2ddevice%2dnot%2dfully%2dworking%2dafter%2dhotplug

You have to post output of alsa-info.sh and pactl list before and after the
hot plug

This look like priority issue if you have usb web cam mic and hotplug usb
headset

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9fcd0ab130579d9742538340edda3225f2b49a3e

Another issue is some usb devices only obtained dB scale at a later time
after the control is created

This may need some delay for pulseaudio to get dB scale

You can add printk statement to find out how much time you need

>
> and a related, I think, bug here:
>
> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/841433
>
> Anyone have a pointer to a udev rule I could create (or a PulseAudio
config I
> could  tweak) that would case a delay before the device is scanned by
> PulseAudio?
>
> I'm pretty sure it's a timing issue, because:
>
> Works OK:
> Cold boot (or reboot)
> Resume from hibernate
> Resume (or hotplug) -> killall/restart pulseaudio
>
> Fails to work:
> Hotplug
> Resume from sleep
>
> Any tips?
>

--001a1135234ed7e7a10505fb216a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; Howdy! I have a situation where PulseAudio is &quot;grabbing&quot; a u=
sb headset before<br>
&gt; fully initialized, thus not all features are being recognized.<br>
&gt;<br>
&gt; More details here:<br>
&gt;<br>
&gt; <a href=3D"https://askubuntu.com/questions/537166/usb%2daudio%2ddevice=
%2dnot%2dfully%2dworking%2dafter%2dhotplug">https://askubuntu.com/questions=
/537166/usb%2daudio%2ddevice%2dnot%2dfully%2dworking%2dafter%2dhotplug</a><=
/p>
<p>You have to post output of alsa-info.sh and pactl list before and after =
the hot plug</p>
<p>This look like priority issue if you have usb web cam mic and hotplug us=
b headset<br></p>
<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
commit/sound/usb/mixer.c?id=3D9fcd0ab130579d9742538340edda3225f2b49a3e">htt=
ps://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/=
mixer.c?id=3D9fcd0ab130579d9742538340edda3225f2b49a3e</a></p>
<p>Another issue is some usb devices only obtained dB scale at a later time=
 after the control is created</p>
<p>This may need some delay for pulseaudio to get dB scale</p>
<p>You can add printk statement to find out how much time you need </p>
<p>&gt;<br>
&gt; and a related, I think, bug here:<br>
&gt;<br>
&gt; <a href=3D"https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/8=
41433">https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/841433</a>=
<br>
&gt;<br>
&gt; Anyone have a pointer to a udev rule I could create (or a PulseAudio c=
onfig I<br>
&gt; could=C2=A0 tweak) that would case a delay before the device is scanne=
d by<br>
&gt; PulseAudio?<br>
&gt;<br>
&gt; I&#39;m pretty sure it&#39;s a timing issue, because:<br>
&gt;<br>
&gt; Works OK:<br>
&gt; Cold boot (or reboot)<br>
&gt; Resume from hibernate<br>
&gt; Resume (or hotplug) -&gt; killall/restart pulseaudio<br>
&gt;<br>
&gt; Fails to work:<br>
&gt; Hotplug<br>
&gt; Resume from sleep<br>
&gt;<br>
&gt; Any tips?<br>
&gt;<br>
</p>

--001a1135234ed7e7a10505fb216a--

--===============1385061886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1385061886==--
