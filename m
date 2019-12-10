Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5090C00454
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:16:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E4B24653
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iWufJoPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4B24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 990801700;
	Tue, 10 Dec 2019 16:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 990801700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575990527;
	bh=DmKtb9/3fM/gvGaP3LHUtIH8XRljMJX1J7VdoapPGTE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWufJoPl07ogph1EfsEq9nKi4dxHFu6rqyGqgX29D6XAcedY7Y73zb9BkHOjXy25Z
	 IGtbKml66sOwdfcfnHr+n/766m0ata+4yKvJ2OGviSxrLF1pzfbj14sNTqsm99nIVi
	 Fh1sUvcXQ/n1hpfwqSHWEagSLM4HJu6KUN+hhinw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1B93F80345;
	Tue, 10 Dec 2019 15:55:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D98BF802A1; Tue, 10 Dec 2019 15:54:49 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 670A8F80268
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:54:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 670A8F80268
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 40959AEF3;
 Tue, 10 Dec 2019 14:54:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:54:03 +0100
Message-Id: <20191210145406.21419-21-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210145406.21419-1-tiwai@suse.de>
References: <20191210145406.21419-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Michal Simek <michal.simek@xilinx.com>
Subject: [alsa-devel] [PATCH for-5.6 20/23] ASoC: xilinx: Drop superfluous
	ioctl PCM ops
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

ASoC PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index f6e30090bdb0..1d59fb668c77 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -533,7 +533,6 @@ static const struct snd_soc_component_driver xlnx_asoc_component = {
 	.name		= DRV_NAME,
 	.open		= xlnx_formatter_pcm_open,
 	.close		= xlnx_formatter_pcm_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= xlnx_formatter_pcm_hw_params,
 	.trigger	= xlnx_formatter_pcm_trigger,
 	.pointer	= xlnx_formatter_pcm_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
