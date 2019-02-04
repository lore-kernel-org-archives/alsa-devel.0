From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: fix out-of-bounds accesses
 to DAPM lookup tables
Date: Mon, 4 Feb 2019 17:11:40 +0100
Message-ID: <20190204161140.GG23441@sirena.org.uk>
References: <20190204135914.7413-1-pierre-louis.bossart@linux.intel.com>
 <s5hr2cnppnj.wl-tiwai@suse.de>
 <a199f5cb-7e56-db27-37bc-78e3e7e5daee@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2900215066907740918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B2626746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 17:11:48 +0100 (CET)
In-Reply-To: <a199f5cb-7e56-db27-37bc-78e3e7e5daee@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2900215066907740918==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 09:08:41AM -0600, Pierre-Louis Bossart wrote:

> Yes I thought about this but didn't know why the array was declared with an
> implicit length.

It's been that way since the first commit (which predates me) so I don't
think it was a super thought through decision.

> Unfortunately the zero is a legit value today, so we'd have to move all
> existing values by one. Not sure if it's worth it.

It's not hard.

> Maybe an alternate way to fix this is to define snd_soc_dapm_max and check
> if the ARRAY_SIZE of dapm_up_seq and dapm_down_seq match. That would trap
> any changes in the enum that isn't reflected in the _seq look-up tables.

We could do that and another thing together for maximum robustness!

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYZDkACgkQJNaLcl1U
h9A27gf/aW1UsK3uepnO460IXwzS41uJ8Ql7kaUDsGJ0tWvN+ayumenZbEbJ/RvS
8mvzgnGxrRKgnx+AyJoVJ1nyI8urfrNTs7ZW8HOFsvVRj8LjZboLYLSsv2ve3WOv
oM2GrHbU7PE7VPMcQk7mJohQ1gsmrjYdCYrnAd0ZXD/WD3aMuSvLQ5BYlCrSMEsR
j/Nfazo84AEub6pf7SjTPx5/GBlYKNQdBbVNGYI38TXPsJMk5Fi/ROMMENZ+f5bK
ilUciwE9FLQmcoOuELO9nREXwd8BGuIqCEkRL9lyqxtHq29SJNIv1phN/dIijFw2
mdJlm6dzoGSSfz4+nwaD1m6x2Pl9jg==
=o9Sz
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--

--===============2900215066907740918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2900215066907740918==--
