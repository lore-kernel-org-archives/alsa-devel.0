Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA953CA9EC7
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:19:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DA7214D8
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pGiZk/ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DA7214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E281701;
	Tue,  5 Nov 2019 09:18:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E281701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572941959;
	bh=Qldwp+pqakABxoarWgBUTbQqS/jdih3FkaJt5DoEVUc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pGiZk/otE3+Q3Hkm1ljEx+pbhl3S8E1ltj8yMHsZQT00XVtW8KeAOhDnNLY7nAGIw
	 qa4hYcM07xZj7BwN+risBNrx9VuZyHBQiGWNhfehp3CsyzblrhVlTKYc5asu4PNV1C
	 p2+VnbNn5OKPVXdaqZiBvti5ZoEQhnVYYrkFcCRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF922F80446;
	Tue,  5 Nov 2019 09:18:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9583F8049B; Tue,  5 Nov 2019 09:18:26 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5B5AF800F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 09:18:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5B5AF800F3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AA465AF95
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 08:18:23 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 09:18:06 +0100
Message-Id: <20191105081806.4896-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda: Disable regmap internal locking
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

Since we apply the own mutex (bus->cmd_mutex) in HDA core side, the
internal locking in regmap is superfluous.  This patch adds the flag
to indicate that.

Also, an infamous side-effect by this change is that it disables the
regmap debugfs, too, and this is seen rather good; the regmap debugfs
isn't quite useful for HD-audio as it provides the very sparse
registers and its debugfs access tends to lead to the way too high
resource usages or sometimes hang up.  So it'd be rather safe to
disable it altogether.

Link: https://lore.kernel.org/r/2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 286361ecd640..906b1e20bae0 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -363,6 +363,7 @@ static const struct regmap_config hda_regmap_cfg = {
 	.reg_write = hda_reg_write,
 	.use_single_read = true,
 	.use_single_write = true,
+	.disable_locking = true,
 };
 
 /**
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
