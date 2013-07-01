From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: mxs: register saif mclk to clock
	framework
Date: Mon, 1 Jul 2013 11:11:40 +0100
Message-ID: <20130701101140.GC27646@sirena.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1709028316862155405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 214802625D8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 12:11:43 +0200 (CEST)
In-Reply-To: <1372666571-17276-4-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1709028316862155405==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MMy/8vIB83tMXVXZ"
Content-Disposition: inline


--MMy/8vIB83tMXVXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2013 at 04:16:10PM +0800, Shawn Guo wrote:
> Mostly the mxs system design uses saif0 mclk output as the clock source
> of codec.  Since the mclk is implemented as a general divider with the
> saif clk as the parent clock, let's register the mclk as a basic
> clk-divider to common clock framework.  Then with it being a clock
> provdier, clk_get() call in codec driver probe function will just work.

Applied, thanks.

--MMy/8vIB83tMXVXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0VXZAAoJELSic+t+oim93hkP/1n/ODFkS2rmd0qN75vNSk2T
DyidznnzjrqFu8txkPgmiv/hzf6E/N9l1Mqzmca7e8e4/V9spIGeSRTgyPsqD2oe
p8CdErEebw+SB3+15toQafMuwk9qUstCuo4+ixAVqzBqVmtbO3D6YT9Hi7NPwd0i
akBbu5Fc3Y810d/WUyiwlAOpEKwIJUs6GXhU/H3u2QV6oNnHe7DoAp4EU45q6ptq
QsQPp+fyaluJS+4JS8fMrU1u7Jz0DJGBVfUIO3IaLhJ1m/KbWwBDN6YvVcwpPmm5
PO4598hG/gGm9nNCmhZjZfP95Z2eMP7yuqCMf/+f1JwecZg0IyA6ePpWjZGrkLmj
MpiDdjCVz7SgP69j0D/b0AiKwfCLG01cJ25QwnUkOIliJupB7fnyIkXpDSejmjyS
ZcKq1XXPRGsd6KlD5K+OHNAt4AzWL7g268VZ76Y0KXcKEh7fFrxRdLDSrpaU8KDS
/lynRkjvNybl1r+D/ry45GNquGLotsVEgeszkdyX1zuOV+MkmqHQipvekjEnt1kS
4svhXWfdpBJfjN2zGeQQxmhFPJiVEHsyvEkYHM+uW1YcNssquR2qk/AL1A1V70gs
eM87fzUI0cbf/lZYFnYyT+rSvtoWhwiNxEPJ9QVI1RqlTWHWC2cx89VUzdufd9/M
JabNFwPqQq1hYANWv701
=9cFf
-----END PGP SIGNATURE-----

--MMy/8vIB83tMXVXZ--

--===============1709028316862155405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1709028316862155405==--
