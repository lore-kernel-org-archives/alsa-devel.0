From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: SOF: Intel: hda: Enable jack
 detection in sof hda driver
Date: Thu, 27 Jun 2019 12:33:45 +0100
Message-ID: <20190627113345.GC5379@sirena.org.uk>
References: <20190626202229.16312-1-ranjani.sridharan@linux.intel.com>
 <20190626202229.16312-3-ranjani.sridharan@linux.intel.com>
 <388c2dce-a235-c592-b88e-0f6deca76220@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4604518823077565351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F24B0F89678
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 13:33:51 +0200 (CEST)
In-Reply-To: <388c2dce-a235-c592-b88e-0f6deca76220@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, Rander Wang <rander.wang@linux.intel.com>, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4604518823077565351==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 11:03:14PM +0200, Cezary Rojewski wrote:
> On 2019-06-26 22:22, Ranjani Sridharan wrote:
> > From: Rander Wang <rander.wang@linux.intel.com>
> >=20
> > In commit 7d4f606c50ff ("ALSA: hda - WAKEEN feature enabling for
> > runtime pm"), legacy HD-A driver sets hda controller in reset mode after
> > entering runtime-suspend. And when resuming from suspend mode, it checks

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0UqZgACgkQJNaLcl1U
h9BTjgf/aPeGh/th5rmCuiBy824jAqtp8r5DXheNUbL5eIIJBZGEhzlR0z7gLRX1
UHXYQcjiNDC6m9UXJ0j9sjcnwm15weJwdMaKPaJgxZK6iiO7RmSxvLb2PVyboXYr
6kuXDaxUMWeTB0ys3ErehSjC+XsOgpIU3U1ldgM/en++pZ5cVi8A5Igz/QAy5gxL
pBoKUoG6WOe3tS5WBGvHkRonwFYZOyHly/MARdtho6sK2zM1MX7CToJpd1hjWnCK
cSXDqWoh9nYr9LW4UOsFbHz9il0ozrwFXOb23VLyp8iBZCVAJv/K9UWXMNPHcdz9
AY7X95ouoY8xj4F0SFeTe2AaMDMkRg==
=K8H4
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--

--===============4604518823077565351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4604518823077565351==--
