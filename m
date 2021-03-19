Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E8C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 03:05:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A91564E4D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 03:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A91564E4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 490AB169A;
	Fri, 19 Mar 2021 04:04:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 490AB169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616123146;
	bh=p09m9mao52BQFeyQL4tbIH7WZA5fzkiV0wTB2GnED7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szipjE/Sd8S6hLYMVlfNwlYnpUyAVJa/iRQcBUKwGb+LpLQKMRXRZNQL7EhYRzEZe
	 SmnKllrJ0tXf6KOkTlh/qDSh9Cql7l7ztBJ4Rw7KXQgSz4gttlPoBfjdj4y1V1GDlw
	 wXWrkTTPni8aG1NmRmQGFMsT6CjcHjV09nuwMY10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8CEAF80253;
	Fri, 19 Mar 2021 04:04:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D7A1F8023C; Fri, 19 Mar 2021 04:04:02 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F789F800E0
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 04:03:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F789F800E0
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J33oKbA013734,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J33oKbA013734
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 19 Mar 2021 11:03:50 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 11:03:50 +0800
From: Jack Yu <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 2/2] ASoC: rt715: modification for code simplification
Date: Fri, 19 Mar 2021 11:03:37 +0800
Message-ID: <20210319030337.16213-2-jack.yu@realtek.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210319030337.16213-1-jack.yu@realtek.com>
References: <20210319030337.16213-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

Modification for code simplification.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt715.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index c461a4c23fd3..a9e4741269ba 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -57,14 +57,14 @@ static void rt715_get_gain(struct rt715_priv *rt715, unsigned int addr_h,
 {
 	int ret;
 	/* R Channel */
-	*r_val = (val_h << 8);
+	*r_val = val_h << 8;
 	ret = regmap_read(rt715->regmap, addr_l, r_val);
 	if (ret < 0)
 		pr_err("Failed to get R channel gain.\n");
 
 	/* L Channel */
 	val_h |= 0x20;
-	*l_val = (val_h << 8);
+	*l_val = val_h << 8;
 	ret = regmap_read(rt715->regmap, addr_h, l_val);
 	if (ret < 0)
 		pr_err("Failed to get L channel gain.\n");
@@ -205,8 +205,8 @@ static int rt715_set_amp_gain_get(struct snd_kcontrol *kcontrol,
 
 	if (mc->invert) {
 		/* for mute status */
-		read_ll = !((read_ll & 0x80) >> RT715_MUTE_SFT);
-		read_rl = !((read_rl & 0x80) >> RT715_MUTE_SFT);
+		read_ll = !(read_ll & 0x80);
+		read_rl = !(read_rl & 0x80);
 	} else {
 		/* for gain */
 		read_ll = read_ll & 0x7f;
-- 
2.29.0

