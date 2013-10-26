From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT
	support.
Date: Sat, 26 Oct 2013 12:48:40 +0100
Message-ID: <20131026114840.GX2443@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3643141271045628572=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D96A22610C4
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 13:48:49 +0200 (CEST)
In-Reply-To: <20131025191513.5345BC4042C@trevor.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3643141271045628572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wpclBcJ4x2yUw58h"
Content-Disposition: inline


--wpclBcJ4x2yUw58h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 08:15:13PM +0100, Grant Likely wrote:
> On Thu, 24 Oct 2013 14:13:49 +0200, Denis Carikli <denis@eukrea.com> wrote:

> > +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
> > +- mux-ext-port : The external port of the i.MX audio muxer.

> > +Note: The AUDMUX port numbering should start at 1, which is consistent with
> > +hardware manual.

> Looks okay to me. I've not been following the sound bindings very
> closely. Are the described properties a common pattern for sound complex
> bindings?

They're standard for i.MX - it's a mux within the SoC.

--wpclBcJ4x2yUw58h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSa6wVAAoJELSic+t+oim9muwP/0iD5Ket3S2v1hCYZka6CVfH
Q4UIIwHE/jLq+EiwzkSE0X408MeGLufVsonB4sDeYKwjDNgn/e8+BxQGBri39h2Z
InWUGvNuQqdgAfxZd0XbH4156UKWBf7jefd29L/wzLm94+QpPq2tliAVJtMx0qzF
tvl6aLLAynHvWQJvKcGLYeJVCy/Yjex9uJtzJ8wLfWNxJ2ZVINxQHp1eBhpJsjF4
0crAuCgthhRAAVl/dkCPVwkBYPbUIGPfFUAgSEY8ovBcuLuTY9RlOz4TmFhMO6I9
sSOFBmEnJEHI4x7Spr/4JF8+5HdXRabZ/8ajMC8IC3UDlQlslJc4hYQai47g9Tig
q3EoiD+K4qVDmGC39w5TjlkPW+iH3/ZnI4YVpkPxn8ec9iPxB32p7vkaMAKMevug
Cqh6lW4jXSO090OEjb2sD6J0oKtVTViXISNTHFhY5L5umKEvB18PjvH3g2ukizO+
V/TG78yfuqRu+we2X5RsbkynDpsYf5VSTSwvxH69fXRcWQx9l7eoAFXQhOSszw3Q
J/XW22ZqbhoQdt9ljDNEdyknq9DN5M27lwla2/8V7IfyFoDHNUeNeOp9+eit07H8
F62irQsTgdq+Ebl/q3YIkZcKqg/NNV8HovxcAroP/I2gL0GXR9nxL4Vk6bR2Rhyy
vyjZsfMkYVzPAgfVqGo/
=6OGO
-----END PGP SIGNATURE-----

--wpclBcJ4x2yUw58h--

--===============3643141271045628572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3643141271045628572==--
