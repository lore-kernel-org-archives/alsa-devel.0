Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5BDC05027
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 02:15:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC30B82E;
	Thu,  9 Feb 2023 03:14:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC30B82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675908947;
	bh=u2tuYdC9nJ7d8d5idwaoFc02rDOtlwGOFPJO1O/vLLo=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RRHC1q5tm5jW4FUJGvhWXVzSSEyjTBY7KLxPZCNlBJ5/jn07/D1wzRq52lHT2yRWf
	 q7Wmds+Q9v9d9e4a0wwmDDi7Z5goowWakL6DqUAh5VGrILeONoQtxzDW7G2uQFk7kZ
	 BObHuLMMXJGawm6xoKtQU8ADX26lyatEF27CF5A4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25568F80027;
	Thu,  9 Feb 2023 03:14:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A68E6F800E4; Thu,  9 Feb 2023 03:14:25 +0100 (CET)
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com
 [115.236.118.80])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98714F80027
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 03:14:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98714F80027
Received: from localhost.localdomain (unknown [27.18.58.194])
	by mail-m11880.qiye.163.com (Hmail) with ESMTPA id BECA32042B;
	Thu,  9 Feb 2023 10:14:08 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA:hda/conexant:add a new hda codec SN6180
Date: Thu,  9 Feb 2023 10:13:48 +0800
Message-Id: <1675908828-1012-1-git-send-email-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThlPVkhJSkMZSB9OShpJSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlMVUpDVU5DVUpCT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6ARw6HD0XPi8sGCkhFzEy
	SUMKCRlVSlVKTUxOQktDQ09CTkpJVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WUlMVUpDVU5DVUpCT1lXWQgBWUFKQ0pONwY+
X-HM-Tid: 0a8633f39d2f2eb6kusnbeca32042b
Message-ID-Hash: 4PBPKIIPWVQHJRBFVGVIJ7RSXIZ7HOUE
X-Message-ID-Hash: 4PBPKIIPWVQHJRBFVGVIJ7RSXIZ7HOUE
X-MailFrom: bo.liu@senarytech.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tangmeng@uniontech.com, huangwenhuia@uniontech.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 bo.liu@senarytech.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4PBPKIIPWVQHJRBFVGVIJ7RSXIZ7HOUE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bo Liu <bo.liu@senarytech.com>

The current kernel does not support the SN6180 codec chip.
Add the SN6180 codec configuration item to kernel.

Signed-off-by: Bo Liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7b1a30a..75e1d00 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1125,6 +1125,7 @@ static const struct hda_device_id snd_hda_id_conexant[] = {
 	HDA_CODEC_ENTRY(0x14f11f87, "SN6140", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f120d0, "CX11970", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f120d1, "SN6180", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15051, "CX20561 (Hermosa)", patch_conexant_auto),
-- 
2.7.4

