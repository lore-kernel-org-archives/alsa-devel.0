Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E8C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:04:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8912077D
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HL05SQn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8912077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B91341860;
	Wed, 24 Jun 2020 18:03:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B91341860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593014646;
	bh=m6Yfp4pJAYcfB5drz8givHhh9tmVZiU0Y7JnlCTd2HI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HL05SQn5/2vH0VIDoV5BK+NbJDUi2d8iGd2D4MZM9IZT0i2Euu8HDBmfnr5rLOBjW
	 U2jC16yuaxuOpd7bWo7eKDXS7f1kN1orTLP9DaMEDuDwjO6dvFFyxLCSAU9KTtFZPD
	 b63pbNbdxprFf5cQRhpEhxuXy53YOsIJ94U3Bk7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4867CF8015A;
	Wed, 24 Jun 2020 18:03:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE329F8015B; Wed, 24 Jun 2020 18:03:14 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD0CFF8012F
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 18:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD0CFF8012F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B3D19AD72;
 Wed, 24 Jun 2020 16:03:07 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: core: Warn on empty module
Date: Wed, 24 Jun 2020 18:03:00 +0200
Message-Id: <20200624160300.21703-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

The module argument passed to snd_card_new() must be a valid non-NULL
pointer when the module support is enabled.  Since ASoC driver passes
the argument from each snd_soc_card definition, one may forget to set
the owner field and lead to a NULL module easily.

For catching such an overlook, add a WARN_ON() in snd_card_new().
Also, put the card->module assignment in the ifdef block for a very
minor optimization.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/init.c b/sound/core/init.c
index b02a99766351..0478847ba2b8 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -203,7 +203,10 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	mutex_unlock(&snd_card_mutex);
 	card->dev = parent;
 	card->number = idx;
+#ifdef MODULE
+	WARN_ON(!module);
 	card->module = module;
+#endif
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
-- 
2.16.4

