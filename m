From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: max98090: Couple improvements
 and ACPI probing support
Date: Fri, 16 May 2014 20:01:49 +0100
Message-ID: <20140516190149.GS22111@sirena.org.uk>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6962598074446717176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF0CC2615B6
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 21:02:04 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6962598074446717176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvMLM4USzlj3SVKc"
Content-Disposition: inline


--gvMLM4USzlj3SVKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 04:55:18PM +0300, Jarkko Nikula wrote:
> Here are couple improvements to MAX98090 codec driver. I think only 1/7
> is a real fix and rest 2-7/7 are regular updates that make codec resume
> working and add ACPI probing support on Intel Baytrail platform.

Applied all, thanks.  All the patches up to 4 look like good fixes,
being out of spec on reset is a definite fix which I've maked to stable
and making sure that the cache is synced correctly is going to be
required if power was lost.  The initialisation on resume might not be
100% required but definitely seems safer too.

--gvMLM4USzlj3SVKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdmCZAAoJELSic+t+oim9jGcP/2kAjpD1DZ0evR8WnDlIzgsa
/ls7RpYMfyv4ZBZ8uwwHBsrnv4L4+zug/3cOrmenGvR90Bz4s9b/6u2+6s1Bs+JT
uxuhU0Phn80OrQsdmI8XmL1yBdXhoPP77O41JL1HCV+NWpUAA3ZLPDgA9LP6U/2w
JAH9Cv/k9VqtpnGo2TQyKEO4YbojTmvq+mT3x86nnPTZEx8sNDLKnHRbW+2yzBXE
GFGMMGy/Zl8CL+LM025GQPpx+lljEaOu8KUAvjfn9r/fodKYuSrczbsY6j3icmfC
apRuExr71TW+YggkP2x3NDM6gRINgQvBA89OvIWiAjiCtGyvMW5ftb+ZCA1fyc4c
aO9jWBy5BD6tkjXbUNn0jtL5jddpDJ/f/SOKJKmtzLpWXzw/Ffza+sbF7lCTV5ij
OYWWvS8cbOkeopbMyIaqbBlmtmvIsaUlcn+h84qRI1l0G+m+MGMbnDCKqnl4IBFT
yUmw7FRvCBOi6OCfnSSOnk+BE9mZoequr4gFGjOEhPx/6qSQWD9mlGXKVxBDJWj/
4JMzT31fpKSHrwt7x60368gjzUEYSEc/BlL1iRfyKaWldUK9ic4HhfC1KC80HxMh
nsTe8jOjGS3sRQTmTzEhKxBGwoAU/c+5c9Emi3eZleu1/GgUVhiZ83nL3xP6lpxT
afUOuVSTg7LEu6CUqXYX
=kL57
-----END PGP SIGNATURE-----

--gvMLM4USzlj3SVKc--

--===============6962598074446717176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6962598074446717176==--
