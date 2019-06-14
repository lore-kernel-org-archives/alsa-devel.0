From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] sound: soc: core: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 18:41:10 +0100
Message-ID: <20190614174110.GF5316@sirena.org.uk>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-5-gregkh@linuxfoundation.org>
 <20190614153405.GD5316@sirena.org.uk>
 <20190614161339.GB22607@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0748235503313558562=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB502F8076F
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 19:41:12 +0200 (CEST)
In-Reply-To: <20190614161339.GB22607@kroah.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0748235503313558562==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oPYnW2SrAqZUvu4n"
Content-Disposition: inline


--oPYnW2SrAqZUvu4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 06:13:39PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 14, 2019 at 04:34:05PM +0100, Mark Brown wrote:
> > On Fri, Jun 14, 2019 at 11:47:56AM +0200, Greg Kroah-Hartman wrote:

> > The majority of this is removing error prints rather than code that
> > actively does something different.  If this was like kmalloc() where the
> > API is itself reported errors then this wouldn't be an issue but unless

> No, the long-term goal is for debugfs_create_file() to just return void.
> I have already done enough cleanups in my local tree to do that already
> for many of the helper functions.

> No one should care one bit if a debugfs file succeeds or not, no logic
> should ever change, nor should it matter.  debugfs is for debugging
> kernel code, not for anything that anyone should ever rely on.

I don't think this would be a helpful change.  Nobody should care about
debugfs file creation for *production* use but that doesn't mean that
people using it for debugging shouldn't care about it.  Debugging tools
that are fragile can be very misleading for developers and hence
intensely frustrating; it's never fun to be building on quicksand.  This
is particularly true for code like here where the core is providing a
bunch of internal data that is hopefully useful to people developing
drivers or system integrations, the users have a hopefully more black
box view of the core than someone directly working on the core would.
If that view of the data ends up being corrupted because some of the
files or directories don't get created that is something we should be
flagging up to people to try to help them avoid being mislead by what
they are seeing.  Developers need to be able to trust their debugging
tools.

> So yes, this patch does remove a bunch of error messages (that as you
> point out can never be triggered), but the main goal here is to not
> check the return value of the function at all, which is what this patch
> does.

Like I said in reply to the other patch the error checking here did the
right thing up until January when debugfs was changed to return error
pointers instead of NULL.  I know that I've found this error checking to
be helpful in the past, not having it would be a loss. =20

If there were some visible error reporting in debugfs I'd not be
bothered about this quite so much (though it'd still be less clear) but
there isn't so it really feels like a step back.

--oPYnW2SrAqZUvu4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0D3DUACgkQJNaLcl1U
h9DGugf/VjddJN07Dw5OwzeXNhOminW+TBjidBE5IWx9QgY7OPws+Ik+7lupKhAA
84kP4UkJWZKrfWHbROHYFsguYBTlH6zy5YihulH6rnbuuqMBzUsN1xLOKKmGrzYh
VChAKLknRb5Vrr1Ltk7ZzwH0UIVjzZ6IZDhm4HEgYjrqeFhMj46s2GTg+ldOLetG
QfMjrJ/qakXExhnDaYekVsGCO4DGt65L35CwN0FdGqB7Q1CvcHs+1srYMwX1icQQ
5QDJ37c6T4bXE0iYYurQ8yZfuBwOUQXaGR3fv/mZH4tlvKZ9lGuI9Vx02Xq41g2D
+59zT8mJUTAjIb9NuFXiqlK5S0JxTA==
=FiYq
-----END PGP SIGNATURE-----

--oPYnW2SrAqZUvu4n--

--===============0748235503313558562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0748235503313558562==--
