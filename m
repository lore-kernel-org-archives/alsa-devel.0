From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Fri, 7 Aug 2015 18:20:28 +0100
Message-ID: <20150807172028.GJ10301@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
 <20150807102508.GL20873@sirena.org.uk>
 <CADnq5_NihZCFEaL150Kt0LWCUBp6eQzne-O0JcCFE0-vHj7ZBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1197025224726245077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97E262606D1
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 19:20:37 +0200 (CEST)
In-Reply-To: <CADnq5_NihZCFEaL150Kt0LWCUBp6eQzne-O0JcCFE0-vHj7ZBQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Chunming Zhou <david1.zhou@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, maruthi.bayyavarapu@amd.com, Takashi Iwai <tiwai@suse.de>, Felix Kuehling <Felix.Kuehling@amd.com>, lgirdwood@gmail.com, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1197025224726245077==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 10:17:36AM -0400, Alex Deucher wrote:
> On Fri, Aug 7, 2015 at 6:25 AM, Mark Brown <broonie@kernel.org> wrote:

> > Looking at the code I'm not seeing too much bus specific except for the
> > above which looks like the sort of device we usually represent as a MFD
> > (with the MFD providing resource distribution and arbitration between
> > various component devices which fit into the subsystem).  Why code a new
> > bus for this device?

> Adding Felix who did worked on the design for this.  The idea is that
> there are hw blocks on the GPU that are controlled by drivers that are
> part of other subsystems.  Those drivers need access to resources
> (e.g., the MMIO aperture) controlled by the GPU driver.  I guess this
> is a MFD of sorts.  If this is not the preferred way to handle this
> type of device, what is?  Can you point me to another driver that
> handles this differently?

Yeah, this sounds like a MFD - see drivers/mfd and take a look at how
the drivers there deal with this.

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxOjbAAoJECTWi3JdVIfQIHEH/A/ySskcHtHBsUE4j4YlVdeY
v7QrzGzkNuGDRVtlO/kFIUd7rAhdeQWl67HFZgZymaqwEfefDqEkrD8yznmkXAp2
uFpSk1VJJoE0HjcjgoLJ4/GfBHhh/2iKb236qG+OAssHVYH10h3Xtx3JJgxk04xq
gzsJq6Suhe8LJaVJnYVRCCeA9GA6WoHHVBSDJktKwwNHR+hJXxjlNLZaxGAmt1nf
71hKiK9y+S8TdmVyg0kQC2BKzA8fPpUH4Chm8++jMdzHRahET2wJ2TSyjqH/JN5G
LSPOXkksj42xMKygT9EwBEcgvhggZN3WoMd8E8m3+YYi5Y84RrVSubvfuvm2mTo=
=pZsk
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--

--===============1197025224726245077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1197025224726245077==--
