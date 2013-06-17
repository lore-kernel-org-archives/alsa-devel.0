From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] mfd: wm5102: Expose DRE control
	registers
Date: Mon, 17 Jun 2013 23:48:52 +0100
Message-ID: <20130617224852.GK1403@sirena.org.uk>
References: <1371055448-31316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130612170704.GP1403@sirena.org.uk>
 <20130617223811.GS7998@zurbaran>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8283978472854135316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D89A2650C2
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 00:49:03 +0200 (CEST)
In-Reply-To: <20130617223811.GS7998@zurbaran>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============8283978472854135316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFa58RoqyP9py9tY"
Content-Disposition: inline


--dFa58RoqyP9py9tY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2013 at 12:38:11AM +0200, Samuel Ortiz wrote:
> On Wed, Jun 12, 2013 at 06:07:04PM +0100, Mark Brown wrote:

> > On Wed, Jun 12, 2013 at 05:44:07PM +0100, Charles Keepax wrote:
> > > Certain use cases may require specific DRE settings so expose the
> > > necessary registers.

> > Applied both, thanks.

> Do you have ASoC dependencies on this one or do you mind me taking it ?

The new register defines get used for the ASoC controls unfortunately so
there is a dependency.

--dFa58RoqyP9py9tY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRv5JRAAoJELSic+t+oim9U3IP+gPw/m1+q9P95thhIdG7jitv
vUGntAnvnzase3FK3haAApUUk0eKeEU9hbsLc29fEZENx7N3qQVNkkW0mmUFHrV5
gmKoRhAKUaufZHi3rvfGMKucRqitetlV/rXeTh2lmoLMfUreemAVTtvTchy+0FGL
/FRWrIwnCjEXBrW96qcy/hU8buaG85jfkN8CrwSTwE6+ZvlJLD7iXQQYnXRa2iyj
baOLQRstsbK0MeifIp1XDoMeSmO/ePeai8zu8ugCxH75nnhokEr1B6yf4QIytwGJ
fE7F32cEx41HGtcf88U+6Am15hE+GAX5jUBLEQma4RBnZafVGY/+KesI4ncB28u+
0T7AhlW+F1HvyKJ9ZL/99s/bh4GW16gX79A+aW6tTjhSMWyFerrpWK9+oVwKthCY
1xNCicRk6ZnJdHDs/cO684TxBuwpYpNIKQom+SuVCfoaxApF3Lx46OtExxv+az3v
kk8euXwMOEivHZoRIDgPiGHGO9NWKzXFQhdIuTKlW/i5msKhjKfX2XcllNd2MHFn
ZxMligXIOS4clHYXd1qSuJJBbB48sD5m8n/IXA3ossN0uitd3xBvKWYVBRX80hCi
fa4+RABeqrEtHhUTUcQyNZDikcm1yrhomG0dQcDF2/UMrgObAuO4mTM86kX1u5xe
v4pbGnD7zk3OtPQ0r6ot
=pxAm
-----END PGP SIGNATURE-----

--dFa58RoqyP9py9tY--

--===============8283978472854135316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8283978472854135316==--
