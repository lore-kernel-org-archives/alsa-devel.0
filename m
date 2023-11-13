Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CFC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Nov 2023 11:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4843844;
	Mon, 13 Nov 2023 12:55:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4843844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699876555;
	bh=O/H4pXONTMALA1QjUwNy+JHYX5HbyQNxYPYG7/ZQK5w=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dfzfwxMzCcYveV764Frnx/wVJzSGe/QnI4xUB+AphLmHXNuXa7VRsMM5it4AlWTMx
	 LFSGo77GGvLW6bYn6aeRn1Jsm3yozWLV+q7e6Yd3+XQF3B04aOLVPv6q++Ko8GLqRe
	 G6mWM9a+ka7HZrwogL7rAHa1wP1lCGKDAE4lHIOw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 091A7F80557; Mon, 13 Nov 2023 12:54:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66C07F80557;
	Mon, 13 Nov 2023 12:54:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40AF0F8016E; Mon, 13 Nov 2023 08:59:17 +0100 (CET)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by alsa1.perex.cz (Postfix) with ESMTP id 2679FF8016E
	for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2023 08:56:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2679FF8016E
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1769628:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256);
 Mon, 13 Nov 2023 15:56:18 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Mon, 13 Nov
 2023 15:56:18 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Mon, 13 Nov 2023 15:56:18 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>,
	ChiYuan Huang <cy_huang@richtek.com>, Allen Lin <allen_lin@richtek.com>,
	<alsa-devel@alsa-project.org>
Subject: [PATCH v1 0/3] rtq9128: Fix user reported issues
Date: Mon, 13 Nov 2023 15:56:13 +0800
Message-ID: <1699862176-23710-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-MailFrom: prvs=1680C42439=cy_huang@richtek.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7XIQXUJJH6V3EIUI7TBR3ABAE4G74AM7
X-Message-ID-Hash: 7XIQXUJJH6V3EIUI7TBR3ABAE4G74AM7
X-Mailman-Approved-At: Mon, 13 Nov 2023 11:54:40 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7XIQXUJJH6V3EIUI7TBR3ABAE4G74AM7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: ChiYuan Huang <cy_huang@richtek.com>

Refersh the patch series based on the below previous one
https://lore.kernel.org/lkml/1697795435-5858-1-git-send-email-cy_huang@richtek.com/

RTQ9128 fixes for pm_runtime/tdm_usage/E1 Sample amp on sequence

ChiYuan Huang (3):
  ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
  ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
  ASoC: codecs: rtq9128: Fix E1 eng version amp on sequence

 sound/soc/codecs/rtq9128.c | 130 +++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 35 deletions(-)


base-commit: a60a609b7f548050d1e84c7aa1c0a57d5d7e22d5
-- 
2.34.1

