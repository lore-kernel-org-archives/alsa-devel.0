From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] ALSA: hda - display audio
	call ncts callback
Date: Fri, 7 Aug 2015 11:04:10 +0800
Message-ID: <CAN8ccib3VP+-OKz0PgWye04JF+jtcd9dq2AEZLyo2nQBLiMVPA@mail.gmail.com>
References: <1438843977-4269-1-git-send-email-libin.yang@intel.com>
 <1438843977-4269-3-git-send-email-libin.yang@intel.com>
 <s5hmvy4loou.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D196CFB33@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0799949295=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <96A12704CE18D347B625EE2D4A099D196CFB33@SHSMSX103.ccr.corp.intel.com>
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

--===============0799949295==
Content-Type: multipart/alternative; boundary=089e015374f8d0163b051cafe347

--089e015374f8d0163b051cafe347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Thursday, August 06, 2015 6:03 PM
> > To: Yang, Libin
> > Cc: alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org; Lin,
> > Mengdong
> > Subject: Re: [PATCH 3/4] ALSA: hda - display audio call ncts callback
> >
> > On Thu, 06 Aug 2015 08:52:56 +0200,
> > libin.yang@intel.com wrote:
> > >
> > > From: Libin Yang <libin.yang@intel.com>
> > >
> > > On some Intel platforms, display audio need set N/CTS
> > > manually at some TMDS frequencies.
> > >
> > > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > > ---
> > >  sound/pci/hda/patch_hdmi.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/sound/pci/hda/patch_hdmi.c
> > b/sound/pci/hda/patch_hdmi.c
> > > index a97db5f..4bd11ff 100644
> > > --- a/sound/pci/hda/patch_hdmi.c
> > > +++ b/sound/pci/hda/patch_hdmi.c
> > > @@ -1786,6 +1786,8 @@ static int
> > generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> > >     int pin_idx =3D hinfo_to_pin_index(codec, hinfo);
> > >     struct hdmi_spec_per_pin *per_pin =3D get_pin(spec, pin_idx);
> > >     hda_nid_t pin_nid =3D per_pin->pin_nid;
> > > +   struct snd_pcm_runtime *runtime =3D substream->runtime;
> > > +   struct i915_audio_component *acomp =3D codec->bus-
> > >core.audio_component;
> > >     bool non_pcm;
> > >     int pinctl;
> > >
> > > @@ -1802,6 +1804,11 @@ static int
> > generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> > >             intel_not_share_assigned_cvt(codec, pin_nid, per_pin-
> > >mux_idx);
> > >     }
> > >
> > > +   if (is_haswell_plus(codec)) {
> > > +           if (acomp && acomp->ops && acomp->ops->set_ncts)
> > > +                   acomp->ops->set_ncts(acomp->dev, per_pin-
> > >pin_nid - 4,
> >
> > Please describe more how "pin_nid - 4" is supposed to work.  Also...
>
> OK, I see.
>
> >
> > > +                           0, runtime->rate);
> >
> > ... this implies that no MST support included?
>
> We will support MST later. Currently I just add the
> interface to support MST, but not implementing it.

Refer to DCN HDA040-A

Multi-stream over Single Display Port

Can the driver use subdevices for those display port support multi
streaming ?

The specification allow up to 64 device entries

This mean the number of subdevices is equal to the device list length

More than one audio output /converters can be connected to the multi stream
displayport pin widget but different device entry while only one audio
output can be dynamically allocated  to other HDMI pin widget

7.3.3.42 Device Select

For Digital Display Pin Widget that is multi stream capable, the Device
Select control determines which Device Entry is currently selected and
accessible by the Pin Widget verbs which are controlling the sink device
operations.  This control verb is only required if it is a Digital Display
Pin Widget and multi stream capable.

The index is in relation to the Device List associated with the widget.
The index is a zero-based offset into the Device List.  Once the Device
Entry is selected by the Set index, all subsequent Pin Widget verbs
controlling the sink device operations will be directed to the selected
Device Entry, until the Device Select verb get updated with a new value.

Device Entry: Indicate the index of Device Entry (0 63) which the UR bit of
is generated for a multi stream capable Digital Display Pin Widget.  Not
valid for non Digital Display Pin Widget or Digital Display Pin Widget that
is not multi stream capable

Device List Length is a 0 based integer value indicating the number of sink
device that a multi stream capable Digital Display Pin Widget can support.
If Device List Length is value is 0, there is only one sink device
connection possible indicating the Pin Widget is not multi stream capable,
and there is no Device Select control (see Section 7.3.3.42).  If the
Device List Length value is 1 =E2=80=93 63, it indicates the Pin Widget is =
multi
stream capable, and 2 =E2=80=93 64 Device Entries are supported in the Pin =
Widget.
>

--089e015374f8d0163b051cafe347
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Takashi Iwai [mailto:<a href=3D"mailto:tiwai@suse.de">tiwai=
@suse.de</a>]<br>
&gt; &gt; Sent: Thursday, August 06, 2015 6:03 PM<br>
&gt; &gt; To: Yang, Libin<br>
&gt; &gt; Cc: <a href=3D"mailto:alsa-devel@alsa-project.org">alsa-devel@als=
a-project.org</a>; <a href=3D"mailto:intel-gfx@lists.freedesktop.org">intel=
-gfx@lists.freedesktop.org</a>; Lin,<br>
&gt; &gt; Mengdong<br>
&gt; &gt; Subject: Re: [PATCH 3/4] ALSA: hda - display audio call ncts call=
back<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 06 Aug 2015 08:52:56 +0200,<br>
&gt; &gt; <a href=3D"mailto:libin.yang@intel.com">libin.yang@intel.com</a> =
wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Libin Yang &lt;<a href=3D"mailto:libin.yang@intel.com"=
>libin.yang@intel.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On some Intel platforms, display audio need set N/CTS<br>
&gt; &gt; &gt; manually at some TMDS frequencies.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Libin Yang &lt;<a href=3D"mailto:libin.yang@i=
ntel.com">libin.yang@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 sound/pci/hda/patch_hdmi.c | 7 +++++++<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/sound/pci/hda/patch_hdmi.c<br>
&gt; &gt; b/sound/pci/hda/patch_hdmi.c<br>
&gt; &gt; &gt; index a97db5f..4bd11ff 100644<br>
&gt; &gt; &gt; --- a/sound/pci/hda/patch_hdmi.c<br>
&gt; &gt; &gt; +++ b/sound/pci/hda/patch_hdmi.c<br>
&gt; &gt; &gt; @@ -1786,6 +1786,8 @@ static int<br>
&gt; &gt; generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0int pin_idx =3D hinfo_to_pin_index(codec,=
 hinfo);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0struct hdmi_spec_per_pin *per_pin =3D get=
_pin(spec, pin_idx);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0hda_nid_t pin_nid =3D per_pin-&gt;pin_nid=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0struct snd_pcm_runtime *runtime =3D substream-=
&gt;runtime;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0struct i915_audio_component *acomp =3D codec-&=
gt;bus-<br>
&gt; &gt; &gt;core.audio_component;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0bool non_pcm;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0int pinctl;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1802,6 +1804,11 @@ static int<br>
&gt; &gt; generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intel_not_sha=
re_assigned_cvt(codec, pin_nid, per_pin-<br>
&gt; &gt; &gt;mux_idx);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0if (is_haswell_plus(codec)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acomp &amp;&am=
p; acomp-&gt;ops &amp;&amp; acomp-&gt;ops-&gt;set_ncts)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0acomp-&gt;ops-&gt;set_ncts(acomp-&gt;dev, per_pin-<br>
&gt; &gt; &gt;pin_nid - 4,<br>
&gt; &gt;<br>
&gt; &gt; Please describe more how &quot;pin_nid - 4&quot; is supposed to w=
ork.=C2=A0 Also...<br>
&gt;<br>
&gt; OK, I see.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, runtime-&gt;rate);<br>
&gt; &gt;<br>
&gt; &gt; ... this implies that no MST support included?<br>
&gt;<br>
&gt; We will support MST later. Currently I just add the<br>
&gt; interface to support MST, but not implementing it.<br></p>
<p>Refer to DCN HDA040-A</p>
<p>Multi-stream over Single Display Port</p>
<p>Can the driver use subdevices for those display port support multi strea=
ming ?</p>
<p>The specification allow up to 64 device entries</p>
<p>This mean the number of subdevices is equal to the device list length</p=
>
<p>More than one audio output /converters can be connected to the multi str=
eam displayport pin widget but different device entry while only one audio =
output can be dynamically allocated=C2=A0 to other HDMI pin widget</p>
<p>7.3.3.42 Device Select</p>
<p>For Digital Display Pin Widget that is multi stream capable, the Device =
Select control determines which Device Entry is currently selected and acce=
ssible by the Pin Widget verbs which are controlling the sink device operat=
ions.=C2=A0 This control verb is only required if it is a Digital Display P=
in Widget and multi stream capable.</p>
<p>The index is in relation to the Device List associated with the widget.=
=C2=A0 The index is a zero-based offset into the Device List.=C2=A0 Once th=
e Device Entry is selected by the Set index, all subsequent Pin Widget verb=
s controlling the sink device operations will be directed to the selected D=
evice Entry, until the Device Select verb get updated with a new value.=C2=
=A0 </p>
<p>Device Entry: Indicate the index of Device Entry (0 63) which the UR bit=
 of is generated for a multi stream capable Digital Display Pin Widget.=C2=
=A0 Not valid for non Digital Display Pin Widget or Digital Display Pin Wid=
get that is not multi stream capable</p>
<p>Device List Length is a 0 based integer value indicating the number of s=
ink device that a multi stream capable Digital Display Pin Widget can suppo=
rt.=C2=A0 If Device List Length is value is 0, there is only one sink devic=
e connection possible indicating the Pin Widget is not multi stream capable=
, and there is no Device Select control (see Section 7.3.3.42).=C2=A0 If th=
e Device List Length value is 1 =E2=80=93 63, it indicates the Pin Widget i=
s multi stream capable, and 2 =E2=80=93 64 Device Entries are supported in =
the Pin Widget.=C2=A0<br>
&gt;<br>
</p>

--089e015374f8d0163b051cafe347--

--===============0799949295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============0799949295==--
