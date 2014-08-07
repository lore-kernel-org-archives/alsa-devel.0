From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3] ASOC: dapm: add code to configure dai
 link parameters
Date: Thu, 7 Aug 2014 18:13:24 +0100
Message-ID: <20140807171324.GM17528@sirena.org.uk>
References: <1407341786-14990-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
 <20140807141604.GJ8181@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSEMfpWWEi9ZGPb2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140807141604.GJ8181@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xSEMfpWWEi9ZGPb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2014 at 07:46:05PM +0530, Vinod Koul wrote:

> I was thinking about this as well a while back, wont it make sense to let
> machine driver expose meaningful controls for this. Just like we have fixup
> for back-ends, we can add fixups for codec-codec links and let machine tell
> you the parameters to configure.

This is supposed to be pretty much the same thing (not looked at the
patch yet) - the machine driver passes in a list of possible settings
and then a control gets generated allowing the user to pick one.

--xSEMfpWWEi9ZGPb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT47OxAAoJELSic+t+oim9HjsQAJHVKaBzGY3CFmihcUB+WnMm
xMGuc50qPuJW8GBKMH0hmEFR1yuwSRPLX2vR4SAZQ83v8xsXm1O9RDALkeSC7GZX
Odh5mJGJ+ndyFO1COPL1UY6wxugExazL1A9uCTyLDFRfEDt23uM89CyLyxHzmeHb
GQXt3xgwADtPRFlcsLyFM4VLZtyy5OBfOriLVozMDgvr9SRbb/hlTcQalYOuKqKo
FZ5AnMYudhdTzhQeZHQnE8e83iW/HncJaODMWvMLQoN6jmr977LIK12gU9ZUsT4Q
ti/nSa4oxsSvcfeUWm5BndBfEc1yUazheEtRCv0qsmWJuspKdvCGAUmyG2UerGEC
ZEtz6bFQ/wNGbTmd1cBD1mq7p+emudFrr4xpWRmPrsAbZapCYoYS+OJ0LI6D3SEY
fJthGa4k+H+PMQjdN5mNyphpm4HO4kQL4Khcorw2SdcRCaz/WBOR5oF+vwCPM+fJ
ufejYhz0DKDyXXz6IUedfGcgQlMHifnDfGcI+da1TbLkyia5pmKTmGVQzBKmDU1/
JIP2grZQO97oPKXnkR57P1/tqw6bsdakUdd43qCno6XiGG2rbRtI1xjRx5OhkTaP
YTBqySNZFebsi5TUoU94O3VdZ89jkIayrS6Fy+COrTW8+qVpC728kFWzfmOnIfqv
IIVnk7Ui4fy9mf+QsGxZ
=SCMY
-----END PGP SIGNATURE-----

--xSEMfpWWEi9ZGPb2--
