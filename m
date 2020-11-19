Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA18C2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:05:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18A22469D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JaFryOo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18A22469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 179771701;
	Thu, 19 Nov 2020 13:04:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 179771701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605787510;
	bh=MC6mYsiY5JhLDa1gNMiiuIJnar4qxf4vzzfFka/rB9E=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JaFryOo3IVeGiuH3iE/O4pyOokHtPhbNOJdKK+haLGkXCFTwvtlKa8Us0ZXHlqidN
	 S6mPdfijY5ot+1/XJq0uoCiHmbhfq08o13JLQpgHD5khRIRyXcPJSPSBIckalR6/io
	 xGfTVYmHn2GiKLk+eKMJZjn+qqWa4c82xq+sEcSA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31BAEF80169;
	Thu, 19 Nov 2020 13:04:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D076F801ED; Thu, 19 Nov 2020 13:04:15 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD629F800C5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 13:04:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD629F800C5
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0AB0BACC5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 12:04:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/ca0132: Fix compile warning without PCI
Date: Thu, 19 Nov 2020 13:04:04 +0100
Message-Id: <20201119120404.16833-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

CONFIG_PCI=n leads to a compile warning like:
  sound/pci/hda/patch_ca0132.c:8214:10: warning: no case matching constant switch condition '0'
due to the missed handling of QUIRK_NONE in ca0132_mmio_init().
Fix it.

Fixes: bf2aa9ccc8e5 ("ALSA: hda/ca0132 - Cleanup ca0132_mmio_init function.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e0c38f2735c6..d8370a417e3d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -9183,6 +9183,8 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 	case QUIRK_AE5:
 		ca0132_mmio_init_ae5(codec);
 		break;
+	default:
+		break;
 	}
 }
 
-- 
2.16.4

