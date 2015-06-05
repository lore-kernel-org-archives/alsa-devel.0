From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Avoid recursive locking in
 the DEADLOCK detector
Date: Fri, 5 Jun 2015 11:31:44 +0100
Message-ID: <20150605103144.GS14071@sirena.org.uk>
References: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
 <20150603164453.GP14071@sirena.org.uk>
 <CANMq1KCFwFppzAx5NiotP_0uy93Ga436PYEbhhA6iM0JCXWtaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5459485760626352905=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 620F926145A
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 12:31:51 +0200 (CEST)
In-Reply-To: <CANMq1KCFwFppzAx5NiotP_0uy93Ga436PYEbhhA6iM0JCXWtaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5459485760626352905==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/SlKNoLjL08cymhl"
Content-Disposition: inline


--/SlKNoLjL08cymhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 08:53:54AM +0800, Nicolas Boichat wrote:

> > Could you be more specific about the deadlock you're seeing?  This isn't
> > really enough to understand either what the problem is or why this fixes
> > it.  Converting all the per-regmap mutexes into a single global mutex
> > isn't an immediately obvious step.

> We originally reported the issue to Realtek:

Any analysis needs to be in the changelog for the commit and...

> I suggested reworking the register read/write calls in rt5677.c to
> direct them to the correct regmap earlier on (rt5677->regmap or
> rt5677->regmap_physical), before locks are acquired. But the patch
> above also fixes the issue (that is, it removes the warning).

...the above sounds like there's a bug in the locking anyway which this
is just a bodge for?

--/SlKNoLjL08cymhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcXqPAAoJECTWi3JdVIfQ34wH/02fjbVe4UrGfBZrYSHaWEcP
QEca2Q6YDViR/zZvny/CGrU+T1zs0lc71SvmJBHYvspWPxHpTbW26cLfsJI1gE8j
07n5a2Ttpx4yYf874NlLbm/TCm9GfBIUrgcQlvTRrdDo4i3EEIGYKny1NgbHiNGW
se10L4m3xajWKhCGdN7RoXfpRPm3d8SFoKJw4H8QsQlneoptAEPwo8t8kzTXxMaX
bl+aFebCPcM/waIVcBqe+XLh+wGSZZ3gY45SeIarzFZ8G4UlSypYfm2uNhNq9g+3
ZHzJHMLqlXyKMYG4fNUp88+cWdfsUX24CaSLIKhANW3myWizLpod0htSjTjxx5U=
=zHAH
-----END PGP SIGNATURE-----

--/SlKNoLjL08cymhl--

--===============5459485760626352905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5459485760626352905==--
