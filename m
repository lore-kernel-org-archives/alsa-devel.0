Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F7C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923D42073E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D+R8Zpvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D42073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B5701802;
	Fri, 13 Mar 2020 14:04:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B5701802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584104691;
	bh=iO+RKb968WATkhBcGWhWZ/Z9X0QHOvcKETwYxjKrA28=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D+R8ZpvuNlUUmnIu243C4Hio+IwntryKlaFuZj4IySeAYMUMoCvAUm5lXktxC12+d
	 8yl1Eh8xqqyyCrpJ4ARWX/bgxUNZa7mKrIyvj1arzJRMXkmteaxTOcLUZ+Q2PRV/hG
	 4ICtyF5J4QuUZ2lvywNuAMxL86Y4xlklDJZ8Zuw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53CB4F8021D;
	Fri, 13 Mar 2020 14:03:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2614DF801EB; Fri, 13 Mar 2020 14:02:46 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72078F80090
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 14:02:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72078F80090
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ED1F1B135
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 13:02:42 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Use scnprintf() for string truncation
Date: Fri, 13 Mar 2020 14:02:41 +0100
Message-Id: <20200313130241.8970-1-tiwai@suse.de>
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

snd_hdac_codec_modalias() truncates the string to the given size and
returns its size, but it returned a wrong size from snprintf().
snprintf() returns the would-be-output size, not the actual size.
Use scnprintf() instead to return the correct size.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 9a526aeef8da..e3119f5cb0d5 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_set_chip_name);
  */
 int snd_hdac_codec_modalias(struct hdac_device *codec, char *buf, size_t size)
 {
-	return snprintf(buf, size, "hdaudio:v%08Xr%08Xa%02X\n",
+	return scnprintf(buf, size, "hdaudio:v%08Xr%08Xa%02X\n",
 			codec->vendor_id, codec->revision_id, codec->type);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_codec_modalias);
-- 
2.16.4

