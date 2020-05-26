Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86250C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 07:13:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31773207ED
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 07:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OlVhQII0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31773207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9057917B3;
	Wed, 27 May 2020 09:12:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9057917B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590563581;
	bh=QIjhQ4Par3PTlHb3lwqGlXHhYG1dps4BYkXKJ8nNa3Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OlVhQII01sBLJoYbWlzUu7ffD1pqRAWNciC8ePHdliqsxXzv9Ha8GrE8ZY+kfhmpZ
	 hwXvGQ/xz6FX2bdRZ067Xb6NZFN6gbbSY7ySWoz7JH+2WSR/rvyymPm1ZX6Nlnbkfm
	 Ql/H/HR/DssJxFsh8oEXKXpVamIj8VEqz8YOn7fU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D0BDF8029A;
	Wed, 27 May 2020 09:10:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22556F80100; Tue, 26 May 2020 23:02:01 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EAD2EF80100
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 23:01:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAD2EF80100
X-IronPort-AV: E=Sophos;i="5.73,437,1583161200"; d="scan'208";a="47867520"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 27 May 2020 06:01:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B82C40DAAC6;
 Wed, 27 May 2020 06:01:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] RZ/G1H enable sound support
Date: Tue, 26 May 2020 22:01:42 +0100
Message-Id: <1590526904-13855-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Wed, 27 May 2020 09:10:26 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>
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

Hi All,

This patch series adds support for sound in R8A7742 SoC DT.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: ASoC: renesas,rsnd: Add r8a7742 support
  ARM: dts: r8a7742: Add audio support

 .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
 arch/arm/boot/dts/r8a7742.dtsi                     | 284 +++++++++++++++++++++
 2 files changed, 285 insertions(+)

-- 
2.7.4

