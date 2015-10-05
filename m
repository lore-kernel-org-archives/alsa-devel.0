From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Mon, 5 Oct 2015 11:07:17 +0100
Message-ID: <20151005100717.GN12635@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <s5hh9n3d4bk.wl-tiwai@suse.de> <55F04AA1.3030607@metafoo.de>
 <1443782064.10151.28.camel@mtksdaap41>
 <20151002144831.GQ12635@sirena.org.uk>
 <1443884500.32571.12.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3612427428452963412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD59A2604A6
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 12:08:04 +0200 (CEST)
In-Reply-To: <1443884500.32571.12.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, p.zabel@pengutronix.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============3612427428452963412==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x/TyKPcLwmKZr+b7"
Content-Disposition: inline


--x/TyKPcLwmKZr+b7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 03, 2015 at 11:01:40PM +0800, Koro Chen wrote:
> On Fri, 2015-10-02 at 15:48 +0100, Mark Brown wrote:
> > On Fri, Oct 02, 2015 at 06:34:24PM +0800, Koro Chen wrote:

> > > I have two cards originally but the second one failed because of the
> > > patch ASoC: Prevent components from being bound to multiple cards.

> > > My configuration is like this:
> > > card0: use platform's DAI component A
> > > card1: use the same platform's DAI component B

> > What do you mean by "DAI component" here?  It's not a term I'm familiar
> > with...

> Sorry I didn't make myself clear enough. In the
> sound/soc/mediatek/mtk-afe-pcm.c, I register two components
> "mtk_afe_pcm_dai_component" and "mtk_afe_hdmi_dai_component", each has
> its corresponding DAIs. Card0 (which is mt8173-rt5676-rt5650.c) uses
> DAIs from the first component, and card1 (new) uses DAIs of the second
> component. These two components are probed successfully and separately
> by card0 and card1, but card1 failed to probe another component created
> by snd_soc_register_platform(), which is already bound to card0.

OK, I see.  We probably do want to relax that restriction, it makes more
sense at the DAI level but at the component level when we have
components that have a bunch of independant DAIs hanging off a DMA
controler as one component (which does make sense) then it breaks.

--x/TyKPcLwmKZr+b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEkvUAAoJECTWi3JdVIfQsMoH/1LPO8TsF1vv9iCiMWCBZtGX
UFXEuRxx0cgR5gYLTpRbKw+gN2zUhw5o8bi4vH2P3MB+XsX+fQYVhnrfV4O37WjV
R2MyzTSeEB/bXYhkZcQaKk6cD5Uf0KK8WtXwYjW1x3EAptfLx/7vhRWPBV/pKNqr
iuJiWDvTWpySeWDA3yiPEc72wpyNTI3Exm9fiUWh+YCjrZ0JnmhaJKXoM7wjM8K6
SkRfFM6auudtgQPK4a/RsPwYEGF8xlHr51pTwYApJ6yF7VE/DygqAM3XHXnp+JN0
cO6cMsP2cyz+h2O4mAckVHV833Xg9yANp1ixgTTH0PpP9EsRxK7y1es0bHFTf18=
=C2dN
-----END PGP SIGNATURE-----

--x/TyKPcLwmKZr+b7--

--===============3612427428452963412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3612427428452963412==--
