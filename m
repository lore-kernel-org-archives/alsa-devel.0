Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A1C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:52:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A94206B7
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A94206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7F2B176D;
	Fri, 11 Dec 2020 23:52:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7F2B176D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607727174;
	bh=h/gViz4biH66ZOf7E3+xdonpro9NW4DpmLv0PcmvmoY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nmAtE4XOt/ATJMRbFTsU3fxKfuxBhzEhUhkm+99XeOeYHXggS93tUje977AALu1P/
	 ByOL+G+5ZUFWWBk+toVhkNKbLpngFlwPbhXTMrWG0LcAix6yEzkYk5uHkuYrFYTiw9
	 nWSap/42b/yoIdp/4z5rxCun+2LTjXGa+f2+qo2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8563FF80240;
	Fri, 11 Dec 2020 23:51:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56053F8021D; Fri, 11 Dec 2020 23:51:08 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1057F8011F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 23:50:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1057F8011F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B191DAC10;
 Fri, 11 Dec 2020 22:50:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils 2/2] alsactl: Fix race at creating a lock file
Date: Fri, 11 Dec 2020 23:50:56 +0100
Message-Id: <20201211225056.12301-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201211225056.12301-1-tiwai@suse.de>
References: <20201211225056.12301-1-tiwai@suse.de>
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

A race at creating a lock file in state_lock() was discovered
recently: namely, between the first open(O_RDWR) and the second
open(O_RDWR|O_CREAT|O_EXCL) calls, another alsactl invocation may
already create a lock file, then the second open() will return EEXIST,
which isn't handled properly and treated as a fatal error.

In this patch, we check EEXIST case and try again open() with O_RDWR.
This must succeed usually, and if it fails, handle finally as the
fatal error.

BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1179904
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsactl/lock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/alsactl/lock.c b/alsactl/lock.c
index 05f6e4d2a102..5b4746231996 100644
--- a/alsactl/lock.c
+++ b/alsactl/lock.c
@@ -63,10 +63,15 @@ static int state_lock_(const char *file, int lock, int timeout, int _fd)
 			if (fd < 0) {
 				if (errno == EBUSY || errno == EAGAIN) {
 					sleep(1);
-				} else {
-					err = -errno;
-					goto out;
+					continue;
 				}
+				if (errno == EEXIST) {
+					fd = open(nfile, O_RDWR);
+					if (fd >= 0)
+						break;
+				}
+				err = -errno;
+				goto out;
 			}
 		}
 	}
-- 
2.26.2

