From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Create dynamic
 instance ids for DSP modules
Date: Wed, 14 Sep 2016 17:43:12 +0100
Message-ID: <20160914164312.GC27974@sirena.org.uk>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
 <1472042001-9582-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6410344562734759126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E5F261B03
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 18:43:24 +0200 (CEST)
In-Reply-To: <1472042001-9582-6-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6410344562734759126==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2016 at 06:03:17PM +0530, Vinod Koul wrote:

> +	if (!(mask_val == 0xffffffff)) {

Why is this not a != comparison?

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2X4eAAoJECTWi3JdVIfQxmgIAICWjiQDkHGAGHmIzVner7QW
WhwR2lid9S6QuWuAAcTgy17GQ5aF+IAaWJnmsS6hESQXE7/w8KDbs0RBvHrWOTPZ
vZqENW8htwDLjSI2Ln5jorq3jPVjTycQ6I3y7HZC5WOapxszabHsZx/Uh5TtmSvj
TLwef6/WE3jtyJ6K8dIIs1Y8qRLk/Xas8A+Y+1tFgKpck33puILuLX5sP7XUttfx
h0mYq37d4xM/PJG2A82iSOuzax5Ee4g9B9zwg0CK04/jC7UWliqiEMM45o6xOU3S
4SfGMMzQSdnMB1BIwxgB/+uKRvysU7W915FOMCaq7996f4F3zTchI6r/dnyE8oU=
=LfVg
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--

--===============6410344562734759126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6410344562734759126==--
