From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Always enable DRAM block for
	FW dump
Date: Thu, 8 Jan 2015 18:19:25 +0000
Message-ID: <20150108181925.GU2634@sirena.org.uk>
References: <1420719172-28777-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6715462237889307366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E9002604B6
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:19:31 +0100 (CET)
In-Reply-To: <1420719172-28777-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6715462237889307366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rADzFwQZQ+Ha/IiF"
Content-Disposition: inline


--rADzFwQZQ+Ha/IiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 08:12:52PM +0800, Jie Yang wrote:
> The first 512 bytes of data DRAM memory is used for FW dump,
> and this first data SRAM block should be never power gated
> (always on), here always enable the block(DSRAM[0]) for D0
> stage.

Applied, though it seems like we should be able to do something to allow
it to be turned off sometimes.  Then again the power saving is likely to
be so small nobody cares.

--rADzFwQZQ+Ha/IiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrsosAAoJECTWi3JdVIfQndAH/2wjqvsB1+Vb/cs0O5nnzesI
rZZ2Fyo+0EGDSkMMCWy2i0NyTk+dSX6W+hPym5rr2U5RU7QrCuaUaRoJMMGxcNNf
vwtVwo6dHaL5ktmLVr0KTHYC/F1pMj5sVX3Nc4B3GzUQF0253eqE7JxAUZj0GSHi
javdmqAYYVdqNBSqc76YB9mVxCc0K547/CqPGUabfLk4qE2uFQ15bzXhkyyi6sU2
XKxKHWodPZ9qdj7uzjYPyjeITKTUfTywhtFtuWofN6mXSOUuA4vLTiGYrBXvz0zV
vaMbaak3FdQQoZdr1L4waN/d0oK6GRGl8M60kyUL/leE4mpYkKIx6K35XzXWrEw=
=PyrI
-----END PGP SIGNATURE-----

--rADzFwQZQ+Ha/IiF--

--===============6715462237889307366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6715462237889307366==--
