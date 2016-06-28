From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Tue, 28 Jun 2016 12:15:20 +0100
Message-ID: <20160628111520.GL17217@sirena.org.uk>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8544202245698825418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7520A266E50
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 13:15:30 +0200 (CEST)
In-Reply-To: <20160628052138.GI14022@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8544202245698825418==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Content-Disposition: inline


--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 10:51:38AM +0530, Subhransu S. Prusty wrote:
> On Mon, Jun 27, 2016 at 06:30:09PM +0100, Mark Brown wrote:

> > This seems incredibly HDMI specific...  what are these tags, can we
> > represent this as TDM (which seems to be what this is really)?

> This is HDA specific and the tag is to support use of same DMA channel by
> both host and codec.

What is a "DMA channel"?

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXclxHAAoJECTWi3JdVIfQVB4H/A1ByMBqNwE1C5JZfTJAx5U9
b3xW4JvzBYuL7pfiA/Y+eqaxEPcHmDTXbWgT87EyuMhyrXFEhul8k/fOTUGzGLi5
zI6ga0jKVPG1WFgWVk85/tPPClnBC8TE4KCrcjinIr35Ilu7BdLwBXhtVvA5lb5O
wykEjzG3U02SEiD0Yxlexlp/yz44nl+hFmxWN4xsHnPQHOn/DRTJWNCzexV48uUN
OqUYPUWuQbXxjZ2LKtiwO5wurrmkwrruZQGx6YItsAi1vHnqLTD71D8jPgXauBDS
MjahIGDboxrXVj4wE1aRDXinEGO1cQDsXvvXJwNYbE7Xvq9VQ0lXGArfwJiGCr8=
=GIZq
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--

--===============8544202245698825418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8544202245698825418==--
