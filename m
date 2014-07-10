From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] ASoC: arizona: Correct checking of FLL
 ratio limitations
Date: Thu, 10 Jul 2014 12:28:40 +0200
Message-ID: <20140710102840.GW30458@sirena.org.uk>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1404924109-1750-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6208197597372703087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FE5261A40
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 12:29:54 +0200 (CEST)
In-Reply-To: <1404924109-1750-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6208197597372703087==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8c7vHYlrYOebzgj6"
Content-Disposition: inline


--8c7vHYlrYOebzgj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 05:41:44PM +0100, Charles Keepax wrote:
> The check to ensure the Fref frequency is within the bounds for the
> current ratio, was placed in the wrong loop. The initial configuration
> will always be valid and the loop lowering the ratio will only reinforce
> this validity. The check should be on the loop increasing the ratio.
> This could on occasion cause an invalid ratio/Fref combination to be
> selected.

Applied all, thanks.  You should really have put this and patch 3 first
since they're bug fixes.

--8c7vHYlrYOebzgj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvmrOAAoJELSic+t+oim99r0P/31GiS7LY8jtTvQyK967vCBU
Um4+OCYwRE/noEd67mOW9cE1yM96MyEM1dWy6vM8PvRubxY7Cb/pHYaA3dX+jVm3
Bwwht93PcRhV7nb5pyb54bTgo6V2hdgSCz5/4FLALogz5ceUVMCAjs2jYUeFvZ+g
G5fGO75e8WCiMhCe3Z1LZWotkDLWLGHYxFZG15Ce52X+2xUvfH6IpsdlhcipTsQ5
Y6x/DQN5uNBzgfX7V07xivtlUL6sc6+oGCXl+FnpyzZ0hF8yldQv65hO/wcYlPEQ
TqAsvfgAthiEhnK/ob6O0hkqD8CTH5I2ruISLckWmN7uQ/zEaMPw1TAkdwkQhEcr
tG9eLO/nOMn3gejM9YffYKEFvVw8jda2RZbXFR/oTxdGsY8gBXDUj9xrnFeteMpw
lc8cv5yrTw5t7cGkYY4XJy4JLDzgF0gtefqZJjJTQc0Z7CcxOYweRvfOQw1un4vF
EtpNFIeJ7pXJjzqOGfdBRVSiRJTggm1JfOrx6Z2RurRbc7Qy6oZWlRKzSWIy6IGr
fAO6xhxMvhEipTs07jNuRWCX4fsQkzwPljZIbw4yAtPD677pX+0JFdIjWfaxrS5R
NxI8v56bWYK71cCgh5NRggypwjVXXrh26SfwdbZpzCvhn6A3zkskMrdAVama9cE9
Pmv9LLYh4Cnv5iXG7dD/
=Ybnb
-----END PGP SIGNATURE-----

--8c7vHYlrYOebzgj6--

--===============6208197597372703087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6208197597372703087==--
