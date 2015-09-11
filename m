From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
 after period elapse occurs
Date: Fri, 11 Sep 2015 12:49:10 +0100
Message-ID: <20150911114910.GL12027@sirena.org.uk>
References: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
 <20150817195555.GY10748@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718D71126@ORSMSX113.amr.corp.intel.com>
 <20150819003529.GO10748@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718D72C4F@ORSMSX113.amr.corp.intel.com>
 <0485FB02182A4744A8B06D69AB7BF8E718D72C72@ORSMSX113.amr.corp.intel.com>
 <0485FB02182A4744A8B06D69AB7BF8E718D98098@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5960160260404190163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D3DE261687
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 13:49:20 +0200 (CEST)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718D98098@ORSMSX113.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fang, Yang A" <yang.a.fang@intel.com>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Mirche,
 Dinesh" <dinesh.mirche@intel.com>, "'lgirdwood@gmail.com'" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "'kevin.strasser@linux.intel.com'" <kevin.strasser@linux.intel.com>, "'dgreid@chromium.org'" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5960160260404190163==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i48WUZoYXCDzOdXY"
Content-Disposition: inline


--i48WUZoYXCDzOdXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 06:50:24PM +0000, Fang, Yang A wrote:

> Could you please let me know your further comment?=20

At the very least this needs a better, more comprehensible patch which
makes it clear that this is just a workaround rather than actually
fixing anything.  Of course I'd be much happier with a patch which was a
clear fix.

--i48WUZoYXCDzOdXY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8r+2AAoJECTWi3JdVIfQcSsH/0dqminve63r4n4GsLG0tmDd
HpFDOV8lpfxzBy6KNc0C/Q2kCPaEpFaHhlIwQtO27vTAxupQAcr7c4g2O/ERUGXC
gMVjlbotmk1in88+SjgO/B2Te6xu9e6w11gBWUZkntfmhk0ohemmGw9g/8Y9eRnz
qTCxSJH4p2Xpblve1NMXiOm97oHg86PfUXTkR7fS5iPFQAVW4xc7HVOGgSI9Amer
T5vnPYOgKG68WXP/orqRlfEmrAx31B5Ex+Tok7CpB0eHm1Sx7vtam43HPH5eWZCX
lZbhwYTfQh0l0Nj/ZtEOcg9oD/6lHcq4boZUDVIMh7KprQEgOebraBhDG7wZkQk=
=rP5S
-----END PGP SIGNATURE-----

--i48WUZoYXCDzOdXY--

--===============5960160260404190163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5960160260404190163==--
