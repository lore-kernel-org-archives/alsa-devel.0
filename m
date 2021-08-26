Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1278FC432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 04:02:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329A7610E8
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 04:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 329A7610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CF6A166D;
	Thu, 26 Aug 2021 06:01:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CF6A166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629950521;
	bh=vBt6on7MpvYZnfKUwno1KXgpOwB+EMFUeaXzfJPJzS4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TArJgK2skNXeKNFa9oDQxCE84l1V6izj7VfdpVm+hIKC5kpWNb2IyjcpCLltKp6mR
	 /2RofJLjK6msNE20mg8w33oXLO5mc8V3QaJ+VX3rd9pG0kiJVRow4QoLtdhDM+BFyG
	 4ImI/9cjFlMH64sf2o9DTLs+jLSrZLrrS7iOxDrA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C321F801D5;
	Thu, 26 Aug 2021 06:01:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6593CF801D8; Thu, 26 Aug 2021 06:01:08 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.134])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD619F800FD
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 06:01:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD619F800FD
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id 439A1CFCBB;
 Thu, 26 Aug 2021 12:00:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P704T139881091159808S1629950456520017_; 
 Thu, 26 Aug 2021 12:00:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <61802dde85102c4f0c68310484d91b96>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 0/14] Patches to update for rockchip i2s
Date: Thu, 26 Aug 2021 12:00:41 +0800
Message-Id: <1629950441-14118-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org
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

These patches fixup or update for rockchip i2s.

Changes in v3:
- Drop property 'rockchip,playback-only', 'rockchip,capture-only'.
  Implement it by 'dma-names' of DT instead.

Changes in v2:
- split property trcm into single 'trcm-sync-tx-only' and
  'trcm-sync-rx-only' suggested by Nicolas.
- split property trcm into single 'trcm-sync-tx-only' and
  'trcm-sync-rx-only' suggested by Nicolas.
- drop change-id

Sugar Zhang (12):
  ASoC: rockchip: i2s: Add support for set bclk ratio
  ASoC: rockchip: i2s: Fixup clk div error
  ASoC: rockchip: i2s: Improve dma data transfer efficiency
  ASoC: rockchip: i2s: Fix regmap_ops hang
  ASoC: rockchip: i2s: Fix concurrency between tx/rx
  ASoC: rockchip: i2s: Reset the controller if soft reset failed
  ASoC: dt-bindings: rockchip: Document reset property for i2s
  ASoC: rockchip: i2s: Make playback/capture optional
  ASoC: rockchip: i2s: Add compatible for more SoCs
  ASoC: dt-bindings: rockchip: Add compatible strings for more SoCs
  ASoC: rockchip: i2s: Add support for frame inversion
  ASoC: dt-bindings: rockchip: i2s: Document property TRCM

Xiaotan Luo (1):
  ASoC: rockchip: i2s: Fixup config for DAIFMT_DSP_A/B

Xing Zheng (1):
  ASoC: rockchip: i2s: Add support for TRCM property

 .../devicetree/bindings/sound/rockchip-i2s.yaml    |  19 ++
 sound/soc/rockchip/rockchip_i2s.c                  | 278 +++++++++++++++------
 sound/soc/rockchip/rockchip_i2s.h                  |  10 +-
 3 files changed, 224 insertions(+), 83 deletions(-)

-- 
2.7.4



