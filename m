Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97458C25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 05:52:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4F72857;
	Tue, 16 Aug 2022 21:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4F72857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660679294;
	bh=E7Og6JHouSSw+gAIPkrM/TO1NNGAVZ5J89GKbAzcFq0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LFy2wupDlQ8pZz6Z6KdlV83HuKlQLtl8G/DlZUeRRguKX3ZylP734crwdeDURV1D7
	 kN8DMj+6S0GUZ4UInAHgFRhD83EsyM1sGoGjVQ0WX1/x6+cW+m9fkxRkpacaNUUo7q
	 P63wMzLSLtWf5e/25BsvULeWO1W7dhHKV+aEH0jY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5912AF80118;
	Tue, 16 Aug 2022 21:47:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4989BF8032D; Tue, 16 Aug 2022 21:47:22 +0200 (CEST)
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28D13F80082
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 21:47:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28D13F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=neo-zeon.de header.i=@neo-zeon.de
 header.b="UZndlUgd"
Received: from neo-zeon.de (localhost [::1])
 by neo-zeon.de (OpenSMTPD) with ESMTP id 86363371;
 Tue, 16 Aug 2022 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=1; bh=C26QCOHlg2M7zNnEEDSWeN6CCrA=; b=UZndlUgdjqpGAOS3iTNS+qE
 JmrLgQEKziHZDJKUuTDTHMbBasTGzC+Sd5VxrVFyQf0dRxr1cuS2h0Y5IlXgtuOy
 JM4QAgO8a0zczrbaeaHOonYRbXPkTYPJQhIzGduXI1mqkmO2mwjmMT+Z1pW/p5Xs
 7hEWFkUNFc0t252W/GJw=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id a374ab74
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Tue, 16 Aug 2022 12:47:08 -0700 (PDT)
From: Cameron Berkenpas <cam@neo-zeon.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add CLSA0101 to serial-multi-instantiate.
Date: Tue, 16 Aug 2022 12:46:40 -0700
Message-Id: <20220816194639.13870-1-cam@neo-zeon.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Cameron Berkenpas <cam@neo-zeon.de>,
 tanureal@opensource.cirrus.com
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

Added CLSA0101 to serial-multi-instantiate.c.

Signed-off-by: Cameron Berkenpas <cam@neo-zeon.de>
---
 drivers/platform/x86/serial-multi-instantiate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1e8063b7c169..bc9bf591dd10 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -327,8 +327,9 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "INT3515", (unsigned long)&int3515_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
-	/* Non-conforming _HID for Cirrus Logic already released */
+	/* Non-conforming _HIDs for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
+	{ "CLSA0101", (unsigned long)&cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
-- 
2.34.1

