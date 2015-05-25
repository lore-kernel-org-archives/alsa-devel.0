From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/5] ASoC: jack - add_gpiods accepts filled
	descriptors
Date: Mon, 25 May 2015 13:12:01 +0100
Message-ID: <20150525121201.GL21391@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <1432332563-15447-3-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6066191228426416598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97C7226150C
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:03:47 +0200 (CEST)
In-Reply-To: <1432332563-15447-3-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, zhengxing@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--===============6066191228426416598==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YGQsgxOP0v8GKjPA"
Content-Disposition: inline


--YGQsgxOP0v8GKjPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 03:09:20PM -0700, Dylan Reid wrote:
> Allow for the desc field to be pre-filled when adding gpios to a jack.
> This allows drivers to get the gpios and decide if they should be added
> to the list or not.  Specifically this will allow the gpio jack driver
> to add gpios based on device property specifications.

Applied, thanks.

--YGQsgxOP0v8GKjPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxGQAAoJECTWi3JdVIfQinQH/3C9cVBLA9xto/vUZWrjrK0u
JkwoOBXSwmPrAZxEJkzKlCbUX+d4c7U14NB+a7Vl16NuOwpjCprfKq+jeU2HwCJn
I/VC/akKM2ngCvmC063KvKuZnvPx7nZMrZHUgUQeTngEwVdY0aVrL0wv0AX8OQhL
2O4qK7U18hWA0gOn9fe7sAaB8l1O8fKp/JNXHrXOT+S4eqDdJpOWdePyjGkZuK08
kbrrG+ySfs4mUrrF1SttdFBGhTgWNDzpqhaCh3C5pfDRkCKzi+6orpbvDHxflXsd
rw+yaDMdSt5KqILPP6RwDSgyqONptURBeSTzzSCxD6Hg4BBN+KkPbP5hP2teGhM=
=fNMH
-----END PGP SIGNATURE-----

--YGQsgxOP0v8GKjPA--

--===============6066191228426416598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6066191228426416598==--
