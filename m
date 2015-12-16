From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume
Date: Wed, 16 Dec 2015 19:21:27 +0000
Message-ID: <20151216192127.GQ5727@sirena.org.uk>
References: <1450216285-14875-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4444021418523178424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD1EB265716
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 20:21:35 +0100 (CET)
In-Reply-To: <1450216285-14875-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============4444021418523178424==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkUjpNzvt17RSo84"
Content-Disposition: inline


--vkUjpNzvt17RSo84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 01:51:25PM -0800, Ben Zhang wrote:
> Sometimes PLL1 stops working if the codec loses power
> during suspend (when pow-ldo2 or reset gpio is used).
> MX-7Bh(RT5677_PLL1_CTRL2) is cleared and won't be restored
> by regcache since it's volatile. MX-7Bh has one status bit
> and M code for PLL1. rt5677_set_dai_pll doesn't reconfigure
> PLL1 after resume because it thinks the PLL params are not
> changed.

> This patch clears the cached PLL params at resume so that
> rt5677_set_dai_pll can reconfigure the PLL after resume.

This is something I'd expect the machine driver to handle - if it's
stopped using the PLL I'd expect it to explicitly turn it off, suspend
(or the CODEC going idle for that matter normally, the PLL is burning
power) should do that.  If anything I'd expect the CODEC driver to
restore the current settings.

That said I'll apply this since it at least doesn't make things worse.

--vkUjpNzvt17RSo84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcbm3AAoJECTWi3JdVIfQ9NMH/3GXEHiNwJIudCNFMzxvqiGt
xunwE+P7MzwKUffulZRgiA1AJjxnbxXoCn9EaMu6fxwWscUAsMfHfFSm5hnkW5eD
0aXOdXTCGSYXkhFxZ27P+MCv/zgcpH+UAh15V0YEeixmFb1djF4oNTyLNzL1Nb0P
fVeBVz7tlFnwS6kpFRvgYGU6cwvlSIxej2wW6KqMJnH16tFzL+cl8krn6eypUPvC
M8OEN5a+rx5xr7468YmrZ3VJOw4N1moPOHMol8B82t9IBVfJ0OvpmsI1tvNZ8EN4
iTXzWTLJiAddh/3YJWlLCxrNoZuemtY94vOisLTeeS8TIhNcly/hh/ibhZnH6Kk=
=9nkW
-----END PGP SIGNATURE-----

--vkUjpNzvt17RSo84--

--===============4444021418523178424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4444021418523178424==--
