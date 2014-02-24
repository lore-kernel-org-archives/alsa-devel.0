From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Mon, 24 Feb 2014 15:52:24 +0000
Message-ID: <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_40263A3A-2A6A-4855-9209-EDC777C5FD00";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140224113011.GE25940@sirena.org.uk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--Apple-Mail=_40263A3A-2A6A-4855-9209-EDC777C5FD00
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


>=20
>> +	/* Disable auto-mute */
>> +	regmap_update_bits(cs42888->regmap, CS42888_TXCTL,
>> +			   CS42888_TXCTL_AMUTE | =
CS42888_TXCTL_DAC_SZC_MASK,
>> +			   CS42888_TXCTL_DAC_SZC_SR);
>=20
> Does this interfere with the manual mute controls or is it a separate
> thing?  If it plays nicely with the manual controls it's probably =
better
> to leave it enabled since it improves performance in some benchmarks
> (that's why hardware tends to have the feature).

Auto-Mute should be enabled by default.

>=20
>> +	if (!IS_ERR(cs42888->clk))
>> +		clk_disable_unprepare(cs42888->clk);
>=20
> Does the device work without MCLK?
Yes, MCLK is required. If you can=92t get the clock you should error =
out.



--Apple-Mail=_40263A3A-2A6A-4855-9209-EDC777C5FD00
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTC2q4AAoJEHdXZdGWfiO70PIIALSgC5o02guz257kMTsyIXyQ
tT+onHYqqS6ogOZwowzXu18KkX4GqSE/8hrrBf+bBTgGKoo8+TTydpUGfs8pT66B
ttHKs0t+zMml55NzZUVGrejO5+3qy5OTMql9Prv3jMkKpZeGLCIy0dA3gWtwJ0Rl
8R/OL+ti3XtLofZWKUyO4jYNB1+Air0iTX5PBg/jBe4mmi1CUfxhI2xZtiKM8Ut6
OiKn14p9nHiAeojDT3hlnHs1a6mc3wsuE8Hpgc1d2+3llyxgFOrazySsdlEN96x0
0kr5BQJtczTPKl7FQr3CqkmPRC1iSk0KM+oKRYo3x8zIRIun4160mokgX0G0l5w=
=XQjd
-----END PGP SIGNATURE-----

--Apple-Mail=_40263A3A-2A6A-4855-9209-EDC777C5FD00--
