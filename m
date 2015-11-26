From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add dmi_system_id "Google
	Terra"
Date: Thu, 26 Nov 2015 11:11:00 +0000
Message-ID: <20151126111100.GB1929@sirena.org.uk>
References: <1448333729-11065-1-git-send-email-bardliao@realtek.com>
 <20151125120139.GP1929@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7010D374E@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7773332954127805047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AF202614C5
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 12:11:06 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7010D374E@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Luke_Yin@asus.com" <Luke_Yin@asus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7773332954127805047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Wosya/OiUJZ+2ov"
Content-Disposition: inline


--9Wosya/OiUJZ+2ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2015 at 09:19:08AM +0000, Bard Liao wrote:

> > > +	{
> > > +		.ident = "Google Terra",
> > > +		.callback = strago_quirk_cb,
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_PRODUCT_NAME, "Terra"),
> > > +		},
> > > +	},

> > It might make more sense to just have a single entry for all these Google
> > platforms and extend this table rather than adding a complete new entry
> > for every platform - they're all the same and it'd make the table smaller.

> Totally agree. We are trying to simplify the code. The idea is using
> DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE") for all google project
> except a few projects with different HW design. We will use if else
> statement to match the projects with special HW design first and the

OK, that's a bit more than what I was thinking but sounds good - my
thought was just to merge entries so there were more things in the
.matches table.

> general ones. Also, I think those can support DT/ACPI should have higher
> priority than DMI match, right?

That might lead to problems - one thing DMI gets used for is to override
information from the firmware to fix bugs in what it's doing.

--9Wosya/OiUJZ+2ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVujDAAoJECTWi3JdVIfQgogH/R4fmiXl7/izVIEcua2LQrm1
5NuM52rLIl0bYe0eGy57fmowTARMMOhSnJQk2V7Qf7eHpydLGqZVn8b16tvihhDS
nf9oJrRxuiPJfWf6T5KYRv1WJXJFSla9EKrGvI0UnABBfdfUmpO/1MDWgmfYEf/R
xVfdDf+evQr5iVvajWwLerLqiH7gyfPHyAz6Ncyr/kJB1gy1pU9T/bqKz0Exya7a
S72WE//TKVl1XWrsV7jqcZxEt4qVP6X+bqKd0N2ogKiQHPl9uCJj6jU/olZMRPAu
30nG7uVNtA9J4bTj4sr1NFJuVtMxBmbT8/ZXNd0wX1lgmokXMHo07xAYOn67I0U=
=Tw/d
-----END PGP SIGNATURE-----

--9Wosya/OiUJZ+2ov--

--===============7773332954127805047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7773332954127805047==--
