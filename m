From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 14:57:53 +0000
Message-ID: <20160316145753.GW2566@sirena.org.uk>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
 <20160316100829.GS2566@sirena.org.uk>
 <20160316105244.GR13211@localhost>
 <20160316110310.GT2566@sirena.org.uk>
 <s5hwpp2d5ar.wl-tiwai@suse.de> <20160316144405.GT13211@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1304200691350902430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 854CC265B54
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 15:58:03 +0100 (CET)
In-Reply-To: <20160316144405.GT13211@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1304200691350902430==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5KENZRfAmuo1v8rU"
Content-Disposition: inline


--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 08:14:05PM +0530, Vinod Koul wrote:
> On Wed, Mar 16, 2016 at 12:35:08PM +0100, Takashi Iwai wrote:

> > Maybe the document is obsoleted.  The PCI core, at least the probe /
> > remove via the normal PCI bus, takes pci_dev_get() and pci_dev_put()
> > already there.

> Yes that is my understanding too, that is why we removed this from driver
> here..

> Mark, is this fine now?

You might want to put some of this analysis in the changelog.

--5KENZRfAmuo1v8rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6XRwAAoJECTWi3JdVIfQFxkH/A5FjXC96+3IEBdkbkL+r4XE
GCotWijibFW1BPeBUwTAEoNFbjediw+2blyO8btp6613BzsjQ9NS1dxrOHPV6wct
6GA/flDEIaX4wmRZGBx6i7BXrx0NMeh+911pCqQJ+iMR35KHM9jn/3bnyXT1yz0O
lr73id2ed9VpKcwjIGNujHR9zUlwqg2Wa31CiXMTgYI6dqACs2yQELE2iF9myUdI
MH4TnxlsLkrjsWRpd01a845HUlisRaOOuZoki39X82ssYsRWdm3sl+rXC/3yasm0
5n70KtNdRcpN7kg9zGFrgj0px/ek7sVKcGA2+MhFAroeMilWpG0gykIiB9JW8sI=
=NMtP
-----END PGP SIGNATURE-----

--5KENZRfAmuo1v8rU--

--===============1304200691350902430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1304200691350902430==--
