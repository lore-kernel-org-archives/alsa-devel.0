From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix possible acpi enumeration
	panic
Date: Mon, 15 Dec 2014 17:06:45 +0000
Message-ID: <20141215170645.GH11764@sirena.org.uk>
References: <1418282517-851-1-git-send-email-kevin.strasser@intel.com>
 <20141211132026.GY11764@sirena.org.uk>
 <51B6C3CD1F10FB47A5702881E0E230A74A0ECAE1@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0201095044417229592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 085A426049F
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 18:07:15 +0100 (CET)
In-Reply-To: <51B6C3CD1F10FB47A5702881E0E230A74A0ECAE1@ORSMSX104.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Strasser, Kevin" <kevin.strasser@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Fang,
 Yang A" <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0201095044417229592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aObFJ3I/fcifeQec"
Content-Disposition: inline


--aObFJ3I/fcifeQec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2014 at 09:55:38PM +0000, Strasser, Kevin wrote:

Please fix your mailer to word wrap comfortably under 80 colums so that
your mails are easily legible.

> > This changes the check from verifying if a codec_id is present to verifying if
> > the first character in the codec_id is non-NULL.  That doesn't seem obviously
> > safer and the tables of machines seem to be terminated by having an entry
> > with all fields set to zero (which is a common idiom in Linux) which would
> > now crash with this change.

> In this case mach->codec_id is non-NULL, even for the terminating element, because it
> is defined to be a fixed width. So we have to take a look at the first character to see if it
> has been initialized.

That's a really unusual and (as you've seen) error prone idiom - is it
not better to fix the struct to use the more common idiom?

--aObFJ3I/fcifeQec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUjxUlAAoJECTWi3JdVIfQdbwH/jMEToQ6JN4EAR2XOTbT9sKH
IRhwFhD20wpAqHL/+GbQUOzDRpoE47WgGXsAr7huYCwv10KRv4DNFr+mD+wTFFJM
eE1eBqjEXcrHS27NEruEZAlSFrpIXLt7Ysd7Aw1NoZ2XefjvVXtQu8fFAgtYRYWA
FdK2kk+23Gtynrb8a6z05cnxZN8Des6/NepHv6wIQ4+GphsTsZ1FKA9t8TTB7Vny
Fa4bP4cdK1FJNSmGa8lH9nFua20nTPuGN4nn7kmAjExYLXrttpAVt+G2b956QMmV
fmB5mBZ/0L6vgkDzvd/c8lQxM1uWbCYEqEPHwNQMT/hdJ+eJkQOVLD0lX/sIXpo=
=TEl5
-----END PGP SIGNATURE-----

--aObFJ3I/fcifeQec--

--===============0201095044417229592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0201095044417229592==--
