Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D81C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A8320678
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D7Q6lNzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A8320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 372C616F0;
	Mon, 13 Apr 2020 10:24:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 372C616F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586766294;
	bh=l8bhlNQnOuvQxOYsyz8eTVUBm76tnTCcEWIpLsYJ6rs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7Q6lNzFhRhIgQ5uEVnBYapC8ALfJUB0XaxiG+unYjd9GuyBhEZWIuzmdvfS9BmQn
	 r4id705SK8AGkszO58rN5ZLTe3IAW9cYYnUsmnVDRqJfh041JjI2dAc6hg4NNYNYM0
	 VRToWWOG2kxhwNCZJuST8BBdyqZOXlRYa0Q7zR4k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C03DDF8029B;
	Mon, 13 Apr 2020 10:20:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C53C9F8028C; Mon, 13 Apr 2020 10:20:51 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 823E6F80264
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 10:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 823E6F80264
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BD518AD63;
 Mon, 13 Apr 2020 08:20:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/6] ALSA: hda: Explicitly permit using autosuspend if runtime
 PM is supported
Date: Mon, 13 Apr 2020 10:20:34 +0200
Message-Id: <20200413082034.25166-7-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200413082034.25166-1-tiwai@suse.de>
References: <20200413082034.25166-1-tiwai@suse.de>
Cc: Roy Spliet <nouveau@spliet.org>
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

From: Roy Spliet <nouveau@spliet.org>

This fixes runtime PM not working after a suspend-to-RAM cycle at least for
the codec-less HDA device found on NVIDIA GPUs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Signed-off-by: Roy Spliet <nouveau@spliet.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 02c6308502b1..8519051a426e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2354,8 +2354,10 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
-	if (azx_has_pm_runtime(chip))
+	if (azx_has_pm_runtime(chip)) {
+		pm_runtime_use_autosuspend(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
+	}
 
 out_free:
 	if (err < 0) {
-- 
2.16.4

