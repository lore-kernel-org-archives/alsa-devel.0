From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Thu, 5 Feb 2015 18:16:38 +0000
Message-ID: <20150205181638.GH21293@sirena.org.uk>
References: <1423056843-26490-1-git-send-email-yang.jie@intel.com>
 <20150204202604.GF21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA9CB6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7012080411965010357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1CF726052C
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 19:16:42 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BA9CB6@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "bardliao@realtek.com" <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7012080411965010357==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YM5nWqqHCyBwy3Y4"
Content-Disposition: inline


--YM5nWqqHCyBwy3Y4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 02:07:35AM +0000, Jie, Yang wrote:

Again, please fix your mailer to word wrap within paragraphs - your
mails are very difficult to read.

> [Keyon] I agree that it may be more reasonable if we can pass
> jack(similar to rt286_mic_detect(), can use jack=NULL for disable)
> from this machine driver, then add checking this jack in handler
> rt286_irq(), don't call rt286_jack_detect() and snd_soc_jack_report()
> when the jack is NULL.  What do you think about this solution?

That sounds fine.  You should be able to just call the jack API with
NULL jacks, it's set up to handle this since it's such a common case.

--YM5nWqqHCyBwy3Y4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07OFAAoJECTWi3JdVIfQZSQH/3ctNKj70ahmrQGID3P/8vG2
iE/FE1evdRlUgQApU2Kw4uMdoMYMtPBkq9qX5fFqfSxlfY9Zz41x109+giQon3wh
uMZc8bWgyhihOQoLwbJMJWsJpnspsP4c5EojET2+YCL4RCASJHGFlmqMeO2BCqIu
I22SwbzJQu30qMNUVEyyWpVX22y/51qRFWcx+0N8mKt4eM6ZNUPDGswfDng87V9g
0N+vyMgt4aOJrJMOSi8zFPK/OPXyibYu+ngWsVO/Ztg2U3uPf46JjLXF65/274NX
MM1l6AEy4vM6JUNDaoYBD+o4PtnIR+iG4WRuXZZSJ5JaSDBe2YqCgzGj+IpSFYc=
=pQ8Y
-----END PGP SIGNATURE-----

--YM5nWqqHCyBwy3Y4--

--===============7012080411965010357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7012080411965010357==--
