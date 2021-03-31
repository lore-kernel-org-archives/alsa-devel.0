Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97209C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:23:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985D361041
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985D361041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nh6z.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF9951688;
	Wed, 31 Mar 2021 20:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF9951688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617215019;
	bh=Wvrl+PGUFFhmFetmW+Bc4xwTyMmhO79JmMYv9SYxDKo=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dx22JEN3n3yNA0YU7+X9PyB1kHAqT/egCkcB3qmUnPb4zkTAM/e2TLGIf7mk19u2R
	 QvKWN83Xi0g4kBOKqFp6YvpH6POjod9cXbW5cYhAJiO5+9v7fElW2nbMY0FRTlv+JG
	 1k0LAaPrKQ8qPfPKtnK9Ll5T0/X5d4lLP8WOd58Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 504F4F802CA;
	Wed, 31 Mar 2021 20:21:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64911F80425; Wed, 31 Mar 2021 20:21:55 +0200 (CEST)
Received: from a27-213.smtp-out.us-west-2.amazonses.com
 (a27-213.smtp-out.us-west-2.amazonses.com [54.240.27.213])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2532F802CA
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 20:21:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2532F802CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nh6z.net header.i=@nh6z.net
 header.b="KaWY2pyt"; 
 dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com
 header.b="dw9PAgmF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zzmz6pik4loqlrvo6grmnyszsx3fszus; d=nh6z.net; t=1617214905;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
 bh=Wvrl+PGUFFhmFetmW+Bc4xwTyMmhO79JmMYv9SYxDKo=;
 b=KaWY2pytdH1cZ+/ddUPbcDrp4tCX5+PNS+vxK0sh8tpT/9ItOAJEQ1ASf2UKVngb
 IbF0BjEN86LYuNtD/PcwL26oCHGBEbwd7AHTWK50WKzoRqc8k1nSBMYzFLoXU5NiN0O
 w3LCLaONr464/zth+8yA16IPacP8UeEkZgbFR0Eo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1617214905;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
 bh=Wvrl+PGUFFhmFetmW+Bc4xwTyMmhO79JmMYv9SYxDKo=;
 b=dw9PAgmFNGeFKIEou25DTGwftO+ropuNBQAlNY9XaYlYxnqAJPqEK0RAmmtiGHp3
 jw24+my18L2wi7A3xCWNohYOXEfbaf1jIe3o+yNnuVDLxow2fvY2eaUnSFearxG5cXg
 Hq6148QozvI6NM1c6xfASujgxFTeGleD8nlhqgQU=
Subject: [PATCH v2 1/2] ASoC: tlv320aic32x4: Increase maximum register in
 regmap
From: =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
To: =?UTF-8?Q?alsa-devel=40alsa-project=2Eorg?= <alsa-devel@alsa-project.org>, 
 =?UTF-8?Q?broonie=40kernel=2Eorg?= <broonie@kernel.org>, 
 =?UTF-8?Q?lgirdwood=40gmail=2Ecom?= <lgirdwood@gmail.com>, 
 =?UTF-8?Q?perex=40perex=2Ecz?= <perex@perex.cz>, =?UTF-8?Q?tiwai=40suse=2E?=
 =?UTF-8?Q?com?= <tiwai@suse.com>
Date: Wed, 31 Mar 2021 18:21:45 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331182125.413693-1-nh6z@nh6z.net>
References: <20210331182125.413693-1-nh6z@nh6z.net> 
 <20210331182125.413693-2-nh6z@nh6z.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXJlqutU2ZzEf5Tk+l1YBnPdSJ8wAAAFVe
Thread-Topic: [PATCH v2 1/2] ASoC: tlv320aic32x4: Increase maximum register
 in regmap
X-Original-Mailer: git-send-email 2.27.0
X-Wm-Sent-Timestamp: 1617214904
Message-ID: <0101017889851cab-ce60cfdb-d88c-43d8-bbd2-7fbf34a0c912-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2021.03.31-54.240.27.213
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Cc: =?UTF-8?Q?team=40nwdigitalradio=2Ecom?= <team@nwdigitalradio.com>,
 =?UTF-8?Q?stable=40vger=2Ekernel=2Eorg?= <stable@vger.kernel.org>,
 =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
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

AIC32X4_REFPOWERUP was added as a register, but the maximum register valu=
e=0D=0Ain the regmap and regmap range was not correspondingly increased. =
 This=0D=0Acaused an error when this register was attempted to be written=
=2E=0D=0A=0D=0AFixes: ec96690de82c ("ASoC: tlv320aic32x4: Enable fast cha=
rge")=0D=0ACc: stable@vger.kernel.org=0D=0ASigned-off-by: Annaliese McDer=
mond <nh6z@nh6z.net>=0D=0A---=0D=0A sound/soc/codecs/tlv320aic32x4.c | 4 =
++--=0D=0A 1 file changed, 2 insertions(+), 2 deletions(-)=0D=0A=0D=0Adif=
f --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32=
x4.c=0D=0Aindex f04f88c8d425..1ac3b3b12dc6 100644=0D=0A--- a/sound/soc/co=
decs/tlv320aic32x4.c=0D=0A+++ b/sound/soc/codecs/tlv320aic32x4.c=0D=0A@@ =
-577,12 +577,12 @@ static const struct regmap_range_cfg aic32x4_regmap_pa=
ges[] =3D {=0D=0A =09=09.window_start =3D 0,=0D=0A =09=09.window_len =3D =
128,=0D=0A =09=09.range_min =3D 0,=0D=0A-=09=09.range_max =3D AIC32X4_RMI=
CPGAVOL,=0D=0A+=09=09.range_max =3D AIC32X4_REFPOWERUP,=0D=0A =09},=0D=0A=
 };=0D=0A=20=0D=0A const struct regmap_config aic32x4_regmap_config =3D {=
=0D=0A-=09.max_register =3D AIC32X4_RMICPGAVOL,=0D=0A+=09.max_register =3D=
 AIC32X4_REFPOWERUP,=0D=0A =09.ranges =3D aic32x4_regmap_pages,=0D=0A =09=
=2Enum_ranges =3D ARRAY_SIZE(aic32x4_regmap_pages),=0D=0A };=0D=0A--=20=0D=
=0A2.27.0=0D=0A=0D=0A
