From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa-mixer: recognize Dock
	headphone jack
Date: Tue, 2 Sep 2014 12:30:20 +0800
Message-ID: <CAN8cciZ28M=UMzKPF00u48xYEGZRk2p=V3T_TFfHn8F+n5c8yA@mail.gmail.com>
References: <1409508681-24485-1-git-send-email-sjoerd@luon.net>
 <CAN8cciazjC5HQpiDDxxP-wLQUDjLpkjT6tvD8qx4vHvv+LwxAg@mail.gmail.com>
 <1409596680.17490.1.camel@luon.net>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0428834740=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1409596680.17490.1.camel@luon.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0428834740==
Content-Type: multipart/alternative; boundary=001a11c1154acd4f8705020d9366

--001a11c1154acd4f8705020d9366
Content-Type: text/plain; charset=UTF-8

> > >
> > > Recognize the Dock headphone jack in the same way the normal & front
> > > headphone jacks are detected.
> > > ---
> > >  src/modules/alsa/mixer/paths/analog-output-headphones.conf | 8
++++++++
> > >  src/modules/alsa/mixer/paths/analog-output-speaker.conf    | 4 ++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git
a/src/modules/alsa/mixer/paths/analog-output-headphones.conf
> > b/src/modules/alsa/mixer/paths/analog-output-headphones.conf
> > > index 89d794f..199b2c5 100644
> > > --- a/src/modules/alsa/mixer/paths/analog-output-headphones.conf
> > > +++ b/src/modules/alsa/mixer/paths/analog-output-headphones.conf
> > > @@ -25,6 +25,14 @@ description-key = analog-output-headphones
> > >  [Properties]
> > >  device.icon_name = audio-headphones
> > >
> > > +[Jack Dock Headphone]
> > > +required-any = any
> >
> > As you assume dock headphone and headphone share the same headphone
volume
> > control
>
> The do on my machine indeed. For reference i've uploaded my alsa-info
> into:
>http://www.alsa-project.org/db/?f=5a1c208208ff33a2231d2d03d5bea5ec452dc24d
>
> > Do you mean the current alsa driver support surround 40 for notebook
with
> > dock headphone is incorrect ?
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=88d5760649d9024a2a68e649909f522ab42d891c

You will get auto mute lineout+speaker if the pin fixup is dock line out
instead of dock headphone but pulseaudio don't like headphone  and line out
share pcm playback volume control and no headphone playback switch

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=1a1455de10d89b9f2107fe5ad1746e7c18838492

For notebook with dual headphone jacks which support multi channel and
headphone Jack won't mute the other headphone Jack

As you expect headphone can mute   dock headphone and speaker

--001a11c1154acd4f8705020d9366
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Recognize the Dock headphone jack in the same way the normal=
 &amp; front<br>
&gt; &gt; &gt; headphone jacks are detected.<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 src/modules/alsa/mixer/paths/analog-output-headphones.=
conf | 8 ++++++++<br>
&gt; &gt; &gt;=C2=A0 src/modules/alsa/mixer/paths/analog-output-speaker.con=
f=C2=A0 =C2=A0 | 4 ++++<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 12 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/src/modules/alsa/mixer/paths/analog-output-head=
phones.conf<br>
&gt; &gt; b/src/modules/alsa/mixer/paths/analog-output-headphones.conf<br>
&gt; &gt; &gt; index 89d794f..199b2c5 100644<br>
&gt; &gt; &gt; --- a/src/modules/alsa/mixer/paths/analog-output-headphones.=
conf<br>
&gt; &gt; &gt; +++ b/src/modules/alsa/mixer/paths/analog-output-headphones.=
conf<br>
&gt; &gt; &gt; @@ -25,6 +25,14 @@ description-key =3D analog-output-headpho=
nes<br>
&gt; &gt; &gt;=C2=A0 [Properties]<br>
&gt; &gt; &gt;=C2=A0 device.icon_name =3D audio-headphones<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +[Jack Dock Headphone]<br>
&gt; &gt; &gt; +required-any =3D any<br>
&gt; &gt;<br>
&gt; &gt; As you assume dock headphone and headphone share the same headpho=
ne volume<br>
&gt; &gt; control<br>
&gt;<br>
&gt; The do on my machine indeed. For reference i&#39;ve uploaded my alsa-i=
nfo<br>
&gt; into:<br>
&gt;<a href=3D"http://www.alsa-project.org/db/?f=3D5a1c208208ff33a2231d2d03=
d5bea5ec452dc24d">http://www.alsa-project.org/db/?f=3D5a1c208208ff33a2231d2=
d03d5bea5ec452dc24d</a><br>
&gt;<br>
&gt; &gt; Do you mean the current alsa driver support surround 40 for noteb=
ook with<br>
&gt; &gt; dock headphone is incorrect ?<br>
&gt;<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/com=
mit/sound/pci/hda?id=3D88d5760649d9024a2a68e649909f522ab42d891c">https://gi=
t.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=
=3D88d5760649d9024a2a68e649909f522ab42d891c</a><br>
</p>
<p>You will get auto mute lineout+speaker if the pin fixup is dock line out=
 instead of dock headphone but pulseaudio don&#39;t like headphone=C2=A0 an=
d line out share pcm playback volume control and no headphone playback swit=
ch</p>

<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
commit/sound/pci/hda?id=3D1a1455de10d89b9f2107fe5ad1746e7c18838492">https:/=
/git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?=
id=3D1a1455de10d89b9f2107fe5ad1746e7c18838492</a></p>

<p>For notebook with dual headphone jacks which support multi channel and h=
eadphone Jack won&#39;t mute the other headphone Jack </p>
<p>As you expect headphone can mute=C2=A0=C2=A0 dock headphone and speaker<=
/p>

--001a11c1154acd4f8705020d9366--

--===============0428834740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0428834740==--
