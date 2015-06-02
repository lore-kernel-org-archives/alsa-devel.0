From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 12:07:32 +0100
Message-ID: <20150602110732.GO14071@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <s5h4mmv9r7m.wl-tiwai@suse.de>
 <20150602104516.GH14071@sirena.org.uk>
 <s5htwuqe60j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5229908483907237804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24F29260517
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 13:07:38 +0200 (CEST)
In-Reply-To: <s5htwuqe60j.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5229908483907237804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 12:53:00PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Ugh, and the functions are macros so can't be used directly.  I'd still
> > expect to see these ops be defined in some central place and reused.

> Maybe we can lift up some time later, but it's nothing more than an
> optimization, so in a low priority for now.

It's not like it's hard to do and given that my concerns around this
series mostly center around code reuse and abstraction I'd rather not
have big warning signs type issues sitting there obscuring other things.

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbY5zAAoJECTWi3JdVIfQsIEH/R1YwGXYmgQwDOZYhNmIHRYm
y4V7UDg77r1P1XK+QxZL+33oDouW11xkzX9Ca342VvFlAMtOQ35KiQ1+FD78FJKL
r48tdPlE8NIuOPkxJMOFumSSgmIhEo2fMPk8zRmMZpEybuuzQjWRAdvduzH/ROyY
oPHIwd9vmIZAObMNWzDDpXj/alHVH35N3bWj4gtbPomrOuwD4BOV6qW5BkDXtxUb
LhNdKL5PJQdMD/amJkGjdI4X4/+yhdR2fZXHxmP4dTRwT5NiBKiaIQk77krta96z
84Z3JOuJ4aW9GiGKggkda+lJdv8vr/fhyEDXY9zA5W6kIqEd39zZ2wAzdwPXZbE=
=L2As
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--

--===============5229908483907237804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5229908483907237804==--
