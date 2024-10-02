Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15268CF6D28
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:30:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CAF4850;
	Wed,  2 Oct 2024 16:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CAF4850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727879443;
	bh=LbaIkjMn2T/qFzP3EUrmSJRwxkrrGPGpe0Yjfir23FE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DpcJYOu2Szm9Pp3om8Rxk21wcA66CwcRWPTPyuwjT02MYh+2s/6N6WmI0RNqYaWKh
	 AK1fuAhbEhcjo77AmZ4bZpxGU7JzUL3Q9jKTb6x9S5pb0jHL1p8SbKVV9Wt23hjUeG
	 Sc7dzGNQ+2AVD/SHHk/7QmUpiMyjoERT1wthZ5Fs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B22B7F8001E; Wed,  2 Oct 2024 16:30:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68493F80580;
	Wed,  2 Oct 2024 16:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 989CBF80518; Wed,  2 Oct 2024 16:30:03 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36FA7F8001E
	for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2024 16:30:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36FA7F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=cltZFlcn
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 4926KwR6000732;
	Wed, 2 Oct 2024 09:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=dTCekQOOPx6KCM72yeUoEYHBa6xB9D98cP6rPfH3EEA=; b=
	cltZFlcntOeKIVr54Z2rquYS/CZ4J3EwHsNKRt7LKNGgs8us6ZyAsZSuV6u+p0wx
	drA7sUIK80Sc7FBknnMklTggAh0XT9tdBhTHHX1tR8rEPBBtLUbd2F3hj5oK18iA
	/T4mz0p1/Zj+wNOoycZSVdvQlz/BYwM4ASgIitbn2aiz+qeXg/K5kVyP0C6J2UlR
	hte2N/pimz6v/bNniICGXbYqV3qZpuHBNCGw1NTXQ2tQ3AkSKoqkI4AelqA4tqe2
	oQBf4V5zBRAFhwPc3FJKEW030Vu7WLJyWDTRX0q7kq5fJnLSbId2iZ8c6F2gLstc
	YZoo1pton93FaBqRnfgUww==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41xe7jw7vg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 09:29:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 15:29:58 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 2 Oct 2024 15:29:58 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0FB1C820248;
	Wed,  2 Oct 2024 14:29:58 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: <perex@perex.cz>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        "Maciej
 Strozek" <mstrozek@opensource.cirrus.com>
Subject: [PATCH alsa-ucm-conf v2 2/2] sof-soundwire: Add sequence for
 controlling Mic Mute LED
Date: Wed, 2 Oct 2024 15:29:47 +0100
Message-ID: <20241002142947.4015912-2-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002142947.4015912-1-mstrozek@opensource.cirrus.com>
References: <20241002142947.4015912-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gUuJ_6WkMBMcrB_5NJ03XmzyNbPQLxi0
X-Proofpoint-GUID: gUuJ_6WkMBMcrB_5NJ03XmzyNbPQLxi0
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: Q2PSUDOFKFW6ZN2XHODOHWBBSTDK4YQP
X-Message-ID-Hash: Q2PSUDOFKFW6ZN2XHODOHWBBSTDK4YQP
X-MailFrom: prvs=7005510c00=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q2PSUDOFKFW6ZN2XHODOHWBBSTDK4YQP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
v2: no changes
---
 ucm2/codecs/cs42l43/init.conf | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ucm2/codecs/cs42l43/init.conf b/ucm2/codecs/cs42l43/init.conf
index cf61833..fad41dd 100644
--- a/ucm2/codecs/cs42l43/init.conf
+++ b/ucm2/codecs/cs42l43/init.conf
@@ -12,3 +12,9 @@ LibraryConfig.remap.Config {
 		}
 	}
 }
+
+FixedBootSequence [
+        exec "-/sbin/modprobe snd_ctl_led"
+        sysw "-/class/sound/ctl-led/mic/card${CardNumber}/attach:cs42l43 Decimator 3 Switch"
+        sysw "-/class/sound/ctl-led/mic/card${CardNumber}/attach:cs42l43 Decimator 4 Switch"
+]
--
2.39.5

