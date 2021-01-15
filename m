Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F1C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 14:04:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326E7208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 14:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326E7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7C0817D3;
	Fri, 15 Jan 2021 15:04:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7C0817D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610719493;
	bh=t5fhaUfTDRVay1XP6tWxGd8h92Sd5Lg8YM77CuejEOM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EypSOQyJhwclicMuT4TYAFWKcthsWU3oFBBXXPK3iJR1kAEO0zu0JehN9dF0QZy5g
	 U5+ULbicLZFMo2XxeSybCXVSX3MtbPN4/DQiIlNHAiCIMbt6A1dI3D3z2ltmd/x9eU
	 y7LpAZ3qJYtelQq7OXD1WXsnTB7hfIezFn9rls14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA9BEF804D2;
	Fri, 15 Jan 2021 15:02:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A675F80254; Fri, 15 Jan 2021 15:02:20 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCC74F8025F
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 15:02:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCC74F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="pIMnj0Ny"
Received: by mail-lf1-x12a.google.com with SMTP id 23so13229304lfg.10
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 06:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1NsOkp9iBw88H+ZIyGf5qHZeJSQo1CPXWCUE5H26Igg=;
 b=pIMnj0Ny2iVoIMGIgV4yaPUZg2T7Ozx6rPZDHqDTGpbe1qAB8ekyJzLZ8AEnr/HflK
 goWt8UIldM1V0kyzcRw12jZoCcpNtosEdpbMK7D8GXOR4klIOJGyjKm/CpYM339gE145
 hE2eVQBQOoYXc1jG3j1ykc02kMuyI+A4XnggEM7RxGsVNsIdlbdJVwQcxC7wWstoRSxa
 pyojsYO7VG9/pg73ufpCOipJV5dvIv8ET5uBHd9SD7AZCyvEiETu8wGzjxL3IzLw7/Tb
 A/Z6Xvr7ollvPvGk3591QRXFo9HCGK4IteUP+0W9TSu9JOF0jn8qEUSJmAc/FZ8GW0C6
 dGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1NsOkp9iBw88H+ZIyGf5qHZeJSQo1CPXWCUE5H26Igg=;
 b=mtPk3mkQ1jnctA46wuWD7c0QKpXms6tKV3OKqn6Mj4aCu/EMza8vTLnPDf0k993rj0
 qTVxzR2iHYOPT+NumOKATWc2Woe11Ha/isuqFZcL3ARBAdU5w2LUYE0GolfEiGK+A0LY
 nhP+Z8eWXQghtedZCj/4WO9BxFXlJkbY+3+Q7h3+0d2PBlkycupWZNSZYfwgguEo9z/3
 iqFolnSGRpPejL7Pep4QSedGQAD6KAe9VfUJ4ba75hOHGZaYSqVkSKtypFmcrB6vciz5
 +gdJPBsACMHuFqqbFAB2/unGYnOfj53UEWyLcj2EmLcCH/HFxnxFxRc8nVByfzopDOXp
 h4FQ==
X-Gm-Message-State: AOAM531QrqVgkMJLdw8qS4H3/ogJCdh1bjr0qudf5dIqvgh/jEXo1kLN
 Hn09lrbyhUD/prL24LLx41o=
X-Google-Smtp-Source: ABdhPJwqZrKQFdE/ox4izOJ8DbpPJvYBRbch14yPMzyXPyscXCSPnW1yhdL5OpAsDMfD9AfHyiNGgA==
X-Received: by 2002:ac2:43a4:: with SMTP id t4mr5708194lfl.197.1610719323774; 
 Fri, 15 Jan 2021 06:02:03 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.gmail.com with ESMTPSA id f132sm906852lfd.252.2021.01.15.06.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 06:02:03 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Peter Geis <pgwipeout@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 0/5] Clock and reset improvements for Tegra ALSA drivers
Date: Fri, 15 Jan 2021 17:01:40 +0300
Message-Id: <20210115140145.10668-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

This series improves the handling of clock and reset controls of
NVIDA Tegra ALSA drivers. Tegra HDA and AHUB drivers aren't handling
resets properly, which needs to be fixed in order to unblock other patches
related to fixes of the reset controller driver since HDA/AHUB are bound
to fail once reset controller driver will be corrected. In particular ALSA
drivers are relying on implicit de-assertion of resets which is done by the
tegra-clk driver. It's not the business of the clk driver to touch resets
and we need to fix this because it breaks reset/clk programming sequences
of other Tegra drivers.

Changelog:

v2: - Added regcache_sync() to the "ahub: Reset hardware properly" patch,
      which was missed by accident in v1.

    - Corrected typo in the format of the error message in "ahub: Use
      of_reset_control_array_get_exclusive()" patch by s/%p/%pe/.

Dmitry Osipenko (5):
  ALSA: hda/tegra: Use clk_bulk helpers
  ALSA: hda/tegra: Reset hardware
  ASoC: tegra: ahub: Use of_reset_control_array_get_exclusive()
  ASoC: tegra: ahub: Use clk_bulk helpers
  ASoC: tegra: ahub: Reset hardware properly

 sound/pci/hda/hda_tegra.c      |  86 ++++++++-----------------
 sound/soc/tegra/tegra30_ahub.c | 113 +++++++++------------------------
 sound/soc/tegra/tegra30_ahub.h |   6 +-
 3 files changed, 59 insertions(+), 146 deletions(-)

-- 
2.29.2

