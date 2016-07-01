From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: jack connection decision
 with different insertion logic
Date: Fri, 1 Jul 2016 17:57:34 +0200
Message-ID: <20160701155734.GV6247@sirena.org.uk>
References: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
 <5774CF97.4010203@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0384065141695487095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ADA0264F45
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 18:03:45 +0200 (CEST)
In-Reply-To: <5774CF97.4010203@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0384065141695487095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V8Y3+xXnhQGsvjWT"
Content-Disposition: inline


--V8Y3+xXnhQGsvjWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 03:51:51PM +0800, John Hsu wrote:

> Yes, it'll be more readable. I have a question. Why to add !! in
> front of bit wise operation? What does it mean?

It's redundant in almost all cases.  It translates an integer value
into a 0/1 value (so if you've got a value of 2 it'll end up as 1) by
doing a double not.  This very rarely matters unless you're storing the
value in an integer and comparing it to 1 to check for truth, otherwise
C will translate any non-zero value into true in any logic context.

--V8Y3+xXnhQGsvjWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdpLoAAoJECTWi3JdVIfQR/gH/3Q2B5pS1ZqSfFxCCAhcrRU+
/gqH0I1Z5eFpEoyhGIdJF3smixY5G729iAjUbunrQ920I141fK9P7qQ+aC21hgGY
esKJLZfOH9Ntbpl/8UecwBoAXMzjQraZ97qLp/jO9e4Xw9QwtG1d5wsd4OxzLpab
hMVbttvv3m4fZ5GU8kWmslr/2i6KGOe/gQ61sPEWk94BXAUpTTtIMWsokK+Frrkj
7DmbQXKli7E0U0n1GxMeDQkksgnvgzU8QaxMkf90BSLWnPJTKKzwvYfXvxfLqLuR
ZD61hRknDHpRTiSMPZWOorXVyM85L8wl+7eK1TQXCNZPev5vnrODXokj3/EV94o=
=eM5p
-----END PGP SIGNATURE-----

--V8Y3+xXnhQGsvjWT--

--===============0384065141695487095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0384065141695487095==--
