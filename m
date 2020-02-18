Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96264C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:36:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA9D20801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ocs+Fwgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA9D20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7887515F9;
	Tue, 18 Feb 2020 17:35:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7887515F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582043775;
	bh=ZJAev8Rt7m5gUXcnR0wkbfADlp5eU5uDylZkzftCGls=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ocs+FwglpmfE9yM3wlTbeNeH4MvIi1pIa7S+b9DZfYY1VeQ2AtOWQk+Doh4fl/wm4
	 q8Li3HlUYN69YXWzr1ecV9CUR1gcF1Q2BRRMflIEI8k3XVDzunBbQdT+7rEGYQMh0q
	 BF6Fcr45USDLqfNcwu3RzmhmhphweXyOx3Wy7Teo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00B7CF80145;
	Tue, 18 Feb 2020 17:35:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E887EF80148; Tue, 18 Feb 2020 17:35:22 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6399AF80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 17:35:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6399AF80137
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id EAEAB26CF76
Received: by earth.universe (Postfix, from userid 1000)
 id 823A53C0C81; Tue, 18 Feb 2020 17:35:15 +0100 (CET)
Date: Tue, 18 Feb 2020 17:35:15 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio
 graph card
Message-ID: <20200218163515.rxdvv5ponu2ndwn7@earth.universe>
References: <20200211171645.41990-1-tony@atomide.com>
 <cd46c6ec-80e3-332f-4922-e58a3acbfc61@ti.com>
 <20200212143543.GI64767@atomide.com>
 <20200214003452.xuadnylj2udqyljs@earth.universe>
 <20200214013454.GX64767@atomide.com>
 <20200214130428.gkhmr55ptmi2bh2x@earth.universe>
 <20200214170946.GB64767@atomide.com>
 <20200218140431.emrxgvckrpltmg2s@earth.universe>
 <20200218141905.GG35972@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="njnztwvky5sdzicr"
Content-Disposition: inline
In-Reply-To: <20200218141905.GG35972@atomide.com>
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


--njnztwvky5sdzicr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2020 at 06:19:05AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.com> [200218 06:05]:
> > On Fri, Feb 14, 2020 at 09:09:46AM -0800, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@kernel.org> [200214 13:05]:
> > > > On Thu, Feb 13, 2020 at 05:34:54PM -0800, Tony Lindgren wrote:
> > > > > And bluetooth would be similar to cpcap_audio and mot_mdm6600_aud=
io
> > > > > above.
> > > >=20
> > > > My understanding is, that CPU is not involved for calls (except for
> > > > setting up cpcap registers correctly). Basically McBSP3 should
> > > > remain idle for a call and data goes directly from modem to cpcap.
> > > > The same should work for modem <-> BT, except that CPCAP seems to
> > > > always provide the clock. That would imply a direct link between
> > > > modem and codec / BT?
> > >=20
> > > Yes the direct link is i2s. I'm ot sure if mcbsp can be idle during
> > > voice call though, I guess it should be doable since mcbsp is not
> > > the clock master :)
> > >=20
> > > > > My guess is that only cpcap registers and clock rate needs to be
> > > > > changed for bluetooth audio BTW, so if somebody havs a bluetooth
> > > > > headset just do the following in Android:
> > > > >=20
> > > > > # cpcaprw --all > /tmp/before
> > > > > configure bluetooth headset for audio in android and start
> > > > > playing some music or make a phone call
> > > > > ...
> > > > > # cpcaprw --all > /tmp/after
> > > > > stop playing music or phone call
> > > > > ...
> > > > > diff -u /tmp/before /tmp/after
> > > > >=20
> > > > > The registers will be different for a bluetooth phone call and
> > > > > playing music.
> > > >=20
> > > > I can provider register values once I find some time.
> >=20
> > [NI] Normal idle (no BT headset connected)
> > [BI] Bluetooth idle (with BT headset connected)
> > [BC] Bluetooth call in progress
> > [NC] Normal call in progress (BT headset disabled)
> >=20
> >                      [NI]  =3D>  [BI]  =3D>  [BC]  =3D>  [NC]
> > CPCAP_REG_VAUDIOC   0x0065 =3D> 0x0065 =3D> 0x0065 =3D> 0x0025
> > CPCAP_REG_CC        0x0000 =3D> 0x0000 =3D> 0x6000 =3D> 0x60df
> > CPCAP_REG_CDI       0x0040 =3D> 0x0000 =3D> 0xaa40 =3D> 0xae0a
> > CPCAP_REG_SDAC      -------------- 0x0000 --------------
> > CPCAP_REG_SDACDI    -------------- 0x0004 --------------
> > CPCAP_REG_TXI       0x0804 =3D> 0x0004 =3D> 0x0000 =3D> 0x0cc6
> > CPCAP_REG_TXMP      0x079c =3D> 0x079c =3D> 0x0400 =3D> 0x0673
> > CPCAP_REG_RXOA      0x0000 =3D> 0x0000 =3D> 0x0001 =3D> 0x0001
> > CPCAP_REG_RXVC      0x0d34 =3D> 0x0d34 =3D> 0x0000 =3D> 0x0b2c
> > CPCAP_REG_RXCOA     0x0000 =3D> 0x0000 =3D> 0x0000 =3D> 0x0601
> > CPCAP_REG_RXSDOA    0x0000 =3D> 0x0000 =3D> 0x0600 =3D> 0x0600
> > CPCAP_REG_RXEPOA    -------------- 0x0400 --------------
> > CPCAP_REG_RXLL      -------------- 0x0000 --------------
> > CPCAP_REG_A2LA      -------------- 0x0030 --------------
> > CPCAP_REG_MIPIS1    -------------- 0x0000 --------------
> > CPCAP_REG_MIPIS2    -------------- 0x0000 --------------
> > CPCAP_REG_MIPIS3    -------------- 0x0000 --------------
> > CPCAP_REG_LVAB      -------------- 0x0000 --------------
>=20
> Great thanks! Care to do also a dump just playing music to on
> bluetooth headset at some point?

