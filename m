Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62440C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:34:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4C620637
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l7alQaBn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eilnp7tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4C620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 286BD1819;
	Fri, 22 Nov 2019 08:33:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 286BD1819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574408046;
	bh=lm2yaK78WhfYDkpLdtLDs8UpJ1RJUYzXd0JiSqhXw00=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7alQaBnIZdSqcKV2bzYxgoVQqT8yhYkeeirmKhYZ9ccu11MeaHXY7kKZaAKRUg8o
	 8yk/LuR6BTmyLoZb9h5W/tE2zGmRStJVxL/mxo5/ZCHOicaht8ZBO/2xRC2jJm1/8x
	 9P4SJ075XwU/vNTG/sXA+/IP427imLOvlV1fgmMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F96DF8015E;
	Fri, 22 Nov 2019 08:31:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 305D3F800EF; Fri, 22 Nov 2019 08:31:41 +0100 (CET)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25ADFF800EF
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 08:31:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25ADFF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="eilnp7tg"
Received: by mail-qv1-xf4a.google.com with SMTP id i11so4115252qvh.3
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 23:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XToaK8EPKMSFVNDfuYBU6xitfR3t3zaNWQXXu2VYm6w=;
 b=eilnp7tgXacQivphC9qMuwwfGA8bVOPzogUP2PzADXjhn7jxYC34xFSFHmpnWe1HLB
 jy4c0oB29W7ZM2Vdx8RyVX6ue+AZ65HwY8Mbh9cwLknaOgnMgegfRh4bnPlXqPnGBtSW
 8fKN6bQMZeSmmxMTNvufea+TeB4uLrMomwt/sx6gisgEhXP8+xjvGoXKu9NRJ3NEOXep
 7bXke6n7Cu8BxYRqababF9lEa3ewbQYou0L0BZXKxYZWl9Mn75DQTTKg2i4NvBFt+swt
 ZIlAc2tpfdf9Yz5Y9daURgsOSZr+R08cEDUYE8Vb1ML8ceYGjjrRHjzWUuMEWbk4oAB3
 Gk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XToaK8EPKMSFVNDfuYBU6xitfR3t3zaNWQXXu2VYm6w=;
 b=sHJHxGou/ZVG+PZlndLTeBN+xEK+y+MvravNSSU445ltHfTzpiOu9As6/Qn9T+/ftq
 UAkvptDc2w8j6z/BSmvFomuJ3MB1JIyhE0IersKf8GTQEjDXDrpqOqkgf7f+0K0/Suwg
 h4UFdrtADRJneCdEn3EFS3P1KKM1lxIMaU4Cajah2xnkVXvSo/dZ4VwsIp+sYfjgVKWO
 QXADSkK/Kn4V97KvlXWRB9jLGS1frwUHNqQxmYDJ+RMVmXoBDqxR/zp/SYLPSORLxusu
 OSxCFMu//zUZIqtXf8UvpKUalqSr+lTGXpozqCrMVUG/lQMKg68vCXRRsEIymuHrG5zI
 LwkQ==
X-Gm-Message-State: APjAAAW+Zzcb6NLICFKzu23BDA9yHtBOxoNJSkAQcBQZSEMZ9MNC2tou
 3CQncfpzurQW0FLRszMUEjebWgQOD5mp
X-Google-Smtp-Source: APXvYqxQQD0jlvUnAAaL/mRUOsNAZnYAa991+CXptM0eE0+L9ndBvIP7MzsnMh56SMTTlXByuuibF9bS0n3p
X-Received: by 2002:a0c:fa50:: with SMTP id k16mr12001606qvo.172.1574407895258; 
 Thu, 21 Nov 2019 23:31:35 -0800 (PST)
Date: Fri, 22 Nov 2019 15:31:13 +0800
In-Reply-To: <20191122073114.219945-1-tzungbi@google.com>
Message-Id: <20191122073114.219945-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20191122073114.219945-1-tzungbi@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH v2 2/3] ASoC: max98090: exit workaround earlier
	if PLL is locked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

According to the datasheet, PLL lock time typically takes 2 msec and
at most takes 7 msec.

Check the lock status every 1 msec and exit the workaround if PLL is
locked.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/max98090.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 12cb87c0d463..f531e5a11bdd 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2108,6 +2108,8 @@ static void max98090_pll_work(struct work_struct *work)
 	struct max98090_priv *max98090 =
 		container_of(work, struct max98090_priv, pll_work);
 	struct snd_soc_component *component = max98090->component;
+	unsigned int pll;
+	int i;
 
 	if (!snd_soc_component_is_active(component))
 		return;
@@ -2127,8 +2129,16 @@ static void max98090_pll_work(struct work_struct *work)
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
 
-	/* Give PLL time to lock */
-	msleep(10);
+	for (i = 0; i < 10; ++i) {
+		/* Give PLL time to lock */
+		usleep_range(1000, 1200);
+
+		/* Check lock status */
+		pll = snd_soc_component_read32(
+				component, M98090_REG_DEVICE_STATUS);
+		if (!(pll & M98090_ULK_MASK))
+			break;
+	}
 }
 
 static void max98090_jack_work(struct work_struct *work)
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
