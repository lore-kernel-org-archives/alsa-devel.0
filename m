Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74163C11D82
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:30:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10CE24681
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nyVP39pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10CE24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58227168B;
	Wed, 19 Feb 2020 23:21:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58227168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582150952;
	bh=jkuVl8+q+MOF6QcTJ1V0wz+wW/IE2meEy8M72knvrp8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nyVP39pcQAAeZ9Dd7Z/2jospC8uVjVxVlqU+JX9Hn/cLboPsazS3SNGH3PNwf8Hhg
	 r+hbxv3Y7HTzkmGZacJaXHoxJ52YFCszUOpqqcC8LW7a4MYXneWZ+W7fOuifg0eUyX
	 +CinH2sYpon6PS/kJ16GeOBCDn6KkfQ9uYmNN834=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2CF5F8025F;
	Wed, 19 Feb 2020 23:21:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43BF1F80273; Wed, 19 Feb 2020 23:21:40 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A80E9F80142
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 23:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A80E9F80142
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 14:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; d="scan'208";a="315531192"
Received: from ssavage-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.46.100])
 by orsmga001.jf.intel.com with ESMTP; 19 Feb 2020 14:21:32 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: soc-core: fix for_rtd_codec_dai_rollback() macro
Date: Wed, 19 Feb 2020 16:21:30 -0600
Message-Id: <20200219222130.29933-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

The use of parentheses to protect the argument is fine for (i)++ but
not for (--i).

Fixes: 83f94a2e293d61 ("ASoC: soc-core: add snd_soc_close_delayed_work()")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f0e4f36f83bf..8a2266676b2d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1157,7 +1157,7 @@ struct snd_soc_pcm_runtime {
 	     ((i) < rtd->num_codecs) && ((dai) = rtd->codec_dais[i]); \
 	     (i)++)
 #define for_each_rtd_codec_dai_rollback(rtd, i, dai)		\
-	for (; ((--i) >= 0) && ((dai) = rtd->codec_dais[i]);)
+	for (; (--(i) >= 0) && ((dai) = rtd->codec_dais[i]);)
 
 void snd_soc_close_delayed_work(struct snd_soc_pcm_runtime *rtd);
 
-- 
2.20.1

