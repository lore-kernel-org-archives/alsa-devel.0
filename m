From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Front speakers doesn't work
 in multichannel output, regression in ALC888
Date: Fri, 8 May 2015 14:49:54 +0800
Message-ID: <CAN8cciZ52i7ysjdsuEudOtcVCgcYmLJSBmZmUCdqs6BjtDphww@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <29807127.PULdKhJLmi@luklap.workgroup>
 <CAN8cciYOSYZ-diTWTrtp-q21RqWsMDWPKeAA-WtGjeitG=t7nw@mail.gmail.com>
 <1736431.dmQFUpE69t@luklap.workgroup>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0467933010=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1736431.dmQFUpE69t@luklap.workgroup>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============0467933010==
Content-Type: multipart/alternative; boundary=001a113cdea092059d05158c6ff1

--001a113cdea092059d05158c6ff1
Content-Type: text/plain; charset=UTF-8

> > > My laptop has built-in front left, front right, rear left, rear right
and
> > > subwoofer and something is strange.
> > > When I set channel output to 5.1 or 4.1 and external speakers are
> > > disconnected, then front left and front right work as expected but
> >
> > built-in
> >
> > > subwoofer is heard only if I test rear left channel (wrong channel
> >
> > mapping?)
> >
> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pc
> > i/hda/hda_codec.c?id=cd4035e814b04c009ece9939396d06370c53ed44
> >
> > Seem only two pairs of stereo speakers and internal subwoofer at left
> > channel before this patch
> >
> > ALSA: hda - Enable surround speakers (when line out is also present)
>
> On my laptop case "Virtual SurroundSound" is written . When I test front
left
> and rear left, I hear distinct sound, so it would mean it's from two
different
> sources of sound.

The driver use more than two channels only after David 's patch

But all internal speakers of the notebook are at front of  the user, The 3D
sound effect is quite different from your external 5.1 speakers

Do you mean your 5930g need champ {FL FR RL RR LFE }?

This can be easily implemented by using "swap center/lfe" switch for those
codec support R/L swap

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=test/chmap.c;hb=HEAD

http://git.alsa-project.org/?p=alsa-lib.git;a=tree;f=src/conf/pcm;hb=HEAD

If codec does not support R/L swap, your 4.1 swap chmap need 5.0 routing

Do you expect pulseaudio show 4.1 swap(5.0) profile for internal speakers
and 4.1 and 5.1 profiles for external speakers ?

--001a113cdea092059d05158c6ff1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>&gt; &gt; &gt; My laptop has built-in front left, front right, rear left=
, rear right and<br>
&gt; &gt; &gt; subwoofer and something is strange.<br>
&gt; &gt; &gt; When I set channel output to 5.1 or 4.1 and external speaker=
s are<br>
&gt; &gt; &gt; disconnected, then front left and front right work as expect=
ed but<br>
&gt; &gt;<br>
&gt; &gt; built-in<br>
&gt; &gt;<br>
&gt; &gt; &gt; subwoofer is heard only if I test rear left channel (wrong c=
hannel<br>
&gt; &gt;<br>
&gt; &gt; mapping?)<br>
&gt; &gt;<br>
&gt; &gt;<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/soun=
d.git/commit/sound/pc"> https://git.kernel.org/cgit/linux/kernel/git/tiwai/=
sound.git/commit/sound/pc</a><br>
&gt; &gt; i/hda/hda_codec.c?id=3Dcd4035e814b04c009ece9939396d06370c53ed44<b=
r>
&gt; &gt;<br>
&gt; &gt; Seem only two pairs of stereo speakers and internal subwoofer at =
left<br>
&gt; &gt; channel before this patch<br>
&gt; &gt;<br>
&gt; &gt; ALSA: hda - Enable surround speakers (when line out is also prese=
nt)<br>
&gt;<br>
&gt; On my laptop case &quot;Virtual SurroundSound&quot; is written . When =
I test front left<br>
&gt; and rear left, I hear distinct sound, so it would mean it&#39;s from t=
wo different<br>
&gt; sources of sound.</p>
<p>The driver use more than two channels only after David &#39;s patch</p>
<p>But all internal speakers of the notebook are at front of=C2=A0 the user=
, The 3D sound effect is quite different from your external 5.1 speakers</p=
>
<p>Do you mean your 5930g need champ {FL FR RL RR LFE }?</p>
<p>This can be easily implemented by using &quot;swap center/lfe&quot; swit=
ch for those codec support R/L swap</p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob_plain;=
f=3Dtest/chmap.c;hb=3DHEAD">http://git.alsa-project.org/?p=3Dalsa-lib.git;a=
=3Dblob_plain;f=3Dtest/chmap.c;hb=3DHEAD</a></p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dtree;f=3Dsr=
c/conf/pcm;hb=3DHEAD">http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dtre=
e;f=3Dsrc/conf/pcm;hb=3DHEAD</a></p>
<p>If codec does not support R/L swap, your 4.1 swap chmap need 5.0 routing=
</p>
<p>Do you expect pulseaudio show 4.1 swap(5.0) profile for internal speaker=
s and 4.1 and 5.1 profiles for external speakers ?<br>
</p>

--001a113cdea092059d05158c6ff1--

--===============0467933010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0467933010==--
