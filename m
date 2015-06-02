From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: don't need compress offload
	for broadwell
Date: Tue, 2 Jun 2015 11:58:53 +0100
Message-ID: <20150602105853.GN14071@sirena.org.uk>
References: <1432972727-9602-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2927335234989942990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D97EF26060C
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:58:57 +0200 (CEST)
In-Reply-To: <1432972727-9602-1-git-send-email-yang.jie@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2927335234989942990==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 30, 2015 at 03:58:47PM +0800, Jie Yang wrote:
> We don't need compress offload feature for broadwell broadwell machine,
> here remove the non exist dependency.

Applied, thanks.

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYxsAAoJECTWi3JdVIfQGo4H/RdFiYIlkAoKVfIolWvvGHyL
YNjFuEEHhU9/IB7IuzHjjYYJV7m8ukgFkEqVGskP6J/LFliJm1KM5B/rJ0sgjCOM
cPQEdlgkxjPU20oitVsnZYMmUtcLJWdyelOyjqIhd8mVCuTUHaU+CPgGuD1hbLvo
ULubRjfgWeBBTOacPlBE/JP8PRVdvUzaixNRdhIUr3eZs5T1Z77q7LPtqzqEtwsa
EyYBVenHnkqil6cO4/1gBNloq8rpdP3HcA0FRpm2bFLHgeMEft+AIB6oewBepRt7
M0jzpi9j+DZSRVCXfy4jadnxJnWIL6lytr7n45Ow+BUFhiRYfYJMNoGe1bv5DZw=
=psFo
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--

--===============2927335234989942990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2927335234989942990==--
