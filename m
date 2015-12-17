From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume
Date: Thu, 17 Dec 2015 12:12:48 +0000
Message-ID: <20151217121248.GS5727@sirena.org.uk>
References: <1450216285-14875-1-git-send-email-benzh@chromium.org>
 <20151216192127.GQ5727@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7010E04FF@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8244848173129792035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5448F2654E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 13:12:58 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7010E04FF@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============8244848173129792035==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XFkHhpX+zY/pUGhI"
Content-Disposition: inline


--XFkHhpX+zY/pUGhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2015 at 05:21:05AM +0000, Bard Liao wrote:

> > This is something I'd expect the machine driver to handle - if it's stopped
> > using the PLL I'd expect it to explicitly turn it off, suspend (or the CODEC
> > going idle for that matter normally, the PLL is burning
> > power) should do that.  If anything I'd expect the CODEC driver to restore
> > the current settings.

> The main reason of this patch is MX-7Bh(RT5677_PLL1_CTRL2) is volatile.
> However, the status bit of MX-7Bh is currently not used by codec driver.
> So, it should be no problem if we set it non-volatile.

> > That said I'll apply this since it at least doesn't make things worse.

> Can we revert it and resend a patch?

Sure.

--XFkHhpX+zY/pUGhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcqa/AAoJECTWi3JdVIfQ2/4H/26jKU1Ydrq8fcUfCPpTbYZm
/ivnGG6pGSTu1+ve7hsQ/s8Ye6Ks8YEPLWCsSKbDMBHRFc4OImMYfozJtAnuxNV0
A7AxPfosq21ybTv1yd6/2+UVU43Dah2LnUbunj+blZzSmFaDdXh2mhyLL7t+jBwq
5pf1ne3iqmCH1h8cY8N06KnqNz/oMghRsRTYBV8H6laBJ7TtgjZmy4+BIJ3WWDIh
TU/naO93WB2UKfOc9AyIKGwFHWLqLvG5QD2/fbxQUCM//XGzM5ZYXw8wEPEKJqRR
6Z9SQGrpi94wLS069kXTB/GncGOe9NGKZw3Jhs+6vsRt7VzbG2DmP9mndE2lWDw=
=ncyR
-----END PGP SIGNATURE-----

--XFkHhpX+zY/pUGhI--

--===============8244848173129792035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8244848173129792035==--
