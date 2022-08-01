Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6091C00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 16:58:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D111815F2;
	Mon,  1 Aug 2022 18:57:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D111815F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659373110;
	bh=CML0OdqlNOy9XCOxCjrE1GWVUeg6kc8X79CXTGEv6jc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZfIm+ErvJ5p/quLG8MCiwEhPDwHBY098mxlpYJr9/dCffwqnfQia/rzhZWVbmYB/
	 6EKZK96nCTAzqA98LH3GxIhyVTzSmaOHQupAnOH7zcXl8t7LDcuNjU4r/hZNOl00QR
	 fo/XjzO29nyRqfZueu8kFvMQ2LEqeFyKwJEiXIv8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A108F80544;
	Mon,  1 Aug 2022 18:57:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E591F80551; Mon,  1 Aug 2022 18:56:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE534F8014B
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 18:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE534F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="mnXiXs4e"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="yt0t5kGo"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F314920633;
 Mon,  1 Aug 2022 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659373002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/4/7H3+OptkylLM9OiNRuP/dwmGL/7B37zAuIZMM2A=;
 b=mnXiXs4eeEcU6cT4Yqq91zmidkzowMOhQaQlsQ3Q/nLFPuudAP/d0EhGEiL6353m1HlYW+
 +d5RXmEtXGb2p+m9Vc6xzTlFPONSJCRyn4J0H1Dn6X7E/3PGLwnaZC9I6wudq0ZfiGrgpK
 9vJuEDOXgUGyL7Ptz7wpAuaHnCxNvxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659373002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/4/7H3+OptkylLM9OiNRuP/dwmGL/7B37zAuIZMM2A=;
 b=yt0t5kGo1kdP9y3KuIYznG9ilgCqsIlvk+p3PlaN7t+/9BzvHMcdCyHPXscmZNA9es31Z1
 PGdDD5eTSP9JYHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D397113AAE;
 Mon,  1 Aug 2022 16:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8JXnMsoF6GLXGgAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 01 Aug 2022 16:56:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/7] ALSA: aoa: Replace sprintf() with sysfs_emit()
Date: Mon,  1 Aug 2022 18:56:34 +0200
Message-Id: <20220801165639.26030-3-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801165639.26030-1-tiwai@suse.de>
References: <20220801165639.26030-1-tiwai@suse.de>
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

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co.  This patch replaces such sprintf()
calls with sysfs_emit() while simplifying the open code in
modalias_show(); as modalias[] is a NUL-terminated string, we can pass
it straightly to a printf() argument.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/soundbus/sysfs.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/aoa/soundbus/sysfs.c b/sound/aoa/soundbus/sysfs.c
index dead3105689b..e87b28428b99 100644
--- a/sound/aoa/soundbus/sysfs.c
+++ b/sound/aoa/soundbus/sysfs.c
@@ -10,19 +10,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct soundbus_dev *sdev = to_soundbus_device(dev);
 	struct platform_device *of = &sdev->ofdev;
-	int length;
 
-	if (*sdev->modalias) {
-		strscpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
-		strcat(buf, "\n");
-		length = strlen(buf);
-	} else {
-		length = sprintf(buf, "of:N%pOFn%c%s\n",
-				 of->dev.of_node, 'T',
-                                 of_node_get_device_type(of->dev.of_node));
-	}
-
-	return length;
+	if (*sdev->modalias)
+		return sysfs_emit(buf, "%s\n", sdev->modalias);
+	else
+		return sysfs_emit(buf, "of:N%pOFn%c%s\n",
+				  of->dev.of_node, 'T',
+				  of_node_get_device_type(of->dev.of_node));
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -32,7 +26,7 @@ static ssize_t name_show(struct device *dev,
 	struct soundbus_dev *sdev = to_soundbus_device(dev);
 	struct platform_device *of = &sdev->ofdev;
 
-	return sprintf(buf, "%pOFn\n", of->dev.of_node);
+	return sysfs_emit(buf, "%pOFn\n", of->dev.of_node);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -42,7 +36,7 @@ static ssize_t type_show(struct device *dev,
 	struct soundbus_dev *sdev = to_soundbus_device(dev);
 	struct platform_device *of = &sdev->ofdev;
 
-	return sprintf(buf, "%s\n", of_node_get_device_type(of->dev.of_node));
+	return sysfs_emit(buf, "%s\n", of_node_get_device_type(of->dev.of_node));
 }
 static DEVICE_ATTR_RO(type);
 
-- 
2.35.3

