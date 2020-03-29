Return-Path: <SRS0=QDkj=5O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13013C43331
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 07:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBDE206CC
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DV1NLDN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBDE206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6CF5167A;
	Sun, 29 Mar 2020 09:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6CF5167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585468707;
	bh=jsddERluIm+/k8aoCGWfGzsyC2FbgZfTaGYs7v9K86I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DV1NLDN3dPhqWh/9tSDnLaGNM7217LGLFn38yzW/da0+UTMq9OsRzR1mLlW/CoADI
	 OozsLRrb9oMRmxd/zfFiNEdMoMxYLitCxJZ7YtAcxoP9/o25N48Pz+Na64Pg8TmsXV
	 ThdeF7szNJ8kIDGuzUaMDgDvY+reeHx3VlAAB6Ng=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 551E5F802A0;
	Sun, 29 Mar 2020 09:54:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3105F80146; Sun, 29 Mar 2020 07:38:20 +0200 (CEST)
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de
 [IPv6:2a01:4f8:c17:c88::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7340F8013F
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2020 07:38:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7340F8013F
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
 id C1497F5D12; Sun, 29 Mar 2020 07:38:09 +0200 (CEST)
Received: from localhost (200116B828b19602BDF47B2a5Ed39330.dip.versatel-1u1.de
 [IPv6:2001:16b8:28b1:9602:bdf4:7b2a:5ed3:9330])
 by magratgarlick.emantor.de (Postfix) with ESMTPSA id EEF25F5D10;
 Sun, 29 Mar 2020 07:38:06 +0200 (CEST)
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: hda: default enable CA0132 DSP support
Date: Sun, 29 Mar 2020 07:30:15 +0200
Message-Id: <20200329053710.4276-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2020 09:54:16 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Rouven Czerwinski <rouven@czerwinskis.de>
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

From: Rouven Czerwinski <rouven@czerwinskis.de>

If SND_HDA_CODEC_CA0132 is enabled, the DSP support should be enabled as
well. Disabled DSP support leads to a hanging alsa system and no sound
output on the card otherwise. Tested on:

  06:00.0 Audio device: Creative Labs Sound Core3D [Sound Blaster Recon3D / Z-Series] (rev 01)

Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 sound/pci/hda/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index bd48335d09d7..e1d3082a4fe9 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -184,6 +184,7 @@ comment "Set to Y if you want auto-loading the codec driver"
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
 	depends on SND_HDA_CODEC_CA0132
+	default y
 	select SND_HDA_DSP_LOADER
 	select FW_LOADER
 	help

base-commit: e595dd94515ed6bc5ba38fce0f9598db8c0ee9a9
-- 
2.25.1

