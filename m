Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62570C04FFE
	for <alsa-devel@archiver.kernel.org>; Tue, 14 May 2024 03:32:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEE9F210;
	Tue, 14 May 2024 05:32:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEE9F210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715657557;
	bh=C5xYCfcQWl/XWOBVZGHYyJOwt9SRH8lTLVBSQ+N8FN8=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MlRGvgN5TUz1dsK6T9IMtrF3Au/GCFY1Aus243CZxJOrGfdYQaGZdmCeriPNVnJRU
	 lLehtw9rpxhNm85PiZqafsrjDtB5nYYvtvUh7QD/xA5R+ML6Y9VhmioJ6ipJmDj4RC
	 jiR57KoM5D+MeE11TA4gFOCGQyfLJYkrRmPwoQAo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7588F805A9; Tue, 14 May 2024 05:32:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DEEDF805A9;
	Tue, 14 May 2024 05:32:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC826F80224; Tue, 14 May 2024 05:31:39 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 034FBF800F5
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2024 05:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 034FBF800F5
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 262E12017DC;
	Tue, 14 May 2024 05:31:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D01162017D7;
	Tue, 14 May 2024 05:31:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AABC3180226C;
	Tue, 14 May 2024 11:31:28 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Date: Tue, 14 May 2024 11:12:07 +0800
Message-Id: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: ZK65UDLOY4FARFRGNMCTXGRBRDVYMJ36
X-Message-ID-Hash: ZK65UDLOY4FARFRGNMCTXGRBRDVYMJ36
X-MailFrom: shengjiu.wang@nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZK65UDLOY4FARFRGNMCTXGRBRDVYMJ36/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On i.MX95 wakeup domain, there is one instance of Audio XCVR
supporting SPDIF mode with a connection to the Audio XCVR physical
interface.

changes in v2:
- Merge patch 1&2, 3&4 from v1 together.
- Add more comments in commit message
- Add constaint for clocks used on i.mx95
- Add 'select SND_SOC_FSL_UTILS' for compiling issue.

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
  ASoC: fsl_xcvr: Add support for i.MX95 platform

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |  55 ++++++--
 sound/soc/fsl/Kconfig                         |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 128 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |  91 +++++++++++++
 4 files changed, 222 insertions(+), 53 deletions(-)

-- 
2.34.1

