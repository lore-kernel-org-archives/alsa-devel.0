Return-Path: <SRS0=yPb/=66=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4DAC433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:31:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4508420709
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dIUChfIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4508420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 975161671;
	Sat, 16 May 2020 08:30:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 975161671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589610701;
	bh=tTaMOxHcWP+vYlSETwWDiNryXSA7xvtYMSFacDwwaG4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIUChfIXDhIsxHJS4m8NEJ2MfttKIklpr/+PYrJpazHQuEeqZlJMxc7czBujb+/fK
	 QUtlqi9q/95/qUxoeMTIRbsp/z7GXXR5fhqEJhxToMxr9jOtiwRg4iz9VnTq3G7MNp
	 BnYzZiK3g5iX4lg+x8U7uiBPJdQpfnRjKc2sLOCQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AD6AF8027B;
	Sat, 16 May 2020 08:29:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 445ABF8014C; Sat, 16 May 2020 08:29:06 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85CB0F800FE
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 08:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85CB0F800FE
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D8382AD68
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 06:29:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: hda: Unexport some local helper functions
Date: Sat, 16 May 2020 08:28:54 +0200
Message-Id: <20200516062854.22141-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200516062854.22141-1-tiwai@suse.de>
References: <20200516062854.22141-1-tiwai@suse.de>
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

snd_hdac_bus_queue_event() and snd_hdac_bus_exec_verb() are used only
internally in HD-audio core.  Let's drop the exports and move the
declarations into local.h.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h     | 3 ---
 sound/hda/hdac_bus.c        | 2 --
 sound/hda/hdac_controller.c | 1 +
 sound/hda/local.h           | 3 +++
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 10945963d727..c1f78d9a6e47 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -372,11 +372,8 @@ struct hdac_bus {
 int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_bus_ops *ops);
 void snd_hdac_bus_exit(struct hdac_bus *bus);
-int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
-			   unsigned int cmd, unsigned int *res);
 int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
 				    unsigned int cmd, unsigned int *res);
-void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex);
 
 static inline void snd_hdac_codec_link_up(struct hdac_device *codec)
 {
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index dee04792ca86..09ddab5f5cae 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -81,7 +81,6 @@ int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
 	mutex_unlock(&bus->cmd_mutex);
 	return err;
 }
-EXPORT_SYMBOL_GPL(snd_hdac_bus_exec_verb);
 
 /**
  * snd_hdac_bus_exec_verb_unlocked - unlocked version
@@ -150,7 +149,6 @@ void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex)
 
 	schedule_work(&bus->unsol_work);
 }
-EXPORT_SYMBOL_GPL(snd_hdac_bus_queue_event);
 
 /*
  * process queued unsolicited events
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index ac15aa357fbd..011b17cc1efa 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -9,6 +9,7 @@
 #include <sound/core.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_register.h>
+#include "local.h"
 
 /* clear CORB read pointer properly */
 static void azx_clear_corbrp(struct hdac_bus *bus)
diff --git a/sound/hda/local.h b/sound/hda/local.h
index 5b935219352f..896ba142e8bc 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -36,6 +36,9 @@ void hda_widget_sysfs_exit(struct hdac_device *codec);
 int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec);
 void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 				struct hdac_device *codec);
+void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex);
+int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
+			   unsigned int cmd, unsigned int *res);
 
 int snd_hdac_exec_verb(struct hdac_device *codec, unsigned int cmd,
 		       unsigned int flags, unsigned int *res);
-- 
2.16.4

