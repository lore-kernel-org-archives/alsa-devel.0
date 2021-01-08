Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC2C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 14:00:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D1E239ED
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 14:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D1E239ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FA7B852;
	Fri,  8 Jan 2021 14:59:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FA7B852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610114434;
	bh=MXzWhkLX2zT33nTxSTgmRfeAM+HX9Lzjn9Rdhw/JTgs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ir3YMKiAjYNLtWC15aETxw3vSzER9cvHurGmkRq5rogqxDqnwh/c7meOl0wcMjim7
	 WRSa2r60fEGKLIZr/3Y7B36b3WesM2ADr9DuGIJA5erDj5Kst1swSHPjKAZBzSVFIF
	 oANnKZbCiX9+JJenHr96KcYPgsRcGGz0M+tf5pb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9058CF80167;
	Fri,  8 Jan 2021 14:59:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1F52F8016A; Fri,  8 Jan 2021 14:59:40 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E836F800FD
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 14:59:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E836F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LXeMOQn4"
Received: by mail-io1-xd2b.google.com with SMTP id e22so9285997iom.5
 for <alsa-devel@alsa-project.org>; Fri, 08 Jan 2021 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyp1Y2onEbcYwJTPNCdZdClbb6AQgC+DkZVAjw0ozR8=;
 b=LXeMOQn4g3/tfRh8x7CMKYz8CPTI1+pP7Llcf5XajSz8CM2P25BkqFKLzEDSkbA0zg
 F1xAys9s6bb0NieajV86osEicFx5J4wlI2pyMeCcXL59rz3qxzETm1ICIPpa/OS04Tvy
 vxff9M/U2V4E1qQlKWysLYEXk4c31AuwqI0I1yLfAK/KjSbKsEK7L22iODrxXGNLkcKL
 fy9nARZQBZyNUnicJ7YGKFBerNvjNaVYMYCZjVG0/xjFcutSnvZsuCD05yaE9+I/y6bh
 9S7ojgF+VzIrg2x4aaAgdq1/uzZV8lO4st6BHZEV4eaZjrwJRbbe1TJx751WervSroEF
 T5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyp1Y2onEbcYwJTPNCdZdClbb6AQgC+DkZVAjw0ozR8=;
 b=QzHOMWWV8//6h/NQQBaZwLU6EBxXFRmtE5sFcXQqvnkAPJKmm4zDh3kDzQfNwDK51Q
 CYvUm9XCmvg3AHWPJ4kN+uCPdY9bVCex8eK9eRgLG0I8NJueEdYMSbxMk8bWEnuqBNU1
 fTTnT/SZzE1pvgSAG10HINKFlUYYKm5K1eqwFi47nA20KU5crhTtr6gCt9Xf69a02Uvq
 LPfQL+GBsY8+1PQnWjKjHhEugaBAVMyv3jpcJ4PlUXNmvkARdBzQLc6B9kdcmNjZMUlk
 ewqgnoFSYjSGJ8/muD619MQfuU2trlLIAANBwDRzg+nqIk6RvBLTZA3T9fo/vb1/ypeZ
 +3Qg==
X-Gm-Message-State: AOAM53129exlB/8IY57oLtlkfuRUEOsqI/C06kFFrbitZ7MbTv7m3kF7
 L1qz1EbrPeIAR5je+JfIvzk=
X-Google-Smtp-Source: ABdhPJw+goSAMa6HMOrIAPdukTjXrBnBjqaAhawYG9QJjpQbABV6HDvRDSd3rHGNj0Vpm3tPVXx4jQ==
X-Received: by 2002:a05:6602:2c4e:: with SMTP id
 x14mr5390290iov.58.1610114371325; 
 Fri, 08 Jan 2021 05:59:31 -0800 (PST)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
 by smtp.gmail.com with ESMTPSA id l6sm7570063ili.78.2021.01.08.05.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 05:59:30 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sameer Pujar <spujar@nvidia.com>,
 Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 0/2] fix tegra-hda on tegra30 devices
Date: Fri,  8 Jan 2021 13:59:11 +0000
Message-Id: <20210108135913.2421585-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-clk@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
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

The following patches fix tegra-hda on legacy tegra devices.
Two issues were discovered preventing tegra-hda from functioning:
-The hda clocks on tegra30 were assigned to clk_m and running at too low
of a rate to function.
-The tegra-hda encounters an input/output error when opening a stream.

Since the only mainline device that used tegra-hda until recently was the
t124, it is unknown exactly when this was broken. Fortunately a recent
patch was submitted that fixed the issue only on t194 devices. We can
apply it to the tegra30-hda device to resolve the issue across the board.
Note that downstream devices used the spdif device instead of hda for hdmi
audio. The spdif device lacks a driver on mainline.

-Checkpatch seems to have issues finding [1], but git show has no issue.
[1] commit 60019d8c650d ("ALSA: hda/tegra: workaround playback failure on
Tegra194")

Changelog:

v2:
-Added ack and reviewed-by from Jon
-Updated fix to apply to tegra30-hda vice universally (Thanks Jon)
-Updated commit to include comments from hardware team (Thanks Sameer)
-Cleaned up commit messages

Peter Geis (2):
  clk: tegra30: Add hda clock default rates to clock driver
  ALSA: hda/tegra: fix tegra-hda on tegra30 soc

 drivers/clk/tegra/clk-tegra30.c | 2 ++
 sound/pci/hda/hda_tegra.c       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

