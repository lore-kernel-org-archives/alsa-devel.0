From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Sat, 27 Jun 2015 14:09:09 +0800
Message-ID: <CAN8cciZiAyseCC5_t0pXZX-t57eukNT5+K8iTZGhG7=MiEztWw@mail.gmail.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1342189361=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hpp4s9ceq.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============1342189361==
Content-Type: multipart/alternative; boundary=001a113dcd5ee240d5051979b11e

--001a113dcd5ee240d5051979b11e
Content-Type: text/plain; charset=UTF-8

> > >
> > > Shall we move or cc this discussion on audio driver side to ALSA ML?
> >
> > Oops I thought I had cc'ed these patches to alsa-devel as well when I
sent them.
> >
> > > I think we also need to decide how to manage PCM devices for DP MST.
> > > Now the HD-A driver create a PCM device for each pin, and the
substream
> > > number is 1 for each PCM. Now with DP MST enabled, each pin can
support
> > > multiple streams (e.g. 3 on Intel HSW/BDW/SKL).
> > >
> > > There may be 2 options:
> > > -#1: Let an HDMI codec specify number of substreams, same as the
number
> > > of device entries on a pin. We can specify 3 for HSW/BDW/SKL. Other
> > > vendors can also specify a value according to actual HW capabilities.
> > >
> > > So for HSW, we have 3x3 subtreams totally. But we only have 3
convertors
> > > (for 3 display pipelines), so we can open up to 3 substreams at the
same
> > > time. When the audio driver finds all 3 convertors are used when
opening
> > > a new substream, it will fail.
> >
> > One thing I noticed is the number of devices on a PIN is only updated
when
> > the MST device is plugged in so normally pins 5,6,7 have 0 devices, and
when
> > I plug in MST device, I get the 3 devices on port 6. So it seems dynamic
> > enough at this point, though I guess it'll always be 0 or 3.
> > >
> > > - #2: Create PCM device dynamically. Only create a PCM devices for a
device
> > > entry which connects to monitor with audio support. When the monitor
> > > is removed, the PCM device will be disconnected, closed and removed,
> > > similar to the USB case.

Do the driver really need dynamic PCM since display ports are dasiy chained
and the locations within the dasiy chain are fixed ?

--001a113dcd5ee240d5051979b11e
Content-Type: text/html; charset=UTF-8

<p><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Shall we move or cc this discussion on audio driver side to ALSA ML?<br>
&gt; &gt;<br>
&gt; &gt; Oops I thought I had cc&#39;ed these patches to alsa-devel as well when I sent them.<br>
&gt; &gt;<br>
&gt; &gt; &gt; I think we also need to decide how to manage PCM devices for DP MST.<br>
&gt; &gt; &gt; Now the HD-A driver create a PCM device for each pin, and the substream<br>
&gt; &gt; &gt; number is 1 for each PCM. Now with DP MST enabled, each pin can support<br>
&gt; &gt; &gt; multiple streams (e.g. 3 on Intel HSW/BDW/SKL).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There may be 2 options:<br>
&gt; &gt; &gt; -#1: Let an HDMI codec specify number of substreams, same as the number<br>
&gt; &gt; &gt; of device entries on a pin. We can specify 3 for HSW/BDW/SKL. Other<br>
&gt; &gt; &gt; vendors can also specify a value according to actual HW capabilities.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; So for HSW, we have 3x3 subtreams totally. But we only have 3 convertors<br>
&gt; &gt; &gt; (for 3 display pipelines), so we can open up to 3 substreams at the same<br>
&gt; &gt; &gt; time. When the audio driver finds all 3 convertors are used when opening<br>
&gt; &gt; &gt; a new substream, it will fail.<br>
&gt; &gt;<br>
&gt; &gt; One thing I noticed is the number of devices on a PIN is only updated when<br>
&gt; &gt; the MST device is plugged in so normally pins 5,6,7 have 0 devices, and when<br>
&gt; &gt; I plug in MST device, I get the 3 devices on port 6. So it seems dynamic<br>
&gt; &gt; enough at this point, though I guess it&#39;ll always be 0 or 3.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - #2: Create PCM device dynamically. Only create a PCM devices for a device<br>
&gt; &gt; &gt; entry which connects to monitor with audio support. When the monitor<br>
&gt; &gt; &gt; is removed, the PCM device will be disconnected, closed and removed,<br>
&gt; &gt; &gt; similar to the USB case.<br></p>
<p>Do the driver really need dynamic PCM since display ports are dasiy chained and the locations within the dasiy chain are fixed ?<br><br></p>

--001a113dcd5ee240d5051979b11e--

--===============1342189361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============1342189361==--
