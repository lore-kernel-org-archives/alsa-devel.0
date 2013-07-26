From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ALSA: SoC: Updating jack
 implementation according new ALSA Jacks
Date: Fri, 26 Jul 2013 19:50:23 +0100
Message-ID: <20130726185023.GW9858@sirena.org.uk>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-4-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0267290613172657012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFE22610D2
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 20:50:26 +0200 (CEST)
In-Reply-To: <1374863133-6745-4-git-send-email-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0267290613172657012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lLYmlcOQv78n9rhj"
Content-Disposition: inline


--lLYmlcOQv78n9rhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 11:25:32AM -0700, Felipe F. Tonello wrote:
> From: "Felipe F. Tonello" <eu@felipetonello.com>
>=20
> ALSA standard jacks already are implemented using ALSA KControl.
> So there is no need implement that itself or to use snd_jack for input
> events only.

This changelog doesn't correspond to the code change - what this is
doing is updating the ASoC jack support to add the ability to specify a
jack index when creating a jack.  There's nothing to do with removing
duplicate kcontrol creation here at all.

The change itself seems fine but it's not accurately described.

--lLYmlcOQv78n9rhj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8sTrAAoJELSic+t+oim9jnAP/iG+7C8fHAL1I61ptK2dL8P4
4WjyK101T3gfaHOn2ApBFqH5WKT/7HaQ0/d4nEwUoxs1I3DsWkQxqydjRtcT/6O+
4qhqAONAWc4B0yyGZPRDwRAeuOC76+tMYQ7OpmiDP4tqFbzJtEHD1wmzg1+PxeLD
jGXJ1MyTtO1u+/U8jMyx86oODqQz5GVVAsg7ti+Wz4D28+s8EBVQwl5+9MprvGu/
1nZsrE1V2c3uvclKiJZ2qlYDs6RKckCRHQZBXwuRp63U7QAhJjJ0/UeiJ1v5paBh
KHdsiQwM7Grsqm3/7BmbOMYh9Pxj/IPGSePDvFncSaYJQzOZXA2kEwJKjmujAQhf
tVmkP+uDJOZMMYD+BoPrrHBhlOAjSfrYR3065MoCDac2XAN3uqvw2zZZc0nucDC6
ig0RXgAt0IcoNOcw5hd6iR/a0JLLq3ySZK67IcAayCVHUrH19XP+vGErSWT06tw4
qkqDjSmjSwOLmHy7/i8XT9Z2fNHGxiE4NM1RV2xBPaxhGsUxgCk/omJaVwD2R/eV
MPtzUJN3pl52L3FYCR+Wj5WFSvoQSKrKSaVXF50rGFzOOVqFgITsUJNNEloTaGg0
ftGWJn7IFf3PG/cKXdn/oapO1nkBPrr4aWPLsMt03cp6NMarAdSxJ6Vcnb2TBts0
Ju9j7meG4Ysnaui5Yc7R
=afiq
-----END PGP SIGNATURE-----

--lLYmlcOQv78n9rhj--

--===============0267290613172657012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0267290613172657012==--
