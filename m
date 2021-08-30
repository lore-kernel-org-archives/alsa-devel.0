Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F58C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 06:39:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00EA60FC0
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 06:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A00EA60FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7ACC01612;
	Mon, 30 Aug 2021 08:39:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7ACC01612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630305596;
	bh=G1xHFWtd4mo9ovxeKK1kuUZTEFUWqoJvkP1DMCyQm6Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=biHeMbYgnj+Qh/wDEiJHLdcM/2tpYu8pOmN5zDIWJ4bSem1QuskDRpfpJuAsTvUAy
	 YBXeiP5nh29dQH2gdgBS290TZK7aCvfzGR72MbJYxNKhgGEMm9uZJGsKQLcZ0YsbZ6
	 bs1h1GGSwxO9b+F85Kt1N/XYxl2+8RfqS2myUqzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07E57F80169;
	Mon, 30 Aug 2021 08:39:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33AB6F80218; Mon, 30 Aug 2021 08:39:04 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.133])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5D95F80169
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 08:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5D95F80169
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id 20F3CD5E13;
 Mon, 30 Aug 2021 14:38:49 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P704T139881204397824S1630305528227144_; 
 Mon, 30 Aug 2021 14:38:49 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7b7901ce8f4b6bf32dce0f979db0edb9>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH v2] ASoC: rockchip: i2s: Fix concurrency between tx/rx
Date: Mon, 30 Aug 2021 14:38:45 +0800
Message-Id: <1630305525-65759-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
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

This patch adds lock to fix comcurrency between tx/rx
to fix 'rockchip-i2s ff070000.i2s; fail to clear'

Considering the situation;

       tx stream              rx stream
           |                      |
           |                   disable
         enable                   |
           |                    reset

After this patch:

         lock
           |
       tx stream
           |
         enable
           |
        unlock
       --------               ---------
                                lock
                                  |
                              rx stream
                                  |
                               disable
                                  |
                                reset
                                  |
                               unlock

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2:
- Fix compile error.

 sound/soc/rockchip/rockchip_i2s.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c7dc350..88e340f 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/spinlock.h>
 #include <sound/pcm_params.h>
 #include <sound/dmaengine_pcm.h>
 
@@ -49,6 +50,7 @@ struct rk_i2s_dev {
 	bool rx_start;
 	bool is_master_mode;
 	const struct rk_i2s_pins *pins;
+	spinlock_t lock; /* tx/rx lock */
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -92,6 +94,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 	unsigned int val = 0;
 	int retry = 10;
 
+	spin_lock(&i2s->lock);
 	if (on) {
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
@@ -132,6 +135,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 			}
 		}
 	}
+	spin_unlock(&i2s->lock);
 }
 
 static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
@@ -139,6 +143,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 	unsigned int val = 0;
 	int retry = 10;
 
+	spin_lock(&i2s->lock);
 	if (on) {
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
@@ -179,6 +184,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 			}
 		}
 	}
+	spin_unlock(&i2s->lock);
 }
 
 static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
@@ -589,6 +595,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	if (!i2s)
 		return -ENOMEM;
 
+	spin_lock_init(&i2s->lock);
 	i2s->dev = &pdev->dev;
 
 	i2s->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
-- 
2.7.4



