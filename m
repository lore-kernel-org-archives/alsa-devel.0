Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA3BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 06:55:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4469361B2A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 06:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4469361B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8DE2167F;
	Tue, 16 Nov 2021 07:54:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8DE2167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637045722;
	bh=Gz6QD0CWlDLeTm+A3whk6Rwlfw0dfsjpoqHSnnlkfjo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvNyFdiGsiP+VOIxh+Mhp5trzjtZ6buFTRlRp5IU2OB5XXZitbsDRgRX6VQU8W9gD
	 /n2GhZFrx17vC62LKI0YAg2/AWCLgToEW6H5vMcfmcKs3MFLpAp0Rl/DSGCHoVnflK
	 4I3PbA50ktah6RxSKVG1RCpj/phQDkOTMNJGGj5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E19C8F80423;
	Tue, 16 Nov 2021 07:54:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 790F1F804BC; Tue, 16 Nov 2021 07:54:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96D35F8026D
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 07:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96D35F8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="kn2O8FSn"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="xmP+s3p5"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 960931FD33
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637045658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbdGGL/EnXzZstaqWol4rzrpDlCM1ZOAp4oXXsePJaM=;
 b=kn2O8FSnCdjnKBFKNKL8ynXAuhyQwZKQyjjbJHpYVrKvWRYegRHsnioZQ5+hzDl1P/b0E7
 zmTfBKEDC35hS/Zp+Ma5Mr/dxYcHmEgONHswXNl7tgjpWmRXEGqaOsnjUFi4M1nF6d2wlR
 NCcHoNHA8KTd5rmnVDQBvQRs+H5gEvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637045658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbdGGL/EnXzZstaqWol4rzrpDlCM1ZOAp4oXXsePJaM=;
 b=xmP+s3p5Zm13B+0C61iwDrZy3xidErmIl90ZKUB/SbtYNaDrPPMlUMWZE2LEQgFGDY5qqr
 MckHmMU61IirNQDg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 87939A3B81;
 Tue, 16 Nov 2021 06:54:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ALSA: usb-audio: Add minimal-mute notion in dB mapping
 table
Date: Tue, 16 Nov 2021 07:54:14 +0100
Message-Id: <20211116065415.11159-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211116065415.11159-1-tiwai@suse.de>
References: <20211116065415.11159-1-tiwai@suse.de>
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

Some devices do mute the volume at the minimal volume, and for such
devices, we need to set SNDRV_CTL_TLVT_DB_MINMAX_MUTE to the TLV
information.  It corresponds to setting usb_mixer_elem_info.min_mute
flag in the USB-audio driver.

This patch adds a new field min_mute in usbmix_dB_map so that the
mixer map entry can pass the flag.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c      | 1 +
 sound/usb/mixer_maps.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6e7bac8203ba..5b9fd07ce2a2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -145,6 +145,7 @@ static inline void check_mapped_dB(const struct usbmix_name_map *p,
 	if (p && p->dB) {
 		cval->dBmin = p->dB->min;
 		cval->dBmax = p->dB->max;
+		cval->min_mute = p->dB->min_mute;
 		cval->initialized = 1;
 	}
 }
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 92c06b1bb979..9d71c569b148 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -8,6 +8,7 @@
 struct usbmix_dB_map {
 	int min;
 	int max;
+	bool min_mute;
 };
 
 struct usbmix_name_map {
-- 
2.26.2

