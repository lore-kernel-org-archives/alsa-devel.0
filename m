From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: add TA5720 digital
 amplifier DT bindings
Date: Tue, 26 Apr 2016 17:50:06 +0100
Message-ID: <20160426165006.GD3217@sirena.org.uk>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-2-git-send-email-dannenberg@ti.com>
 <20160426153707.GZ3217@sirena.org.uk>
 <20160426161425.GA2885@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0665123988728155634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABCF72612CC
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 18:50:17 +0200 (CEST)
In-Reply-To: <20160426161425.GA2885@borg.dal.design.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============0665123988728155634==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="an18TTCYBDxQZRot"
Content-Disposition: inline


--an18TTCYBDxQZRot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2016 at 11:14:25AM -0500, Andreas Dannenberg wrote:
> On Tue, Apr 26, 2016 at 04:37:07PM +0100, Mark Brown wrote:
> > On Mon, Apr 25, 2016 at 03:17:35PM -0500, Andreas Dannenberg wrote:

> > > +Optional properties:

> > > +- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
> > > +- pvdd-supply : phandle to a supply used for the Class-D amp and the=
 analog

> > This suggests that the device doesn't need power... =20

> no power, now that would be nice! :)  What this was supposed to mean is
> that the properties are optional, the power of course is not. The DT has

They should only be optional if they may really be missing.  We may
attempt to be liberal in the DTs we accept but we should not encourage
sloppily written DTs.

> really no control over how I wire up my HW and I'd argue most folks just
> permanently power the TAS5720 since the shutdown current is just a few
> uAs IIRC in order to save some BOM cost. But I suppose the DT description
> is such that the Kernel can more intelligently handle things based on
> what the driver is doing if somebody choses and implements additional
> regulator/power switch HW. Or did I misunderstand your point?

It doesn't really matter if a given system ends up controlling things
actively, we still want to be consistent in describing them since it is
less error prone when it does become relevant.

--an18TTCYBDxQZRot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXH5w9AAoJECTWi3JdVIfQEQYH/367gpPyBFVghsejyDRuOOZr
8CqQ61D9Y5/f1dSdVhMErNaPTVqiaRRPrxS/7tMEEuh18HR2XiRkgt9rzrxySlwT
lRP1DCParRrhFBVOd751vXkKClGgRveIk+CXc07JZ5OLjXBfyTSjFrqFAGxoKQB1
57vt+uae4Ox3ANqEyp7DZoV/U43HyIjSeI7zidorWlYyTX0y9AjLExmmArR4ei6V
ivVowBd/V2n+KHlokBop5zn9KeCxadvIqcpaq12FBbsJPTkMtPUynBtAAvtyc+vO
Bh+3fRZrOXWwy9hjHZj9W6wkXwGL7xrxHiHSj3YO8wrAiCym3Fj2e7qtb36vqRY=
=dhQW
-----END PGP SIGNATURE-----

--an18TTCYBDxQZRot--

--===============0665123988728155634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0665123988728155634==--
