Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D386ECD128A
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Apr 2024 07:11:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 684632D1A;
	Sat,  6 Apr 2024 09:11:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 684632D1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712387514;
	bh=RTIDtrrNxRu6jF02BCUn9VGQIZeM+xPk9ksaRegnfJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NnGFzEhCDLEHKixXtusHuVq04gSptk8sfnHF70QpJ3xFFIN21ZewrJHz92F5C9lSz
	 3paVRGRhkNU3N3s1BsgD/ykYqlmVcKnqwHTsHhnyCbL75Y2SgM+jD0lqVfvQi5uVY9
	 dWVzyPebOyAQL7tnDzMK7Ub9jmDTqIImDzdgnT2A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C72BF8059F; Sat,  6 Apr 2024 09:11:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 227A7F805BD;
	Sat,  6 Apr 2024 09:11:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26CD7F80238; Sat,  6 Apr 2024 08:51:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 443F4F8055C
	for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2024 08:48:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 443F4F8055C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=rv8Nub56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712386111; x=1712990911;
	i=oswald.buddenhagen@gmx.de;
	bh=JMiNQoU3MTZPWgno5imqbi9Pn68+reNg8u1rCr8bsnQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=rv8Nub56i8TlMHGflKCarhofaTtKYY0Nekg7c/QZacEuigBSi38y+KMqJsWkfDTB
	 OVMgweouRqJpHK0KophFQJHsAvZSw7qwYOHazZr9oCq142Ta5hPXFxv62qIzNZuTt
	 xZYfAGwbXGOcKlAyB4BfHpHAMXTIswjghBXD8EQ6nU2wj+7YZ6xkPi8GEfWcV50OO
	 7HquSLZ8Iv603rX7MrIFyBKYyt/ZFUBrx9MMkMaUetigJ4rHrVOfKTgT+V05hSX4k
	 CX8tXP6ct/xefkAcBm8rc4MYHceJsIT+Arcv+BPOeiX724YFaCFW2ZhLA4fLpbb+7
	 CTWWr6NbdS9rT6ykbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.118]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1sPZZg0SXf-00fkKu; Sat, 06
 Apr 2024 08:48:31 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rszqo-Jqg-00; Sat, 06 Apr 2024 08:48:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH v3 03/17] ALSA: emux: fix validation of snd_emux.num_ports
Date: Sat,  6 Apr 2024 08:48:16 +0200
Message-ID: <20240406064830.1029573-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.44.0.701.g2cf7baacf3.dirty
In-Reply-To: <20240406064830.1029573-1-oswald.buddenhagen@gmx.de>
References: <20240406064830.1029573-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p26TYhehDN2NOWFykYeYSUuCLETmm9o1WWsEHZ0UWpT8QuJSY/8
 0Yr2L+RQS2nAucVURcpHQZUbPgUUV6MuYO2q3f8Ri6GJSQEnodKDRRjqCYQuyT/wMBP59lI
 nEgqWTRUbCmISvdeSzL2kzPeLQgkvU6x7MSKuv/1Fp4pKcZfKGqDRLWh1UMTic/Ktv8B2GS
 HqhhkgxAScHc8GwI0hp/w==
UI-OutboundReport: notjunk:1;M01:P0:pGQrY4j9Kz0=;GICSpBejhiuN6IX96osWHhncYR5
 x/twZP4hn3TemiZ95O1p6pL5M/q29ypOlsUAL73N7ak6szDqIOcXAd9CogXBpBQGjqgiyE+M0
 FwsDo0zI5uvvDXN2n78/6vTOhsSxWpAE8+XFztrUFfh6kLgEuv5Xv5Tm/3e5RMrb39s/zYyvL
 6d90fy8YgIHfffe3Lp+fahblBA/CgaCWuzH90VsjBGLCYHWpt2qqRnMeGUDgG0tBJd5LTjfu/
 UUZTbGx+8kHJJY7jHnzs3yPJDX51JbjJT4+JPcshKMt9l4HalHTm/qv/xUAIoOy/MZk1JWrMd
 5Y3GQI3XJfr/GgHp3bJJY7FMdN5Z/nzy5yAK4uSzVMhZceUV91KTN2H+cdVUpWqdLXmT1L59D
 zMWQyVfSJVsfNGlhRFyOYeYlcjPI4QADWoVHzPFlI9zC/gPhrauMO670dq2FOnsN25Tjh3YCU
 Py77lYvbKsgtrsXF/FOQYZbA481wVtdAwTZv2SbcD/71dejhO2hZZhZTt2sGEih0DytYYKBUK
 JQYRFUePyyhysZwmDU5iIN2ZYbdllK8A7jYmrAjqqCm7y8tB9QkbyMhrsFRoii9pkJ2qkuMV/
 oosm7c11sAxUZlv1j2ovI/0+iGirH1VW2ZgbhTBsBPgHJL1NycjH7xUtCMcvgWbAlKEn25/s/
 w5qEMD0odnQ2JDRHIShTSlhNia9jFFX4vjypDILqVzMsKopL3LACgf0t2AZO2i7niUTGKi+qo
 4OnlzBpPvarRSgXwbexDXlZj4tvz+Xo32dzS0n5aLfk4qN1P0XAjl5MIWDdSIGfnhIAcxfxeO
 6TEKL634RUMyyICutj0HQwwivDUb8rXDXXuOC1y6d0uLk=
Message-ID-Hash: 7EQ5LMQMB7JWXYOFA7FM4MAOZZHVHE3Z
X-Message-ID-Hash: 7EQ5LMQMB7JWXYOFA7FM4MAOZZHVHE3Z
X-MailFrom: oswald.buddenhagen@gmx.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7EQ5LMQMB7JWXYOFA7FM4MAOZZHVHE3Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Both bounds had off-by-one errors.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/synth/emux/emux_seq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index b227c7e0bc2a..1adaa75df2f6 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -65,11 +65,11 @@ snd_emux_init_seq(struct snd_emux *emu, struct snd_card=
 *card, int index)
 		return -ENODEV;
 	}
=20
-	if (emu->num_ports < 0) {
+	if (emu->num_ports <=3D 0) {
 		snd_printk(KERN_WARNING "seqports must be greater than zero\n");
 		emu->num_ports =3D 1;
-	} else if (emu->num_ports >=3D SNDRV_EMUX_MAX_PORTS) {
-		snd_printk(KERN_WARNING "too many ports."
+	} else if (emu->num_ports > SNDRV_EMUX_MAX_PORTS) {
+		snd_printk(KERN_WARNING "too many ports. "
 			   "limited max. ports %d\n", SNDRV_EMUX_MAX_PORTS);
 		emu->num_ports =3D SNDRV_EMUX_MAX_PORTS;
 	}
--=20
2.44.0.701.g2cf7baacf3.dirty

