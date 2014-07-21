From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Disable AIF TX/RX before configuring it
Date: Mon, 21 Jul 2014 17:24:48 +0100
Message-ID: <20140721162448.GD17528@sirena.org.uk>
References: <20140716121029.GA22222@opensource.wolfsonmicro.com>
 <20140717194215.GH17528@sirena.org.uk>
 <20140721090104.GA21400@opensource.wolfsonmicro.com>
 <s5hsilvnkuf.wl%tiwai@suse.de>
 <20140721103327.GA29141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5JJEVRmBpje5aLKk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140721103327.GA29141@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5JJEVRmBpje5aLKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2014 at 11:33:27AM +0100, Richard Fitzgerald wrote:
> On Mon, Jul 21, 2014 at 11:04:56AM +0200, Takashi Iwai wrote:
> > Richard Fitzgerald wrote:

> > > The case being fixed is like this:

> > > aplay 48kHz.wav; aplay 96kHz.wav

> > > The second open happens before pmdown_time so the AIF is still enabled.
> > > Writes to the AIF config registers only take effect if the AIF is disabled.
> > > Without this patch, the 96kHz.wav will play at 48kHz

> > If the glitch really matters, the driver can minimize by checking the
> > change of sample rate and doing temporary turn on/off only when
> > required.

> That's a fair point.

The case I was particularly worrying about here was simultaneous
playback and capture - we won't be changing rates here since these
devices currently require symmetry which is enforced via constraints but
we are likely to at least be starting multiple streams close to each
other frequently.

--5JJEVRmBpje5aLKk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzT7MAAoJELSic+t+oim9v/oP/RvaN2sXIp6/pczl+SuIWu4Z
GBqN6tyBw4krZ7Go3CwrdS7e4pp+4KTtb2FVJGZL5r5u24O3zld67wfyYQohbyrb
1xEsRy51FM2wOGHaVC+wqqQrUgpKPRIHvNbhO7TSTDrSWWnFldXRzJdIttFUKY2h
KDyDD4f6+gOC4UamVLRG2T+wuX/N+i6ey/Nk4cVE/gF1ZvGbJiL2WLoQSQcpFS+K
7PDECrQSWxklo9cVETTs0i2Uz1HxSytdhFvmzUuL90pFtjkxAVD5AbB9d8R2LyiG
kkYU8+wja770a1D0qtTHDPDHMa4/7VMfNML8n2HLQaHF9aCNG2hwzzAGDbV85270
qjOe2OUplf5/T5pBAaV3fSOeFaR+uVU4Ubp1dNgYncmTZL1L+G/0kW3agetUlzGx
rx/0D16pRUwbH6HTHLPEMal+MwQJXme9jgxmivaYXRPnJrtLvjQvnmWg61lY/Kd0
/CV9m6Dtauc1x1gGzT6c8An92vbggo/iGRQegkuNK6EFmGR3lqxLv/o/CueX6DDw
KMYxM9HWuz+1YrNuOL/gTwowtpReiKoSaI5E91rqw5pm+jyFUNpQJ5CVcFQ92hpM
Lc3HvILfip2vkInkoxbJPCBm0G8N4eZaD5+0IK55x5lvKqhVpoqMrXYNy7xF1SA9
M2J40n8BpmF73bWqWPPD
=tlur
-----END PGP SIGNATURE-----

--5JJEVRmBpje5aLKk--
