Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD2C4346E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:33:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1B42223E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n2q5UhZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1B42223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70317829;
	Mon, 21 Sep 2020 20:32:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70317829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600713200;
	bh=i9w5uy75x9nnlvgfsNtnLotJHvAb4u74dssrSSbQUL8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2q5UhZOKqi6jZzvix2eoHcfgiWG3PluUz90xHZitEzxK28g9StO7mH9ZQOVaO8Vf
	 K5IQu9fArhn5EFLi1XJeCgxuODkH+mKyJxlGFifHcAPevh5atULLw3W1j1vp1DUe9w
	 xYuhQpfAu6OHyx4joTOY4kPEWvLMMOy+yXEZ2sC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B997F80161;
	Mon, 21 Sep 2020 20:32:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6A2EF80171; Mon, 21 Sep 2020 20:32:28 +0200 (CEST)
Received: from mail.siol.net (mailoutvs40.siol.net [185.57.226.231])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34D3BF8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 20:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34D3BF8015F
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id 3AD4E5274C3;
 Mon, 21 Sep 2020 20:32:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id XJOz8y8z8RPg; Mon, 21 Sep 2020 20:32:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id D10215274C4;
 Mon, 21 Sep 2020 20:32:16 +0200 (CEST)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
 (Authenticated sender: jernej.skrabec@siol.net)
 by mail.siol.net (Zimbra) with ESMTPA id F3DBC5274C3;
 Mon, 21 Sep 2020 20:32:15 +0200 (CEST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime@cerno.tech>,
 =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio
 node
Date: Mon, 21 Sep 2020 20:37:09 +0200
Message-ID: <59286578.E0qSRroNqr@kista>
In-Reply-To: <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan>
 <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Dne ponedeljek, 21. september 2020 ob 19:23:49 CEST je Cl=E9ment P=E9ron=20
napisal(a):
> Hi Maxime,
>=20
> On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Sep 21, 2020 at 12:27:18PM +0200, Cl=E9ment P=E9ron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > Add a simple-soundcard to link audio between HDMI and I2S.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++=
++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/
boot/dts/allwinner/sun50i-h6.dtsi
> > > index 28c77d6872f6..a8853ee7885a 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -67,6 +67,25 @@ de: display-engine {
> > >               status =3D "disabled";
> > >       };
> > >
> > > +     hdmi_sound: hdmi-sound {
> > > +             compatible =3D "simple-audio-card";
> > > +             simple-audio-card,format =3D "i2s";
> > > +             simple-audio-card,name =3D "sun50i-h6-hdmi";
> > > +             simple-audio-card,mclk-fs =3D <128>;
> > > +             simple-audio-card,frame-inversion;
> > > +             status =3D "disabled";
> > > +
> > > +             simple-audio-card,codec {
> > > +                     sound-dai =3D <&hdmi>;
> > > +             };
> > > +
> > > +             simple-audio-card,cpu {
> > > +                     sound-dai =3D <&i2s1>;
> > > +                     dai-tdm-slot-num =3D <2>;
> > > +                     dai-tdm-slot-width =3D <32>;
> >
> > It looks weird to have both some TDM setup here, and yet the format in
> > i2s?
>=20
> Yes, I agree I will check if it's really needed.

I think this was explained before. Anyway, this is needed to force width to=
=20
32, no matter actual sample width. That's a requirement of HDMI codec. I=20
believe Marcus Cooper have another codec which also needs fixed width.

There is no similar property for I2S, so TDM one is used here.

Best regards,
Jernej

>=20
> Clement
>=20
> >
> > Maxime
>=20


