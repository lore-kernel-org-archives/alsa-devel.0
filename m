From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Tue, 7 Jan 2014 17:43:32 +0000
Message-ID: <20140107174332.GF31886@sirena.org.uk>
References: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
 <20140107173510.GD31886@sirena.org.uk>
 <20140107163818.GB16227@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4472318977698071329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61054265087
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:43:37 +0100 (CET)
In-Reply-To: <20140107163818.GB16227@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4472318977698071329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="53oGybRJwcWhFj4z"
Content-Disposition: inline


--53oGybRJwcWhFj4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 10:08:18PM +0530, Vinod Koul wrote:

> I am not aware is any users of desciptors yet :) so thats why went ahead and
> modifed... This is long term plan to query dynamic capablities of device using
> this

Right, but might be worth tagging it to stable as a result - I can see
someone building their userspace with the LTS headers for example.

--53oGybRJwcWhFj4z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzDzBAAoJELSic+t+oim9TmEP/iS9EXAVBPiHOkZcMBxaxWWQ
GIgj38AG9cNy34h9YkAcOsTujAhurumszW6T4/1ywzPmBFfeQ5GPEEJFiOCztmbO
WmXUReRYFDyBy95JLWVingeYFyrMChc/NKB7o4r4nUiLyC/mTYwghoDLXXigwIqX
ZzH0e4mt4IfqqJNWMiMfSFEXrsiIps3+eSjZ3kqRRCkNuohzQxaiIkrdS6bkZpKG
bmsAL7xRTxhUchwGnEuRE6U6dWN8mTUYvcMFYb3pEB2qa5jYtu6rGeV+X/jc3f/N
u8Hwwvl/35iCSNtvNBmbmIRcJxkFlSXf8rFfh7espxmj17tkYZ2fpLAt4QnELQV3
UyEQiWZwfi96Llta3b6GtDYpCkCvxJXVzNci18xNBgg/z9lNmQbHkd6tB0Y3cDK8
z1HTFN2WPm7qeC39hnLZr0obi7dG2hN0+E++ar6BrYJ4x8RZztDr0QqvgN6QmNZG
xBcn2R2jJkb9O/w2XtCAiovcBCgClA3wqRXCiZ8OfnEAiVcRfwWqUPrTm8pOgKor
ksCUGgODz1KjQb6kd49BIMGlavNMJ6Fvgyhr0MSkik2+AmufGHAtUFkzz61iKL09
bAetYEfA5I44axAsYR+WpMF7n6hCCESeUJ17Im1WdKRFfMDE8GbdaJYW//0QLd0Z
tmrhoZOqi76Udbak/IAR
=W9sI
-----END PGP SIGNATURE-----

--53oGybRJwcWhFj4z--

--===============4472318977698071329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4472318977698071329==--
