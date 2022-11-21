Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB75C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Nov 2022 14:15:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C66FB15F2;
	Mon, 21 Nov 2022 15:14:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C66FB15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669040104;
	bh=2/smtpaMxutBP29lDAqMjaR6gCDC8Gy+WBZ38ZjMhD0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QBSVC0pKzyMnkL9j1BXbj95p5DdSyfYWrysLo33KNMdkJIgvrUPRl2oHR30rYGQ05
	 fAYAx1MbBtNtaUUt43LPh05k7ICiw3i6qfTN/JuyCWwrgiLrUf+MzKrUZ6nLV2LlFg
	 sHxQoeu5mx6eL8udL5Nn/e/n0pwdng8GCK2M5as0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A844F804AB;
	Mon, 21 Nov 2022 15:14:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F993F80149; Mon, 21 Nov 2022 15:14:12 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D653BF800F3
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 15:14:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D653BF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Px2yehW0"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2ALCr4Bv002700; Mon, 21 Nov 2022 08:14:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=drhTEQe31yycsjARalMi8wiw6eVsmgrhMdEVBIej5ao=;
 b=Px2yehW0pb3Dxk9Et+O5SgtdGsZeG+kXGc3p3QjGWDkub5qGbuUdeMLag+VO6SOBOCsF
 DNhb0ERqw9FNiXBSncGlgzb1bhPdcTsc32h1PAsyLAOgqmCZuv87SGkgceIxjzpuzYI/
 bA4ClYvtTf/SFc5nekF5lMnen1xv22ul6JcXvBI5t6W/z1Iti9QUXGqviPGNnjxlIIVl
 Ddb8wKqJPvI7XIV4cRQcBEh7+7IxdycptQ7xP19MQBJSk3xQBcqYNwbGJzbPM4QzsXBC
 ZQ2tmXfDTs4b04QdmW+k9rUbRsEZII2oWSmJWnBANv4PARNVrJbcxjYZQX+YV7FBKE1l DQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet283r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Nov 2022 08:14:07 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 21 Nov
 2022 08:14:06 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via
 Frontend Transport; Mon, 21 Nov 2022 08:14:06 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DF06468;
 Mon, 21 Nov 2022 14:14:06 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
Subject: [PATCH v3 0/4] Minor SoundWire clean ups
Date: Mon, 21 Nov 2022 14:14:02 +0000
Message-ID: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JZF-RXjQwTMQmNfQXDXWTohWiOHZXD5q
X-Proofpoint-GUID: JZF-RXjQwTMQmNfQXDXWTohWiOHZXD5q
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

Just some minor tidy ups and preparation for starting to upstream some
Cirrus SoundWire devices. The first three patches are pretty trivial,
the last patch which moves the remaining core over to using the no_pm
functions could probably use some careful review.

Changes since v2:
 - Fix up a memory leak of a buffer on the error path
 - Added some reviewed by's

Thanks,
Charles


Charles Keepax (3):
  soundwire: Provide build stubs for common functions
  soundwire: debugfs: Switch to sdw_read_no_pm
  soundwire: stream: Move remaining register accesses over to no_pm

Simon Trimmer (1):
  soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions

 drivers/soundwire/bus.c       | 10 ++--
 drivers/soundwire/debugfs.c   | 13 ++++-
 drivers/soundwire/stream.c    | 30 +++++------
 include/linux/soundwire/sdw.h | 94 +++++++++++++++++++++++++++++++----
 4 files changed, 116 insertions(+), 31 deletions(-)

-- 
2.30.2

