Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCFCC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Mar 2022 21:00:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D41331ED7;
	Fri,  4 Mar 2022 22:00:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D41331ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646427653;
	bh=LrmxOQiORsVt5ClH42Uf0eTVBg/+TCwYW3p4TbK4Fs8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFKBLAkPdhcO8uEE08/niOTwJ/WbHwYPitRJXwQlIMlAHBgZ2pb867Nt/4MRzCRiP
	 N8j99xU5xoCsWCd/aLJ71MoYWqLw9YTk/dRlqp+8DbGFeVO2OrakAb+p1OdzJ6dbUr
	 UdhyPGc1InKvcCfngwgcXto91ABZvcbiZIxUgn4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1611F80529;
	Fri,  4 Mar 2022 21:57:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7062F8051E; Fri,  4 Mar 2022 21:57:55 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4109CF800FA
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2022 21:57:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4109CF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="bGuRC9wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646427468; x=1677963468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LrmxOQiORsVt5ClH42Uf0eTVBg/+TCwYW3p4TbK4Fs8=;
 b=bGuRC9wvnFAn9mKcSgMuSFwziJvg54eIJQ//hatYGN5vcBIKvXqNxP6C
 xcpm1iMnlEYxHoGCHn0rSI5jLippYaBukwvErW1o3JRlnSZrY5YlQlDrd
 PNnoh3sci5jM5gYoDJzDNUPH30TR0v+iJQgx77EooMFb4+XvSWTOeetNU
 0A90yjtYM6xr4upRmUZi9iNyh4CbmVOiK5tlwWqLpioEbDzXUzSZBucOZ
 Y3fY07qrg79XJYSqf2sUVKywrEBipe+QECP44cR1Ajpbte8apjOiWDeaS
 UHEJ0Ot6h0mIEFPCq6+PSng/tOST/6xFByrsZen/KwU8mc3I4GWvL35aw Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340492550"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; d="scan'208";a="340492550"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 12:57:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; d="scan'208";a="631271288"
Received: from grmundad-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.115.48])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 12:57:43 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/10] ASoC: SOF: amd: Flush cache after ATU_BASE_ADDR_GRP
 register update
Date: Fri,  4 Mar 2022 14:57:27 -0600
Message-Id: <20220304205733.62233-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304205733.62233-1-pierre-louis.bossart@linux.intel.com>
References: <20220304205733.62233-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

ACP_SRAM_PTE block has cache that needs to be flushed after every
PTE updates. This patch updates ACPAXI2AXI_ATU_CTRL register to
flush cache after updating PTE with stream physical address.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/amd/acp-stream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/amd/acp-stream.c b/sound/soc/sof/amd/acp-stream.c
index f2837bfbdb20..b3ca4a90dbf8 100644
--- a/sound/soc/sof/amd/acp-stream.c
+++ b/sound/soc/sof/amd/acp-stream.c
@@ -115,6 +115,9 @@ int acp_dsp_stream_config(struct snd_sof_dev *sdev, struct acp_dsp_stream *strea
 		offset += 8;
 	}
 
+	/* Flush ATU Cache after PTE Update */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACPAXI2AXI_ATU_CTRL, ACP_ATU_CACHE_INVALID);
+
 	return 0;
 }
 
-- 
2.30.2

