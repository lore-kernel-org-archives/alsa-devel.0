Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32960C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:05:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8D72084E
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m4QaY+S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8D72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD8BE1607;
	Tue, 12 Nov 2019 14:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD8BE1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573563916;
	bh=eecVduX1Yw0LzDJJu01uZsHwc3YtQZO9fxXXm2KrVNk=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m4QaY+S1441ZlKUObClRkGljoCiAhNEixdd3AT/e6rcW2EyRAVS9e77fiR4lvzYNG
	 9/7fR9jcGQp8jnjkO9FynRX2XL/OVBorcBOJgNKwvlM7PrIyse/akf6bDnyi6qG3dc
	 stxSTUwbEulkBM/x8gHaDAE00i8rsU0y33VHBqlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58D80F8044C;
	Tue, 12 Nov 2019 14:04:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62D1DF80483; Tue, 12 Nov 2019 14:04:24 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E7ABF80275;
 Tue, 12 Nov 2019 14:04:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E7ABF80275
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Nov 2019 05:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; d="scan'208";a="234854714"
Received: from pharlozi-hp-elitedesk.igk.intel.com ([10.237.149.38])
 by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2019 05:04:14 -0800
From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 12 Nov 2019 14:02:36 +0100
Message-Id: <20191112130237.10141-1-pawel.harlozinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, patch@alsa-project.org, tiwai@suse.de,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: Jack: Fix NULL pointer dereference in
	snd_soc_jack_report
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

Check for existance of jack before tracing.
NULL pointer dereference has been reported by KASAN while unloading
machine driver (snd_soc_cnl_rt274).

Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>

---
 sound/soc/soc-jack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index a71d2340eb05..b5748dcd490f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -82,10 +82,9 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	unsigned int sync = 0;
 	int enable;
 
-	trace_snd_soc_jack_report(jack, mask, status);
-
 	if (!jack)
 		return;
+	trace_snd_soc_jack_report(jack, mask, status);
 
 	dapm = &jack->card->dapm;
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
