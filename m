Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1443C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:10:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7546520739
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YZvLXpb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDF47166E;
	Mon,  6 Jul 2020 12:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDF47166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594030241;
	bh=svBquMVvJXTKFFIyNUXxMQlYm19BBb4SYqNtjZP7PjI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YZvLXpb1pi06sV/e3ggVQcM4FO8DqX8LlxU9XOdkELV839uYgBXAn1A16wpGJ1W1S
	 3j1bMc+SFd2MmIhHaAZCOTujPwo6D/s4Qd8uocdBZS0lwsdJ3Dx9pgQmdU4chlNsi6
	 TWlg1veBT3mfNaI1C0b5capQSHT/v3OQjvEf7f08=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 114E7F801D8;
	Mon,  6 Jul 2020 12:07:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C85C5F802A0; Mon,  6 Jul 2020 12:07:41 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4E3CF80125
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 12:07:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4E3CF80125
IronPort-SDR: 6gxx6NXXyb5ydjc6p0J423cZnVkYN3uhXPqFOaJWNEDll+kO4mq1GisgQY6iu+Ga03+pNVKYKc
 gXaMVjNrmWgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="135637965"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="135637965"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 03:07:37 -0700
IronPort-SDR: 6w777GSf3RPmvUZjU+2kZujlJUKEZ/Y32lQasy2JOe58RISU2oawLITaRFuvWy77gxZ/XyZjHY
 Xmfvyo3g+3XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="313913004"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 03:07:35 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 04/10] topology: decode: Add enum control texts as separate
 element
Date: Mon,  6 Jul 2020 11:05:57 +0200
Message-Id: <1594026363-30276-5-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
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

Change-Id: I7b97803da13478c642d003b78ce12be1eedbf802
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

