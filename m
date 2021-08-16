Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5961C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:44:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D35760F22
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D35760F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4889E16AC;
	Mon, 16 Aug 2021 19:43:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4889E16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629135848;
	bh=ic32dy6NfDLUPa0z1MYS8w9G+KtXwDfRNj7oobxhQAA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f+fH37ASlrlblyaCLGDX9mhc1IofnaK7wT7URQuMq0X9E8V0aJ/ZYujw86rrjz3NC
	 8NchU5GlycEhEnwDMug4ga0IuIDvdclJXIBhuIsyoJBDtnwYv9GxFcPg+28QplpDeE
	 3EzkxRU0x+enxb+OlEadPAII1sPwSAXrGyj6idNw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5586F80134;
	Mon, 16 Aug 2021 19:43:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28289F80249; Mon, 16 Aug 2021 19:43:17 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39512F80154
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 19:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39512F80154
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215632618"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="215632618"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 10:43:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="675864566"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 10:43:03 -0700
From: Imre Deak <imre.deak@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix hang during shutdown due to link reset
Date: Mon, 16 Aug 2021 20:42:59 +0300
Message-Id: <20210816174259.2759103-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, youling257@gmail.com
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

During system shutdown codecs may be still active, and resetting the
controller->codec HW link in this state - based on the bug reporter's
tests - leads to the shutdown sequence to get stuck. This happens at
least on the reporter's KBL system with an ALC662 codec.

For now fix the issue by skipping the link reset step.

Fixes: 472e18f63c42 ("ALSA: hda: Release controller display power during shutdown/reboot")
References: https://bugzilla.kernel.org/show_bug.cgi?id=214045
References: https://gitlab.freedesktop.org/drm/intel/-/issues/3618#note_1024665
Reported-and-tested-by: youling257@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>
Cc: youling257@gmail.com
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 sound/pci/hda/hda_intel.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0322b289505e7..0062c18b646af 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -883,10 +883,11 @@ static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
 	return azx_get_pos_posbuf(chip, azx_dev);
 }
 
-static void azx_shutdown_chip(struct azx *chip)
+static void __azx_shutdown_chip(struct azx *chip, bool skip_link_reset)
 {
 	azx_stop_chip(chip);
-	azx_enter_link_reset(chip);
+	if (!skip_link_reset)
+		azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
 	display_power(chip, false);
 }
@@ -895,6 +896,11 @@ static void azx_shutdown_chip(struct azx *chip)
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
 
+static void azx_shutdown_chip(struct azx *chip)
+{
+	__azx_shutdown_chip(chip, false);
+}
+
 static void azx_add_card_list(struct azx *chip)
 {
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
@@ -2385,7 +2391,7 @@ static void azx_shutdown(struct pci_dev *pci)
 		return;
 	chip = card->private_data;
 	if (chip && chip->running)
-		azx_shutdown_chip(chip);
+		__azx_shutdown_chip(chip, true);
 }
 
 /* PCI IDs */
-- 
2.27.0

