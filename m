Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2ACC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E793B207F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kb2GAFpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E793B207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E8E1676;
	Wed,  1 Jul 2020 20:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E8E1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593628029;
	bh=m/mhVm1dbWyl7bZ/MZIV9pqZpP1b7QdCclDGitxSiAY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kb2GAFpJ5lbsB7Gg6zGLpQfo2VrkyD9YuHY/U7HkcsSDuZ5wBjXATUe6gaC46YlFK
	 V+hBvtnE+9+lTBRUq8dNRU1G5b4qjs6He1ZdgZh5WhvsCrULEaiKb1PupSNkjk+d6F
	 8hDom9r6bP+Y1Ef/0O/lj1RuZQgPLVuuBLZt7AsA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE31AF802A9;
	Wed,  1 Jul 2020 20:24:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 228E2F802A8; Wed,  1 Jul 2020 20:24:42 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48008F80217
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:24:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48008F80217
IronPort-SDR: RJV//3T0wv8BPmVMyXY4XWn+clolpfL6MedKH68/ihL9V6+NTdK52pJ4YsrhupGwaI36CuNrTW
 nDGKFO9p0qww==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="208189487"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="208189487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:31 -0700
IronPort-SDR: nJAZUZu8p44+1ipILrXCz75pHghiP+z4e9LTVMuUzm4tSITpeC2OkU+QvpmqFV/8iHw6Xx3gub
 rHgcjTCzFIXw==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="425679547"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:30 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/11] ASoC: codecs: ak4458: fix 'set but not used' warning
Date: Wed,  1 Jul 2020 13:24:12 -0500
Message-Id: <20200701182422.81496-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 broonie@kernel.org
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

fix warning with W=1

sound/soc/codecs/ak4458.c:408:16: warning: variable 'ret' set but not
used [-Wunused-but-set-variable]
  408 |  int nfs, ndt, ret, reg;
      |                ^~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/ak4458.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index f180cb5dfe4f..e8b4048fbbe4 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -427,7 +427,7 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 		mdelay(ndt);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-- 
2.25.1

