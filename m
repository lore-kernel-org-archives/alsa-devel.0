Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB995C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:48:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DA42065F
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lGmLZsAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DA42065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 982E0165E;
	Wed, 15 Jul 2020 19:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 982E0165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594835310;
	bh=bkIXVnrSKX9zM0XSuSvvpbS4e4/UqBf2koceWeo1OlM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lGmLZsAROndQUmF1sUWTE2Kz43LzMcGG4+v5zV4FvI+t3RvCxP6zZirbFyKSBSQ0e
	 U4EuaW2jjK7tZLuWtIOgtuTsTfeFGF4v9OUSEQsb/jMgf9T5Y9WuyEq1c066amMphZ
	 9be5DnSoxO6rQDhjQb0X3z4iVRczC3TGfHdeVpEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5F03F80217;
	Wed, 15 Jul 2020 19:46:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74D70F8021D; Wed, 15 Jul 2020 19:46:46 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90B16F80229
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 19:46:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90B16F80229
IronPort-SDR: jpsDmlmXVHefyZxDbYD2mZDQh/0Z9OC34Jexo5qHcgiXdRWOHu3JiZSKibAUw+lAw4BAs8WJHS
 jNiEW0FkSyTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="146739502"
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; d="scan'208";a="146739502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 10:46:33 -0700
IronPort-SDR: z1gIsUd+zDV2I9C4EiSdeFPIXYonbwsmXQSuADoA/w3zbmUzoKggN8hiDWYnPw1tU5mqHYGByc
 xnAjkZzJ/YGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; d="scan'208";a="326259073"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga007.jf.intel.com with ESMTP; 15 Jul 2020 10:46:31 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 2/2] ALSA: hda: fix snd_hda_codec_cleanup() documentation
Date: Wed, 15 Jul 2020 20:45:51 +0300
Message-Id: <20200715174551.3730165-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715174551.3730165-1-kai.vehmanen@linux.intel.com>
References: <20200715174551.3730165-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Fix a copy and paste error in snd_hda_codec_cleanup()
documentation.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b4331355602c..3576e2d8452f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3179,7 +3179,7 @@ int snd_hda_codec_prepare(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_codec_prepare);
 
 /**
- * snd_hda_codec_cleanup - Prepare a stream
+ * snd_hda_codec_cleanup - Clean up stream resources
  * @codec: the HDA codec
  * @hinfo: PCM information
  * @substream: PCM substream
-- 
2.27.0

