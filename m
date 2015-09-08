From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
Date: Tue, 8 Sep 2015 13:23:40 +0100
Message-ID: <20150908122340.GC9751@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk>
 <55EC0AFE.3080809@atmel.com>
 <20150907162548.GW5313@sirena.org.uk>
 <55EEAC0D.7010003@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55EEAC0D.7010003@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Songjun" <songjun.wu@atmel.com>
Cc: nicolas.ferre@atmel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2015 at 05:36:13PM +0800, Wu, Songjun wrote:
> On 9/8/2015 00:25, Mark Brown wrote:

> >Sure, there's no problem at all having that structure in software but it
> >should be possible to do this without having to represent this structure
> >in DT.  It should be possible to register the card at the same time as
> >the rest of the components rather than needing the separate device in
> >the DT.

> Do you mean using a single entry in the DT for the whole classD system and
> instantiate ASoC components from it.
> For now, there are two entry, they could be combined to one entry.

Yes, exactly.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7tNLAAoJECTWi3JdVIfQebkH/26ALcNiCvJg3/suSEiUT7GV
gW9WOAddVliWYj8NMbhcAnX3Fg+gLmbZiftDzjNFb4gwIowiHn//Z9m5AqThZ/wq
1oaraRqS6XG/TIOqTRIERQrc+bHCI3B546WSisWzPy9yP9DCix8m1IweSA8QupGl
+xdn+srLBV3EpN80+Ut6YExT1dVOlcpwoqYZzDPlqSVeY2yeCYM8A3HupggwXZnZ
1SGpfI7iBuQcqWxLKVH2w4ctg5tPGoEopQe8tXf7SF8ii4QMA6C0Dnjv7fmMlfMY
Ogyu0Dy/pmV/IUYpDPI8HDbE7MRNBcCnOXJ9OSG33wkSXuV+N6F2+fCDgbEyYXY=
=ajMg
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
