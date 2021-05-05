Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DEC433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:56:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAC660FE9
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAC660FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29AF81756;
	Wed,  5 May 2021 18:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29AF81756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233791;
	bh=itsFaItEQgusV1deU/5OCuBOnGoXV0pjO8IfRlcyiUc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3YGfFCNa73ExrDWYjp4EhOxSRulR4iYlj6hEemtUU+GsQj5Ks5XwvXRNV9ev7fI+
	 O5EzH10Wd3ZVylx3oipB9lMcUrRkcZYFPf56588by1DoMPYDBsboI3bTYb8lpNuaaj
	 o3Qsk0pDD2NKaLXSHGSyVikOipzx19Ray8jSO4oA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72DBAF80634;
	Wed,  5 May 2021 18:39:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E12CF80624; Wed,  5 May 2021 18:39:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEA59F8051A
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA59F8051A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D7H1GwSk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97DB2614A7;
 Wed,  5 May 2021 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232748;
 bh=itsFaItEQgusV1deU/5OCuBOnGoXV0pjO8IfRlcyiUc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D7H1GwSkNFcpaiBxZGOdWbX5LZvws1j+kglbBIgqO7lrmb0Se3KpAzbjQpXOZqOcu
 XRI70+FPN9KMUPIRUIyX8LcljxcjJ0bXcRY1hts1K6fTd5p2kahGosqt9bOPeL15K5
 ukyLsSbWEH1RKha866GJlE1edxguhjr2v2L61k6DIpsCflc0hDoPyTb/mcNAh/Hcj8
 GHKJwfbCxYcJW1w6ImAiGbcSK5Mg7DU5rQs3LGS3EYKX1XjyAMTyrzgqz9odtiCF8S
 WSzIlhpKuPEapv2KFF9uZR3CFe2/gP86XY/oFo4yKXIlqrTi0Sg/HGK8gsx8Wj+MSJ
 MwTHotqx2RgUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/46] ALSA: hdspm: don't disable if not enabled
Date: Wed,  5 May 2021 12:38:18 -0400
Message-Id: <20210505163856.3463279-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163856.3463279-1-sashal@kernel.org>
References: <20210505163856.3463279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Tong Zhang <ztong0001@gmail.com>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Tong Zhang <ztong0001@gmail.com>

[ Upstream commit 790f5719b85e12e10c41753b864e74249585ed08 ]

hdspm wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.786391] snd_hdspm 0000:00:03.0: disabling already-disabled device
[    1.786400] WARNING: CPU: 0 PID: 182 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.795181] Call Trace:
[    1.795320]  snd_hdspm_card_free+0x58/0xa0 [snd_hdspm]
[    1.795595]  release_card_device+0x4b/0x80 [snd]
[    1.795860]  device_release+0x3b/0xa0
[    1.796072]  kobject_put+0x94/0x1b0
[    1.796260]  put_device+0x13/0x20
[    1.796438]  snd_card_free+0x61/0x90 [snd]
[    1.796659]  snd_hdspm_probe+0x97b/0x1440 [snd_hdspm]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Link: https://lore.kernel.org/r/20210321153840.378226-3-ztong0001@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/rme9652/hdspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 81a6f4b2bd3c..e34f07c9ff47 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6889,7 +6889,8 @@ static int snd_hdspm_free(struct hdspm * hdspm)
 	if (hdspm->port)
 		pci_release_regions(hdspm->pci);
 
-	pci_disable_device(hdspm->pci);
+	if (pci_is_enabled(hdspm->pci))
+		pci_disable_device(hdspm->pci);
 	return 0;
 }
 
-- 
2.30.2

