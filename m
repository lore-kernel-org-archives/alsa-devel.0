From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] ASoC: dapm: Reduce number of checked
 paths in dapm_widget_in_card_paths()
Date: Wed, 22 Oct 2014 12:02:17 +0100
Message-ID: <20141022110217.GR2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8475995125923054071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83AB6261B11
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:02:29 +0200 (CEST)
In-Reply-To: <1413826604-3212-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8475995125923054071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Content-Disposition: inline


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:33PM +0200, Lars-Peter Clausen wrote:

> +/**
> + * dapm_is_external_path() - Checks if a path is a external path
> + * @card: The card the path belongs to
> + * @path: The path to check

We should probably not be marking internal only functions up using
kerneldoc, this will cause them to appear in generated documentation
which would doubtless be confusing for readers.  Just omitting the /**
and only using /* should be enough if kerneldoc doesn't have a specific
markup for this.

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR464AAoJECTWi3JdVIfQI4gH/ihTbNLyzffuTNLqOLL5N+1G
mGvS++Fr1PHowRk2koWrjCjmPebI2ReBgp7/1osOtS9C+JNBCnBMPGrCdEJ3XT1p
vgiN8VFukXucw4ThingwkcOi1kQvfCI7Oz57J33D64TVtcn9L8DUUaJbxnzawoJn
F0KYvbdHx4D1l9gxoweVVqtmPs/iMjwU9XED6GWMRgd8wPjRyDqwvMJKkMQHawvy
px1MAt2XQf1kkfOBgj1Og+Do/H8GkSQmrnfq0Opdqw5Yusxm09PC3CDT+E4mRvxa
TVgCjMWM/6kvZ0TF2f1pjyc7aXtc6D3u8zo+HbwWGkccH6NbGSxf1IgReox9DaM=
=Tv2O
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--

--===============8475995125923054071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8475995125923054071==--