AFAIK BT music is usually done via A2DP using the data connection,
but I can get a register dump to make sure. I guess the more
interesting bit would be to use BT headset for a VOIP call, which
requires the headset profile being routed to the CPU.

-- Sebastian

--njnztwvky5sdzicr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5MEj4ACgkQ2O7X88g7
+poFYw//XQ7O3qOgKSSW0CMyFy16w6YZb78hfG0vsiZOA+KshUjO/hGfzhv9ySM3
QQvcrsENfeadQ6EqFLUK/1xcDUjDgziemLEPnbSHwXfWz4DwFmVYyxwaQc1XaeRm
qzgVBlvMiUCKKkDrhQz482eTWMZt6OyuXQ8YHZL1mCzrxdXDy7yYm5f1BIHLQK0H
+yboDLCloyuu+qiTinurCZxzmU8VuAbBFfh1iAQsfeJqcau8MEr0yTFHV77cHikU
kAYczOFDDjROvE8Q56vxnpYuC1M7Rbz9Jj0Y1C78VVjJRAt5gyKMgreK213J6xZb
nWXuBDoWKthTv2akmJ+HClx3kyi8TweQKnaDGPSy1/ub+6FswXCcZ172bg+kyUV2
RM+HjqHeocK3fr8YIRxrPIVIih4NCTWuoc8xfCG5y314wS+D9KfD1aI3TMaKeKxG
6ID7143Qgs1XxyBoAJ8dIW7knKxSldUs2LhSuglBeOhHCBVgBs4hHWbTUvCrR5Jt
jCeVEt1SQ+wgsTgbTYbnUlzwLRWAIpuBzrprCndipfUTx0KQsvDS6aUFRkEx70HL
CVEsTaDX3V7r1Z5izI6B7DJKw2gElRzRTHRQBhaqpvnxu57DEqdas4fQ/bdLbZj9
3GTcae+qU+oaImxVYb4hZNKX740QeL1zoJ8YSzONOTrKBq/zx/g=
=GOC7
-----END PGP SIGNATURE-----

--njnztwvky5sdzicr--
