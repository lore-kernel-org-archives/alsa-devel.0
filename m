From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set
 the divider clock API
Date: Thu, 5 Nov 2015 16:16:15 +0000
Message-ID: <20151105161615.GS18409@sirena.org.uk>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
 <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
 <20151104143431.GH1717@sirena.org.uk> <563AEF97.1080304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5847998958972041531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BFCE2660EE
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:16:28 +0100 (CET)
In-Reply-To: <563AEF97.1080304@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: alsa-devel@alsa-project.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org


--===============5847998958972041531==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Content-Disposition: inline


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2015 at 01:56:39PM +0800, Caesar Wang wrote:
> =E5=9C=A8 2015=E5=B9=B411=E6=9C=8804=E6=97=A5 22:34, Mark Brown =E5=86=99=
=E9=81=93:

> >Same thing as your other very similar patch: why does this feature
> >require set_clkdiv()?

> Okay, you said "
> Why is this a requirement?  The clock to use as a source should normally
> be specified via set_sysclk() and any internal dividers calculated
> automatically by the driver.
> "

> I think we should divider settings for these different sample rates.

Sure, the question is how these things get set.

>  If the codec is master mode, we are *not* need this operate.
>  If the codec is slave mode, we are need to divider the MCLK to setting t=
he different sample rates.
> (for example, the sample rates (8k, 48k) the clock is MCLK, the clock sho=
uld be divider cpu ip )

> "dividers calculated automatically by the driver", that should be occured=
 by codec(max98090
> ) driver, but the divider clocks (LRCK, SCLK) should need to set for cpu =
internal side.

So the CPU knows what rates it needs to set and what clocks it's getting
in, why can't it set the dividers autonomously.

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO4DOAAoJECTWi3JdVIfQl+8H/20bOu+y+cohkOGta0nK7ESB
+B8ZwA1O0pDREWrp/hgpAjGG+9CNJBMrvncYxsC7HUiY8yoT3Tk0AeGSGEOq72ur
fAox1ZODd8LDtF1vmXvvYN3s066SwglCkb/+RWos1vSOLHMI2hcSsvTpt5WQUT9Q
3+uZjCyblJq1hdZ77fASZsdQpDhIhhmvgm4hkK/EydZtLNejjb3ByGF+n/wiZCpN
yqTBa9+vQH3WStweDAUoJtJp1IiAPeY+F7ktoBZ/q3w8F5j5+Jrh2pNQHu2BjJLD
bRUNkBIBnubR2qpICpLGHDHYa4xLhDfHvhLvB7aI1ZrWaHfuWjbMB7dQG97Nnbs=
=N0FO
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--

--===============5847998958972041531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5847998958972041531==--
