From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 11/15] ASoC: hdac_hdmi: Don't fail in
 dai startup to make userland happy
Date: Mon, 15 Feb 2016 20:55:21 +0000
Message-ID: <20160215205521.GE18327@sirena.org.uk>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-12-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3546907972867028794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D65265062
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:55:59 +0100 (CET)
In-Reply-To: <1455243375-16067-12-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3546907972867028794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2016 at 07:46:11AM +0530, Subhransu S. Prusty wrote:
> In dai startup, driver was checking for ELD and would fail if no
> monitor is connected. This causes userland like PA, CRAS to be
> unhappy as they scan the device list at bootup.
>=20
> So move the ELD check to hw_params and fail, if valid ELD is not
> found.

Should this not be sent as a fix?

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwjs4AAoJECTWi3JdVIfQ32UH/iArBFofsI/LnW7goi01PXqt
eHQd0I7eBbIvey6ALkuYrqPv37ENmGCp2GQUHC8Ul7uO1L2c6gWIVt24ENQCgwAn
VhPFLq/zhwqoKd655wUaYvUydt+blZ6JgJyTG0pZXtLoD53Y+LcLFIA/KBlK+HnH
Jy178bunI5B7vdHGMHfiQrg2S5X3MK9KuMPfBxV4opjazCxFvavvI9z59UXi4Opq
pGGoYA/iQqe53yzElWnP/XtRh3nILx7TgJCGJrg6ZQMlY92ImwoYaHhTj+otBwo5
Qa99ScO2VAR0RVR7bYkP9v3rmdBhof3cjHSMu6QMwBMTSMLrBYa3BlvGOuz8/HM=
=7PXQ
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--

--===============3546907972867028794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3546907972867028794==--
