Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84928C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:09:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191872465B
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ThfBldGh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="29CsJCaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191872465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63E791689;
	Wed, 22 Jan 2020 20:08:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63E791689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579720145;
	bh=9AQ0K5rH929gGePzXPe6wC585K29P9HqEpU3U7lR++c=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ThfBldGhkKaXeSJrwYY/honJI/NnERgNAFPTw3L+fd8DDyPbcE99AiIqlziZOW3p7
	 844B5eE0/jQH5aog+kVpSoUMuYV9zoZYiInsuyg4dXXImn1en17xb++3MXcWWsn3Se
	 613QvLNdhUks1XcIWVIXuLVqi9OmvRc2l4qoXz1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5A9CF8007E;
	Wed, 22 Jan 2020 20:08:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6AC8F8020C; Wed, 22 Jan 2020 20:08:13 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BF81F8007E
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 20:08:07 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5E258A003F;
 Wed, 22 Jan 2020 20:08:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5E258A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1579720087; bh=Pku/X5mG5+VO72YN24QXDQhrqZ0TAyLk/3xAjxDFd4A=;
 h=From:To:Cc:Subject:Date:From;
 b=29CsJCaGQuL0+/wNYAYg5Moemil4Db5m3xfMh8G1xCdBe3bYRwZSlGeJUbb1IabuJ
 9n43y71BZ5VGqODTBRCRIsUmgkfWSeiNThR/llXiN6mDnucVc41XQyM/vzAq/mBE4F
 XeJVMx7XN4iiUFmuq+MtSs8i1FM7t+aZFgFMlo8Y=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 22 Jan 2020 20:07:59 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Date: Wed, 22 Jan 2020 20:07:52 +0100
Message-Id: <20200122190752.3081016-1-perex@perex.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Takashi Iwai <tiwai@suse.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH] ASoC: topology: fix soc_tplg_fe_link_create()
	- link->dobj initialization order
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

The code which checks the return value for snd_soc_add_dai_link() call
in soc_tplg_fe_link_create() moved the snd_soc_add_dai_link() call before
link->dobj members initialization.

While it does not affect the latest kernels, the old soc-core.c code
in the stable kernels is affected. The snd_soc_add_dai_link() function uses
the link->dobj.type member to check, if the link structure is valid.

Reorder the link->dobj initialization to make things work again.
It's harmless for the recent code (and the structure should be properly
initialized before other calls anyway).

The problem is in stable linux-5.4.y since version 5.4.11 when the
upstream commit 76d270364932 was applied.

Fixes: 76d270364932 ("ASoC: topology: Check return value for snd_soc_add_dai_link()")
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/soc-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 92e4f4d08bfa..4e1fe623c390 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1906,6 +1906,10 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	link->num_codecs = 1;
 	link->num_platforms = 1;
 
+	link->dobj.index = tplg->index;
+	link->dobj.ops = tplg->ops;
+	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
+
 	if (strlen(pcm->pcm_name)) {
 		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
 		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
@@ -1942,9 +1946,6 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 		goto err;
 	}
 
-	link->dobj.index = tplg->index;
-	link->dobj.ops = tplg->ops;
-	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
 	list_add(&link->dobj.list, &tplg->comp->dobj_list);
 
 	return 0;
-- 
2.24.1
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
