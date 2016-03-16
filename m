From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: remove call to
	pci_dev_put
Date: Wed, 16 Mar 2016 16:18:53 +0000
Message-ID: <20160316161853.GZ2566@sirena.org.uk>
References: <1458144438-28912-1-git-send-email-vinod.koul@intel.com>
 <20160316160717.GY2566@sirena.org.uk>
 <20160316161605.GX13211@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7801418757473779030=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E42266507
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 17:18:58 +0100 (CET)
In-Reply-To: <20160316161605.GX13211@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7801418757473779030==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CjAlqr6ZqJYkDGFX"
Content-Disposition: inline


--CjAlqr6ZqJYkDGFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 09:46:05PM +0530, Vinod Koul wrote:
> On Wed, Mar 16, 2016 at 04:07:17PM +0000, Mark Brown wrote:

> > This doesn't seem to apply against current code (I don't have the
> > relevant SHA1s for the dependency) - can you please check and resend?

> Thats surprising as I amended the commit in last series and sent this one. I
> will re-fetch your tree and do this again.

Is it depending on some -next only stuff or something?

--CjAlqr6ZqJYkDGFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6YdqAAoJECTWi3JdVIfQoEwH/3hh2MXS1vsxpJk5mEolpdXk
GT0Nigo3JK10Eo3xI04hXhtBBkEtQLIN/Kjhh8iWB0wAVr15OcYmMQRKYaiRu1QC
S3dspgcAQV1tR7BUJiSJwks75cukLfFryevlZVXRtsDTHBf3erMvn9zgupEJcL3U
g8l3/m4nEkjb65bYhFKTTYOAE0a9R79jPT9D7Kegxj+n6jNZJAxyxPQUFQY3bBPq
S8i17288OMHpBfdTwgNNNJXyBamncvC8BJgyVWVQo2FBRH+Edf1Hdt+OE3DX/nni
gGP6lAwI3ng5JBBtuvsDqm/agEa4Ye1STn4xAozJaKI1ZThWBmFCdH9PleJxW1U=
=sda4
-----END PGP SIGNATURE-----

--CjAlqr6ZqJYkDGFX--

--===============7801418757473779030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7801418757473779030==--
