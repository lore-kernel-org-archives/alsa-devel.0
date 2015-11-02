From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Mon, 2 Nov 2015 12:07:27 +0000
Message-ID: <20151102120727.GD20228@sirena.org.uk>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
 <1446217461-2106-2-git-send-email-vinod.koul@intel.com>
 <20151101025438.GH28319@sirena.org.uk>
 <20151102101108.GL21326@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3539557446528474738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C146261507
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 13:07:35 +0100 (CET)
In-Reply-To: <20151102101108.GL21326@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3539557446528474738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 03:41:08PM +0530, Vinod Koul wrote:
> On Sun, Nov 01, 2015 at 11:54:38AM +0900, Mark Brown wrote:

> > > The UEFI BIOS does not create a machine entry for Linux devices
> > > so add a table style machine registration to fix this missing
> > > entry

> > How does this relate to the existing sst_acpi code?  This might be
> > clearer with a user...

> It is similar but sst_machines structure is entirely different. In Skylake
> case we only need machine entry name and rest of the information is coming

So what exactly is the "machine entry name" supposed to be here and why
don't we use any board specific information?

> from topology manifest data. I will try to move this as well to topology
> data later, but for now on upstream to get audio out from boards I need this
> patch :)

I'm not sure I entirely believe that this is going to work well in
practice TBH.

> I am not sure I follow the comment on user, the SKL driver here is user in
> this

There are no machines defined for this.

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWN1H/AAoJECTWi3JdVIfQhM8H+wabsZ8nslwh3HhWrBOJVPfr
o/vmVzeSbMl6ibrH6qZo+BODtyrnBxJ8y+CSJxajPDo9+giobbfs20SLy4Vlx4At
Pe12SFfH8rbwG3d9wqCiykxtHZ1lDu4/uGoFziTnL+kPg57CioAwOocpr5ThY2OW
+yw7j/gxcJjQ4AQcaIIFbkm8Q+Ey47HOmmQfH7/KiwDxKqUOgp306vPeVFSOrsix
nK2i9ONzOhWoRqVWvSS3Mv98ysZ3KAxQ4IeUizNcxE2qllyvTFWoJrfhbryV0Zsh
cf8+0sEY/kvjRyExmylu6IdzG3sxwwx7JlCD423NOPqv4V6DB2lsDpqEzLj8azY=
=V9tL
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--

--===============3539557446528474738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3539557446528474738==--
