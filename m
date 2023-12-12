Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7C2C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Dec 2023 10:42:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75253DED;
	Tue, 12 Dec 2023 11:42:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75253DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702377771;
	bh=EWNSETg9yq21XZwuUz/IVrLOyer/74TXpPqHUh33ktY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=s3jbIaPJI3RqwNj/71jB7fle/hFdaSQaA11mS0oezoU0tQikJSfp58ljX1ORqWzdo
	 7kwjFiFmMp6HMqf+Z6A3y7XKcaBPRkZeDKYnxeKMD+ksCbHHxYSVAgH1MHC08YrW3n
	 CqH/tP25zoByKwQuUGnlp3ApjYc0RwdneRqvzas0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0722F80588; Tue, 12 Dec 2023 11:42:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82B0AF80557;
	Tue, 12 Dec 2023 11:42:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43133F8016A; Tue, 12 Dec 2023 11:42:06 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D2C7F80124
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2023 11:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D2C7F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=gEetVJqy
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BC7hp9P027901;
	Tue, 12 Dec 2023 04:41:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=S
	jSfjnzX2kgKs2OORwGVP88+lFNDDFtHEENCImnrvG8=; b=gEetVJqyAbWbrTgxx
	3BjLyFH4NEuFPE2KygocmlHLsU5aOAdVsBmmoCCd34XYP7MwnLYCqkwJEwN53ljA
	aTRhMhhmT45ABazn4s3KNjIq555lUjdQgl5RKdb+paXv9dJCToYgOcd9npdK9F7x
	0uhyhQN0e1JxCyJR1L6mzlnToP+f/ZBe6Rf1JhXCZiT7pll0Kv0DcAMjSZpoxRsj
	WoDCkFDKorRdhs+ySGGJL5P62S5b+ZMb6EFZW8xq9rDoPXDSqPzTIDPr8xjxLzko
	tWBdP0qXdd/xDKClErsg7y8i+sAJ3sDyIDdmnhuoiOJusjWx9S8pYNKEU23LgWPB
	pSlFA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3uwawka8vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 04:41:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 10:41:50 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 12 Dec 2023 10:41:50 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DBBDA468;
	Tue, 12 Dec 2023 10:41:49 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <sfr@canb.auug.org.au>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l43: Add missing statics for hp_ilimit functions
Date: Tue, 12 Dec 2023 10:41:49 +0000
Message-ID: <20231212104149.2388753-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jqSYpUkfmg95LRwyJseQ-gSJ3IzKVT5_
X-Proofpoint-GUID: jqSYpUkfmg95LRwyJseQ-gSJ3IzKVT5_
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: OGLAZB2IVB52PURNHD3UEXPJDLN2ORI4
X-Message-ID-Hash: OGLAZB2IVB52PURNHD3UEXPJDLN2ORI4
X-MailFrom: prvs=7710dd07de=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OGLAZB2IVB52PURNHD3UEXPJDLN2ORI4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fixes: bbbc18d8c27c ("ASoC: cs42l43: Allow HP amp to cool off after current limit")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index d2412dab35996..6a64681767de8 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -139,7 +139,7 @@ CS42L43_IRQ_ERROR(spkl_therm_warm)
 CS42L43_IRQ_ERROR(spkr_sc_detect)
 CS42L43_IRQ_ERROR(spkl_sc_detect)
 
-void cs42l43_hp_ilimit_clear_work(struct work_struct *work)
+static void cs42l43_hp_ilimit_clear_work(struct work_struct *work)
 {
 	struct cs42l43_codec *priv = container_of(work, struct cs42l43_codec,
 						  hp_ilimit_clear_work.work);
@@ -156,7 +156,7 @@ void cs42l43_hp_ilimit_clear_work(struct work_struct *work)
 	snd_soc_dapm_mutex_unlock(dapm);
 }
 
-void cs42l43_hp_ilimit_work(struct work_struct *work)
+static void cs42l43_hp_ilimit_work(struct work_struct *work)
 {
 	struct cs42l43_codec *priv = container_of(work, struct cs42l43_codec,
 						  hp_ilimit_work);
-- 
2.39.2

