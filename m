Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61E0C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Jan 2022 09:27:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44BB01795;
	Fri,  7 Jan 2022 10:27:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44BB01795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641547671;
	bh=93DEcowAI0MRvSO0T1CI6BT+mV/OyQ80+HUGexWiSQY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JsbrcMMIWdSdQ0V+InBFMYZlT9HF3zM1q9qL88dmYtVpsjm9Dhvg2sqBoLuFQB1lQ
	 F4K78K5QUXGnCqOLbLVa2eplIplJz95M0cXhVk8WGbsLOXuIE8QrVyjT86JWxb8eHq
	 +bMnM7olUG5293+G0TQgV4iuoY7fkPfiHr4L8Qmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1C45F8014B;
	Fri,  7 Jan 2022 10:27:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 520B4F80249; Fri,  7 Jan 2022 10:26:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 283BCF80082
 for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2022 10:26:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 283BCF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="DXATyJUV"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="BQo92Dvi"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CD039210E3;
 Fri,  7 Jan 2022 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641547609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/KB6VCwrU9LakCD/AREo0p/TSjss7dA1WrSnNfI8teg=;
 b=DXATyJUVx6qVGfhsGY6M5zK78UnPzx9w3nuDWvWTphwsUIlQ/s2VXyjoP75ycMvFLfD65t
 +YeOcnnZUOHasyYfjNYCkAG+wg0A7pTrfAg81iNKCKQd/Pqcgb2e8pFHuskkcefX9b8p3E
 7TNgUA8wJo7y3JoOVyK8Oqh5apebRt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641547609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/KB6VCwrU9LakCD/AREo0p/TSjss7dA1WrSnNfI8teg=;
 b=BQo92DviqdWi7FHrBYZETxX0YYEiIzLxnjzUv6Scn+nWb6i5v5JC2C3ci8+fKs0R0Xt1LJ
 64EbQalOA6aLBdBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id B82A4A3B87;
 Fri,  7 Jan 2022 09:26:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix dependency on ASoC cs35l41 codec
Date: Fri,  7 Jan 2022 10:26:47 +0100
Message-Id: <20220107092647.20258-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
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

The recently added support for CS35L41 codec unconditionally selects
CONFIG_SND_SOC_CS35L41_LIB, but this can't work unless the top-level
CONFIG_SND_SOC is enabled.  This patch adds the proper dependency.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 84cefc006f29..68effb74866c 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -97,6 +97,7 @@ config SND_HDA_SCODEC_CS35L41
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
 	depends on ACPI
+	depends on SND_SOC
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
@@ -110,6 +111,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 config SND_HDA_SCODEC_CS35L41_SPI
 	tristate "Build CS35L41 HD-audio codec support for SPI Bus"
 	depends on ACPI
+	depends on SND_SOC
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
-- 
2.31.1

