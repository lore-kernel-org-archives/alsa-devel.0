Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44350C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 23:00:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA9521707
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 23:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA9521707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E9FD175C;
	Fri, 11 Dec 2020 23:59:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E9FD175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607727639;
	bh=QXlTqffLfiMKu/NGbDRChQ2RLOPF4V15G6y2vjW1Bxo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RwSTvalwmL4EcqX7Cn/mtMBE7RPIxvpVSni64XGHNcuNVt3nlRdco41mR7udBm+Kq
	 rYUDxSNdF0WmSbvWpSQBTwIPf6MQUWQdYM91seuwgqwemnmHTo0M48quwBxEThat/v
	 o34i5wXiJ31fE067uMFB2YNFIe4e3QpyPCouggGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E569F801D8;
	Fri, 11 Dec 2020 23:59:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0046BF8020D; Fri, 11 Dec 2020 23:59:47 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 409C6F8011F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 23:59:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 409C6F8011F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E9159AB7F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 22:59:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils] alsactl: Remove asound.state file check from
 alsa-restore.service again
Date: Fri, 11 Dec 2020 23:59:41 +0100
Message-Id: <20201211225941.12958-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We added the check of asound.state file presence some time ago to
assure that alsactl gets called only if the state file is already
present.  Since then, the situation has changed significantly:
e.g. now alsactl does initialize if the state file isn't present, and
the same alsa-restore.service is used to save the state.  This means
that we should start this service no matter the state file exists at
the boot time or not.  So, revert the old change again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsactl/alsa-restore.service.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
index a84c2e842444..80fd5fd48203 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -7,7 +7,6 @@
 Description=Save/Restore Sound Card State
 ConditionPathExists=!@daemonswitch@
 ConditionPathExistsGlob=/dev/snd/control*
-ConditionPathExists=@asoundrcfile@
 
 [Service]
 Type=oneshot
-- 
2.26.2

