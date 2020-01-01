Return-Path: <SRS0=lBDT=2W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F444C2D0DC
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:01:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17C520842
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="buwo7cdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17C520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B1ED16EE;
	Wed,  1 Jan 2020 17:01:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B1ED16EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577894517;
	bh=gt3xrjrRFIfB/2KbUmXV7awr8rGc+r2MMS0ysOykXw8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buwo7cdoCNbV4POiiDJEm5s1wNfJo53vAXQ7uQkXHMxsq2wVw5kRZ4HTyulGMt95k
	 PdhSRoimBJDYuW+QrjfuCxi8Hs6rRD7kUwlVnRapUrAv0RPvGFZPbGIFVuFDpJEqAi
	 g2EwLnJTW0SG2t/I6Mxw2VpH19tBRI8tlFlqWhvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BD57F8027C;
	Wed,  1 Jan 2020 16:58:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87123F8015D; Wed,  1 Jan 2020 09:20:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71EB3F8011E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2020 09:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71EB3F8011E
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; d="scan'208";a="429578750"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 01 Jan 2020 09:20:08 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Date: Wed,  1 Jan 2020 08:43:20 +0100
Message-Id: <1577864614-5543-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailman-Approved-At: Wed, 01 Jan 2020 16:58:14 +0100
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH 02/16] ALSA: constify copied structure
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The azx_pcm_hw structure is only copied into another structure,
so make it const.

The opportunity for this change was found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/hda/hda_controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a74c85867eb3..9757667cdd58 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -548,7 +548,7 @@ static int azx_get_time_info(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_pcm_hardware azx_pcm_hw = {
+static const struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
