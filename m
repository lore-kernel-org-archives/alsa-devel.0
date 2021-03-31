Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1885C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:28:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B801060FF2
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B801060FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEBAD1675;
	Wed, 31 Mar 2021 16:28:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEBAD1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617200931;
	bh=bZmOz5rGh1pN7N34ijI387Bi/JUKNwGsdZCOXKAT0eM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ahvStSNDRFEtvDvtFZibbdFnquvKpSnMXaCYZHWXg4XE/Ge53Bhfe1i18JbHjUS93
	 Hu6QnsRHYHYmFu/HcNTA14rf+W365nznoAubcpVpoPMRiIBy1BS/OxDshV+zyU9tQh
	 eSYebLZtH6gc+C0bl6fRFq6VyDaLTO655bYQQv+w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CD95F80166;
	Wed, 31 Mar 2021 16:28:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9413F8016E; Wed, 31 Mar 2021 16:27:59 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAB35F8013F
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 16:27:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAB35F8013F
Received: by mail-oi1-f181.google.com with SMTP id i81so20169500oif.6
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 07:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wtt/6BX1Tdfid27/aCLws3P6mkfARPhCm6lARDr04cg=;
 b=pm77TXUcQT6iOuHzf3KNyfX97b8YjwYC7SgH81Ejzk42hxAHm3P3Puv/XOUxwavncF
 8ehaPC81kd77wvpia0qz1NASF1graaxE244uLwELK/DCiNqSSixkgSU1BuntDcTO4dcJ
 WjMLTbMwoEeA6zyjuRRc8474fjtEXxRQOQhsC682dqlKr5B85IHQxqTey+bhOwLU7/5T
 VfZNlgcqTzP91GFmthl5Ix0Ap2miRzKk57EwmioqqgebaSHQuoNh9WxeNeePqID3LxNa
 n7M5bOVsdWMJMqAjHrZgAPte48jZgK34KY39qBBQt6bXtKBonLs5Nt+veMzgsv8SiJT7
 pM0Q==
X-Gm-Message-State: AOAM530PYJ5bY3ep+q6+qAxhkkcvfhcnfvT4hki0hG+RXCHsv2t0VqKT
 MVh1M3BTr1mhoNeMQUb6hA==
X-Google-Smtp-Source: ABdhPJzQCtRAKChGGJ8hU5u/x1BvO7XS3DqJEL/hzq2eppjLWh8LfjhB92bi9TKGCvqx86XOKiENNg==
X-Received: by 2002:aca:aa84:: with SMTP id t126mr2539037oie.50.1617200871097; 
 Wed, 31 Mar 2021 07:27:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id v136sm451146oie.15.2021.03.31.07.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 07:27:50 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] ASoC: dt-bindings: Rework audio-graph-port schema
Date: Wed, 31 Mar 2021 09:27:45 -0500
Message-Id: <20210331142748.2163272-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Lubomir Rintel <lkundrak@v3.sk>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

This series refactors the audio-graph-port.yaml schema moving the
'port' node out of the schema and updating to use graph.yaml schema.
This allows users to define what each 'port' node is like other graph
binding users.

v2:
- Rebase on ASoC tree

Rob

Cc: alsa-devel@alsa-project.org
Cc: linux-tegra@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Sameer Pujar <spujar@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

Rob Herring (3):
  ASoC: dt-bindings: Move port/ports properties out of
    audio-graph-port.yaml
  ASoC: dt-bindings: Use OF graph schema
  ASoC: dt-bindings: socionext: Use audio-graph-port schema

 .../bindings/sound/audio-graph-port.yaml      | 104 ++++++++----------
 .../bindings/sound/marvell,mmp-sspa.yaml      |   6 +-
 .../bindings/sound/nvidia,tegra186-dspk.yaml  |  11 +-
 .../sound/nvidia,tegra210-admaif.yaml         |  11 +-
 .../bindings/sound/nvidia,tegra210-ahub.yaml  |  11 +-
 .../bindings/sound/nvidia,tegra210-dmic.yaml  |  11 +-
 .../bindings/sound/nvidia,tegra210-i2s.yaml   |  11 +-
 .../bindings/sound/renesas,rsnd.yaml          |   5 +-
 .../sound/socionext,uniphier-aio.yaml         |   8 +-
 .../sound/socionext,uniphier-evea.yaml        |   8 +-
 10 files changed, 89 insertions(+), 97 deletions(-)

-- 
2.27.0

