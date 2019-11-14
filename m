Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60515C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:58:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CB1206D3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oQSidGyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CB1206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 312631657;
	Thu, 14 Nov 2019 17:57:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 312631657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573750686;
	bh=xLLag5qaNEiyMKbq5T0ZyTIo9ApGqHkyJw1PcIGNgCw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQSidGyr3h8zTWElBA5YtXS1NJY0GmorUsdQPYmcgxFteqbdHZqMTh5RCmG08QRR+
	 SZZrxzS6Iz4/KQSayjCmsC0b4+n3OlmjFa09/JW8Takli+VhIg4o+8LwaTujXbnIQK
	 mOiM9Rh/r8Gca1PiLM1OuximKsHeQiv0ycGK8LHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C52EF800EF;
	Thu, 14 Nov 2019 17:56:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06A9DF800CF; Thu, 14 Nov 2019 17:56:20 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0801FF800CC
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 17:56:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0801FF800CC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 55D45AD87
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 16:56:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 17:56:13 +0100
Message-Id: <20191114165613.7422-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191114165613.7422-1-tiwai@suse.de>
References: <20191114165613.7422-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/2] ALSA: usb-audio: Add skip_validation option
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

The unit descriptor validation may lead to a probe error when the
device provides a buggy descriptor or the validator detected
incorrectly.  For identifying such an error and band-aiding, give a
new module option, skip_validation.  With this option, the driver
ignores the validation errors with the hexdump of the unit
descriptor, so we can check it in a bit more details.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c     |  3 +++
 sound/usb/usbaudio.h |  1 +
 sound/usb/validate.c | 23 ++++++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index db91dc76cc91..9f743ebae615 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -74,6 +74,7 @@ static bool autoclock = true;
 static char *quirk_alias[SNDRV_CARDS];
 
 bool snd_usb_use_vmalloc = true;
+bool snd_usb_skip_validation;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -96,6 +97,8 @@ module_param_array(quirk_alias, charp, NULL, 0444);
 MODULE_PARM_DESC(quirk_alias, "Quirk aliases, e.g. 0123abcd:5678beef.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
+module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
+MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
 
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index feb30f9c1716..ff3cbf653de8 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -120,5 +120,6 @@ int snd_usb_lock_shutdown(struct snd_usb_audio *chip);
 void snd_usb_unlock_shutdown(struct snd_usb_audio *chip);
 
 extern bool snd_usb_use_vmalloc;
+extern bool snd_usb_skip_validation;
 
 #endif /* __USBAUDIO_H */
diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 389e8657434a..36ae78c3da3d 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -322,11 +322,28 @@ static bool validate_desc(unsigned char *hdr, int protocol,
 
 bool snd_usb_validate_audio_desc(void *p, int protocol)
 {
-	return validate_desc(p, protocol, audio_validators);
+	unsigned char *c = p;
+	bool valid;
+
+	valid = validate_desc(p, protocol, audio_validators);
+	if (!valid && snd_usb_skip_validation) {
+		print_hex_dump(KERN_ERR, "USB-audio: buggy audio desc: ",
+			       DUMP_PREFIX_NONE, 16, 1, c, c[0], true);
+		valid = true;
+	}
+	return valid;
 }
 
 bool snd_usb_validate_midi_desc(void *p)
 {
-	return validate_desc(p, UAC_VERSION_1, midi_validators);
+	unsigned char *c = p;
+	bool valid;
+
+	valid = validate_desc(p, UAC_VERSION_1, midi_validators);
+	if (!valid && snd_usb_skip_validation) {
+		print_hex_dump(KERN_ERR, "USB-audio: buggy midi desc: ",
+			       DUMP_PREFIX_NONE, 16, 1, c, c[0], true);
+		valid = true;
+	}
+	return valid;
 }
-
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
