Return-Path: <SRS0=8kjR=FC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0DC63798
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Nov 2020 20:32:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AC02222C
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Nov 2020 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pFNHByT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AC02222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B11B01865;
	Sat, 28 Nov 2020 21:31:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B11B01865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606595538;
	bh=pSc4TVNwLrhg4OosZd5k1Gn2qh8LrkGQb//ejaC+qhI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pFNHByT8mQIAVvN3q0Bc8/KdCuU9cjsEAbGX9CAd6ZBWDZp+8O5KNvz8nNZSfVft+
	 1uEAS3eX3U/xT4rJ+bTu83EGX0iVHqSrYtbQad7jFuzCA1xxSOXRzuQpfXkJMQWEXo
	 DdXUnuES+iblqP7+g9tGpfLu9a4vi4Y0zq7iZdAY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E60AF80165;
	Sat, 28 Nov 2020 21:31:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA41DF800EA; Sat, 28 Nov 2020 21:31:14 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 084FDF800EA
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2020 21:31:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 084FDF800EA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2A01EAC17
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2020 20:31:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils] alsactl: Make sure the kernel driver loaded before
 alsa-restore.service
Date: Sat, 28 Nov 2020 21:31:01 +0100
Message-Id: <20201128203101.7333-1-tiwai@suse.de>
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

alsa-restore.service requires the sound devices having been set up
beforehand.  However, systemd tends to start this service too early
before the driver setup, which leads to the unsuccessful state
restore.

For assuring the kernel driver setup before this service, add the
dependency on sound.target.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1179363
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsactl/alsa-restore.service.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
index a84c2e842444..104b97a6ef68 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -8,6 +8,8 @@ Description=Save/Restore Sound Card State
 ConditionPathExists=!@daemonswitch@
 ConditionPathExistsGlob=/dev/snd/control*
 ConditionPathExists=@asoundrcfile@
+Requires=sound.target
+After=sound.target
 
 [Service]
 Type=oneshot
-- 
2.26.2

