Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9AFC4829A
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:01:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B19CFA4B;
	Tue, 13 Feb 2024 16:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B19CFA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707836495;
	bh=oM+ZoyIjXDNRxwrDc/pX5Se6omq6E/r+S5nA28fWjWk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=A2APN5ByHxGBIoMN6BpaK2WE6Ij/hbdRGDptbISgiKMReWnB8hISFaAOWD7pkDSt+
	 M5KILzUY9MMAVrbknyjf0j2xauIgyZgLNhHdnwk96Qy3e1TfEU250+cpWx81bYzwZ3
	 M9XVuB+RAXgBnDcR9Zv5QBWxEYS2RcktvOcvneU0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CDD6F8016E; Tue, 13 Feb 2024 16:01:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A74B4F805AB;
	Tue, 13 Feb 2024 16:01:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44B09F80238; Sun, 11 Feb 2024 16:09:59 +0100 (CET)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58FABF80104
	for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2024 16:09:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58FABF80104
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Vinod Koul <vkoul@kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] soundwire: fix double free of pointer
Date: Sun, 11 Feb 2024 07:09:37 -0800
Message-ID: <20240211150937.4058-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-MailFrom: D.Dulov@aladdin.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: H2AIQKXMFRWCJK2E3OHPX4QFFS2XNTH3
X-Message-ID-Hash: H2AIQKXMFRWCJK2E3OHPX4QFFS2XNTH3
X-Mailman-Approved-At: Tue, 13 Feb 2024 15:00:56 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H2AIQKXMFRWCJK2E3OHPX4QFFS2XNTH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

If sdw_ml_sync_bank_switch() returns error not on the first iteration,
it leads to freeing prevously freed memory. So, set the pointer to NULL
after each successful bank switch.

Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/soundwire/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 304ff2ee7d75..d650e6f0f8e7 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -833,6 +833,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 				"multi link bank switch failed: %d\n", ret);
 			goto error;
 		}
+		bus->defer_msg.msg = NULL;
 
 		if (multi_link)
 			mutex_unlock(&bus->msg_lock);
-- 
2.25.1

