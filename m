Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04033C48BE6
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:18:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BF061370
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BF061370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11AF5179E;
	Mon, 14 Jun 2021 09:18:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11AF5179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623655134;
	bh=BkbrjUmJgVHs4GQp+xbD8zMisN63RHIv11Bs2ads8J0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ByD2U6727dywpAgjtbXWM4YOwsUWuC04bL51NlE3ySnRCxTcpAjCr8dkbxlW9RdI1
	 hArvowcxH6h9Dxh96crbplK7IJ0fc+ZN53fV5qVw7azRalxwJbSQEOEEeOLvqicgvH
	 OdcDHUUJg5F/qrg8IYnE7dbcuHq0nM0kIlNyZ77c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DCFFF8025A;
	Mon, 14 Jun 2021 09:18:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CD2CF80273; Mon, 14 Jun 2021 09:18:02 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 491DBF800F7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 09:17:56 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E3028A003F;
 Mon, 14 Jun 2021 09:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E3028A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1623655075; bh=XFMAbc3ingAh0d40kJ4nWlArt1RP++I45Xd6XRUn9LY=;
 h=From:To:Cc:Subject:Date:From;
 b=CdBHLTaGR55CR2dhmGL8Bmgg/Aos0QNUDwhFtqIpbkTxRYB++PHQSwL9cHK5Dep/U
 X00JOWs3iiNdi/w5+pcNkelar/G5Ga5tPrJeD9ePqI35ZkN/piGSBca4lJcrPS6KfN
 oQM7GrYuASCZSy8qBRPWpaNXVNKVA8SUP23MjO2s=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 14 Jun 2021 09:17:50 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: soc-pcm: fix the return value in dpcm_apply_symmetry()
Date: Mon, 14 Jun 2021 09:17:46 +0200
Message-Id: <20210614071746.1787072-1-perex@perex.cz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

In case, where the loops are not executed for a reason, the uninitialized
variable 'err' is returned to the caller. Make code fully predictible
and assign zero in the declaration.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8659089a87a0..46513bb97904 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1700,7 +1700,7 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
 	struct snd_soc_dai *fe_cpu_dai;
-	int err;
+	int err = 0;
 	int i;
 
 	/* apply symmetry for FE */
-- 
2.30.2
