From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix missing mutex
Date: Sun, 2 Nov 2014 11:07:46 +0000
Message-ID: <20141102110746.GA3815@sirena.org.uk>
References: <1414910081-2487-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5961663923419546970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEFF260A5D
 for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2014 12:09:18 +0100 (CET)
In-Reply-To: <1414910081-2487-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5961663923419546970==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 02, 2014 at 12:04:41PM +0530, Sudip Mukherjee wrote:
> on error in block prepare, we were returning the error code while still
> holding the mutex. We are releasing the mutex in this patch before
> return.

Applied, thanks.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUVhB7AAoJECTWi3JdVIfQcZUH/RoQnYrPMaboeP9/y82hei2r
yJLn7r5a3tqjyPOqUc4aZPCcaY7B50gtk2HhheVprHh4h1oe+iq1tSorP/u0g2ai
a+9H4/qmS2qH1oVBHJDmFLgl6csFzhvyQatvAdCEuCyvOuCiUamoocDqTHs0v6wu
iLQCjgdYM6HLHAlcB8tnR1cJccrqeFpN61bAxihUUwDJbz2zIHeMDbieFMduY5QZ
QVhJ2x+QGZZC0AzjvWj6RNnIPhxQQtBAtN/Pg4y06sHXTW1gI0gh+P6kqxjjgN8Y
CKzIxafBTurDDYd1NGEuWjuvpDVC6si+YRWvG+j+QK8RDWH3FDTHMSQ7ypfrP5w=
=9h1N
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============5961663923419546970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5961663923419546970==--
