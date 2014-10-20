From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
 and management
Date: Mon, 20 Oct 2014 16:29:00 +0100
Message-ID: <20141020152900.GS18557@sirena.org.uk>
References: <s5hy4seucfk.wl-tiwai@suse.de> <20141020054149.GC28745@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4696189234100384960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF610265A9A
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 17:29:32 +0200 (CEST)
In-Reply-To: <20141020054149.GC28745@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4696189234100384960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D5tFrmRBv7YOLFOK"
Content-Disposition: inline


--D5tFrmRBv7YOLFOK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 11:11:49AM +0530, Vinod Koul wrote:
> On Fri, Oct 17, 2014 at 02:07:43PM +0200, Takashi Iwai wrote:

> > > > > I will work on moving memcpy32_toio to core and move users as well :)

> And I did prepare RFC for that and had to trash it :(

> Turns out we already have an API for this in kernel.

> While adding the new header, though it should be io.h, stumbled upon not
> much used __iowrite32_copy() which seems to be the API I need.

> I am testing it as we speak, will send conversion patch today.

Probably best to send patches for the MTD devices too while you're at
it.

--D5tFrmRBv7YOLFOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURSo7AAoJECTWi3JdVIfQaO4H/iTrSr2/FZ1V+Dxsai5ogiUF
PQMaU1gNcdxjHTYZ7xsgSl2f1IgLhsggPjYhXAfm0Pke6zrGMkb1lcSQB3D2zZ6u
XpNLYe7bAvZGBm61US0+Ry/FhmlkmEEMmGh0+l3T9gXC8HKzp44w/6EHv3nWHXl2
PAfVqbkqit7K3klClYpys5nSb+gCdIKaGNpE5pdYwsLhruxqs2cKPBgs1szlo2JT
K4voZ3MjCLVCyLGstFV67sw5wp/KmLkRsKkEXvyJgJYX0VRN5lDc2u901kprxk3+
B3DGDp/GrLc7UCawKJc+57g7qCtV/jo+icx1DRssoYm029rSebWZx7D9IgwR59E=
=iToW
-----END PGP SIGNATURE-----

--D5tFrmRBv7YOLFOK--

--===============4696189234100384960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4696189234100384960==--
