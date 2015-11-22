From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] ASoC: remove SND_SOC_BYTES_EXT
Date: Sun, 22 Nov 2015 21:47:34 +0530
Message-ID: <20151122161733.GP25173@localhost>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
 <s5hlh9ve7n0.wl-tiwai@suse.de> <20151118181953.GX25173@localhost>
 <20151121140828.GK26072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2893391173999179555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D9D5F264EFF
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 17:13:47 +0100 (CET)
In-Reply-To: <20151121140828.GK26072@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2893391173999179555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2015 at 02:08:28PM +0000, Mark Brown wrote:
> On Wed, Nov 18, 2015 at 11:49:53PM +0530, Vinod Koul wrote:
> > On Wed, Nov 18, 2015 at 02:53:23PM +0100, Takashi Iwai wrote:
>=20
> > > Hmm, won't this break user-space?  Both use the difference access
> > > methods, so I wonder how they can be kept compatible.
>=20
> > Yes they will, so should we then keep these and mark SND_SOC_BYTES_EXT
> > depricated ..?
>=20
> > Mark what should we do with these
>=20
> Yes, that seems like a reasonable approach.

Okay I will send a patch which add comment about this being deprecated

Thanks
--=20
~Vinod

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWUeqdAAoJEHwUBw8lI4NHb0IP/Am5wOg36eHMVklO//uiiMyG
SnCY905aVpWU9sSv85/NKIASq+7YelKL8Sadq2Sl/3c63jbDrPABrBUsh57r8rrv
lLJoahwsvG5/uQGvgE/Gzb4pOm8JkfnLkX6fZlHpg3EMmilnw9+ADljiZmTuKlTw
82wVHpUuX0yNg+8FopsJOd/zGR2MWLgbOBJ8gwqi749xc0LHzpdODQhnpdzUUw3l
dmAuSFo2RFf58m3Wmct4AgKI1SgDMIquGHoIoc0B2NHMMCCaOs/Ge9Z9SKyTKq4j
f2EwrEJeiQQeb4b49MFBsEsyROWtrIMFxGtCtWhNI2dxaXiytqbS0O7Xae8YrBxl
DhcFSVGjJkoJtS/ZcWwr/5wuGnd5+WC6Egcr97rr7mgeKEuZazvxtMc7rlpZqlav
UnqpWUd2tkTyar7PUFZcc4Q9x3so+nH+3GLpF4CD/fKcdLOcKdotQ/PHOQcuoYBN
HteKyHHPOXYgo7e2OD7RuRxCytqzu/s9rP6waBEIyQGvRFhmIU2gKSNFC/oNoCk0
wvyOAwLad/l/CDragzk4+d3wvhgMudRR9JNCFvp0DuRpeILCCxVPFSDJV/XHU9lv
unjtH3g5oiseEFvP/gr90mE4HGyLJDa33w9MtTrWUSDqfPV0PQd2XhITfq6UoCgb
w/rCX4r/+nUQ8yTCMM1j
=+Pv/
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--

--===============2893391173999179555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2893391173999179555==--
