From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse
 ELD from HDMI driver
Date: Wed, 27 May 2015 12:43:33 +0100
Message-ID: <20150527114333.GD21577@sirena.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4615583935014568713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16A50265998
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 13:43:51 +0200 (CEST)
In-Reply-To: <20150527104308.GA8341@phenom.ffwll.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Yakir Yang <ykk@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4615583935014568713==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="517pCzpsiLFBzq6n"
Content-Disposition: inline


--517pCzpsiLFBzq6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 12:43:08PM +0200, Daniel Vetter wrote:

> Just curious questions really, I probably don't understand what's exactly
> going on. But I do think that we need a more formal way for drm/snd to
> talk to each another (i915 is growing quite a few hairy things in that
> area outside of eld atm). Problems we have are around shared power wells

Yes, I agree strongly with this - I've been asking for a while for more
code sharing and common code in this path, the helpers in here are
really good from that point of view and I'm very pleased we've got them
applied.

> and clocks (x86 doesn't help here without all the dt goodness). But
> there's also stuff like figuring out the right dividers for a given
> audio/video clock. eld and hotplug is still done in hw, but I've heard
> noises that we need to have a sw approach too on some platforms at least.

That seems to be the case, yes - FWIW quite a few of the embedded
systems are basically connecting a standard S/PDIF or I2S output to a
HDMI encoder chip or IP block so the audio controller knows nothing of
HDMI directly.

--517pCzpsiLFBzq6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZa3kAAoJECTWi3JdVIfQ+LkH/i7CSKsKIBwWIVgPk6ByfUrb
WxSdM0v/HwKIEoldDGhfPy++mjJl1e179GcNvuV8VdS+uAZYHR4CqkmHj8juXsKF
ySX7d5qJ2QrWj7KikcAeM+srz5NM9vNhlcnJXYPSg8X3dbo3zC+W9wajhJj1grO1
J8soaTb/9/bf8511jHb6mZLXC0VxEejIBPz7vRPuwCaeJ7ix+3BWHqoLtR6w5l/v
FQcc4zz4ZxPgbAuaY1+VLK+UtPAKvwmzQSUSD3tkasS3cquX1qWe4c9AL/obDVSB
yq6r2IetHGVUveAqGi5nQCTbGqxwtSAqIlAbR4/c+rar/q1fdM2U+hoJxWb3h4M=
=sbRY
-----END PGP SIGNATURE-----

--517pCzpsiLFBzq6n--

--===============4615583935014568713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4615583935014568713==--
