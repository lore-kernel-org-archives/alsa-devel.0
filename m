From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Fri, 22 Mar 2013 11:26:16 +0100
Message-ID: <20130322102616.GE22890@opensource.wolfsonmicro.com>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
 <514B3B07.4030309@wwwdotorg.org>
 <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
 <514BE645.2050409@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9047721697746260680=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29A5F26516B
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:26:21 +0100 (CET)
In-Reply-To: <514BE645.2050409@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9047721697746260680==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 11:04:05PM -0600, Stephen Warren wrote:
> On 03/21/2013 07:19 PM, Kuninori Morimoto wrote:

> However, I do see:

> > ./mpc8610_hpcd.c:213:	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./p1022_ds.c:223:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./p1022_rdk.c:226:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> > ./imx-sgtl5000.c:151:	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);

> That's a bit icky; DT-based systems should use .cpu_of_node, not
> .cpu_dai_name...

With the exception of the SGTL5000 one those are all very old school
ASoC DT drivers that predate any framework involvement or review outside
of the driver.

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTDHBAAoJELSic+t+oim9H6wP/jgkSsY2ZebDQcu0CIdth4+T
M6jBZI3m6LnPq9nHsTrORy66LpTpDaoYZvw/WLX+5v3s4bALGip+EcuxW2Sqt7rc
k2Raqm4XOkB9/fTzgpvAfeAhY7PhWuhZ6oWsZQhXIafCvIWIBLXqxPPtJ1j314G1
mQcz3Lt3GGSxGeEYwcoIyMbZOijfNjKlElVcVFnDGNF4kPGKG/rfPaSzn7vZsqMR
KjJjA2JTnH4Sce4otc6B+a6owOWo0N7H11JhKueijAdrgREZ0qNoL3H9crFFdGGU
wWws1CPhl6A8kXkF3apA4unNcPt/9/u64+Bpb9jZkmPOEBAp1us1MntOUujlgBml
hbLB47KpoGNh1pOlDR0F3fKrtDqaGKPx8sLtul68eF46CE6lw9qvxXcoM9w2rxNF
hRm1Sx6rWXYUn5LEayoHiGvlXOgU/oll5BF7INiow6Bueez0sTLaI6Eji35bbgpS
TZhLULEOtLfHKsUmMyRIdMumS3BSt5/p04D1yW3ddYRFohV8qBdOz2FvISuE0nrg
o6a+NP8VQB4iOvJTkPCKEe5DTNYPZxqzAWuzUlHTUDHdpw4GisITxzOArtO4L6Wp
McNkU6l5O2HUsINkjaOMRAUHFngSU8etncJIr27+cZD1vAxoWjapx2kkgLGh/TmK
h4V5q52G+BWRcfX7dXXt
=Owx9
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

--===============9047721697746260680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9047721697746260680==--
