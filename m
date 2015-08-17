From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
 after period elapse occurs
Date: Mon, 17 Aug 2015 12:55:55 -0700
Message-ID: <20150817195555.GY10748@sirena.org.uk>
References: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0906459125550234843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1F926042F
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 21:55:59 +0200 (CEST)
In-Reply-To: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, dinesh.mirche@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============0906459125550234843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b4c2lVEA12mfheYj"
Content-Disposition: inline


--b4c2lVEA12mfheYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 16, 2015 at 11:12:25PM -0700, yang.a.fang@intel.com wrote:

> We should not read sst hw_ptr and pcm_delay in sst_platform_pcm_pointer
> Since it will be ricky if sst_platform_pcm_pointer is called while dsp
> is updating the timestamp.Now read sst hw_ptr after period elapse
> interrupt occurs.

So I guess there's still some risk that we could run into problems here
if we take too long to service the interrupt and/or the period is very
short?  Is there anything we can do to improve that?

--b4c2lVEA12mfheYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0jxKAAoJECTWi3JdVIfQvREH/R7HsSE1Q6mJWLHEZRjGo1Bs
L6AfbI0X6xisoZqvGvie/+d2ZWRt0LdK2vISHptUZOlSf7iewASE69HSa66qHufI
2jo7grvtsyXU4tp57pUJ5sDg9GxrDmOPQHgMV03yK/b8A6oDtCmnjelV4sL51gzh
YMzfNPPe1QXDCS0zKGpoFP/Jr7dVCQCdJVzE+XpALNd3Uq3HkyQbWOXt+ieiJ/oj
7E9e7E4x4MHyC52XV8O+yotEwfSnCC6rAr02vnjACIl+ZF52J0TCtNYDBCdLB1gF
tLjQtBVEOKf8y/ixVUCZBv/wbrEH+G8pixNEZhMS5Joy9WGqR/YMo5cYyFUvhtg=
=vhcV
-----END PGP SIGNATURE-----

--b4c2lVEA12mfheYj--

--===============0906459125550234843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0906459125550234843==--
