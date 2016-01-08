From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 6/6] ASoC: hdmi-codec: Use HDMI
 notifications to add jack support
Date: Fri, 8 Jan 2016 12:55:34 +0000
Message-ID: <20160108125534.GN6588@sirena.org.uk>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
 <1451935145-24861-1-git-send-email-p.zabel@pengutronix.de>
 <568E9BE1.6050209@ti.com> <1452242629.3347.12.camel@pengutronix.de>
 <568F87F7.3010409@ti.com>
 <20160108104623.GF19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3523294629709587610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8874A26040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 13:55:53 +0100 (CET)
In-Reply-To: <20160108104623.GF19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============3523294629709587610==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qw1jpiGhEv1c2/gd"
Content-Disposition: inline


--qw1jpiGhEv1c2/gd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2016 at 10:46:23AM +0000, Russell King - ARM Linux wrote:

> Given that, I'd like to throw in here another detail: iirc, i915's
> HDMI exports the ELD to userspace via a control called "ELD" - see
> eld_bytes_ctl in sound/pci/hda/patch_hdmi.c.  This allows userspace
> to monitor, and read the ELD including which compressed audio formats
> are supported.  I'm not currently aware of anything that makes use of
> this, but as there is this precedent for exporting this information,
> maybe it should become a standard way, so that video playback
> applications can then select an appropriate audio stream depending on
> the current properties of the connected device?

That makes sense to me.

--qw1jpiGhEv1c2/gd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj7HFAAoJECTWi3JdVIfQORIH/0YNaiR4C4XhfP6fBuOyvCzr
x+MuXmoQ8BELTKhbMCzEta+HR/3HDpZZ8Y7uVUP9OjECJK12R0QgRbspUpj7hIJO
mgfMgXA84Y+JdykfLTmaBCL/ubsnPDmCBKCj5DymqqdZ8H1dvCkmg0qL5lQ0tfuA
CrAj41C3z3+DN5cDrk5hVMGBmmHmXoC+3p5QRBdHUCgJ/Z66YHAqkOpYHPh3fbxa
ZSLs0jj1YhpH/maR3wKYbILTNuz99BTbsglvAv+jEUjYC80BZIn7CLT/1YQ++jKA
0+/H5xGwfyC5oOwyCQVM+IBNzvlw1tOEXTnVY7SDpLO4J16V5LS1BM9LHL//eCw=
=FgyI
-----END PGP SIGNATURE-----

--qw1jpiGhEv1c2/gd--

--===============3523294629709587610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3523294629709587610==--
