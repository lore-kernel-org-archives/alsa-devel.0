Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED3C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:52:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C518E2065D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C518E2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 371A01755;
	Fri, 11 Dec 2020 23:51:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 371A01755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607727123;
	bh=RmYEX0VnQ3qopEVdpclKtw7C1gfwXixXI8ZBem6ydo4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hc8Otl+/IxV/qM9HYxt+7uoAJt9Fy5cDZvf/l0j/fw/eKe8G9oAPLpklYwQePISmd
	 mtO0SsyKjXqZ7bKAeB51BcjqFRTMvMXiSrxRdEv+BPc9x89/GERjXbMIHv2cfkT2sZ
	 meeGwrAolG+KoVr5mHDFBpcDJv4XGhoPootz1vc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E11BF801D8;
	Fri, 11 Dec 2020 23:51:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14705F80105; Fri, 11 Dec 2020 23:51:08 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A368FF801D8
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 23:50:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A368FF801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A35D8AB91;
 Fri, 11 Dec 2020 22:50:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils 1/2] alsactl: Fix double decrease of lock timeout
Date: Fri, 11 Dec 2020 23:50:55 +0100
Message-Id: <20201211225056.12301-1-tiwai@suse.de>
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

The state_lock() has a loop to wait for the lock file creation, and
the timeout value gets decremented twice mistakenly, which leads to a
half timeout (5 seconds) than expected 10 seconds.  Fix it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsactl/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/alsactl/lock.c b/alsactl/lock.c
index 4a485392b3bd..05f6e4d2a102 100644
--- a/alsactl/lock.c
+++ b/alsactl/lock.c
@@ -63,7 +63,6 @@ static int state_lock_(const char *file, int lock, int timeout, int _fd)
 			if (fd < 0) {
 				if (errno == EBUSY || errno == EAGAIN) {
 					sleep(1);
-					timeout--;
 				} else {
 					err = -errno;
 					goto out;
-- 
2.26.2

