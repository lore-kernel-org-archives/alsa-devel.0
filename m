Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14FEECAAD4
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Aug 2022 09:46:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2D8B820;
	Mon, 29 Aug 2022 11:45:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2D8B820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661766358;
	bh=N8vs6WN+WlhPhE1pqP0GrSk0Z4Q593JRf4W9viSCHAw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dx6SGrWypN4XidVJUvY4i01rpViN0LY21Zk6ZIIiHdutTL1qKnQoBZsp3qAOS/hUc
	 63LqyJ/jlNXSbHaevuWyzS5hhYwrLlhrsHbR2YrwIJzr1wniNcHyxBbbZAdlIfAHAI
	 v49F06WLB32986l29fMoqZDffFTpHUMnGz3tKliA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EEC8F801F7;
	Mon, 29 Aug 2022 11:45:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32D86F8012A; Mon, 29 Aug 2022 11:45:06 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75240F8012A
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2022 11:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75240F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Iodnet+Q"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5g85k004126;
 Mon, 29 Aug 2022 04:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0QrEnrGyT0A123XlPnuSeRTt5nZfbiGJ6EqrLxHEoHY=;
 b=Iodnet+QDKFo+xsv7jt3dabVbWQtBNdu+bi83ecNw8FLRvb1k2IEpxa+WHGWfcRzoCS+
 JSywybQFMpG+W6rBR1coRC17jI6f5lakskB3JS/ef7y37eynK2UTExwK/PPU/m1mglFw
 MpbE1Ia0x3DVmt/g4K4scDpPZFmo4olkohAuBURA5ufalpMUc4JolMTRtRbyJ15McKed
 R0sEiY6QMelYRI1maXW4M4HcYZnDEFMr9jZ584M6pIN44A8w8yp8Mx7iDyBMb/nBl05u
 qtYou8rG5nxd6C0d253ocPXWEbf0klmZFNTn5MKCqSvWPLrpUch/b42ZgP/tnP6/2sru mQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3j7fpp9v2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Aug 2022 04:45:00 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 29 Aug
 2022 04:44:58 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via
 Frontend Transport; Mon, 29 Aug 2022 04:44:58 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.95])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CF6D67C;
 Mon, 29 Aug 2022 09:44:58 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
Subject: [PATCH 0/1] soundwire: bus: Fix for missing UNATTACH when
 re-enumerating
Date: Mon, 29 Aug 2022 10:44:57 +0100
Message-ID: <20220829094458.1169504-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xPM0AhWVeq-oAxelvi8BAYNz_uA8Hj91
X-Proofpoint-ORIG-GUID: xPM0AhWVeq-oAxelvi8BAYNz_uA8Hj91
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

This is an alternative fix for the race where a device that is reset can
be found on #0 and its ID reprogrammed before the bus code has handled
a PING showing it unattached.

The other possible fix is here:
https://lore.kernel.org/all/20220825122241.273090-4-rf@opensource.cirrus.com/

Richard Fitzgerald (1):
  soundwire: bus: Don't re-enumerate before status is UNATTACHED

 drivers/soundwire/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.30.2

