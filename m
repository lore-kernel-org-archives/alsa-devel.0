From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Sat, 15 Aug 2015 07:59:04 -0700
Message-ID: <20150815145904.GE10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
 <20150814203428.GR10748@sirena.org.uk>
 <s5ha8ttypc1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6166720058549609864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AED1926512B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 16:59:12 +0200 (CEST)
In-Reply-To: <s5ha8ttypc1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6166720058549609864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPyQn7mfIBXOql8K"
Content-Disposition: inline


--ZPyQn7mfIBXOql8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 09:37:34AM +0200, Takashi Iwai wrote:

> We can make the topology stuff disabled in Makefile (and the only call
> in soc-core.c) instead of the whole revert.  This will be the minimal
> impact and safe enough.

Yes, though it does leave the UAPI files there for people to look at
which is a big part of the risk since they end up getting shipped
separately to the kernel binary.  Might be sufficient, though - we could
just put some #errors in the headers to catch potential users.  Or
perhaps we're OK with the ABI as it stands.

> BTW, I wonder why there is no Kconfig for topology stuff.  If we had
> it, it would have been easy to disable.

It's probably worth adding that anyway - I know Intel at least are keen
on having the capability to minimise memory usage!

--ZPyQn7mfIBXOql8K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz1O3AAoJECTWi3JdVIfQ6EYH+gO29UEzB/VslGXFAq2+RBbj
Np68F4DQ+3LMgCXZCnbIHNyr0dqOP56/Y3o8HdCzOhw3G9xQYv6P2PSfD2VoiFbH
11zqDmZQbeGB/WQ4HJTUwLs/47GTom6TIfgzxxtVKU6jkSjDQJOzqL1E37ptCIGT
XdwE1gSbU//yhbomLS+abwCSc+AvZpHlg5p4F4P+Qtp9q3Fz2HBkrC2CLUnRHQA2
YBNyocX8J1mWJIoaWdKS7zjNjheqxli14f3ZK9fpXN2CivR39/DQ0pQlZQSYOm3s
PVzf9VlzUlrHtoMNxhbRP4fMr88mjUtrZD7GAg7CI0O0BX7h2ktWU7THO0wpIqE=
=KVy3
-----END PGP SIGNATURE-----

--ZPyQn7mfIBXOql8K--

--===============6166720058549609864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6166720058549609864==--
