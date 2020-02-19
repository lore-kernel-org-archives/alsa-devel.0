Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6DCC34047
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:36:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1522465D
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AFwoUbdC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X2e0sx2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1522465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 731FB167E;
	Wed, 19 Feb 2020 18:35:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 731FB167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582133765;
	bh=3IpkmeNpM+HKZJZnc/BR0Sq1nSfC409kaPYTvO5H8GE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AFwoUbdCBon4CE1BILb4RDoeWp+N6o/0Kc9iBl1SNnUUsbHiRhSPwGr6V5QpSroCt
	 H+aBB2FSOG1m7g/Q0/4619Zr3O7AN6YIJN6TEXHvbvPxGahqncXNrGypPB0j/plVM0
	 LgNi9SdI0nQwvsY/pwDK4O2h014uQ5Aknsfj21r0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A12D1F80273;
	Wed, 19 Feb 2020 18:35:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C83A4F80276; Wed, 19 Feb 2020 18:35:12 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D771FF801F5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 18:35:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D771FF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="X2e0sx2O"
Received: by mail-wr1-x444.google.com with SMTP id w15so1532564wru.4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKZ1ddDPfUYCjUQ7kAF3t+orQ6m6BZIYkrSaotWcAmM=;
 b=X2e0sx2O23WHDyj+CdogMOZnhLzlHGUY84Cw/1358tG4/lp0p4QzlF4gTn0S3FY5aF
 wlKpLxS0Pq7GvSWtJJZlnc1/BhuJaSmmxc957ERCeTZfWstj/7P9ynHWGySHKdNut72W
 OixpFUrGD9ADXYh9sGhd7pCeG+MDemjlpISXz9n5guTcFXHwC4ltNKQPsv1xZyo0nH/6
 oedY9idCZ394g4kRJLT2t10k1kTREfbTfiWs8hohLdnCJxCwkXRaSe0izO0rYPp5W3V3
 9d0Pm7TJCz+eu+Qnazm4qvj9KIpCTIg+eKRCDKN8gdAj8G6lYG+tTsbqRHk2AaBkxfcw
 YygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKZ1ddDPfUYCjUQ7kAF3t+orQ6m6BZIYkrSaotWcAmM=;
 b=G5qeIg2BhzBS/joRBoOF5b0FTlveGfKuHUUH/SHHgL0roSyP3ZVerInNUvMiL3i+aQ
 HoICEV5K26l/51BjOuZ2yFgpudM/BlSGJiNqTUgNQm6wGOq+ulnuw31pSpfm9RLs4LjV
 FiJyv9CQb6V7u724eIpWlLb9OFl/FINvVdYWJQrp5u1bZQRvu6O70Ybh6RqVxFkAbglG
 k9HMTueAHUzwC5WqVGcl0TKsj4pJZlgyDZTIyS7ptYA0huUl4X9YKTzx3uhe7HWWtCo1
 Hfui4KBVz9oddPsa44UYiiPv4luu4SE0j9WFQ2slAjp6txEVJC2a22UV9OkKVWxA0Hy8
 mTxg==
X-Gm-Message-State: APjAAAVzAj4X/VohQwl9bFolbHVpo1vug96Qw4Yy0do6fqlg4NQfyJ94
 zqEWPVkTOFs8hZlqX2OJve2Q8A==
X-Google-Smtp-Source: APXvYqzk6aYz8GK14PUd7/aAq+BxUqQaODL7ymtKvwWlFXfp7QfRzdYohN9IJrf2eOWE2Tw9MfdveA==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr37515585wrm.107.1582133708455; 
 Wed, 19 Feb 2020 09:35:08 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id v15sm648120wrf.7.2020.02.19.09.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 09:35:07 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 0/2] ASoC: meson: add internal DAC support
Date: Wed, 19 Feb 2020 18:35:01 +0100
Message-Id: <20200219173503.1112561-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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

This patchset adds support for the internal audio DAC provided on the
Amlogic gxl, g12a and sm1 SoC families. On each of these SoC families,
there is glue between this codec on the audio provider. The architecture
is similar to the one used for the synopsys hdmi codec on these SoCs

Changes since v2 [1]:
* Fix Mute kcontrol name

Changes since v1 [0]:
* Change some kcontrol names
* Move DAC sources to DAPM

[0]: https://lore.kernel.org/r/20200219133646.1035506-1-jbrunet@baylibre.com
[1]: https://lore.kernel.org/r/20200219161625.1078051-1-jbrunet@baylibre.com

Jerome Brunet (2):
  ASoC: meson: add t9015 internal codec binding documentation
  ASoC: meson: add t9015 internal DAC driver

 .../bindings/sound/amlogic,t9015.yaml         |  58 +++
 sound/soc/meson/Kconfig                       |   8 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/t9015.c                       | 333 ++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
 create mode 100644 sound/soc/meson/t9015.c

-- 
2.24.1

