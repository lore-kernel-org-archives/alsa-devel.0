Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6C4C25B75
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:33:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A07F0850;
	Mon,  3 Jun 2024 14:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A07F0850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717417988;
	bh=Z6gzK40Tr5pMhZZtIC99f8/GM2gQz6amBeERw55iMko=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Zb8iikq2FwGNN6kbZA+90c9yk6j+HDrTkzxT2iF2REyb1uCEyElr+9YkRwLDStZu4
	 5U4K89NZCiHTEgH/yD1ZxJbjAgkTTn7z2dti5UGxg/RDnDO1lIVJzT+IqEg3xIfZLa
	 El9TpEU6YN7GcWRU4wu4sIhRd2TyeGfHu51H8Zeo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7628EF8058C; Mon,  3 Jun 2024 14:32:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07B25F804B2;
	Mon,  3 Jun 2024 14:32:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E45DF80236; Mon,  3 Jun 2024 14:32:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5926F800AC
	for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2024 14:32:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5926F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=g55rAM0t
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A218260DC5;
	Mon,  3 Jun 2024 12:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F299C2BD10;
	Mon,  3 Jun 2024 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717417941;
	bh=Z6gzK40Tr5pMhZZtIC99f8/GM2gQz6amBeERw55iMko=;
	h=From:To:Cc:Subject:Date:From;
	b=g55rAM0txzQDEHqkYAlVenCl0JcFw7yKN3UQBi7w6P5ksgu8lF8AhRLjwKl2/5ywK
	 fHnLpr2OliQwr+DMWr1xPFs0asqAl7m4BC+jaOP02u8oqaLSS6AXO9839HSjuWl5W+
	 jHbHIp/UOJJRI0MzWNowB/uVfgXCRttePyDIS+/vQD56Hjxw2CvDw6oFs/CDf/3Hcb
	 B4yl1PYdkWS7Ysk/AL7mgHpnZpbRBTi/ZCRXZ+Jw8AuL/y7WCCqXkKZAQ261qvpviR
	 ei18VbdJvrAXNMcaj2QqkMCrPsLpDmLFEjZS7hEjjhIfFjBYkbHvgmnAbtzYO5SbHM
	 JBmnDLsWUT5xg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sE6rL-000000007wp-204Q;
	Mon, 03 Jun 2024 14:32:19 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] soundwire: bus: suppress probe deferral errors
Date: Mon,  3 Jun 2024 14:31:27 +0200
Message-ID: <20240603123127.30477-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6KEMTNGIGUUA4YNTJWA5DDJJELSMFU4S
X-Message-ID-Hash: 6KEMTNGIGUUA4YNTJWA5DDJJELSMFU4S
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6KEMTNGIGUUA4YNTJWA5DDJJELSMFU4S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use dev_err_probe() to avoid logging errors on probe deferral:

	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c32faace618f..8c3746f0d527 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -112,9 +112,9 @@ static int sdw_drv_probe(struct device *dev)
 		if (!name)
 			name = drv->driver.name;
 
-		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
-		return ret;
+
+		return dev_err_probe(dev, ret, "Probe of %s failed\n", name);
 	}
 
 	mutex_lock(&slave->sdw_dev_lock);
-- 
2.44.1

