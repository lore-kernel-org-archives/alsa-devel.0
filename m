Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD7CC4727C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:34:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C532220D
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YOA5bb8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C532220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E11E171D;
	Tue, 22 Sep 2020 17:33:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E11E171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600788887;
	bh=6hhqAD4ysnVBsdzeWSkLydXVoqklmhpmP7YZ6Znv48s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YOA5bb8poLM68nsizv6I9x21/aiF7VR1LFJeLywO2ZxIyFF67NUar5Q7pthgkGKKp
	 eQjXuBxkyIgiNinA5NBr1zutd2jX2OZgF5KhrPqZKH3SbfXvOJX6+Mn7BF9Lv2ph5R
	 FowNNSFfvqQuLxRakWK6AhGUuS49k5I8YdNKO04k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC0B8F800ED;
	Tue, 22 Sep 2020 17:33:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18D8FF80232; Tue, 22 Sep 2020 17:33:54 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F403F800ED;
 Tue, 22 Sep 2020 17:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F403F800ED
IronPort-SDR: JeslkO6zUK6nXT/bGckjhhz8UJ8ygQBe0s2XXGdiZxL2DelaE9XPzfI/QkD/7ludYmkCoMnU0Z
 gRa6SfaEcTRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222223697"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; d="scan'208";a="222223697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 08:33:35 -0700
IronPort-SDR: ygY9fqnN/8WVBHLE8mYoLoV4NwYCDbSt/BXEBeoy225Kni74aaK8ovEAbUELOaAC3iyFwEYzIA
 FpdDynE0JLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; d="scan'208";a="486002170"
Received: from pharlozi-hp-elitedesk.igk.intel.com ([10.237.149.38])
 by orsmga005.jf.intel.com with ESMTP; 22 Sep 2020 08:33:33 -0700
From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 1/1] ALSA: hda: Refactor calculating SDnFMT according to
 specification
Date: Tue, 22 Sep 2020 17:33:32 +0200
Message-Id: <20200922153332.4919-1-pawel.harlozinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, patch@alsa-project.org,
 kai.vehmanen@linux.intel.com, tiwai@suse.de, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com,
 Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
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

Fix setting SDnFMT based on :wq
High Definition Audio Specification Rev. 1.0a page 48.

Bits per Sample (BITS):
000 = 8 bits. The data will be packed in memory in 8-bit containers on 16-bit boundaries.
001 = 16 bits. The data will be packed in memory in 16-bit containers on 16-bit boundaries.
010 = 20 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
011 = 24 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
100 = 32 bits. The data will be packed in memory in 32-bit containers on 32-bit boundaries.
101-111 = Reserved

Set SDnFMT depending on which format was given.
Henceforth split cases for formats 20, 24, 32 bits,
but leave constraints to maxbps.

Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>

---

 v3: drop gerrit Change-Id
 v2: leave constraints to maxbps
 
 sound/hda/hdac_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 3e9e9ac804f6..ccc47a10ba63 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -764,7 +764,14 @@ unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 		val |= AC_FMT_BITS_16;
 		break;
 	case 20:
+		val |= AC_FMT_BITS_20;
+		break;
 	case 24:
+		if (maxbps >= 24)
+			val |= AC_FMT_BITS_24;
+		else
+			val |= AC_FMT_BITS_20;
+		break;
 	case 32:
 		if (maxbps >= 32 || format == SNDRV_PCM_FORMAT_FLOAT_LE)
 			val |= AC_FMT_BITS_32;
-- 
2.17.1

