Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B12ECAAD3
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Sep 2022 12:11:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F916185A;
	Wed, 14 Sep 2022 14:10:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F916185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663157459;
	bh=sdTncHjHA0gaGHwrGAlljZxHPR6Y9wlY9e9zl+b4aGo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BNRwDCLSzusXLqkechMKHI66sH+k7laHMIZdDMyReKX/oh6l8k9BQu4rrX/9nJRWj
	 wxMoF/ugwNjRJnuDePakW9dPkHc+VlhSZqe9o8chp2naABRu6LNwqZHCQWFcmc/vXs
	 Vr9L6YhWCQ3C6AdmpHVcWmBfq53szmgF6xyBRUdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02A98F800C0;
	Wed, 14 Sep 2022 14:10:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A357F80507; Wed, 14 Sep 2022 14:10:06 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0B7EF8008E
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 14:09:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0B7EF8008E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="FxHPAHNi"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EBt7vM003707;
 Wed, 14 Sep 2022 07:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jSHVQM4f5c6nFOJUjjIDepmDXBFYw20rCfoBuGjpZxs=;
 b=FxHPAHNiev5LqKQxwq0fhh0knh9A3L+fH54NJHCdxxvwRcq7dNdE4bZ4pCexu3cY+Jet
 ULK78uyyKPdBowMSnAtXJocNnxAm4NVZ1eFr6GEOw3allWpqaOlXPce85ODQreR36lDx
 DGcJH6uSTRCoHlYtJv06oXPJMYghdIh0ymYtaDCo57/1A65ad8RsHGIFoS5aDnPJAFrQ
 PPOe5c/vdiOieIrITyTI2dy76Kl9om1CGmRQK4J9JageyUYul70fwVxM+vee6o8rxyr5
 6idGa1w6Z73O+g2FFG5blxvgJigbHEXU868KUh7KCdVe8uTdwz18Jer4rMAG8A2xZPkg OA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jjxyr0xed-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Sep 2022 07:09:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 07:09:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via
 Frontend Transport; Wed, 14 Sep 2022 07:09:56 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.95])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4796B11DA;
 Wed, 14 Sep 2022 12:09:56 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
Subject: [PATCH v3 3/5] soundwire: bus: Don't re-enumerate before status is
 UNATTACHED
Date: Wed, 14 Sep 2022 13:09:47 +0100
Message-ID: <20220914120949.747951-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914120949.747951-1-rf@opensource.cirrus.com>
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xIMthwqaKpNG13HZSLZ4sCZHWrLoNil9
X-Proofpoint-GUID: xIMthwqaKpNG13HZSLZ4sCZHWrLoNil9
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

Don't re-enumerate a peripheral on #0 until we have seen and
handled an UNATTACHED notification for that peripheral.

Without this, it is possible for the UNATTACHED status to be missed
and so the slave->status remains at ATTACHED. If slave->status never
changes to UNATTACHED the child driver will never be notified of the
UNATTACH, and the code in sdw_handle_slave_status() will skip the
second part of enumeration because the slave->status has not changed.

This scenario can happen because PINGs are handled in a workqueue
function which is working from a snapshot of an old PING, and there
is no guarantee when this function will run.

A peripheral could report attached in the PING being handled by
sdw_handle_slave_status(), but has since reverted to device #0 and is
then found in the loop in sdw_program_device_num(). Previously the
code would not have updated slave->status to UNATTACHED because it had
not yet handled a PING where that peripheral had UNATTACHED.

This situation happens fairly frequently with multiple peripherals on
a bus that are intentionally reset (for example after downloading
firmware).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cc858b4107d..6e569a875a9b 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -773,6 +773,16 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 			if (sdw_compare_devid(slave, id) == 0) {
 				found = true;
 
+				/*
+				 * To prevent skipping state-machine stages don't
+				 * program a device until we've seen it UNATTACH.
+				 * Must return here because no other device on #0
+				 * can be detected until this one has been
+				 * assigned a device ID.
+				 */
+				if (slave->status != SDW_SLAVE_UNATTACHED)
+					return 0;
+
 				/*
 				 * Assign a new dev_num to this Slave and
 				 * not mark it present. It will be marked
-- 
2.30.2

