Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FEBC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jan 2022 13:58:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E36621B1B;
	Thu, 27 Jan 2022 14:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E36621B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643291900;
	bh=sFfWeMOwb/DaCYYoJwj4HHE8Pa/mi0j8iVOl9OvQIco=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lqqTVPO66sbLEZTfpo2IHLKGs0wMTjRh6NVy0Pq6EKlGXWKl7/wAiXoT9ZqAZiyej
	 QHbeFBM5eiG38j75pZsX1ztIaHwAK/9AMDhkiidegKBhfa7cYziRLckDtZOJBnrNdg
	 rMSkw7+W/nhDz+R96mgL/JB0RPPqqcz2iKDCODKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ACEBF80249;
	Thu, 27 Jan 2022 14:57:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65BB9F80254; Thu, 27 Jan 2022 14:57:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E986F80118
 for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2022 14:57:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E986F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="goeBwUMi"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ekq+si23"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id ABCF51F45F
 for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2022 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643291838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LmT/SjHcbPhcyFOdbApD7gw2Cm4x3JFbwybWT/8fCqQ=;
 b=goeBwUMiNz8wpJPFhh8Y6c40P5Joy6pyuYbGTStIGXTrOWbKwLKP65gS8o1iym6todNPrm
 t+eAoHgMirfakkOPSBWdmHAkZCs5Q7a7VBQYgXXCACYfxCET7t64fgUbOru7KdUu0SKNVD
 jgB2PbQBdo+9g/wjoq6uUus0hZGXXHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643291838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LmT/SjHcbPhcyFOdbApD7gw2Cm4x3JFbwybWT/8fCqQ=;
 b=ekq+si239yWekUZg4j9WPQgm5gsj1WMr6bvYceMoW1ibVWxT+5bLxmrzmbFhQua4kWFg9g
 Pd9/YlG6iXYXlODg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 9B316A3B81;
 Thu, 27 Jan 2022 13:57:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix signedness of sscanf() arguments
Date: Thu, 27 Jan 2022 14:57:17 +0100
Message-Id: <20220127135717.31751-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
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

The %x format of sscanf() takes an unsigned int pointer, while we pass
a signed int pointer.  Practically it's OK, but this may result in a
compile warning.  Let's fix it.

Fixes: a235d5b8e550 ("ALSA: hda: Allow model option to specify PCI SSID alias")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 82c492b05667..cd1db943b7e0 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -981,7 +981,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 	int id = HDA_FIXUP_ID_NOT_SET;
 	const char *name = NULL;
 	const char *type = NULL;
-	int vendor, device;
+	unsigned int vendor, device;
 
 	if (codec->fixup_id != HDA_FIXUP_ID_NOT_SET)
 		return;
-- 
2.31.1

