From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack
	type
Date: Thu, 7 Aug 2014 18:31:36 +0100
Message-ID: <20140807173136.GN17528@sirena.org.uk>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7567909389350407500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A37A2652D7
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 19:31:47 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Graeme.Gregory@linaro.org, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7567909389350407500==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dy55e8aolw+8fmws"
Content-Disposition: inline


--dy55e8aolw+8fmws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2014 at 01:43:24AM +0000, Bard Liao wrote:

> > If this is coming from the hardware design I'd expect this to be configured
> > via platform data or firmware data rather than with an API.
> > Why do it this way?

> Actually, this patch is for Intel platform which doesn't support platform data
> yet. That's why we create an API so they can call the API in machine driver.

So, this is something that the people wanting to use ACPI in platforms
with devices like this are going to have to deal with - we need a way of
getting configuration to devices.  Traditionally small tweaks have been
done based on DMI information but that's not at all scalable.  I believe
newer ACPI specs are trying to accomodate this due to the expanding
range of systems supporting ACPI.  Punting to the machine driver just
moves the problem around, it doesn't really address it.

I've CCed in Graeme Gregory who's been writing some guidelines for this
sort of thing in the context of ARMv8 serviers - the most recent patch
is:

   http://thread.gmane.org/gmane.linux.acpi.devel/69757

The advice there looks good to me - see the "Device Enumeration"
section.

--dy55e8aolw+8fmws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT47f1AAoJELSic+t+oim90CIP/1jle7x4Fjzl9nPR3oVLZUA+
H7z02/HEioT6OGOGZkHZnrpho1Ih6yNeUhQNiJP1T/0YjUWzZgvcv3C8Gz/IoWbH
/s2xbiV0uTC2qboSPKbciRBztixCJcCRVyL7dVn11qTNpHCXsmR9Nwvm/0dLHvd9
tjwyR0YM3SAx2y+xZk4HSxtQrb8fq896DXKCH/gT1F/WBSlqrG4ryutOOMtN8PX1
TL3ZgwMDFrVBhxXym4PcQXeml2PODkawVaIFej5vjtmx8LuQltXIEB/xG5VfaGYe
ONJL8bfeNeIi1MBY7UsIYFVI6sVrW4E1mqSY3d9SKXhOoCDEjwfFtIOe9a3S8eNm
SLaApuZMnmDpUD7UJ6bvegEEetoioIDRIPQ5PPPxbkK6ERxOkcgsg1haNa+yaOEq
ED2qAMWcVbQaTVzT1pi47PIsGkUKIPlAWVqxMIOFTDLHx8rqOifIdk3SnkAdVsVy
NmVVUWgWc1NyxzF33BdELgBHc9FRYcVHrnFmLst/6KFkb99YMfZTcMAovJwj2RW0
0p9xlx04iSMhWGWeW2t5DllmU38sIrpQ5U/Uvr+m4uJB5aJgepqkWTZtWKsUXKLW
CqOxtmhzDBnc1V+SAX6UYacoug+4Axo+Op9VnQUOqsYlVnQQuzTJOypn7ZZHaK6R
lHTSlNRojap+DGxjFg79
=BMoP
-----END PGP SIGNATURE-----

--dy55e8aolw+8fmws--

--===============7567909389350407500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7567909389350407500==--
