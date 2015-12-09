From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Wed, 9 Dec 2015 20:38:36 +0000
Message-ID: <20151209203836.GI5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
 <5667EFCB.3010402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7829951526783668978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AED1E2612D7
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 21:38:43 +0100 (CET)
In-Reply-To: <5667EFCB.3010402@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7829951526783668978==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A3bjmUvO/1DXpqhN"
Content-Disposition: inline


--A3bjmUvO/1DXpqhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 05:09:31PM +0800, Mengdong Lin wrote:

> I have no intention to replace the existing aux_devs with aux_components.
> The aux_components is not for codecs and has no rtd like aux_dev.

OK, but I do think that's something we *should* be doing as part of the
overall move of CODECs to components and it's something that having this
change implies we should be doing as an immediate thing since it's the
more obvious direct use of the code (as Lars said in reply to the early
draft you posted IIRC).

> The purpose to introduce aux_components here is to let a soc card to load
> topology info easier:

> E.g. The machine driver may not define any FE DAI links explicitly but
> specify an aux component. And the platform driver can implement the aux
> component and let its probe ops to load the topology info. When the ASoC
> core is instantiating the soc card, it must to find the aux component and
> probe it (the platform component). Thus the topology info for the platform
> is loaded and topology core will create widgets/controls/routes/DAIs/DAI
> links. So after probing the aux components, the ASoC need to check if any
> new links are created, bind them and create pcm runtimes for them.

I think I'd need to see the code you're proposing here to really comment
but I think it sounds like it comes back to the same thing as the above
case where we're overall trying to move everything towards uniformly
being components.

--A3bjmUvO/1DXpqhN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaJFMAAoJECTWi3JdVIfQnIcH/0Y3iHiHyJ7qjdZ3N2hn23VB
7l4hM7WCSjYqkOi7rnXO8eGkoqrxAI9KPB+3HmdbPSPH1vhS3191d2cMZi73591D
WyyqYUSiUIGljqfsivgz4aJ+l5cbyNU8e7242hK0yQB9Z9d4EciQWqgVk/hLQIqg
9WupzG8mDevfjoPwWDEEfjouiRTY7Wpr/CTwetsFqKIHjXlek6Cq8DRikWCQpYGd
jxNgBgHPoGDbH/k7QovIIPak+TqnXdy66eSE00b5Xjl7GDFAQrPD1QIXDlpYR9EI
IPk4y8DWgithY1Q/8KTjYUMhdJniyMXMd/IcDul5o63p64RzPExGrSEtSf0qESk=
=tWcs
-----END PGP SIGNATURE-----

--A3bjmUvO/1DXpqhN--

--===============7829951526783668978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7829951526783668978==--
