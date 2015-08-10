From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] ALSA: hda - display audio
	call ncts callback
Date: Mon, 10 Aug 2015 12:23:19 +0800
Message-ID: <CAN8cciYu+MJvtGGbu9gE1U-vrF-Wi7Bkoa2cU=0BjLQuCwjd=g@mail.gmail.com>
References: <1438843977-4269-1-git-send-email-libin.yang@intel.com>
 <1438843977-4269-3-git-send-email-libin.yang@intel.com>
 <s5hmvy4loou.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D196CFB33@SHSMSX103.ccr.corp.intel.com>
 <CAN8ccib3VP+-OKz0PgWye04JF+jtcd9dq2AEZLyo2nQBLiMVPA@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D196DF764@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0950395131=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <96A12704CE18D347B625EE2D4A099D196DF764@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Yang, Libin" <libin.yang@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============0950395131==
Content-Type: multipart/alternative; boundary=001a113ac8fe6f06c0051ced5845

--001a113ac8fe6f06c0051ced5845
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015-8-10 =E4=B8=8A=E5=8D=8811:15=E6=96=BC "Yang, Libin" <libin.yang@intel.=
com>=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Raymond,
>
> >
> > > >     }
> > > >
> > > > +   if (is_haswell_plus(codec)) {
> > > > +           if (acomp && acomp->ops && acomp->ops->set_ncts)
> > > > +                   acomp->ops->set_ncts(acomp->dev, per_pin-
> > > >pin_nid - 4,
> > >
> > > Please describe more how "pin_nid - 4" is supposed to work.  Also...
> >
> > OK, I see.
> >
> > >
> > > > +                           0, runtime->rate);
> > >
> > > ... this implies that no MST support included?
> >
> > We will support MST later. Currently I just add the
> > interface to support MST, but not implementing it.
> Refer to DCN HDA040-A
> Multi-stream over Single Display Port
> Can the driver use subdevices for those display port support multi
streaming ?
>
> [Libin] What do you mean subdevice here,
> using a struct device to represent a dev_entry or an int type?

http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/s=
tac9227-intel-d946gzis-mobo?id=3DHEAD

When HDA codecs have three Audio Input widgets, the driver create three
subdevices for those desktop which have three or more input sources in the
past

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2

With the auto generic parser , the driver create one subdevice for Analog
two subdevices for Alt Analog

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: STAC92xx Alt Analog [STAC92xx Alt
Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

>
> The specification allow up to 64 device entries
> This mean the number of subdevices is equal to the device list length
> More than one audio output /converters can be connected to the multi
stream displayport pin widget but different device entry while only one
audio output can be dynamically allocated  to other HDMI pin widget
>
> [Libin] Yes, Pin widget can have multiple device entry and connecting
different converters. The audio output will be based on device entry.

--001a113ac8fe6f06c0051ced5845
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
2015-8-10 =E4=B8=8A=E5=8D=8811:15=E6=96=BC &quot;Yang, Libin&quot; &lt;<a h=
ref=3D"mailto:libin.yang@intel.com">libin.yang@intel.com</a>&gt;=E5=AF=AB=
=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt; Hi Raymond,<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0if (is_haswell_plus(codec)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acomp &am=
p;&amp; acomp-&gt;ops &amp;&amp; acomp-&gt;ops-&gt;set_ncts)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0acomp-&gt;ops-&gt;set_ncts(acomp-&gt;dev, per_pin-<br>
&gt; &gt; &gt; &gt;pin_nid - 4,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please describe more how &quot;pin_nid - 4&quot; is supposed=
 to work.=C2=A0 Also...<br>
&gt; &gt;<br>
&gt; &gt; OK, I see.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, runtime-&gt;rate);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ... this implies that no MST support included?<br>
&gt; &gt;<br>
&gt; &gt; We will support MST later. Currently I just add the<br>
&gt; &gt; interface to support MST, but not implementing it.<br>
&gt; Refer to DCN HDA040-A<br>
&gt; Multi-stream over Single Display Port<br>
&gt; Can the driver use subdevices for those display port support multi str=
eaming ?<br>
&gt;<br>
&gt; [Libin] What do you mean subdevice here,<br>
&gt; using a struct device to represent a dev_entry or an int type?<br></p>
<p><a href=3D"http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git=
/tree/codecs/stac9227-intel-d946gzis-mobo?id=3DHEAD">http://git.kernel.org/=
cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/stac9227-intel-d946gzis=
-mobo?id=3DHEAD</a> </p>
<p>When HDA codecs have three Audio Input widgets, the driver create three =
subdevices for those desktop which have three or more input sources in the =
past</p>
<p>ARECORD</p>
<p>**** List of CAPTURE Hardware Devices ****<br>
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]<br>
=C2=A0 Subdevices: 3/3<br>
=C2=A0 Subdevice #0: subdevice #0<br>
=C2=A0 Subdevice #1: subdevice #1<br>
=C2=A0 Subdevice #2: subdevice #2</p>
<p>With the auto generic parser , the driver create one subdevice for Analo=
g=C2=A0 two subdevices for Alt Analog </p>
<p>**** List of CAPTURE Hardware Devices ****<br>
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]<br>
=C2=A0 Subdevices: 1/1<br>
=C2=A0 Subdevice #0: subdevice #0<br>
card 0: Intel [HDA Intel], device 2: STAC92xx Alt Analog [STAC92xx Alt Anal=
og]<br>
=C2=A0 Subdevices: 2/2<br>
=C2=A0 Subdevice #0: subdevice #0<br>
=C2=A0 Subdevice #1: subdevice #1<br></p>
<p>&gt;<br>
&gt; The specification allow up to 64 device entries<br>
&gt; This mean the number of subdevices is equal to the device list length<=
br>
&gt; More than one audio output /converters can be connected to the multi s=
tream displayport pin widget but different device entry while only one audi=
o output can be dynamically allocated=C2=A0 to other HDMI pin widget<br>
&gt;<br>
&gt; [Libin] Yes, Pin widget can have multiple device entry and connecting =
different converters. The audio output will be based on device entry.<br></=
p>

--001a113ac8fe6f06c0051ced5845--

--===============0950395131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============0950395131==--
