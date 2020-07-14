Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E9C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:30:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8F9206F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q5dF8GOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8F9206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE6911670;
	Tue, 14 Jul 2020 14:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE6911670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594729819;
	bh=A3hV9ouKVUG/NGJVNdQUqaU09OlHkZQX5YeGO57Nu3I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5dF8GOkLVEychreGaKYkiXjVHsEPB3SiBCocND8npWjFSTdUHYHoZlrWP5bbAT3O
	 gpl/RCMiKs2z3P5MyCQtK70y3QK/AqjLHC3F7+dmEFE9hZq6bGbysujbmTIpmAYZgs
	 ZLZlawL6FjRBoED6j6uERxKMF1YCfJ3t3e7AIQ/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7B23F802DB;
	Tue, 14 Jul 2020 14:26:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE507F8014E; Tue, 14 Jul 2020 14:26:46 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EDE9F8019B
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 14:26:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EDE9F8019B
IronPort-SDR: RU9dYrAv1OOVUbolayTXuD3bXYUptQ8Kcv8Iiypvmkcp08nyGkzpy16vNr/tcgml1C/1i1xhFM
 1xIJgYSbp79A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166981787"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="166981787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 05:26:31 -0700
IronPort-SDR: xAd15Y68hVsNowzox6SzxPWdDwsDfoJFel/qR550lKFfVXeNJWZHAvXIn5dUxyTWUu5hX81W4c
 JvpdFLR2/IZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485860420"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 05:26:30 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 04/10] topology: decode: Add enum control texts as separate
 element
Date: Tue, 14 Jul 2020 13:25:05 +0200
Message-Id: <1594725911-14308-5-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

Texts are separate sections that should referenced by enum control.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
---
 src/topology/ctl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 02e482e..1f39846 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -1088,11 +1088,19 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 	}
 
 	if (enum_ctl->texts != NULL) {
+		struct tplg_elem *texts = tplg_elem_new_common(tplg, NULL,
+						enum_ctl->hdr.name, SND_TPLG_TYPE_TEXT);
+
+		texts->texts->num_items = num_items;
 		for (i = 0; i < num_items; i++) {
-			if (enum_ctl->texts[i] != NULL)
-				snd_strlcpy(ec->texts[i], enum_ctl->texts[i],
-					    SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			if (!enum_ctl->texts[i])
+				continue;
+			snd_strlcpy(ec->texts[i], enum_ctl->texts[i],
+				    SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			snd_strlcpy(texts->texts->items[i], enum_ctl->texts[i],
+				    SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 		}
+		tplg_ref_add(elem, SND_TPLG_TYPE_TEXT, enum_ctl->hdr.name);
 	}
 
 	if (enum_ctl->values != NULL) {
-- 
2.7.4

