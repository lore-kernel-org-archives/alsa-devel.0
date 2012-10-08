From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 22:34:43 +0200
Message-ID: <87zk3wity4.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
 <87ehl86h4l.fsf@dex.adm.naquadah.org> <s5hvcek7oh7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8904878100215757578=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 18ADF265179
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 22:35:34 +0200 (CEST)
In-Reply-To: <s5hvcek7oh7.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
 08 Oct 2012 21:28:20 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8904878100215757578==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> Doesn't the beep work if you load pcspkr module?  It should be there
> independently.

pcspkr is loaded, but no sound from the speakers. And I don't think this
laptop has an old buzzer. ;)

> Hm, then maybe the effect of removing noise appears no matter which
> input of NID 0x0b be unmuted?=20=20

I've retested some, and you're right, it seems some others do make the
noise disappear:

For example, this works too:

@@ -198,7 +198,7 @@
   Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
   Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=2D  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x=
80]
+  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80]
   Connection: 5
      0x18 0x19 0x1a 0x1b 0x1d
 Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In


This one too:
@@ -198,7 +198,7 @@
   Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
   Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=2D  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x=
80]
+  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80]
   Connection: 5
      0x18 0x19 0x1a 0x1b 0x1d
 Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In

Other pairs do not work, but some do change the noise sound.

No pair work when speakers or master is muted; the noise is always
there, no matter which pair I mute/unmute.

> So, obviously muting the amp triggers the noise.
> BTW, does the noise come only from speaker, not from headphone,
> correct?

Yeah correct. Never got any noise in the headphone.
(That's how and why I didn't got insane so far with that noise always
there :)

> Related tests: what happens if you mute both input amps of the node
> 0x0d?  This is a mixer widget between DAC and the speaker pin.
> Does this widget work as a proper mute/unmute point without causing
> noise?

I tried all combinations on 0x0d with master unmuted: there's 2 inputs,
so 4 combinations, and I got=E2=80=A6 4 different noises. Almost funny.
If master is muted, changing any input amps from 0x0d change nothing at
all, noise still there.

>> When doing that, I cannot hear anything, because it seems to disconnect
>> the speakers. My idea would be to set this pin to 0x00 instead of 0x40
>> when "Speakers" are set to mute (I don't know about master though).
>> WDYT?
>
> Possible, but a bit hackish.  Let's see...

Heh, too bad. But you know better than me. :)

=2D-=20
Julien Danjou
// Free Software hacker & freelance
// http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQczjjAAoJEGEbqVCLeKXCEx8P/i5Fr7mO6fNP457CinuXjLF+
KkQqmz8+Tct7RatOtWaUdCC0QQ5EhghyrTRosau07bbGudW6iNb4ULVXs5hw3nSI
JAs3EEv9XSf45OnqAGhWTuTwWKqA6wv5rg17DOvQ/QBOMUc87Z3+pnql8LuH4m5o
Xy1YQE/ydZiE9+po0BGn+fcCsr1rcrmi9YqzTaTQqdD74tGXft5USBKsw6P588zN
1hGC7UbqruvQUD1pjGqRwxd4bo5TvbvHg1+e15GvxX2/rRcKccFMYU0YtNdEPdZh
9mwk4eoCKZa5v3AO9LweUiE856PmqL1JP/87q1W6WR1+0XCNhG5Lh/CGUUpf1rMG
YwYHg3TjpzRHo9y7GdwAU2MfZ8sXGujvLSKITDpOK2sfd9IeVoKw/9A0gxna6hGU
r3YOuY0E0lXXfH/T7exLiL4Nf4/xgtOCDS0UQaM1x4QI6SB6hXLDG8QjO1RwUWVf
mhVzg8rO1gDCfECnf9pwWH1A8npEgZHMJ1Z+IVud2u6p47twvV/SNcxjF5bd4xhR
P/ibMutw9GxZOkwexBJuwX6J4TY4yOAKhGzMKbY18iXuRo6jaAmrHffQ0ADHKLRs
Q4U0YQ6T8f8wkv6kx3SqE0SVG93N+RA+/GfNeRp1NYTgJ2hbAJaZfzFvG/FiTfzN
rYV2MiRTN9SI3xbHk8/l
=cdOM
-----END PGP SIGNATURE-----
--=-=-=--

--===============8904878100215757578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8904878100215757578==--
