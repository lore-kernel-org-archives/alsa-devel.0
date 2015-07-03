From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Fri, 3 Jul 2015 11:45:10 +0800
Message-ID: <CAN8ccian-kupvzhRPPin6t2oPtOESoZEE1=i6CN4r_zc3Zhjew@mail.gmail.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de>
 <CAN8cciZiAyseCC5_t0pXZX-t57eukNT5+K8iTZGhG7=MiEztWw@mail.gmail.com>
 <87egkvyme8.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2030107167=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <87egkvyme8.fsf@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============2030107167==
Content-Type: multipart/alternative; boundary=001a113cd5220219e10519f06279

--001a113cd5220219e10519f06279
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015-6-29 =E4=B8=8B=E5=8D=883:58=E6=96=BC "Jani Nikula" <jani.nikula@linux.=
intel.com>=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, 27 Jun 2015, Raymond Yau <superquad.vortex2@gmail.com> wrote:
> >> > >
> >> > > Shall we move or cc this discussion on audio driver side to ALSA
ML?
> >> >
> >> > Oops I thought I had cc'ed these patches to alsa-devel as well when =
I
> > sent them.
> >> >
> >> > > I think we also need to decide how to manage PCM devices for DP
MST.
> >> > > Now the HD-A driver create a PCM device for each pin, and the
> > substream
> >> > > number is 1 for each PCM. Now with DP MST enabled, each pin can
> > support
> >> > > multiple streams (e.g. 3 on Intel HSW/BDW/SKL).
> >> > >
> >> > > There may be 2 options:
> >> > > -#1: Let an HDMI codec specify number of substreams, same as the
> > number
> >> > > of device entries on a pin. We can specify 3 for HSW/BDW/SKL. Othe=
r
> >> > > vendors can also specify a value according to actual HW
capabilities.
> >> > >
> >> > > So for HSW, we have 3x3 subtreams totally. But we only have 3
> > convertors
> >> > > (for 3 display pipelines), so we can open up to 3 substreams at th=
e
> > same
> >> > > time. When the audio driver finds all 3 convertors are used when
> > opening
> >> > > a new substream, it will fail.
> >> >
> >> > One thing I noticed is the number of devices on a PIN is only update=
d
> > when
> >> > the MST device is plugged in so normally pins 5,6,7 have 0 devices,
and
> > when
> >> > I plug in MST device, I get the 3 devices on port 6. So it seems
dynamic
> >> > enough at this point, though I guess it'll always be 0 or 3.
> >> > >
> >> > > - #2: Create PCM device dynamically. Only create a PCM devices for
a
> > device
> >> > > entry which connects to monitor with audio support. When the
monitor
> >> > > is removed, the PCM device will be disconnected, closed and
removed,
> >> > > similar to the USB case.
> >
> > Do the driver really need dynamic PCM since display ports are dasiy
chained
> > and the locations within the dasiy chain are fixed ?

http://www.intel.com/support/motherboards/desktop/sb/CS-034199.htm

Do the first display always support sound since hdmi can connect to tv
using dvi ?

As Pulseaudio does not support multi streaming ( playing different audio
streams to headphone and rear panel speakers , how can pulseaudion support
displayport MST ?

--001a113cd5220219e10519f06279
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
2015-6-29 =E4=B8=8B=E5=8D=883:58=E6=96=BC &quot;Jani Nikula&quot; &lt;<a hr=
ef=3D"mailto:jani.nikula@linux.intel.com">jani.nikula@linux.intel.com</a>&g=
t;=E5=AF=AB=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt; On Sat, 27 Jun 2015, Raymond Yau &lt;<a href=3D"mailto:superquad.vorte=
x2@gmail.com">superquad.vortex2@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Shall we move or cc this discussion on audio driver=
 side to ALSA ML?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Oops I thought I had cc&#39;ed these patches to alsa-dev=
el as well when I<br>
&gt; &gt; sent them.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; I think we also need to decide how to manage PCM de=
vices for DP MST.<br>
&gt; &gt;&gt; &gt; &gt; Now the HD-A driver create a PCM device for each pi=
n, and the<br>
&gt; &gt; substream<br>
&gt; &gt;&gt; &gt; &gt; number is 1 for each PCM. Now with DP MST enabled, =
each pin can<br>
&gt; &gt; support<br>
&gt; &gt;&gt; &gt; &gt; multiple streams (e.g. 3 on Intel HSW/BDW/SKL).<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; There may be 2 options:<br>
&gt; &gt;&gt; &gt; &gt; -#1: Let an HDMI codec specify number of substreams=
, same as the<br>
&gt; &gt; number<br>
&gt; &gt;&gt; &gt; &gt; of device entries on a pin. We can specify 3 for HS=
W/BDW/SKL. Other<br>
&gt; &gt;&gt; &gt; &gt; vendors can also specify a value according to actua=
l HW capabilities.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; So for HSW, we have 3x3 subtreams totally. But we o=
nly have 3<br>
&gt; &gt; convertors<br>
&gt; &gt;&gt; &gt; &gt; (for 3 display pipelines), so we can open up to 3 s=
ubstreams at the<br>
&gt; &gt; same<br>
&gt; &gt;&gt; &gt; &gt; time. When the audio driver finds all 3 convertors =
are used when<br>
&gt; &gt; opening<br>
&gt; &gt;&gt; &gt; &gt; a new substream, it will fail.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; One thing I noticed is the number of devices on a PIN is=
 only updated<br>
&gt; &gt; when<br>
&gt; &gt;&gt; &gt; the MST device is plugged in so normally pins 5,6,7 have=
 0 devices, and<br>
&gt; &gt; when<br>
&gt; &gt;&gt; &gt; I plug in MST device, I get the 3 devices on port 6. So =
it seems dynamic<br>
&gt; &gt;&gt; &gt; enough at this point, though I guess it&#39;ll always be=
 0 or 3.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; - #2: Create PCM device dynamically. Only create a =
PCM devices for a<br>
&gt; &gt; device<br>
&gt; &gt;&gt; &gt; &gt; entry which connects to monitor with audio support.=
 When the monitor<br>
&gt; &gt;&gt; &gt; &gt; is removed, the PCM device will be disconnected, cl=
osed and removed,<br>
&gt; &gt;&gt; &gt; &gt; similar to the USB case.<br>
&gt; &gt;<br>
&gt; &gt; Do the driver really need dynamic PCM since display ports are das=
iy chained<br>
&gt; &gt; and the locations within the dasiy chain are fixed ?<br></p>
<p><a href=3D"http://www.intel.com/support/motherboards/desktop/sb/CS-03419=
9.htm">http://www.intel.com/support/motherboards/desktop/sb/CS-034199.htm</=
a></p>
<p>Do the first display always support sound since hdmi can connect to tv u=
sing dvi ?</p>
<p>As Pulseaudio does not support multi streaming ( playing different audio=
 streams to headphone and rear panel speakers , how can pulseaudion support=
 displayport MST ?<br>
</p>

--001a113cd5220219e10519f06279--

--===============2030107167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============2030107167==--
