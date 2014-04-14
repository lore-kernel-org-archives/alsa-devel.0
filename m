From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Do not touch 0x04
 register above McASP_VERSION_2
Date: Mon, 14 Apr 2014 20:45:50 +0100
Message-ID: <20140414194550.GP25182@sirena.org.uk>
References: <1396616190-3299-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5786723542335054768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBEC26528F
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:46:01 +0200 (CEST)
In-Reply-To: <1396616190-3299-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5786723542335054768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Content-Disposition: inline


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 03:56:30PM +0300, Peter Ujfalusi wrote:
> This register is not defined in TI81xx and on AM335x/AM437x it is the
> SYSCONFIG register which should not be touched by drivers since it is
> related to PM and handled by the generic PM code.

Applied, thanks.

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTDrrAAoJELSic+t+oim9OaAP/jk1IItGGr6simUaRsQJ01ai
hN5mOhOej8cWOvYvQhzO1coEz7fg2g4LUu7UCeeDqeVoFlS1Z+HZ0jDTB+9UcZnv
3Be57qriPzrCeMQg60TBRUJiPTxwewlyhfTgoP8YPUzWJQJ54Z/V3iQh3jNXLyk6
Fnt9nI+77qV5o2eO2Dn5W/JUU3sJZOaQLXm4TzkZ1kBTgP9bVCy92CSi2rDcv5qz
kXDKh9/g3T2KLqu15P/Gx90FpmG1QxyG0vNdL7zLCoyNebC+uDmKrzS55+8rb8FP
/qIUeDHebizLidzofRfeZqR4MsAzr5v/bxU9v881qGdtscl9+rAvFrRc+18x224N
tzCJTxg54E/JRZj5/VVhQirvtn3dd6txO6x5roBydrpJ7Cu4R0OI84lNNmaFVqPG
OHVYsTFAreDjDllUwQcTlI2oJ7PscvtWwXhGPzNenBSKaDs+ke+82JTTsoZnUqQI
PIcGIErSl7ui0k5jE0v2W+jZpbRKVHDDJnDGvnIjWkxTeOFpc5FsjrU16JM70KXj
LJXqAP0pGsAWbrrETf0eKwU8Eyw3bED4TE1Pf4EF1ktBDX/flfNPR9KJTkCSlnxQ
jSD1T/nlYn7v+oHtgeQQlgNsb94SgPKYK+0g7oro9vITNYs8mErtkm3KX5BoqFCi
+9eYrM5u1Lont8BUn8XS
=jZ7S
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--

--===============5786723542335054768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5786723542335054768==--
