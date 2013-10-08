From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Tue, 8 Oct 2013 17:46:48 +0100
Message-ID: <20131008164648.GH21581@sirena.org.uk>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
 <20131008150612.GR2954@intel.com> <52542F44.4030604@metafoo.de>
 <20131008153024.GS2954@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8325454287042035273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC24265368
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 18:47:02 +0200 (CEST)
In-Reply-To: <20131008153024.GS2954@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8325454287042035273==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjOkcJJWexFowuLm"
Content-Disposition: inline


--PjOkcJJWexFowuLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 09:00:24PM +0530, Vinod Koul wrote:
> On Tue, Oct 08, 2013 at 06:13:56PM +0200, Lars-Peter Clausen wrote:

> > >And second question for Takakshi or Mark. I see that this value ends up in
> > >usermode, what is the intented usage of this?

> > I think it is supposed to help to calculate the audio delay, but I
> > don't think it is actually that widely used at the moment. And yes,
> > in order to make this more accurate we should probably add support
> > for incorporating also the fifo size of the DMA channel.

> But then why dont add to delay field, why report to usermode

It's only really useful if the buffer is large enough to start causing
an issue with A/V sync and similar - it's there to help account for
delays introduced after things have gone from DMA.  Most hardware has
relatively small buffers so it's not a big deal.  I don't know why the
two are expressed differently, though the fact that one is in units of
time and the other is in units of data suggests it's just about making
it easier to express.

--PjOkcJJWexFowuLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVDb1AAoJELSic+t+oim9sWsP/1Y6zLURRQEMBA5ZODb2HBOZ
pRLN5Js5+a+rF48QNoe89MbaClNn6fmahOnMOPCzkKjK1QPCFHReUT57djiJXxIA
tD58c5R2GmT/+x2KzVFtu4hrB6s72RBlQzwk7eEYwquTfHKfzu0WDxF1u3a1KwuC
rX4d+2MgYKOpGKfZj3k2u4o4UKFDuKiJL8IKiXSSLeSjB1QT6Pt0OBG1PoFM4YuK
lN9tqHknqSpd21hXsUYRXRNfwK1geszhi+6jFLpkjxz4wQAPG1e7UeTarWpDAT6H
Q5mrnvWl3Q3FuUWurBnHyhPqoVeXzibKOEwZjjXDopNCKorQMG4hG+Ewf1Fxp7vv
kcREVDuJ73U0GugtY/OX/1qsdexrrc23mWzxEETalvtQzP68GzIsIfrlBH1Js63N
CNfJUaX1XT30Z/8oQI/Jzx02IkAkL75qGwpsTF7R2F8yS38znfPiPSeAbLcT80rt
jVkk+64zuKFxi362oze/qdOGoG22jvw0D2S4vlbFI2xuTil37lj0B+1R/4rgz5n6
2CC6alctspO/YqjaGGm/rd+RnGVSI8p8bs3/8vWHBH82Syuuc5rwDMBDxz7Q+lVc
xzyPo3dR4gQJ1zPS1QDNw3iXEOJXPPSHpNyhODB8pjmIDWEkk0ob0w6lkAMyyz7/
VS82hjHFBYGsEDS4AdR9
=zFPt
-----END PGP SIGNATURE-----

--PjOkcJJWexFowuLm--

--===============8325454287042035273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8325454287042035273==--
