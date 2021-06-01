Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD2C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 21:45:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD125613BC
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 21:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD125613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8627616CF;
	Tue,  1 Jun 2021 23:44:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8627616CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622583936;
	bh=zKEuRh3QZvzK3KPbzAIoqP94TsaQWE0ojkZB7e8gUBU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bFvrLnXOJXFExfCY5oHnD3XPOqbcWbU+EjV8ssU+cjwyPuSg/h0hZ1L5rWaliUR5j
	 +9QxoLLtXyWMH5IPSVST8lT4VC5dsU0DLCHLOuyNAeCPNsMvZny6hhQhBQXuVqr0eX
	 KV6R0rLY14h+RXgB9j5HC0TWBvJWWKhgjWQS8CbE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D277F80253;
	Tue,  1 Jun 2021 23:44:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9404F80254; Tue,  1 Jun 2021 23:44:43 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC972F80141
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 23:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC972F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="X+66xa1N"
Received: by mail-oi1-x235.google.com with SMTP id x15so744204oic.13
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m2jSbDzFQxJVPkX9wWnQHslCI+0Vych+K1kXWHexGRU=;
 b=X+66xa1NeLwDoC6qBRhC7+OLEtu7IpItYVb0NJ4giS9dLIQEujX4cngkZALdCjjY8m
 zO9GaRSMPsYKJ5a1dYcPmynrW77warNWAyvM+QSODLLWpBePh7t8rTR42fLf1FDYJEV4
 wbt0VaSpuwLmNGfB9VYsre/vkJYs32/Zn/yi7Jc8eKcGlDWaniGqnBORwqb9SgKuK7HT
 lYiNYAF82+WhEqqPmO5Z8jTTZ0iaJGmXErWr9AV0bL66WlxMBP5LRzK+QfwFbQTwOqvt
 SNpYPbE90+uLbWAQbqN8fRfVnSt4i78at3085MvWk3wzrrXTkWKrbR9NX9AHHKlFrpkM
 YvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m2jSbDzFQxJVPkX9wWnQHslCI+0Vych+K1kXWHexGRU=;
 b=PjeZjMOObXvk8uslPwj5BRkTbSMcGcYeD51AWakZHzDIhBNiVCPR/RMFdWfYDX2tcO
 8CP37xRIz7fQ855+ZAOipJEeWO/ZsOhBWJenkNzbKSeNe2YdecK676DeA/8Q8g2TY/kU
 /CtIsbFXQyhVLgGISXweoltxcyvl4SKeIc8dWaOSiFkQrMv9yD9J7udlHwLXRvfxrbxR
 Gy+qyrhdPF7+v5Hx6feWp5FFkD4OtWb9myvKaakm8BGEdu+POjIHV9Vg+WdU0dCaP+nl
 m3Gj10o8nrMs6bbPJcKhwD8jp7i5ZZbMx3DVPWpoKw3hemzd+xERUBEBOCguRiNQCyZd
 SLyA==
X-Gm-Message-State: AOAM532IPoOnE5bLScvKi1rgiXvn8WboqYh/84vAMfJVuiMdAmJKHbUK
 nyMLwcYvh5VFsWDgVTp3I5QKDXbWviQ=
X-Google-Smtp-Source: ABdhPJxM7zmpKF7WbOWcOrlqa4mViYf71xE3SF8omG87A3XfAN89dzaivJY8MDuzP8DEx4e1NlyfkA==
X-Received: by 2002:aca:4d07:: with SMTP id a7mr1487930oib.106.1622583873629; 
 Tue, 01 Jun 2021 14:44:33 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com.
 [76.183.134.35])
 by smtp.gmail.com with ESMTPSA id x14sm3737524oic.3.2021.06.01.14.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 14:44:32 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rk817: fix a warning in rk817_probe()
Date: Tue,  1 Jun 2021 16:44:24 -0500
Message-Id: <20210601214424.23432-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, heiko@sntech.de,
 devicetree@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, broonie@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 lee.jones@linaro.org, maccraft123mc@gmail.com
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

From: Chris Morgan <macromorgan@hotmail.com>

The return value of snd_soc_component_write() is stored but not
evaluated and this results in a warning when W=1 is set. Stop storing
the return value to be consistent with all other calls of
snd_soc_component_write() and to remove the warning.

Fixes: 0d6a04da9b25 ("ASoC: Add Rockchip rk817 audio CODEC support")

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 sound/soc/codecs/rk817_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index 17e672b85ee5..fd3a5ba034a9 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -415,12 +415,11 @@ static int rk817_probe(struct snd_soc_component *component)
 {
 	struct rk817_codec_priv *rk817 = snd_soc_component_get_drvdata(component);
 	struct rk808 *rk808 = dev_get_drvdata(component->dev->parent);
-	int ret;
 
 	snd_soc_component_init_regmap(component, rk808->regmap);
 	rk817->component = component;
 
-	ret = snd_soc_component_write(component, RK817_CODEC_DTOP_LPT_SRST, 0x40);
+	snd_soc_component_write(component, RK817_CODEC_DTOP_LPT_SRST, 0x40);
 
 	rk817_init(component);
 
-- 
2.25.1

