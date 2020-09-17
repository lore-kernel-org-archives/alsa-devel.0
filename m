Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E16C43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:11:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AA62085B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VcxbkMMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AA62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EB371660;
	Mon, 21 Sep 2020 10:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EB371660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600675875;
	bh=6Sa3IG/J4vzk75z3wkwHH4wYWFHks7KOVx+jwsdi2TY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VcxbkMMqLDExSmOi/Q+3eI/++f0Pr5TaD37TAd/j6Do1j4j4uThm/PwLDY+TyolBL
	 lGhMayIw0Qt+x2FzVOIlko09wFYx9BHaPBGg08ZVKEPM+NySzFSjeWAQ+HV2BOC1m0
	 f7gqgbV0uXTIVqwtrPH+kbMEyhfqfI8IT2FJ4gOw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCFF5F80161;
	Mon, 21 Sep 2020 10:10:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1C01F80212; Thu, 17 Sep 2020 09:56:35 +0200 (CEST)
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE7FAF800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 09:56:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE7FAF800E8
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id A3D604E17A0;
 Thu, 17 Sep 2020 15:56:18 +0800 (CST)
From: Wang Qing <wangqing@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Wang Qing <wangqing@vivo.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] sound/pci/asihpi: fix spellint typo in comments
Date: Thu, 17 Sep 2020 15:55:52 +0800
Message-Id: <1600329372-2266-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGR8fS0kYS01CGEtOVkpNS0tISUJITENCT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Cio4Vj8vOBQ4HjgPMkM8
 FTcaCjJVSlVKTUtLSElCSExCSExPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
 SU5KVUxPVUlJTVlXWQgBWUFKT01JNwY+
X-HM-Tid: 0a749b106c0d9376kuwsa3d604e17a0
X-Mailman-Approved-At: Mon, 21 Sep 2020 10:10:22 +0200
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

Change the comment typo: "ununsed" -> "unused".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/pci/asihpi/hpios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index 26f7cf4..9e551bc
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -67,7 +67,7 @@ struct hpi_ioctl_linux {
 };
 
 /* Conflict?: H is already used by a number of drivers hid, bluetooth hci,
-   and some sound drivers sb16, hdsp, emu10k. AFAIK 0xFC is ununsed command
+   and some sound drivers sb16, hdsp, emu10k. AFAIK 0xFC is unused command
 */
 #define HPI_IOCTL_LINUX _IOWR('H', 0xFC, struct hpi_ioctl_linux)
 
-- 
2.7.4

