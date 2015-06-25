From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Thu, 25 Jun 2015 16:22:38 +0800
Message-ID: <CAN8cciYWwDQaMdWXb-Tw9F728jxwqrQLWiGY2B+LszrDvFrw+Q@mail.gmail.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1653749196=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: alsa-devel@alsa-project.org, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============1653749196==
Content-Type: multipart/alternative; boundary=001a1141bdea99b5d4051953534f

--001a1141bdea99b5d4051953534f
Content-Type: text/plain; charset=UTF-8

> >
> > Shall we move or cc this discussion on audio driver side to ALSA ML?
>
> Oops I thought I had cc'ed these patches to alsa-devel as well when I
sent them.
>
> > I think we also need to decide how to manage PCM devices for DP MST.
> > Now the HD-A driver create a PCM device for each pin, and the substream
> > number is 1 for each PCM. Now with DP MST enabled, each pin can support
> > multiple streams (e.g. 3 on Intel HSW/BDW/SKL).

What hardware feature are available ?

Only three monitors playing different audio streams or

With 1x3 video wall , can the center monitor playback stereo while the left
monitor play left channel and right monitor play right channel ?

--001a1141bdea99b5d4051953534f
Content-Type: text/html; charset=UTF-8

<p><br>
&gt; &gt;<br>
&gt; &gt; Shall we move or cc this discussion on audio driver side to ALSA ML?<br>
&gt;<br>
&gt; Oops I thought I had cc&#39;ed these patches to alsa-devel as well when I sent them.<br>
&gt;<br>
&gt; &gt; I think we also need to decide how to manage PCM devices for DP MST.<br>
&gt; &gt; Now the HD-A driver create a PCM device for each pin, and the substream<br>
&gt; &gt; number is 1 for each PCM. Now with DP MST enabled, each pin can support<br>
&gt; &gt; multiple streams (e.g. 3 on Intel HSW/BDW/SKL).<br></p>
<p>What hardware feature are available ?<br></p>
<p>Only three monitors playing different audio streams or</p>
<p>With 1x3 video wall , can the center monitor playback stereo while the left monitor play left channel and right monitor play right channel ?<br>
</p>

--001a1141bdea99b5d4051953534f--

--===============1653749196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============1653749196==--
