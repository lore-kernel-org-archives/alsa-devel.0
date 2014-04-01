From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tlv320aic23: add an of_match
	table
Date: Tue, 1 Apr 2014 12:45:22 +0100
Message-ID: <20140401114522.GO2269@sirena.org.uk>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <1396291098-13796-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1519062780500569536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1242652B9
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 13:45:33 +0200 (CEST)
In-Reply-To: <1396291098-13796-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1519062780500569536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TN6tpTzbxVxIV0OU"
Content-Disposition: inline


--TN6tpTzbxVxIV0OU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 12:38:17PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.

Applied, thanks.

--TN6tpTzbxVxIV0OU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqbPAAoJELSic+t+oim90LYP/0f80N7/oyCnT4dBGIutdUVk
wstT+r3kaft05Ah6SL16wYv6dV+rm468TShMIOlFUeaILg7kUpz+hfrDXwgJi1b9
GGviL7DPWES9L7Ig+2aeG1lf+rJegPCDJNG+Otq3zWIgkeZYJD3Z1dLc0TZgjyXm
UtlQxjl6Z5vXVbpMIUVLJLlhvTMNti/cHOfRUm5whmM0FNKQdGBCvFMWBWJykuqL
ypEMA02iCCyVE1ZTDj/V8R8bBgevbiWjbk/uAy2NFCgsISvjalGu7qBSZcDIYiFP
YcXBC9VeOPh/c1VRoGiYt0uvAVzDYTTki3vpozMLtV+ZG33VfAOm0X3+BYGEolHk
MRHh2pztMyfkvWR2AnuCvnrVJyLu09ScoEYw0WkGqQkeN6Bnxl/yHha5Im/WG4eG
OUU/U2MuyJotyBUk+fILqRbyJJTRLYS5GM1SldhTLUXaJkbpzqoOJmEMOinJkxWJ
kad/uh4LqzK6meq1Ok1x+mm4TCWQNuL5AhAsvOXxpzW7pkotkE8mCDagcuSGSYf8
CO6wEXr4NgDPmm8ntN9UXfFmDIl7RByb3XDdzZUGMko5b6ao8jjzjnWeXJrUcb+k
IvdujsRJ0a86mgLjU2dcZ/ED9o1kN/mQAXb6PxG7M0Kn20x9dYzwtMuujDS4mtos
78TPmKLQJEr58rTsFGpP
=YY9B
-----END PGP SIGNATURE-----

--TN6tpTzbxVxIV0OU--

--===============1519062780500569536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1519062780500569536==--
