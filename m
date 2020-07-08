Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA9C433E1
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:01:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AD720672
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iS82pRD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AD720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05B2950;
	Wed,  8 Jul 2020 18:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05B2950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594224094;
	bh=KXrk3dyCYXOhM4HCLViqOxk6B9V/wSkdyfsKYywdFv4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iS82pRD049abiBJ8kvitnPfHnJN6V6xXhXQsjt+WqD9rDVSl+67yZF7WjC8Rhi81K
	 SEXysC00D7JBZkDmUYXJGGjzda3fJewH8qk/dgzUiMLYAITQWiLWIFBHcPSSbZEXjY
	 mg+FfWhpe5+Q8SMYgreNK0v1/rrtNP0TuVo6stIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CF4BF80150;
	Wed,  8 Jul 2020 18:00:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4025F8015A; Wed,  8 Jul 2020 18:00:42 +0200 (CEST)
Received: from mail.siol.net (mailoutvs17.siol.net [185.57.226.208])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FB6AF800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 18:00:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FB6AF800AE
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id E591F5249DF;
 Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id TGA0pwlFKG2D; Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id 89FE65249E9;
 Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net
 [194.152.20.232]) (Authenticated sender: jernej.skrabec@siol.net)
 by mail.siol.net (Zimbra) with ESMTPA id 8BE0F5249DF;
 Wed,  8 Jul 2020 18:00:33 +0200 (CEST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
 Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 13/16] arm64: dts: allwinner: a64: Add HDMI audio
Date: Wed, 08 Jul 2020 18:00:33 +0200
Message-ID: <4131203.q43jsyBQJq@jernej-laptop>
In-Reply-To: <20200706053123.uenb3nrdrckdvao7@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-14-peron.clem@gmail.com>
 <20200706053123.uenb3nrdrckdvao7@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-sunxi@googlegroups.com,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Hi!

Dne ponedeljek, 06. julij 2020 ob 07:31:23 CEST je Maxime Ripard napisal(a):
> On Sat, Jul 04, 2020 at 01:38:59PM +0200, Cl=E9ment P=E9ron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >=20
> > Add a simple-soundcard to link audio between HDMI and I2S.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > ---
> >=20
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> > c662f6a170ce..6a321fdc8e90 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -102,6 +102,25 @@ de: display-engine {
> >=20
> >  		status =3D "disabled";
> >  =09
> >  	};
> >=20
> > +	hdmi_sound: hdmi-sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,format =3D "i2s";
> > +		simple-audio-card,name =3D "sun50i-a64-hdmi";
> > +		simple-audio-card,mclk-fs =3D <128>;
> > +		simple-audio-card,frame-inversion;
> > +		status =3D "disabled";
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai =3D <&hdmi>;
> > +		};
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai =3D <&i2s2>;
> > +			dai-tdm-slot-num =3D <2>;
> > +			dai-tdm-slot-width =3D <32>;
> > +		};
> > +	};
> > +
> >=20
> >  	osc24M: osc24M_clk {
> >  =09
> >  		#clock-cells =3D <0>;
> >  		compatible =3D "fixed-clock";
> >=20
> > @@ -856,6 +875,7 @@ i2s2: i2s@1c22800 {
> >=20
> >  			resets =3D <&ccu RST_BUS_I2S2>;
> >  			dma-names =3D "tx";
> >  			dmas =3D <&dma 27>;
> >=20
> > +			allwinner,playback-channels =3D <8>;
>=20
> This isn't documented anywhere

This can be safely dropped. It is just leftover from multi-channel (>2) wor=
k,=20
which will have to be redesigned anyway.

Best regards,
Jernej


