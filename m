Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81EC43462
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 09:36:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738DB61027
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 09:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738DB61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0368315F2;
	Mon, 19 Apr 2021 11:35:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0368315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618824989;
	bh=qbJUsbPvUeIowbOn4zVxIT+HuRx3goLcwFO3/pYPjXQ=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rJTnLX7W0+B5ABYWIaC+o1hQX2AuKX5N4ifYCcmztl6S4NbpKJKDx0awBwo84yS+d
	 C+unHh3oHeVmaTWgLZa6ILmnxu2ccVh6oFwy7tl8jwOq+Koj7/SL7SjQO8ePN1UNQR
	 ibX9N5I1XyClHmxq8BAhT9NkxHUW/qmVKmSXp0mU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77900F80164;
	Mon, 19 Apr 2021 11:35:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08E56F80227; Mon, 19 Apr 2021 11:35:35 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 540ACF80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 11:35:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 540ACF80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CAEt3s53"
Received: by mail-yb1-xb4a.google.com with SMTP id
 o187-20020a2528c40000b02904e567b4bf7eso7124415ybo.10
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=8WNrhjLyGdyDWHM865ZCSJ0+zVt77fNMyFmGjFGrnl4=;
 b=CAEt3s53rOTQrQyMSGDziVgDrIyTUMOlQuNe0Tk+6QH1Nu046WxDAwSUeb9ImRFQGA
 gwnNZctQXHXthNf0nIiNzSkO1yyVNd7JyYGFcUiZSM9ode7MlEr2n0iXKxYwbcx+Pzh/
 XvMNKjhb+Xy5sy5L79ZtyNattUmxFOurOIWY/cOiNtuYyIlCXDo7f04rUtepM47IF0Mw
 PVSBmF+iSKx5R4XGmgTO3FgwzZkKtfzMhr1ftR4qXtZcwydVWlaKh9BOJWbQz6CuUEKD
 DfhH7sdV8GxzSOQXKWz58LIze6jme/Qq7B9mGDLtpkm/RKrg9sDrte+mRbFBS6BgT481
 Jt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=8WNrhjLyGdyDWHM865ZCSJ0+zVt77fNMyFmGjFGrnl4=;
 b=sCd5cq61lWWLg78C0P+9AWO4tuigEQSMKSJ3deJMXnCYb1JVqt+pTlCvtiXTC1aKyw
 GkQLKjQ+iJBapLKrGgBRH9MIRobSl0sq7F1lINfv2gY1cDfzodCg+HdRtf8m4bfOFyM7
 Ouw+pcvKJHSxO0YDtUMKr4Kvwk4j/LWQDN1WdyK1I4mpoqu1/UFTIthfZ8vVT25yLpyY
 uxGSEV6/esARR4YSNcczc6yVw5QlC00GxegIpun6jBUmV76NwR3rkVWEZBOjZ88og3OI
 jRmdv8+a/zt7RNcFZAg/RFcqLiD40gSeyYh+tXfdznHf1qUvkkSuXJSk8c2uqTlSHRUN
 TWAA==
X-Gm-Message-State: AOAM533Q+zOcuoQC2XIE1KucZYNywWYT1PAYQX3Ml//xlSAaGGO0mIJL
 UJP7vMAJPtZMWU699vyKuOaJkFQFCDdV
X-Google-Smtp-Source: ABdhPJzBRm7VdHEJmg0TVEqWdqGpo383048pfypHGJSkLrWN945dqM4Gi1tsqSwWKdDgxo8u869CRLRnuG9a
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:907f:7138:4a1f:7db])
 (user=tzungbi job=sendgmr) by 2002:a25:c754:: with SMTP id
 w81mr15258408ybe.492.1618824919014; Mon, 19 Apr 2021 02:35:19 -0700 (PDT)
Date: Mon, 19 Apr 2021 17:34:49 +0800
Message-Id: <20210419093449.3125704-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] pinctrl: mediatek: use spin lock in mtk_rmw
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, sean.wang@kernel.org, linus.walleij@linaro.org, 
 matthias.bgg@gmail.com, zhiyong.tao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, tzungbi@google.com,
 andy.shevchenko@gmail.com, linux-mediatek@lists.infradead.org,
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

Commit 42a46434e9b1 ("pinctrl: add lock in mtk_rmw function.") uses
mutex lock in mtk_rmw.  However the function is possible called from
atomic context.

For example call trace:
  mutex_lock+0x28/0x64
  mtk_rmw+0x38/0x80
  [snip]
  max98357a_daiops_trigger+0x8c/0x9c
  soc_pcm_trigger+0x5c/0x10c

The max98357a_daiops_trigger() could run in either atomic or non-atomic
context.  As a result, dmesg shows some similar messages: "BUG: sleeping
function called from invalid context at kernel/locking/mutex.c:254".

Uses spin lock in mtk_rmw instead.

Fixes: 42a46434e9b1 ("pinctrl: add lock in mtk_rmw function.")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---

Changes from v1[1]:
- Snip call trace.
- Use _irqsave and _irqrestore version of spin lock.

[1]: https://patchwork.ozlabs.org/project/linux-gpio/list/?series=239749

 drivers/pinctrl/mediatek/pinctrl-moore.c         | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 5 +++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index f77921957f15..3a4a23c40a71 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -619,7 +619,7 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 
 	hw->nbase = hw->soc->nbase_names;
 
-	mutex_init(&hw->lock);
+	spin_lock_init(&hw->lock);
 
 	/* Copy from internal struct mtk_pin_desc to register to the core */
 	pins = devm_kmalloc_array(&pdev->dev, hw->soc->npins, sizeof(*pins),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index fcf7c3eeee4a..fc79b3a7a188 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -57,15 +57,16 @@ static u32 mtk_r32(struct mtk_pinctrl *pctl, u8 i, u32 reg)
 void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set)
 {
 	u32 val;
+	unsigned long flags;
 
-	mutex_lock(&pctl->lock);
+	spin_lock_irqsave(&pctl->lock, flags);
 
 	val = mtk_r32(pctl, i, reg);
 	val &= ~mask;
 	val |= set;
 	mtk_w32(pctl, i, reg, val);
 
-	mutex_unlock(&pctl->lock);
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 65eac708a3b3..13836bb188b7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -252,7 +252,7 @@ struct mtk_pinctrl {
 	struct mtk_pinctrl_group	*groups;
 	const char          **grp_names;
 	/* lock pin's register resource to avoid multiple threads issue*/
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set);
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 48e823f6d293..85db2e4377f0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -970,7 +970,7 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 
 	hw->nbase = hw->soc->nbase_names;
 
-	mutex_init(&hw->lock);
+	spin_lock_init(&hw->lock);
 
 	err = mtk_pctrl_build_state(pdev);
 	if (err) {
-- 
2.31.1.368.gbe11c130af-goog

