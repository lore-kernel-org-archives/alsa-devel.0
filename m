Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BAFC3A5A5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:02:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7244C22CF6
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nXH6dIbi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="stvEzN4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7244C22CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17956166B;
	Thu,  5 Sep 2019 14:01:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17956166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567684946;
	bh=9slIe2W1E1laU4fIJSNnpTJlVM6ul9Q15HvDMLf/apA=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nXH6dIbiLFv6veUCZNMvpuC5/08p7kkca7E+WMj4PfPJUF5zeP3jVD7Bzd4lHzTdM
	 vkIvgZwDmlKbqGgkw/nOnhpFp1m7o0t+YM0IXoz8sBgvRBsGciu44F545ZIIq1DRnM
	 5skCxju5WyTzVLPJvqWaWZy3pmGZihIXvvPUV2yU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21E09F804A9;
	Thu,  5 Sep 2019 14:01:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24318F80227; Thu,  5 Sep 2019 14:01:33 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BC32F80227
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2019 14:01:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BC32F80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="stvEzN4t"
Received: by mail-wm1-x342.google.com with SMTP id r17so4835185wme.0
 for <alsa-devel@alsa-project.org>; Thu, 05 Sep 2019 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yFK6X2V6i39GcNDQWpzEpnOVpoV1Dx+VySBb8i2GX/I=;
 b=stvEzN4tUS8oK1tZu/EaUIi2TPABQfmjiU4mPlGJpIy9qIoGskfwsPYca0Dq0e4oPl
 DuwEICzFSm8kaAm51AaPy9tOzbXLDJifxZjw4c8+ZPPOrZm8/E6ECYeVwnZxC+XiUvjp
 949UTxAT6G0O23iPXgjV+Wdf6ES/zchaFfEK3pbnJVhU/VhlNBLdYpUFhhwZyEhE6vsb
 2PejIUevv+7DNzmPNZPNwnpVDYBmE3CDCi0TZ4lHHEq63JrW1Pa3NgH9AUBRJHkGT/eZ
 jfbufeoQpcZCnDjTh5FgfFfKIrhUCSvsSE5L6Bk3uw0/fkIOsb2YUIubWIWWuRXiJ0B4
 PWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yFK6X2V6i39GcNDQWpzEpnOVpoV1Dx+VySBb8i2GX/I=;
 b=U++nZnPc2ERsPiQVfjDpdFgO8HnM7iRn/PaBgeZC2bl67e8jwokYiS3ncYHVyozEoZ
 tn33TA+PSu6mDRlP9gxU5igfSRU+MjLhHwjS2RuNpxAV370OvJZeTu5hW8/s4fFuVdle
 RVuQiXreixrC6CaJL5G+PIq89dhB8Orbd6wnownvFEZXmw8IYh2KY7wSkm0eqWUFkbXn
 DrnY1XOxDbopmsKhD2Cy0g1bwGVrJ073IcgOD/difqe/NF1IrDO4bavynMBakLM3OavO
 LA0qU8uBlHaUa2kZm9tqAWHTBKc4WvPN0k+BzzmAQl9QUBT++0UI4CdhqQ9u8hmbuTXX
 aPDg==
X-Gm-Message-State: APjAAAX1VdR+Su29xxe3YoQlwAH4mgX1czRESwf7GxRpEOr7dz4SXOGD
 fTfBrWWQZs6Oxj4/85+b214NMQ==
X-Google-Smtp-Source: APXvYqx0FuZccTavmCfh5UKk59D68gUWa1P+Lko4JSyqzHolIXwrXQ2h9DNNhEMWzPwh8vmYnLQyAw==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr2593849wmc.140.1567684888491; 
 Thu, 05 Sep 2019 05:01:28 -0700 (PDT)
Received: from starbuck.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 05:01:27 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Date: Thu,  5 Sep 2019 14:01:12 +0200
Message-Id: <20190905120120.31752-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH 0/8] ASoC: meson: add sm1 support
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

This patchset prepare then add the audio support on the amlogic sm1
SoC family in ASoC.

This has been tested on sei610 platform. Since this platform does
not have spdif, this patchset does not include the change necessary
to support spdif input or output on the sm1.

Jerome Brunet (8):
  ASoC: meson: add sm1 compatibles
  ASoC: meson: add reset binding
  ASoC: meson: axg-frddr: expose all 8 outputs
  ASoC: meson: axg-toddr: expose all 8 inputs
  ASoC: meson: tdmin: expose all 16 inputs
  ASoC: meson: axg-frddr: add sm1 support
  ASoC: meson: axg-toddr: add sm1 support
  ASoC: meson: tdmout: add sm1 support

 .../bindings/sound/amlogic,axg-fifo.txt       |   9 +-
 .../bindings/sound/amlogic,axg-pdm.txt        |   6 +-
 .../bindings/sound/amlogic,axg-spdifin.txt    |   6 +-
 .../bindings/sound/amlogic,axg-spdifout.txt   |   6 +-
 .../sound/amlogic,axg-tdm-formatters.txt      |   4 +-
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  |   5 +-
 sound/soc/meson/axg-fifo.c                    |   2 +-
 sound/soc/meson/axg-fifo.h                    |   1 +
 sound/soc/meson/axg-frddr.c                   | 105 ++++++++++++++++--
 sound/soc/meson/axg-tdmin.c                   |  47 +++++---
 sound/soc/meson/axg-tdmout.c                  | 103 +++++++++++++----
 sound/soc/meson/axg-toddr.c                   |  83 ++++++++++++--
 12 files changed, 321 insertions(+), 56 deletions(-)

-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
