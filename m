Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92DC2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F839246DC
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QUF4K3H+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f871c1EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F839246DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1D9716E5;
	Fri, 14 Feb 2020 17:21:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1D9716E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581697338;
	bh=XAB6owUri0jXGfksJ/gknAirkbI0aBKrBK9f0a0OTrM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUF4K3H+WYVpkKnPwDU17L6FizVuBsuPuIzuQKB8b+n78Ajm1HAsuAgcYpWL5qYNN
	 qIOXudHyTsY+6TQogUpe9+i2GK19qODk3PcWmK59TTupbWKnDMf0dkokJXZsyUC/1A
	 f6+2hDf0u+XsJSa/AdAOVxdRKDHQr76O1bVZNhfM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C734CF8013E;
	Fri, 14 Feb 2020 17:17:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53BFBF802C4; Fri, 14 Feb 2020 17:17:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D907F800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 17:17:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D907F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f871c1EM"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 186B8246F4;
 Fri, 14 Feb 2020 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581697050;
 bh=8aHHGS6tkGBLeGkwk9FMJYUq4EvcCZ+0UidKSNcAdGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f871c1EMNV7nfLzXbgTMAsT12Kq3SiTy1hrmZOVVH9gQ2cHClfo33i1HqGWO66hWW
 q3Nb8hs7gLUstKBVjP2ITRwU/NHLvA1GG2ciEZLv1sFmAw0ndy0d1tZZUn6s3ZUVpL
 7ku+eOclzzMaVFsch21IybdHh9xEfX+/1lGgsegQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 14 Feb 2020 11:14:20 -0500
Message-Id: <20200214161715.18113-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH AUTOSEL 4.14 011/186] ALSA: ctl: allow TLV read
	operation for callback type of element in locked case
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit d61fe22c2ae42d9fd76c34ef4224064cca4b04b0 ]

A design of ALSA control core allows applications to execute three
operations for TLV feature; read, write and command. Furthermore, it
allows driver developers to process the operations by two ways; allocated
array or callback function. In the former, read operation is just allowed,
thus developers uses the latter when device driver supports variety of
models or the target model is expected to dynamically change information
stored in TLV container.

The core also allows applications to lock any element so that the other
applications can't perform write operation to the element for element
value and TLV information. When the element is locked, write and command
operation for TLV information are prohibited as well as element value.
Any read operation should be allowed in the case.

At present, when an element has callback function for TLV information,
TLV read operation returns EPERM if the element is locked. On the
other hand, the read operation is success when an element has allocated
array for TLV information. In both cases, read operation is success for
element value expectedly.

This commit fixes the bug. This change can be backported to v4.14
kernel or later.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20191223093347.15279-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 36571cd49be33..a0ce22164957c 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1467,8 +1467,9 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	if (kctl->tlv.c == NULL)
 		return -ENXIO;
 
-	/* When locked, this is unavailable. */
-	if (vd->owner != NULL && vd->owner != file)
+	/* Write and command operations are not allowed for locked element. */
+	if (op_flag != SNDRV_CTL_TLV_OP_READ &&
+	    vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
 	return kctl->tlv.c(kctl, op_flag, size, buf);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
