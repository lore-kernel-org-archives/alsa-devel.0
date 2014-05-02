From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix block allocation so we
 only allocate blocks once.
Date: Fri, 2 May 2014 09:52:09 -0700
Message-ID: <20140502165209.GI3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3756706727095038789=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C95B7261AC1
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:52:27 +0200 (CEST)
In-Reply-To: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3756706727095038789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K21dSG0a048FVyHJ"
Content-Disposition: inline


--K21dSG0a048FVyHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:27PM +0100, Liam Girdwood wrote:
> Make sure we dont alloc blocks twice with requests spanning more
> than one block.

Applied, thanks.

--K21dSG0a048FVyHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY802AAoJELSic+t+oim9sbEP/ilyziy9N39lclDDhh2yAZAz
sibEuA4bzf4KNXKIGojLtjv7OGi+nBMfrNS0uhHtLDW8P3YSMkkSWLLfanH1sd0T
63cl7RMVrzaoR3T4iUx8SY2ip1exxYy5F9hh75D7LqXOh4teScTfVFm+0wSs3Dzt
ttxGFrpjnpHa4BonrVVAEBNY+NFjMzhfvqTVNUQcE6lrTriyORabP3XPynxS2MZv
0EcGfqgtc3KPHX+NDvWQuHyOA5bZUicynSNYanfmw1vpzwwvuTq6SXkAoeaGS1MP
fwdqlTSYpY0z2a8bhVmprHuH0S461wHaCMqfOQgEAiybf7Sq1L/11zsHDQkPr6g+
ewVCz98ZneSCGuulMnrQlj5PkAJBu127hwQ4vd90d9e6C41bwXc6l8kz7t1ZjnL9
QBeKtCc8RHAOV8akeiZM8JBpSYzqalG0wuIvizgg+AIgTcLlfpEdbqpcNhHnMtw8
ikIEgR5v8bxqLXKpddTO5P5jA1Eq7zCQtq04wK08CnnbNSqOJNTF5Y2lzv/tkVb2
GigsmaMx9XESAj9rXF/WliOZk6t4BzCGxtJJUSBs4t3OUC2Nv0i1+WMBQglm72sX
hP8yOjOBLnjRPCFuMKZ1A+fY6Ao0J8I2nBe3AVdaNynrz/peWg13MBRrbZtbNL7f
o+53aRQw+xJ0e/MPmWQa
=wgE7
-----END PGP SIGNATURE-----

--K21dSG0a048FVyHJ--

--===============3756706727095038789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3756706727095038789==--
