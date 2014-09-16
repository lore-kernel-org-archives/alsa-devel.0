From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: Set cbj_en for ACPI devices
Date: Tue, 16 Sep 2014 09:14:37 -0700
Message-ID: <20140916161437.GM7960@sirena.org.uk>
References: <1410399654-10371-1-git-send-email-bardliao@realtek.com>
 <20140912135558.GW7960@sirena.org.uk>
 <1410852714.23184.49.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396123172124068981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6648D261A3D
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 18:15:00 +0200 (CEST)
In-Reply-To: <1410852714.23184.49.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, graeme.gregory@linaro.org, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1396123172124068981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cEOOY/qhMBY6Rcxu"
Content-Disposition: inline


--cEOOY/qhMBY6Rcxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 08:31:54AM +0100, Liam Girdwood wrote:
> On Fri, 2014-09-12 at 14:55 +0100, Mark Brown wrote:

> > Why does this platform data apply to all boards using this ACPI ID?
> > Shouldn't this be _DSD data instead, or should we be doing quirks based
> > on DMI data?

> Sadly there is no data within most/all current BIOSes that have this
> ACPI id for the RT286. The BIOSes are a little behind in the development
> here compared to the codec driver. So it's probably we will have to
> support this and _DSD with this particular driver.

They should all have DMI data (ie, board level identification), I can
see them not having _DSD but DMI has been there since forever.

--cEOOY/qhMBY6Rcxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGGHsAAoJECTWi3JdVIfQW7QH/0u6xROLDvmXk7WNMqs2HNje
2ZuT6AUXGrG+FX9COxWqXM1lBwmDyWrScZq3x8JOcFnwOIUEesCbd/BpNPHWfP3o
4hm18/lq3FBMOZrgbas/XXLniSloGVWFmL0q4eutSUnvNi7kAlqTHF2jIVgUwF7M
hZmY3LsTDwNxlYRpYw5yuZ49CoGWvWMFK0bSTJl/wVIWxiUq2spsRznsq4gn+pyx
FHzAV6q5KKyia0xc/GtephIpjTyof2Ro4vd69l1/Zxi4StUMOI50XXLDozvK6vM3
8RDszJfPXp9uimtyWvi5iiScoL5DM+6p7NzCdBl3LmXjGRTPcva4A1f+ZPz+qeE=
=+ULB
-----END PGP SIGNATURE-----

--cEOOY/qhMBY6Rcxu--

--===============1396123172124068981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1396123172124068981==--
