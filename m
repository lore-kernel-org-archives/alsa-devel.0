Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A6C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E32C2084E
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mc979ziV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E32C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C5C6886;
	Tue, 12 Nov 2019 11:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C5C6886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573555766;
	bh=FT71z/GFtLa7B+E5AUYVj/ABWvWXzrDxUAJVDTAXbnc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mc979ziVSbiXye1Ndx6ii8sHILci8zud8hLD6+FTnpWaAor5NyIAgvqmzs/Rxiups
	 cTDIusNpcQiG7odHYyaQyJ5Iz2FGfJQC5rQZ2wmaNkkxxKK8bxRtdzi8x7fbjKseL3
	 jvsRxveDK+slquh805/GkMpszKxgUd5UhwuRNbbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 670B3F8044C;
	Tue, 12 Nov 2019 11:48:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4052F80483; Tue, 12 Nov 2019 11:48:33 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75A17F802E0
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 11:48:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75A17F802E0
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 078211A06E6;
 Tue, 12 Nov 2019 11:48:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 124321A0324;
 Tue, 12 Nov 2019 11:48:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6DF254024E;
 Tue, 12 Nov 2019 18:48:22 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2019 18:46:42 +0800
Message-Id: <1573555602-5403-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Subject: [alsa-devel] [PATCH] Revert "ASoC: soc-pcm: check symmetry after
	hw_params"
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

This reverts commit 957ce0c6b8a1f26559864507ae0bfcba29d924ad.

That commit cause soc_pcm_params_symmetry can't take effect.
cpu_dai->rate, cpu_dai->channels and cpu_dai->sample_bits
are updated in the middle of soc_pcm_hw_params, so move
soc_pcm_params_symmetry to the end of soc_pcm_hw_params is
not a good solution, for judgement of symmetry in the function
is always true.

FIXME:
According to the comments of that commit, I think the case
described in the commit should disable symmetric_rates
in Back-End, rather than changing the position of
soc_pcm_params_symmetry.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/soc-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8655df6a6089..b7800c95327a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -861,6 +861,11 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+
+	ret = soc_pcm_params_symmetry(substream, params);
+	if (ret)
+		goto out;
+
 	if (rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
@@ -940,9 +945,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	component = NULL;
 
-	ret = soc_pcm_params_symmetry(substream, params);
-        if (ret)
-		goto component_err;
 out:
 	mutex_unlock(&rtd->card->pcm_mutex);
 	return ret;
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
