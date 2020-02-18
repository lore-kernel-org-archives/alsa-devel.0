Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC2C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:05:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559E020801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aiD8EMV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559E020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4150168A;
	Tue, 18 Feb 2020 15:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4150168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582034729;
	bh=18BoX21eg3g/2gJV0tyUuhi7Cn6WZTF64YJh0Dk7+a8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aiD8EMV9Ej78DZlqgzd7Aarf6VzbJU0u5+tVaNe0o43cpa3hQnZ7VM//B1QEGrOzc
	 RuDoNzeUzNIC5eCpqwd4HVgexzO0opYySc7Vbnv0epysNW2r+FpyWzPMSxEH4vRata
	 03zS7Aqb628b8FJ+ypLXrPFXuGn81he0naFzpPcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38BCCF80145;
	Tue, 18 Feb 2020 15:04:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30E8FF80148; Tue, 18 Feb 2020 15:04:37 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1FF4F80135
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 15:04:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1FF4F80135
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id A615629138B
Received: by earth.universe (Postfix, from userid 1000)
 id F10E93C0C81; Tue, 18 Feb 2020 15:04:31 +0100 (CET)
Date: Tue, 18 Feb 2020 15:04:31 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio
 graph card
Message-ID: <20200218140431.emrxgvckrpltmg2s@earth.universe>
References: <20200211171645.41990-1-tony@atomide.com>
 <cd46c6ec-80e3-332f-4922-e58a3acbfc61@ti.com>
 <20200212143543.GI64767@atomide.com>
 <20200214003452.xuadnylj2udqyljs@earth.universe>
 <20200214013454.GX64767@atomide.com>
 <20200214130428.gkhmr55ptmi2bh2x@earth.universe>
 <20200214170946.GB64767@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7l4uy2pkqo77ymf7"
Content-Disposition: inline
In-Reply-To: <20200214170946.GB64767@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
 Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 "Arthur D ." <spinal.by@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--7l4uy2pkqo77ymf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2020 at 09:09:46AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [200214 13:05]:
> > On Thu, Feb 13, 2020 at 05:34:54PM -0800, Tony Lindgren wrote:
> > > And bluetooth would be similar to cpcap_audio and mot_mdm6600_audio
> > > above.
> >=20
> > My understanding is, that CPU is not involved for calls (except for
> > setting up cpcap registers correctly). Basically McBSP3 should
> > remain idle for a call and data goes directly from modem to cpcap.
> > The same should work for modem <-> BT, except that CPCAP seems to
> > always provide the clock. That would imply a direct link between
> > modem and codec / BT?
>=20
> Yes the direct link is i2s. I'm ot sure if mcbsp can be idle during
> voice call though, I guess it should be doable since mcbsp is not
> the clock master :)
>=20
> > > My guess is that only cpcap registers and clock rate needs to be
> > > changed for bluetooth audio BTW, so if somebody havs a bluetooth
> > > headset just do the following in Android:
> > >=20
> > > # cpcaprw --all > /tmp/before
> > > configure bluetooth headset for audio in android and start
> > > playing some music or make a phone call
> > > ...
> > > # cpcaprw --all > /tmp/after
> > > stop playing music or phone call
> > > ...
> > > diff -u /tmp/before /tmp/after
> > >=20
> > > The registers will be different for a bluetooth phone call and
> > > playing music.
> >=20
> > I can provider register values once I find some time.

[NI] Normal idle (no BT headset connected)
[BI] Bluetooth idle (with BT headset connected)
[BC] Bluetooth call in progress
[NC] Normal call in progress (BT headset disabled)

                     [NI]  =3D>  [BI]  =3D>  [BC]  =3D>  [NC]
CPCAP_REG_VAUDIOC   0x0065 =3D> 0x0065 =3D> 0x0065 =3D> 0x0025
CPCAP_REG_CC        0x0000 =3D> 0x0000 =3D> 0x6000 =3D> 0x60df
CPCAP_REG_CDI       0x0040 =3D> 0x0000 =3D> 0xaa40 =3D> 0xae0a
CPCAP_REG_SDAC      -------------- 0x0000 --------------
CPCAP_REG_SDACDI    -------------- 0x0004 --------------
CPCAP_REG_TXI       0x0804 =3D> 0x0004 =3D> 0x0000 =3D> 0x0cc6
CPCAP_REG_TXMP      0x079c =3D> 0x079c =3D> 0x0400 =3D> 0x0673
CPCAP_REG_RXOA      0x0000 =3D> 0x0000 =3D> 0x0001 =3D> 0x0001
CPCAP_REG_RXVC      0x0d34 =3D> 0x0d34 =3D> 0x0000 =3D> 0x0b2c
CPCAP_REG_RXCOA     0x0000 =3D> 0x0000 =3D> 0x0000 =3D> 0x0601
CPCAP_REG_RXSDOA    0x0000 =3D> 0x0000 =3D> 0x0600 =3D> 0x0600
CPCAP_REG_RXEPOA    -------------- 0x0400 --------------
CPCAP_REG_RXLL      -------------- 0x0000 --------------
CPCAP_REG_A2LA      -------------- 0x0030 --------------
CPCAP_REG_MIPIS1    -------------- 0x0000 --------------
CPCAP_REG_MIPIS2    -------------- 0x0000 --------------
CPCAP_REG_MIPIS3    -------------- 0x0000 --------------
CPCAP_REG_LVAB      -------------- 0x0000 --------------

-- Sebastian

--7l4uy2pkqo77ymf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5L7ukACgkQ2O7X88g7
+poophAApJAJiKd6MJhkOGd7eW5g2hWtYr0qp9cVC99Z6POxm8vqSPa1uQvF6oz+
WpT4x0lPj1qTxQJvcsm2MS+HHi3fMdodtfI96kXUxC/owAem23WGtIdggLvsna28
uVoCqRrAVriUsqfyTZDIw7FQNe9rxfOLMilYLQz9KrPF+j+witt2i5hwKAQemXke
wLpTEH3uaT1GgSEsXyu/YUlAY8f5f6lSkQgodG1sLbhrR16MUPDCrlmrHgNI07IK
sXT/wm9urqjkBo5/KWVuLhmXR87TgY6RPx0UEDOSuz2k2a85CoX0dH9Of6dBexj1
eQyOxQZQo+u2cBzBGqZFL9TaW9slOqfbFn8sV3i50sG/0B0UAyfvgtRdJpuZw9Y8
hXuDeyhQ1fj7E2/GmH4+EJhgQ+9xYw8t1oqRDR9LxvtCzi8Kcf9wFRbGpEhunvUQ
kG3HJfOwTtN/fyqkqrIkwxVvvVG0qMNheIsPXMswnYwRTySHypzzsYV+pxe1yxXt
DZiHCB+yydiUzFOOec31nK/O29A5gdsLAtLk715eU75UbB5xz4zBcW+Jx9hnqVgd
CZeolty1OMmDQBfWRlQEs75CAx6aSbWY4kANpxCc0WCq++HnG75m5sgSA2QGucfl
2gCXCdMQoJxTOd+WptS0Hzv0Z8agrMJETT31lvgjXJ7ZH3MIz/w=
=0V6p
-----END PGP SIGNATURE-----

--7l4uy2pkqo77ymf7--
