Return-Path: <SRS0=UCdw=6R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84639C28CBC
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 14:18:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568252073E
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QpGVOS7T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="LVuWgceZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568252073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adoakley.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3599C16B6;
	Sun,  3 May 2020 16:17:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3599C16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588515479;
	bh=YW2eU7aBfIFLN+ExVvzDFTNHndgDO/OiXnwGLv3Lv3Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QpGVOS7Tk99fPoH1btiH0qq9YPXge16QtdfXVnVnpY9vhc6Br8NxImePBpL5FmWOl
	 iPDdIOfnNR/JQomo4TIy0g+5362QdEzCfKfu4vLtIvj/wUkxIKtiCbxmBiU8txqFYg
	 JcHV3+428AV34H6N2PzgtCp42uMa/2SVlyk4WluE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5201F8015B;
	Sun,  3 May 2020 16:17:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B05EDF8015F; Sun,  3 May 2020 16:17:02 +0200 (CEST)
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 803B9F800EE
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2020 16:16:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 803B9F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=adoakley.name header.i=@adoakley.name
 header.b="LVuWgceZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i5qyWzie2YUEYBq6MlE0gghXLVMPc0sHLd8NDaB0YPc=; b=LVuWgceZ3vGKfxP4KXCT6mE6oJ
 4YzqCG3igDvAqnCOcvlnRLTvV2HB9OSNECAdp/7jGp/ng2u5nosiVynxtk/5ieQYiEFwJn/CHnZq6
 KUOSFYBYseEbj8pe4VKcQylJxzBhlBBw95CxKV56OHqiL2aJnGjiEa9+A2vQwIC36G0E=;
Received: from [2001:8b0:14bb:e93b:5435:c2c0:635c:9b55]
 (helo=ado-tr.ado-tr.lan)
 by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92.2) (envelope-from <andrew@adoakley.name>)
 id 1jVFQK-0001Pn-O6; Sun, 03 May 2020 14:16:52 +0000
From: Andrew Oakley <andrew@adoakley.name>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: add mapping for ASRock TRX40 Creator
Date: Sun,  3 May 2020 15:16:39 +0100
Message-Id: <20200503141639.35519-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrew Oakley <andrew@adoakley.name>
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

This is another TRX40 based motherboard with ALC1220-VB USB-audio
that requires a static mapping table.

This motherboard also has a PCI device which advertises no codecs.  The
PCI ID is 1022:1487 and PCI SSID is 1022:d102.  As this is using the AMD
vendor ID, don't blacklist for now in case other boards have a working
audio device with the same ssid.

alsa-info.sh report for this board:
http://alsa-project.org/db/?f=0a742f89066527497b77ce16bca486daccf8a70c

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 sound/usb/mixer_maps.c   | 5 +++++
 sound/usb/quirks-table.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 0260c750e156..bfdc6ad52785 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -549,6 +549,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = trx40_mobo_map,
 		.connector_map = trx40_mobo_connector_map,
 	},
+	{	/* Asrock TRX40 Creator */
+		.id = USB_ID(0x26ce, 0x0a01),
+		.map = trx40_mobo_map,
+		.connector_map = trx40_mobo_connector_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index a1df4c5b4f8c..6313c30f5c85 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3563,6 +3563,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 ALC1220_VB_DESKTOP(0x0414, 0xa002), /* Gigabyte TRX40 Aorus Pro WiFi */
 ALC1220_VB_DESKTOP(0x0db0, 0x0d64), /* MSI TRX40 Creator */
 ALC1220_VB_DESKTOP(0x0db0, 0x543d), /* MSI TRX40 */
+ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* Asrock TRX40 Creator */
 #undef ALC1220_VB_DESKTOP
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.24.1

