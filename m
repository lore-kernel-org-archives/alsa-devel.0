From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Mon, 27 Jun 2016 18:30:09 +0100
Message-ID: <20160627173009.GF17217@sirena.org.uk>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2540350201092361618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70DD626669F
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 19:30:15 +0200 (CEST)
In-Reply-To: <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
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


--===============2540350201092361618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:17:55AM +0530, Subhransu S. Prusty wrote:

> Stream tag is unique stream identifier for each HDA stream. It's
> programmed in both host and codec to identify link the stream is
> transported.  The platform driver allocates the stream and calls
> this ops to program the stream tag in the codec dai.

This seems incredibly HDMI specific...  what are these tags, can we
represent this as TDM (which seems to be what this is really)?

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcWKfAAoJECTWi3JdVIfQETMH/38Fk2vfo83Y+sLfG5ap7rHh
O31YiVRHXs2DS0z08uqMh1zAYEIW5rT9xImHiaUTY9faKab6dlRj0HHAbz+EP3N1
kacftFIBQ1Iagb+qHB32GHj2qeoYgu880F0uCoKFqL4A5TLQ/1X1Z3HpCQLQ5mMx
j0gv2wWfLcaCY5oxV3CfKOE3OMFHFo2jZOz/NjV4jVu7UCukLXDsyzdKRr2F+f/6
UKCHnuI4HxuN7lZV/luUTxmQ6W+Z6TZpf4CQR6mZvsPy+oSW29UGlWEpO7aIMg4D
AshXVSB6qDtbfeLy2a7Vo1DxOaS6B2gj8txTgGNLC7rKi9Fyh987dr786ZuPKUo=
=/987
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--

--===============2540350201092361618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2540350201092361618==--
