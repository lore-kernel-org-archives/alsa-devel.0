Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01230C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 19:52:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 053EE83A;
	Mon, 25 Jul 2022 21:51:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 053EE83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658778759;
	bh=hcRPlfM5Td+EcU0ePZyUz156ScV9SVPDnCAIVARwEbw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hL7R9UheDKD7GqVZuI/OmYf8LovGBoQcuu+gVlCnVbn56OW2MgV1CTep9yYYSHzyp
	 P83P+HNEoMyzsWcPBQ9HzJL4e8MgqSmLI8TX5z/53WcvgDq7MZbW8e0UNFzCxUh1UN
	 yWqpwR4p1gHS8KWLODI+B02p3YrPDzrgMQkZwwFk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D53FF80543;
	Mon, 25 Jul 2022 21:49:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D64FF80551; Mon, 25 Jul 2022 21:49:44 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D158F804FC
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 21:49:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D158F804FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="UBFJMAtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658778575; x=1690314575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hcRPlfM5Td+EcU0ePZyUz156ScV9SVPDnCAIVARwEbw=;
 b=UBFJMAtGgSuDKSqJ0iyLX+BNyX4eyq4prGLOpl7QOXmKsQg3WuglvJCa
 cg4IVj+n39jIlbSfH/8RYhq2otlPgbKIkTQ8lhdxO4Skpbu7gkZjyAKdD
 bJcvj9nVe2OUOCVMxWMg6/Grvg3g+MVO3T1g5gs1MEu4l7xRvF83AvmIO
 IYHxBsMlr3B8J39V+39fTl+fcvwjM32vdNeI0V8X0ypsUqB7HFjjvSa22
 rZYuocrpIvRrab8KzAINOVf/RGMKgXdYBVUQT52vSfSnQsEKGIhsJOj7H
 dv9QUgeqTzosOy4uGPVfmMa08G6o4HnB5R/PBuI2k6s0zl+s+yZ6I1gxJ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267553913"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="267553913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:49:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="632479468"
Received: from mbianco-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.71.159])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:49:24 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/10] ASoC: Intel: sof_es8336: reset the num_links during
 probe
Date: Mon, 25 Jul 2022 14:49:05 -0500
Message-Id: <20220725194909.145418-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220725194909.145418-1-pierre-louis.bossart@linux.intel.com>
References: <20220725194909.145418-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 broonie@kernel.org, Muralidhar Reddy <muralidhar.reddy@intel.com>,
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

From: Muralidhar Reddy <muralidhar.reddy@intel.com>

The number of dai_links for sound cards needs to be reset during
probe. This is done in all machine drivers except this one.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Muralidhar Reddy <muralidhar.reddy@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_es8336.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index f6a003d2da29..b616d22bc0fa 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -634,7 +634,8 @@ static int sof_es8336_probe(struct platform_device *pdev)
 	if (quirk & SOF_ES8336_ENABLE_DMIC)
 		dmic_be_num = 2;
 
-	sof_es8336_card.num_links += dmic_be_num + hdmi_num;
+	/* compute number of dai links */
+	sof_es8336_card.num_links = 1 + dmic_be_num + hdmi_num;
 
 	if (quirk & SOF_SSP_HDMI_CAPTURE_PRESENT)
 		sof_es8336_card.num_links += (quirk & SOF_NO_OF_HDMI_CAPTURE_SSP_MASK) >>
-- 
2.34.1

