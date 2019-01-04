From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Variable "val" in function
 rt274_i2c_probe() could be uninitialized
Date: Fri, 4 Jan 2019 13:49:37 +0000
Message-ID: <20190104134937.GB4140@sirena.org.uk>
References: <20190103215912.6071-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3133482702937171072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CB530267944
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 14:49:50 +0100 (CET)
In-Reply-To: <20190103215912.6071-1-yzhai003@ucr.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: csong@cs.ucr.edu, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, zhiyunq@cs.ucr.edu, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3133482702937171072==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 03, 2019 at 01:59:12PM -0800, Yizhuo wrote:
> Inside function rt274_i2c_probe(), if regmap_read() function
> returns -EINVAL, then local variable "val" leaves uninitialized
> but used in if statement. This is potentially unsafe.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwvZHAACgkQJNaLcl1U
h9C6jwf+Keh0tNKg0i8mQ5uxEDQ1Lg7bBW+fmCUAddmRcYyHe3lllL3fuauZDonb
84ms+X7TxqSJ3KR3sB1EnHb0xktJsPqkG1asj6WDdiLNteREWJyXqjH4f4cfXU+n
hLJ3LBzfBm/rJWKBV4NqLz24MvS96nasql+VW2H1b9hjr9r5fmtJeqXEMwHHCF68
dub9Yqwp1V/BWetT45o7PWQ//X5KqIa9nIxlTAzzCUGOzSwDNp4mCiN7nwDEQySW
HAt611Inky8+BMHWxKdo8rwwqxNMwx011hu9mk/ZAEkHuRaySiD8Bb8zSULj9N2N
NFS35byS6C4U22O1HUNHpoWuc2C+sw==
=FRPy
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

--===============3133482702937171072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3133482702937171072==--
