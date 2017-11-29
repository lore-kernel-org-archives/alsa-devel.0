From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
Date: Wed, 29 Nov 2017 12:33:14 +0000
Message-ID: <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8156267986855793272=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1A0266B67
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 13:33:25 +0100 (CET)
In-Reply-To: <1510740463-21655-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8156267986855793272==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vk5lptp5ghfq2wt3"
Content-Disposition: inline


--vk5lptp5ghfq2wt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 03:37:42PM +0530, Naveen Manohar wrote:
> Remove option of choosing channel count based on pdata for
> kbl_rt5663_max98927 machine driver.
> As User-space expects 4ch DMIC data and uses channel-map in ucm to
> figure-out the desired channel to use, Hence removing driver change
> to allow choosing channels.

To repeat my previous question which I don't seem to see a response to:

| Which userspace and are you sure there are no boards that only have two
| of the mics?

--vk5lptp5ghfq2wt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloeqQkACgkQJNaLcl1U
h9B2HggAgTMfHP3mnLszYgc11PMA6bZAA0Vn/EAMYorTVb+LFNkTP9HE3QQ4dJ2z
J2EpjxeKenGe9lJWoc+2cMd7R0TgHBp+mBfNjbFFST9VuEM70zMUMxektFEugB1b
4yStf/et7XjkvJxmcAWT6Ht+QenMzO/8MP4hJ97OxpqHrQp0aqf8QEiEmMyqZXmG
xLjZkYtm2hCMP+I3/WFTOyonJtnVwLyayop4zR92pgbBwFLYSTX3mADEmnm4qF9b
0EQKebPPTCVbYhAE5J1Uet1ZYgZzk/12zqIv++a+3xcSk1ZCLrJrTuClQHeL/0JP
1QCrYL9AaT4HfBEwOM+QdQASXtbbfA==
=PRp9
-----END PGP SIGNATURE-----

--vk5lptp5ghfq2wt3--

--===============8156267986855793272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8156267986855793272==--
