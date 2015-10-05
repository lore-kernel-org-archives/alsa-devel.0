From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Mon, 5 Oct 2015 11:08:59 +0100
Message-ID: <20151005100859.GO12635@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <s5hh9n3d4bk.wl-tiwai@suse.de> <55F04AA1.3030607@metafoo.de>
 <1443782064.10151.28.camel@mtksdaap41>
 <20151002144831.GQ12635@sirena.org.uk>
 <1443884500.32571.12.camel@mtksdaap41>
 <20151005100717.GN12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8486320983964183887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E73F126054D
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 12:10:21 +0200 (CEST)
Received: from [89.101.192.72] (helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1Zj2il-0002sn-HE
 for alsa-devel@alsa-project.org; Mon, 05 Oct 2015 10:10:20 +0000
In-Reply-To: <20151005100717.GN12635@sirena.org.uk>
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


--===============8486320983964183887==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GviraxgP0A7vmYdC"
Content-Disposition: inline


--GviraxgP0A7vmYdC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 11:07:17AM +0100, Mark Brown wrote:
> On Sat, Oct 03, 2015 at 11:01:40PM +0800, Koro Chen wrote:

> > Sorry I didn't make myself clear enough. In the
> > sound/soc/mediatek/mtk-afe-pcm.c, I register two components
> > "mtk_afe_pcm_dai_component" and "mtk_afe_hdmi_dai_component", each has
> > its corresponding DAIs. Card0 (which is mt8173-rt5676-rt5650.c) uses
> > DAIs from the first component, and card1 (new) uses DAIs of the second
> > component. These two components are probed successfully and separately
> > by card0 and card1, but card1 failed to probe another component created
> > by snd_soc_register_platform(), which is already bound to card0.

> OK, I see.  We probably do want to relax that restriction, it makes more
> sense at the DAI level but at the component level when we have
> components that have a bunch of independant DAIs hanging off a DMA
> controler as one component (which does make sense) then it breaks.

Oh, one other thing here - if there is routing within your component
which would allow the two cards to be interconnected then that's a bit
different and the cards should probably be combined into one.

--GviraxgP0A7vmYdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEkw6AAoJECTWi3JdVIfQn1UH/0MnGJKNRWVFO4XLi5LcOg4d
mPRqD7yI+BcurKE0iCxvCFydCOlUUqRaUR8UT5NgT8ZZvEo1Kh//5MdAvP2hkEdX
qyGEqDCuSgzn7nwXuiQ2uI1dPwgkZiOqX8sBAfBjyp4vUzOmQRM3zYg773EOJlrT
Ht7tzG4HGDugYhZHHwrwmGTXSGC4MLgpoHFBnpDYOox8bl7ggaLy7w+KPFN8AB7/
xNfsw2U+xY7Bet2pNc5iz4jUSoZ2zY463t+/TbswDDfI4ufEt+07UJyvAX2uug5Z
HKn2C5B9BlekyPEXGke4XKV3xXAyDaqjuww8/Vvuib82z/SBjleRvTakl96pjks=
=FRHe
-----END PGP SIGNATURE-----

--GviraxgP0A7vmYdC--

--===============8486320983964183887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8486320983964183887==--
