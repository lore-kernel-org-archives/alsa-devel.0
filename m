Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC56C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56CE2074B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="evasadRM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="13+czhf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56CE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4162D1660;
	Tue,  9 Jun 2020 01:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4162D1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591658732;
	bh=yelJ21b3v0Rc7rYz3Zzu5h2wxtT86ub0XQvVeh7D2zE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evasadRM9iwRW0l3YsA2bbt4hVB7oYxpPgMj0fGbr9A+jatEADiSeQVSKLGfpm+UR
	 M0aDrEqjcnU/37yjKfdkbdy+CpAmxljbQProL6oif0xGBtjsy9CAAwBdh1xmUg+uv9
	 nlQmeVQtHYB3+u1QS+QOTfdjAlAm5/gYQj3t9EG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15194F802EC;
	Tue,  9 Jun 2020 01:18:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDDD0F802E2; Tue,  9 Jun 2020 01:18:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 149CCF802C2
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 01:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 149CCF802C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="13+czhf0"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1566A20842;
 Mon,  8 Jun 2020 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658324;
 bh=yelJ21b3v0Rc7rYz3Zzu5h2wxtT86ub0XQvVeh7D2zE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=13+czhf0MrDvFxljm2he3+ntQM/pIT958vXsn/NOHq9yqrPAfmmbnPWTm3anPzZNE
 XklqtRQgCy9wsXNrVQsfKTDnKG3/rXnnibhZ59aA/iHJQvEhDrKnAkLbBHJDstQi9W
 eaZeY0DTJN1k4zKylzxAyFEZ2VSot2YAuCU5Ggz0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 324/606] ALSA: hda/realtek - Add new codec
 supported for ALC287
Date: Mon,  8 Jun 2020 19:07:29 -0400
Message-Id: <20200608231211.3363633-324-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>
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

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 630e36126e420e1756378b3427b42711ce0b9ddd ]

Enable new codec supported for ALC287.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/dcf5ce5507104d0589a917cbb71dc3c6@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 92c6e58c3862..e62d58872b6e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -384,6 +384,7 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0282:
 	case 0x10ec0283:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
 	case 0x10ec0285:
 	case 0x10ec0298:
@@ -8292,6 +8293,7 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0215:
 	case 0x10ec0245:
 	case 0x10ec0285:
+	case 0x10ec0287:
 	case 0x10ec0289:
 		spec->codec_variant = ALC269_TYPE_ALC215;
 		spec->shutup = alc225_shutup;
@@ -9570,6 +9572,7 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0284, "ALC284", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0285, "ALC285", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0286, "ALC286", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0287, "ALC287", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0288, "ALC288", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0289, "ALC289", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0290, "ALC290", patch_alc269),
-- 
2.25.1

