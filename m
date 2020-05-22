Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF8C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 14:52:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE842072C
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 14:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ey1gxBio";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4df+HoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE842072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B484318AB;
	Fri, 22 May 2020 16:52:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B484318AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590159173;
	bh=yO9kSLV/CLczlfa7d6GaWt1Hhi9GOygxQZuKLBBXTPw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ey1gxBioPlYuw7r4y5y+BUDRn+pky9eE3q4g/RWu11WJrrn+Tq7/TEP7TcTKC4xRf
	 6Mf29XA+panKOfGXzEN3JFb8pfnjgd9aUoPPz/uPTSZO2DizVC6Yuz9odF5/PurLfN
	 G1zGHT0becX1IxqdicrM3IUa6UaNISniKwruqq/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6848F8025E;
	Fri, 22 May 2020 16:51:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF798F80274; Fri, 22 May 2020 16:51:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83A4DF801DA
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 16:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83A4DF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="E4df+HoZ"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 638C5221FF;
 Fri, 22 May 2020 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590159089;
 bh=yO9kSLV/CLczlfa7d6GaWt1Hhi9GOygxQZuKLBBXTPw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E4df+HoZS1jY1G2BN0xQssXU9hNS1HfbH3PBpomBKwtclx/PrCbSX7hQSph5HQjok
 cMziK+MDfywFTKsCLM4R6DHk+2nckIY4ySIjtqSWiJGUPO32bXh1BQ7j51P7KTmdcz
 dLVaqDzMTAKKFHIaauA2tP4jm9wQZuzBhU1x/H2M=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/19] ALSA: usb-audio: add mapping for ASRock
 TRX40 Creator
Date: Fri, 22 May 2020 10:51:08 -0400
Message-Id: <20200522145120.434921-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145120.434921-1-sashal@kernel.org>
References: <20200522145120.434921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Andrew Oakley <andrew@adoakley.name>
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

From: Andrew Oakley <andrew@adoakley.name>

[ Upstream commit da7a8f1a8fc3e14c6dcc52b4098bddb8f20390be ]

This is another TRX40 based motherboard with ALC1220-VB USB-audio
that requires a static mapping table.

This motherboard also has a PCI device which advertises no codecs.  The
PCI ID is 1022:1487 and PCI SSID is 1022:d102.  As this is using the AMD
vendor ID, don't blacklist for now in case other boards have a working
audio device with the same ssid.

alsa-info.sh report for this board:
http://alsa-project.org/db/?f=0a742f89066527497b77ce16bca486daccf8a70c

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
Link: https://lore.kernel.org/r/20200503141639.35519-1-andrew@adoakley.name
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_maps.c   | 5 +++++
 sound/usb/quirks-table.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 1689e4f242df..d7a8b23b335b 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -543,6 +543,11 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
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
index 774aeedde071..4f8a2b98e090 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3412,6 +3412,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 ALC1220_VB_DESKTOP(0x0414, 0xa002), /* Gigabyte TRX40 Aorus Pro WiFi */
 ALC1220_VB_DESKTOP(0x0db0, 0x0d64), /* MSI TRX40 Creator */
 ALC1220_VB_DESKTOP(0x0db0, 0x543d), /* MSI TRX40 */
+ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* Asrock TRX40 Creator */
 #undef ALC1220_VB_DESKTOP
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.25.1

