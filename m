Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57E6C4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Dec 2022 16:22:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0A1F27BD;
	Sun, 18 Dec 2022 17:22:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0A1F27BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671380575;
	bh=Zr5+rd/DM/JA4jkAFChvzZ1KpESeG0fHR5HoskmIKQA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SbK1o1Y/MfGcQpnmYDfWBPVZmxY+CKaUFpQNlDZnjBwNUCLcgbGZCK9SXUZ8ttrk4
	 arBGdcOjMh5LJIC5HO19Sp5y9wpGtDYiVTjANFCg9n6f/NgY/LNAdEamoJP4yedPgj
	 izyyB19u/5XxanjqRQ+Q0FY1YTxvLJIRcib/ogmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75E1DF8032B;
	Sun, 18 Dec 2022 17:22:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 540B4F80496; Sun, 18 Dec 2022 17:22:04 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A187F8014C
 for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2022 17:22:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A187F8014C
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=K+abHEaI
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7C242CE0B9A;
 Sun, 18 Dec 2022 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB8C433D2;
 Sun, 18 Dec 2022 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671380516;
 bh=Zr5+rd/DM/JA4jkAFChvzZ1KpESeG0fHR5HoskmIKQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K+abHEaIeDgaIvjbYl6oJFEPfFuhas7Y4XVHQypjqLLH4ocfh879k+43strGiKLt8
 YDhrqP7v5mHY6XsHw8FSl84KgDWLujLkWmqoHVWbT1xAsvYCFS01yp5zS7m4bI0hLR
 dJpGbjf4RPIvjrsbzEopHWVXjzyod6ar3QLRX+y2oZizWNDPjFiRPLIiZVCJxDsQps
 vYGiZYgEqHadvGR1uPaJiqlSQFB6+w09BsviOfoZe+/ANu9ivHeQdL0lOKxk3VUDYT
 GLWoCLwy2NiPiUtT2CFBerFwcBDGsoIrnYq2ts76uRvKfMuHfGozPtGtPqTVBtSDD7
 TdD5KuNUsylIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/23] ASoC: codecs: rt298: Add quirk for KBL-R
 RVP platform
Date: Sun, 18 Dec 2022 11:21:29 -0500
Message-Id: <20221218162149.935047-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218162149.935047-1-sashal@kernel.org>
References: <20221218162149.935047-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 953dbd1cef18ce9ac0d69c1bd735b929fe52a17e ]

KBL-R RVP platforms also use combojack, so we need to enable that
configuration for them.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20221010121955.718168-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt298.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ce963768449f..041955eb7922 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1170,6 +1170,13 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Geminilake")
 		}
 	},
+	{
+		.ident = "Intel Kabylake R RVP",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kabylake Client platform")
+		}
+	},
 	{ }
 };
 
-- 
2.35.1

