From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: dapm: lock mixer & mux update
 power with DAPM mutex.
Date: Wed, 7 Mar 2012 19:48:43 +0000
Message-ID: <20120307194842.GI3107@opensource.wolfsonmicro.com>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
	<1331116707-10016-3-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5129030511052546228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D2BE10B952
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 20:48:44 +0100 (CET)
In-Reply-To: <1331116707-10016-3-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5129030511052546228==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jcZk2Ix8j3PVOBnV"
Content-Disposition: inline


--jcZk2Ix8j3PVOBnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:38:27AM +0000, Liam Girdwood wrote:
> Both snd_soc_dapm_mux_update_power() and snd_soc_dapm_mixer_update_power() can
> be called internally within DAPM core (with DAPM mutex held) and externally.

Applied with typo fixes to the changelog.

--jcZk2Ix8j3PVOBnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7uPAAoJEBus8iNuMP3dNn4P/j3+KnpaftkesHBLV3G8YJop
VTkzhHOzeia3NPqpyNVvRyVUtR8SL2vr3pYVv9tIcqB0r8tN31po2YW1Nh4qTRby
/nBGY4/zjQkVWL6o+fq6EaG3HcmW0VA8s2Zp6USyqfHSFF/qdabrVjjeJ1Hy2sZt
Ru+HbzncTTqn4LOnm8G+ulSiTX1wbwIm3HTAVhWFDbQ6UBkJblSwPi/8eLjlIoNa
e8th7EQTSIRr00o7m5/Z0NIapXdtWobPP6LHpmyOr6TLFnwlvcxaID5M6eKSAI8k
NQQ2oiK2hk9/zF1RQy1c0g125FMIu12aqssbQU208k+Od5guohset4JjSey1mzdu
qf8cSbbkjtjIWknBSBQAMxh31e6AV1TAJ3Q5Rc2R6P5M0T4++znqPZHSL5tOgaoX
uPrwX/0Ny+BwLFe9RhO2ekj83YC8F/JXvNnkHHQW2eAq+RHJelibsUDdckUHzkop
020rFZkCwrDqCy2Y9yPcfFmQuwHPVr9BLmA1C+21DFn1877ZAPi+oS2GkKqF7ZZ+
0PJgXFVwKVxG3v8prc001mgXCJp7QzbJWDKpIkiaj0taMHjZh4kKnrcIAGkkkL4t
S3I0DxI6sgY7Ig7Lc0OZjMNwBZl55HDfsFCZQ88dDfO9hZQ3p5zhN1WL+UH9ndil
OdQV0CKajvN0fxWr4xjp
=NAup
-----END PGP SIGNATURE-----

--jcZk2Ix8j3PVOBnV--

--===============5129030511052546228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5129030511052546228==--
