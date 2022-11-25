Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF474C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA580173B;
	Fri, 25 Nov 2022 16:49:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA580173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669391430;
	bh=Yw8cIAqUDPczlncRcOt/MQWuBUz40FsIONvzsUnNmbg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bh9Ce2boRbaH8dfFL9Ds3DkzKS5pKHhY1aLQj63NSieq7EQz/H5Mi0dPymDn5D26j
	 lUOFyENxsmk+/FAb+nFVN01eMg5CrDGYVp6KV+NMyNcpC4WCSnYGNCwMMyeLgvjNz1
	 usEffv/9ytmlIOF8tDH5cZJCPGqBP3pfGgwQnq+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45BE3F80236;
	Fri, 25 Nov 2022 16:48:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B4FDF80236; Fri, 25 Nov 2022 16:48:52 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08A12F80236
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 16:48:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08A12F80236
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Ms1+V5uI"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2APAeIZG029176; Fri, 25 Nov 2022 09:48:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=iDjsnJSq1O5v8CyddAW+9g38EPpxSqpCsUZAk0iCxD8=;
 b=Ms1+V5uI2wLTq0YmH3YEWKNHjsmhWiP+v3wgAjmM+UnQShs6slUAadeRA893zqGc+k3N
 r7HaW9q+hhb7BbrsPP0Rs35jcIFeru06L0BYhVr628eSNvsalOMuo//1bu2tBJSMag1K
 8o4qqx3MAJq6zjmXJOyPr0EGu+55KnammfSQWsQmbM0TjDO0s+S0HrZdn2UqHeKELr4D
 SwxdzkX7pMd6oPNr93uawr/3AtGbHxjYd8iD5HglTZe/dov5hqlAMOXE7V6kHqD9zrjP
 99SDyR+HdcVLCg+toaS4zfPOovq3OrctJKHas8ujyH9hxh4mwoQNKazZd5gaI4oxJIdK Zg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet7f2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Nov 2022 09:48:39 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 25 Nov
 2022 09:48:37 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via
 Frontend Transport; Fri, 25 Nov 2022 09:48:37 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A8C2FB0E;
 Fri, 25 Nov 2022 15:48:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 0/2] SX control bounds check fixups
Date: Fri, 25 Nov 2022 15:48:35 +0000
Message-ID: <20221125154837.1270501-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VsC0DA_LLvCFtDmv_-SYkqSxd-PskEif
X-Proofpoint-GUID: VsC0DA_LLvCFtDmv_-SYkqSxd-PskEif
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 guille.rodriguez@gmail.com, lgirdwood@gmail.com
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

These two SX control fixups seem to have got lost somewhere along the
line. They were merged back in 5.18 but never seems to actually make it
into the kernel:

https://lore.kernel.org/all/165236477046.1016627.15470197691244479154.b4-ty@kernel.org/

Apologies if resending isn't the correct course but it seemed the safest
way to go. Note I have made a slight fixup to the second patch.

Thanks,
Charles

Mark Brown (2):
  ASoC: ops: Fix bounds check for _sx controls
  ASoC: ops: Check bounds for second channel in snd_soc_put_volsw_sx()

 sound/soc/soc-ops.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.30.2

