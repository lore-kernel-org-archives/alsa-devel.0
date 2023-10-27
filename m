Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D63C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Nov 2023 16:21:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77C71827;
	Fri,  3 Nov 2023 17:20:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77C71827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699028466;
	bh=SHXuxzFvYXcvhYeUZbkXSLDg70K2FX2H323uPwjGRYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FsI06XwbmbUQEqjDSI8al9wgX3Tg4UaHC1T+tbYV1M/yQMsHg4OGevnhKITD8S9H7
	 Ew1rnwExJel9pUE4VwVD7AoX/+pFyyrOFjx0cpDfhu4hDqUXEhFBnbbJDeAgm5xwRC
	 e4T6edEV8HGaiG6f3ZKD6HvoWZYFAzTom51M1OJY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49E4BF805C7; Fri,  3 Nov 2023 17:18:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD79BF805C7;
	Fri,  3 Nov 2023 17:18:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3DA3F8019B; Fri, 27 Oct 2023 16:51:26 +0200 (CEST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85185F80165
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 16:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85185F80165
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com
 header.a=rsa-sha256 header.s=DFC430D2-D198-11EC-948E-34200CB392D2
 header.b=B141Uhok
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 30AC49C336E;
	Fri, 27 Oct 2023 10:51:23 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Huc8k3_z90CZ; Fri, 27 Oct 2023 10:51:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B92679C336B;
	Fri, 27 Oct 2023 10:51:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B92679C336B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698418282; bh=MZJUJ3iJ5MYbHjsiC7F4cSgtWodH6jOKqbrvkgZ1L1k=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=B141Uhok3q9Qpjr1uNI1fmgs1kNoDsNhgKgj1cYeFL1IdNkKPrxGNMif7DCzOnvCl
	 I1btVlXMEnNaQgcQUUF58IplClMmLx2LpcEV+KA5M/Wgzj3a27lTBWCTZZWvs9YACt
	 JDmvS4DwBgvmkblVxPjdYHhFyA/kO+v1U/YphkTMGwIk379yzUhfcOPGqcuEvUTosE
	 6Tvopk/OhZWJQZNq+EASvUvU4fjv+gm9JWSnTNs+VLvIvA50tnETX1eyeC52RdNeFA
	 VDZMOZfbhrZMI3XSdbB9a1S/MAxqRsFqTXFvNV+C3HyJRSxS7YlSHAkeFnoOTjoMTg
	 UwhO9yt3KDH2A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FTEtwwnXJj5Y; Fri, 27 Oct 2023 10:51:22 -0400 (EDT)
Received: from gerard.rennes.sfl
 (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C92909C3364;
	Fri, 27 Oct 2023 10:51:21 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	broonie@kernel.org
Cc: elinor.montmasson@savoirfairelinux.com,
	alsa-devel@alsa-project.org,
	philip-dylan.gleonec@savoirfairelinux.com
Subject: [PATCHv2 06/10] ASoC: fsl-asoc-card: add dts property
 "cpu-slot-width"
Date: Fri, 27 Oct 2023 16:47:31 +0200
Message-Id: <20231027144734.3654829-7-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027144734.3654829-1-elinor.montmasson@savoirfairelinux.com>
References: <20231027144734.3654829-1-elinor.montmasson@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MailFrom: elinor.montmasson@savoirfairelinux.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: INUJYSEH5IBO6C7CC43OBTXQZTXQAXO7
X-Message-ID-Hash: INUJYSEH5IBO6C7CC43OBTXQZTXQAXO7
X-Mailman-Approved-At: Fri, 03 Nov 2023 16:18:04 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/INUJYSEH5IBO6C7CC43OBTXQZTXQAXO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add new optional dts property "cpu-slot-width", which allows to set a
custom TDM slot width in bits for the CPU DAI
when using the generic codec.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Co-authored-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelin=
ux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.=
c
index 61c0fd97cde3..42aa6ec306ec 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -724,6 +724,7 @@ static int fsl_asoc_card_probe(struct platform_device=
 *pdev)
 		priv->dai_link[0].num_codecs =3D 2;
 		priv->dai_link[2].num_codecs =3D 2;
 		priv->dai_fmt |=3D SND_SOC_DAIFMT_CBP_CFP;
+		of_property_read_u32(np, "cpu-slot-width", &priv->cpu_priv.slot_width)=
;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret =3D -EINVAL;
--=20
2.25.1
