Return-Path: <SRS0=ZD2s=ZQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C2CC432C3
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2019 08:40:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1217D207FD
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2019 08:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XbvuXgIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1217D207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7138C184C;
	Sun, 24 Nov 2019 09:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7138C184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574584824;
	bh=P4+ItKHeMf8w00jP0qQmfAKpbEcfAfTQQ613k+9S2C8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XbvuXgImmfpwNpheoCJ7smASTH6XTTNS3rLuYVfs+WeENGGzaaCFhTzVM+9iq7fd2
	 ag+uRrJ1903ky2YgHDiIMvwYtQ8J1trLzBRidPmcv8sDAl262H9e8CiZTANLgw/jW0
	 Nrf5Lext9ZvSJybZEGkvT0MgUcT3XXMSffLzq2uM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E69E1F800E5;
	Sun, 24 Nov 2019 09:39:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22068F801ED; Sun, 24 Nov 2019 09:39:31 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B8F9F80108
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2019 09:39:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B8F9F80108
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 226E8AEE0
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2019 08:39:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun, 24 Nov 2019 09:39:24 +0100
Message-Id: <20191124083924.14049-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: aloop: Fix dependency on timer API
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

An explicit Kconfig dependency is missing for the recent addition of
the timer support.  CONFIG_SND_TIMER isn't always selected by SND_PCM.

Fixes: 26c53379f98d ("ALSA: aloop: Support selection of snd_timer instead of jiffies")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 15d6d46acf9c..577c8e03ec4d 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -92,6 +92,7 @@ config SND_DUMMY
 config SND_ALOOP
 	tristate "Generic loopback driver (PCM)"
 	select SND_PCM
+	select SND_TIMER
 	help
 	  Say 'Y' or 'M' to include support for the PCM loopback device.
 	  This module returns played samples back to the user space using
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
