Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C404FC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:10:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439832065D
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V7+oL6ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439832065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7C3518E0;
	Thu, 25 Jun 2020 14:09:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7C3518E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593087039;
	bh=qPrmTmWIZmjanQ98uvsYyjle6NebOBCpgwSdJUQDCRw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V7+oL6ZAjPVMuzjTUYnheCgRZ6QibIYXDgHKpcl+6XADOpaex4e1O7f8kuwJmpn4z
	 tEN9YlsJ/jTB2FfxyPDoprT0qwULqAkrBD2wy2CNd9lvcR9nBzJbr195Y7ipYtScI9
	 4e9Vo4yA6RYCzgl3uFqxPK9X+yVjHeV1ok0IbF/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 474D4F802E7;
	Thu, 25 Jun 2020 14:06:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEF13F802BE; Thu, 25 Jun 2020 14:05:56 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A470F80259
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 14:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A470F80259
IronPort-SDR: rb+cTLIFwJ4BfKNgjqJZBzYfkrbhXYpDgJssOGjqkW+n6NRYf8HjFBFkHzHG2kn/efF4KL6zl1
 lvYwRfNnRqRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206389944"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="206389944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:05:43 -0700
IronPort-SDR: cIpxOQRl8TIs9aT/A64BC+C54thb/aqcKb0yCUpAr99/wCbjBZkuq0EUJqLUJuq6dQlelsarWh
 zmPlJhdDOsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="354438978"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga001.jf.intel.com with ESMTP; 25 Jun 2020 05:05:42 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 7/8] topology: decode: Add DAI name printing
Date: Thu, 25 Jun 2020 13:03:45 +0200
Message-Id: <1593083026-7501-7-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593083026-7501-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1593083026-7501-1-git-send-email-piotrx.maziarz@linux.intel.com>
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

DAI name is a part of topology binary. Not printing makes data loss while
converting from binary to UML.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
---
 src/topology/pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 49c5eab..5a54e15 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -781,7 +781,9 @@ int tplg_save_fe_dai(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	struct snd_soc_tplg_pcm *pcm = elem->pcm;
 	int err = 0;
 
-	if (pcm->dai_id > 0)
+	if (strlen(pcm->dai_name))
+		err = tplg_save_printf(dst, pfx, "dai.'%s'.id %u\n", pcm->dai_name, pcm->dai_id);
+	else if (pcm->dai_id > 0)
 		err = tplg_save_printf(dst, pfx, "dai.0.id %u\n", pcm->dai_id);
 	return err;
 }
-- 
2.7.4

