Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA454C7EE29
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 10:13:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E42C682A;
	Fri,  2 Jun 2023 12:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E42C682A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685700833;
	bh=EaaYP7koW2tpLrxhYgKWoEzE3HT1QFzxLh6XdMmw8g0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=uBc+9Yt9/ZwU4DCmtinbGwYL/vr57NnPkIdVlbouHLPzEQCGZWFMe7yGLKdqZwV47
	 +91Gn2YExXBWGovDq4ngDszb3vNOrJgFHVGReYmEpILXT2C55NjG1j1cLX2eH4GTPs
	 bAfjQXdDRYFwJjIzWYgycIstnVL6L1vckLTXzvwQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 373B7F80132; Fri,  2 Jun 2023 12:12:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E67CF80132;
	Fri,  2 Jun 2023 12:12:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFD90F80552; Fri,  2 Jun 2023 12:12:04 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2D54F80149
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 12:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2D54F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=BmLckQfC
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3529pNL4008786;
	Fri, 2 Jun 2023 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BTOTTJsN7I2l8z0ulkqfI6NnphC4S4LDmAiJC+e0M4k=;
 b=BmLckQfCGiRPgUG00hU0t+BQGZiEQlhT8iN+alyjqAVfwtB6CBCtM7u0M86kz6oPo676
 R+0MB4dE80GdXKM3aNpW1omZg1x9lDaMZUHW70ZEWPazL/G3Ue6XKA9eXvXbYZS3f9ZN
 UNw//+QrxkqwKOHOdvzC9q5LoDKkGIm1dsYZoGlz5uIDWy1eJeZPYzkxHksBAtYvA6je
 optHCv7y5jjptr4vTDTVGh4p/QxT1FnlIrJx8QCyUE13YxMEHekglGTNGHklwOHbJY5j
 iwogYYsuzfEXjMkfnpwSnIQHGLRw5fWs5J52JWhSC6ZJoHHhmLPAASbTvJ32SRevmDdK pQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jun 2023 05:11:42 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9DA8A468;
	Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/5] soundwire: stream: Add missing clear of alloc_slave_rt
Date: Fri, 2 Jun 2023 11:11:36 +0100
Message-ID: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -nkIT4ZhmyRip5gK4eOuyv4GAWhgwrlz
X-Proofpoint-ORIG-GUID: -nkIT4ZhmyRip5gK4eOuyv4GAWhgwrlz
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: EYZWEEYLWR57RYYBHLFAX47GABR7R3QU
X-Message-ID-Hash: EYZWEEYLWR57RYYBHLFAX47GABR7R3QU
X-MailFrom: prvs=1517dd3c90=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EYZWEEYLWR57RYYBHLFAX47GABR7R3QU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The current path that skips allocating the slave runtime does not clear
the alloc_slave_rt flag, this is clearly incorrect. Add the missing
clear, so the runtime won't be erroneously cleaned up.

Fixes: f3016b891c8c ("soundwire: stream: sdw_stream_add_ functions can be called multiple times")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Added missing fixes tag

Thanks,
Charles

 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index c2191c07442b0..379228f221869 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -2021,8 +2021,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt)
+	if (s_rt) {
+		alloc_slave_rt = false;
 		goto skip_alloc_slave_rt;
+	}
 
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
-- 
2.30.2

