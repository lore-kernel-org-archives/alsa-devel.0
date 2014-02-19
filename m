From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: sst-acpi: Request firmware
 before SST platform driver probing
Date: Wed, 19 Feb 2014 23:14:45 +0900
Message-ID: <20140219141445.GC2669@sirena.org.uk>
References: <1392798638-20767-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140219122506.GN2669@sirena.org.uk>
 <1392817832.2351.51.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5381262946811475533=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8236326538C
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 15:32:08 +0100 (CET)
In-Reply-To: <1392817832.2351.51.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5381262946811475533==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RAwBpkJyiFtmijpx"
Content-Disposition: inline


--RAwBpkJyiFtmijpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 01:50:32PM +0000, Liam Girdwood wrote:
> On Wed, 2014-02-19 at 21:25 +0900, Mark Brown wrote:

> > The more usual thing to do here is to only request the firmware when the
> > device is actually being used (in this case on open).  This also allows
> > the firmware to be replaced easily at runtime which is helpful too.  It
> > seems like this is still an improvement though so I've applied it.

> Fwiw, we need to load the FW at probe time since it will contain the FW
> topology for the SST drivers. The next phase for the SST FW is to use
> the ASoC firmware loader for DAPM, Kcontrols + DAI links (Vinod is
> working on patch for DAI links iirc, I will be back to the fw loader
> next week if all goes to plan). The good news is that the ASoC FW loader
> can also unload FW so we should be able to re-load FW at runtime too :)

I had thought the firmware loader would be able to cope with the
firmware getting loaded and unloaded at runtime, several of the
potential users actively want to be able to switch firmwares?

--RAwBpkJyiFtmijpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBLxRAAoJELSic+t+oim92VIQAJFWTT+67VsbUWMmr43qxcVO
kicR2Vln2/P3lAft6v5uNq/pgYwvcwQRT9VDiwLbU216Qh8mgCU0teQdnxDyt3EN
djfI5AgD2fLDCu1lPXHoc+ZEUCtG/vM+saWUbJ+O1u0WoQ1WYIRM13zHjSbxqWMg
v6q3kcVo++ixAtsFRylqwqLkgA7ybcRAdhZk4WcGRPLV4YX4jidgnkOra0TXpEbK
/i087FrnPHQMRtBTnZZ0JCahT2OkfH6u/kA/JtpSXJmbNOgrxRs5Wl4iMSQlDaXE
+0wkXSzsNiQpXTWj2vJKnsyCpPab5O6dOnVBeBykPh6Agz3zhaRZIjH3v951R/l/
EfT/t1Tn/u9jLFnts+rNZso25WvCiedtLhVVOPdExMYeVgXn4yHO6Y7P05jO91vO
enO7jYsuvEh6sSRr1QqdfOeCwnaGAj8pirjsk6CvBkV05jdXJ+gSWW6imBu4ZZC3
AlI3Z+BlDe9gVnSaH2R0xFnialvuxFvVZVVPrhMrcVc2SIG35kxvSALCzy9R5vdh
hBNyo1kydk0TXFn3jSz+jtLW7VYQdsfQXYlWslWdlElGgEIO9zPlJsxpQkPQcObo
FHKm73gbxZ+pQ0VNAB7yQ+64sHPaGMUaqKU2ZyQTNpABEWtoihzEi6eObOPcCo/5
OP/p3GsTrnTa/28WUq7V
=/9Yr
-----END PGP SIGNATURE-----

--RAwBpkJyiFtmijpx--

--===============5381262946811475533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5381262946811475533==--
