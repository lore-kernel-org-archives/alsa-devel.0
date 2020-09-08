Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F88C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:31:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5790A21D20
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z2A0HphG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5790A21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B329176E;
	Tue,  8 Sep 2020 11:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B329176E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599557504;
	bh=afC2hy1YLsD+mzIcgXfeQDozZswgrs4Z4Dx1DeQgaq4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z2A0HphGYfCQ4gurk9C5aZZi8zZO3U52yXgVHCyWRO0iOKbhPek0DhtJw4O6Vznen
	 bpOgGQvQ/0bpWwsZ4lT9heStXoQOyCVl4DUoqtf+4yoB/EPWoL9/N8u5rULIrRyTkb
	 DjaSDJ6cOPd1j8xKVqu8T7X86m8J3+Zj/pZkzQ88=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CBDD1F80277;
	Tue,  8 Sep 2020 11:30:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33DFCF8026F; Tue,  8 Sep 2020 11:29:57 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41BACF800FD
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 11:29:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41BACF800FD
IronPort-SDR: bbhXNDu0BPIIr72tftEPX8tU5SVgRs6lg/sz83jBDfPcUo0rtlbaoBnYIDXK+OaGaNpUXt0I0f
 t2K+SpVp8nPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="219659851"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; d="scan'208";a="219659851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 02:29:47 -0700
IronPort-SDR: udvWaGciUNHo01+rhqyh1L7e0uwlnqZoIsvORLSVT+uFjALYeQ38Mj/nykDr270ceFSGACZtRy
 lYdZaAmclV2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; d="scan'208";a="317130411"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 08 Sep 2020 02:29:45 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/2] ASoC: topology: Add support for WO and RO TLV byte
 kcontrols
Date: Tue,  8 Sep 2020 12:28:24 +0300
Message-Id: <20200908092825.1813847-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Dharageswari R <dharageswari.r@intel.com>, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Dharageswari R <dharageswari.r@intel.com>

This patch adds support for write-only and read-only TLV byte kcontrols
by checking for appropriate get/put IO handlers.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/soc-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index cee998671318..28faaf58326e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -603,10 +603,11 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 				sbe->get = ext_ops[i].get;
 		}
 
-		if (sbe->put && sbe->get)
-			return 0;
-		else
+		if ((k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READ) && !sbe->get)
 			return -EINVAL;
+		if ((k->access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE) && !sbe->put)
+			return -EINVAL;
+		return 0;
 	}
 
 	/* try and map vendor specific kcontrol handlers first */
-- 
2.27.0

