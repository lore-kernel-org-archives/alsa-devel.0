Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64849C433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Jan 2022 08:14:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C189F1766;
	Sun,  9 Jan 2022 09:13:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C189F1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641716080;
	bh=lp2y3jS2nnQoQbMjz4Yy/IGrK07vs5+xBg+Qycp0o/Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C8H0rX3IEirK7hnAkcA0hopJ1zRDkdBUEn+FKiFDq8zAlrJKW7d1rA2pybZnTU1e1
	 7a8zJNQuZlRklDDm/59e4faGBIHEOkWmVihzVNaglDAV4Ip3lifnxMD22JORGKV+rv
	 eYGPH9OW/xEDUVSY6FUF7rfIMHRvxXaxN8CtktVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67F2DF801F7;
	Sun,  9 Jan 2022 09:13:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EC8AF80212; Sun,  9 Jan 2022 09:13:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2249BF800DA
 for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2022 09:13:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2249BF800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="WfWO+X8b"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="zrAqZduq"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1699E1F382;
 Sun,  9 Jan 2022 08:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641716019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jVl1juY0qsfH0sLWBcyNvdl+ecfHGI6tlURLQzAOEGs=;
 b=WfWO+X8bCvDxXFwDhGV30jsVNKHRcU32ubhfdu7z8y7ouupDrlJPN/xTYSTzTlqYedRo8F
 pIcx11QLB2vvUmS7xU8v0Zt65jQHPFEyZIs0J5aKuFEHhsbEjYxQCS8NUJKUJ4msvpEKsG
 H0MWzbtEyOKpCw5zj7cmPk6dlAcyUQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641716019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jVl1juY0qsfH0sLWBcyNvdl+ecfHGI6tlURLQzAOEGs=;
 b=zrAqZduqqv7qHylu1w9KYft4jHgQ7BUrt9Yric3yLwunU7io9oSQNcaxCniPNNZYmJEGoI
 eyTVLMy2yKw0Z4BA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 0388BA3B83;
 Sun,  9 Jan 2022 08:13:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix dependencies of CS35L41 on SPI/I2C buses
Date: Sun,  9 Jan 2022 09:13:37 +0100
Message-Id: <20220109081337.30623-1-tiwai@suse.de>
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

CS35L41 SPI and I2C drivers depend on those buses, hence they have to
have dependencies in Kconfig; otherwise it may result in missing
symbols.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 68effb74866c..febe1c2b7d9a 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -96,6 +96,7 @@ config SND_HDA_SCODEC_CS35L41
 
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
+	depends on I2C
 	depends on ACPI
 	depends on SND_SOC
 	select SND_HDA_GENERIC
@@ -110,6 +111,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 
 config SND_HDA_SCODEC_CS35L41_SPI
 	tristate "Build CS35L41 HD-audio codec support for SPI Bus"
+	depends on SPI_MASTER
 	depends on ACPI
 	depends on SND_SOC
 	select SND_HDA_GENERIC
-- 
2.31.1

