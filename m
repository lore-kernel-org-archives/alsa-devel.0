Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A293C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 16:26:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E9BCAEB9;
	Wed, 19 Oct 2022 18:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E9BCAEB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666196809;
	bh=+rUq1YVNCJ9rQIC/+32AHdlkU7UOww2HYWFDWhCL9qQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WNjS4sVJp+jebtKS0MPrapMDTqJtuMz/yi5ia4TebTsouO6QKr/8/9R/zR38JCQdI
	 MQcjvmMnzsOCqybQh1sRDH4o4eKMHbjnABcv3KBvqw7ORqU7SwXoH6PmwclkZMyK2s
	 YOgZqusBzbiC+E/8oq8B/pLu/aeUTxuOtJO/B9bg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F8E2F8057B;
	Wed, 19 Oct 2022 18:24:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B30FF80579; Wed, 19 Oct 2022 18:24:01 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B88FF80558
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 18:23:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B88FF80558
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="f0ouIy+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666196636; x=1697732636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+rUq1YVNCJ9rQIC/+32AHdlkU7UOww2HYWFDWhCL9qQ=;
 b=f0ouIy+1VkyQo9LfjBGsOHRImDDP9CFgzSwumZ+5V0QiH2r1dDKX5x9d
 0bg12g+SmDpS1UcNOlPGixke890nylB8NVf5CEUNrBMVeiXVaPYTWEWLa
 7BBqtn7lNct3j3bI/Q/ztJrLqtNNekumL9zAII4vvekVg4q3hiyXlAPeG
 8zjq5V8nTZJzhJ7HNnVLAbpMZ1YnhFeeN0D1IjYLajSNYn1GTZeVjhfkR
 48wwt0azatu1Of+sa/s9wnM6HxfoCNmzSTHyCQ2qbIIWOjnQuxzqaQc01
 ZazBhuN/Jspz9seeE+TCSE7XXeu3vblAhTcEK4KdZFe7yTGTpB1H8Fwr6 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286856258"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="286856258"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 09:21:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="698153861"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; d="scan'208";a="698153861"
Received: from afsinurr-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.16.185])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 09:21:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/10] ALSA: hda: hdac_ext_controller: remove useless loop
Date: Wed, 19 Oct 2022 11:21:14 -0500
Message-Id: <20221019162115.185917-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019162115.185917-1-pierre-louis.bossart@linux.intel.com>
References: <20221019162115.185917-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

commit 0b00a5615dc40 ("ALSA: hdac_ext: add hdac extended controller")
introduced a for() loop on the number of HDaudio codecs that seems
completely useless.

a) the body of the loop does not make use of the loop index, and
b) the LSDIID register is related to the SDI line, so there can only
be one codec per multi-link descriptor.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 08d3313f2df7e..6199bb60ccf00 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -135,12 +135,10 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_link_free_all);
 struct hdac_ext_link *snd_hdac_ext_bus_get_hlink_by_addr(struct hdac_bus *bus, int addr)
 {
 	struct hdac_ext_link *hlink;
-	int i;
 
 	list_for_each_entry(hlink, &bus->hlink_list, list)
-		for (i = 0; i < HDA_MAX_CODECS; i++)
-			if (hlink->lsdiid & (0x1 << addr))
-				return hlink;
+		if (hlink->lsdiid & (0x1 << addr))
+			return hlink;
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_hlink_by_addr);
-- 
2.34.1

