Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CBC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:52:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B0520888
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bwLDTTCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bVyqlbjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0520888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D039A9F6;
	Wed, 17 Jun 2020 17:51:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D039A9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592409144;
	bh=JNdpTkIk6QqnwCKmsncA3bjzpvucLeTAJXs5iaa0w94=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bwLDTTCbUNYDGDN4psTc8tlVkL0ZnWdB05qLHi7IIpO/VHpNk/C4yUgtaUVwTlmIu
	 R5dXzFF/j/ub7qMb6PL2eSTJiTPjmwJKJeyvayTpTSDgM1w8Se6Wc2GpYAc+mYx6H0
	 lRkgjM+DEh59D6AHb+8FD0zgBJ02Zr/rqrCJJ8so=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAB33F801EB;
	Wed, 17 Jun 2020 17:51:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F758F801ED; Wed, 17 Jun 2020 17:51:01 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 537A1F80116
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 17:50:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 537A1F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="bVyqlbjO"
Received: by mail-wm1-x344.google.com with SMTP id q25so2546275wmj.0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gz0TiWBmw+aJjacnLXnbSuMlgOySP03BitSmuW5/pTg=;
 b=bVyqlbjOxknCYKDUBm2TKAn89gyvC0qZPTZc+AA89SQykLSHdAZRKlj9ZdaUj9wHmT
 RLp3tLreNr5mzSZs6X7pvHQexd7t8zr0JE7K73pFDBTJBa1fKMRWzns7cYHccZ246Xc+
 rIuhZaJJYEg3C4xUTt4U6/nu1r+oYuzHIvJlY0D5y/fR14Av74tmFTlDm7sld8elr94X
 UMAGtN20nYrKTx6OxZ1LzlWE5z1Ybvg/Tc+nQ+iyNrdHnrJgInLqL/oRGGtwy3xQ3GVo
 lLDk7pmHGU8/Hf3Omb/hL+0lsXobmy2QDxMm0AlvcN5HOmdm8EpwsyJBOEHOlkFrEq81
 AjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gz0TiWBmw+aJjacnLXnbSuMlgOySP03BitSmuW5/pTg=;
 b=DnycWo4AWgSqqoYv5eXZ4MmyKlothuE7JCVKWmcXNcEnlTejppaZxcTXAdQ0JRRjlF
 nBVqgxPzNNQEyi+O5VMWDWsfPHKmx8O5wkQb8xWzuM0qyYpIUk1/lfIlI64qM5Q9wIoY
 7gkoA9NQ1ndSHKDrEEz5pprh9Dw2ZyyIhMjH+HCbJJK6ILGCCkF89Ffe8p1r7CcQr9bS
 pM7EwUiOxJ9eY/194XPtaV40C4qUq56+kVil+xiEmr+YaiGuKCS1oadBdC96KDEi7XhQ
 pnZzv/UjW1M1iQFjLQsjKZfxwJyzfwPl7x9RpabvPT+WF6HOpZn19pIBk5qlrPiXu859
 yZAQ==
X-Gm-Message-State: AOAM531WpfAc4DU7B9+KByToa3pnTCFzIaVw7OY3PWRoIelYWpnPieTx
 WslN1CabmKF5FRQLYY79Dumr7w==
X-Google-Smtp-Source: ABdhPJxoFCcxZsYTJQxAd05X6iz1WmWLFZIak3GIqhWjq+mPPpM+Rj1kPj6E5du6HY1VHwaN1pd9Cg==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr9732160wmh.105.1592409053716; 
 Wed, 17 Jun 2020 08:50:53 -0700 (PDT)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id d24sm139646wmb.45.2020.06.17.08.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:50:53 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: meson: imply acodec glue on axg sound card
Date: Wed, 17 Jun 2020 17:50:47 +0200
Message-Id: <20200617155047.1187256-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

When axg card driver support is enabled, lets enable the related
internal DAC glue by default.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8b6295283989..363dc3b1bbe4 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -68,6 +68,7 @@ config SND_MESON_AXG_SOUND_CARD
 	imply SND_MESON_AXG_SPDIFOUT
 	imply SND_MESON_AXG_SPDIFIN
 	imply SND_MESON_AXG_PDM
+	imply SND_MESON_G12A_TOACODEC
 	imply SND_MESON_G12A_TOHDMITX if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the AXG SoC sound card
-- 
2.25.4

