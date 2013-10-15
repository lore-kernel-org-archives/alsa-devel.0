From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Add an
 interface to override its functions
Date: Tue, 15 Oct 2013 12:05:18 +0100
Message-ID: <20131015110518.GW2443@sirena.org.uk>
References: <1381823360-8672-1-git-send-email-b42378@freescale.com>
 <525CF814.6090403@metafoo.de> <20131015082229.GA18714@MrMyself>
 <525D04B4.3050606@metafoo.de> <20131015092350.GA18784@MrMyself>
 <525D0D7A.8010309@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3867438884115365744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D962261736
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 13:05:24 +0200 (CEST)
In-Reply-To: <525D0D7A.8010309@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3867438884115365744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wk+D4bxjv0bBail9"
Content-Disposition: inline


--Wk+D4bxjv0bBail9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 11:40:10AM +0200, Lars-Peter Clausen wrote:

> Wanting to use on-chip memory for the audio buffers is not that uncommon.
> I'd rather see this implemented generically in the generic driver instead of
> each SoC implementing its own version.

I agree - to me it looks like the major problm here is that the handling
of the on chip memory tends to vary widely between devices rather than
that there are different problems.

--Wk+D4bxjv0bBail9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXSFrAAoJELSic+t+oim9QugP/3lpje0VdWaMZI1pMn07Ocmt
b+arR3FUowBl3juPwebblZy2o+cIepRCD67LcFuwu33bvhHvgeYRKG17HwtaTUIX
d5BdkGmbOUFV+j6CRHkG/n15zcBGDAAqManATmfBkijoB2eooaJINdtaTAGy+i2d
fW6KlgS4Gq6uRJq104jKjrCyPRaPM7ZUzd9w97U2EqsA1ik5ZeEWDNKuCQeZx1FK
VBlkR3JDT9vEGw6zk97Q5PB6TwUSt5sBdrHGuC+TqIKl0w5h8RVPsSmyIzdLLR8I
S/sVdZOjUJRcI6AahnT9FPboJrxfFbi2MTnyTfKAPZqJMVgsb6lyFA9buazoBmaz
2zFEVHUMOGVUW0YqdhROTTdKVlHEmohPrBhNyizpu4zLuq8kTdM0Kd8cBbo5iWjc
L//oF+hMXygYc6CGpxSQeiByIE6ehT+ajesjGagG/3rk7p3mh4X8rf9tF+AMji3r
7QW/XUUdWQkCn/S7/0okua+8F658XZazblxkMVEUQn8yGtoOyiicVS4NtYVJwB2H
KRDwBz5m6ITRL6iHzCgg7v+qwosBPR6nuOWv+ZLH2tdT/mwmxmqM7q+A3rLG84S6
LvDHfOSwXyZ5MU0KXPZ1ZvoJziKNk4W64F083aeDTRsZgVjKfqDe+14dgLOHO+R/
oKbi48ApXXn/xmW731oE
=kydy
-----END PGP SIGNATURE-----

--Wk+D4bxjv0bBail9--

--===============3867438884115365744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3867438884115365744==--
