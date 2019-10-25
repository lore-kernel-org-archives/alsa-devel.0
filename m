Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660DCA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:46:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE3221872
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jDPL2S8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE3221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88F6218FD;
	Sat, 26 Oct 2019 00:46:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88F6218FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572043612;
	bh=JkJoSh19OK8ziMI3VQj+eTRNEm7sg5NZeDnhjD+Ja4Q=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDPL2S8HcHVN2ys1NNLQqVhcK4qN9NImwyYT3q5AhB/W7+c7fPjNYzipSHqPdlOJG
	 bD7+Kv65Rv3NBsqbyczjnzUJOvpnbhsa9FTdJE1kM2fnhUipaK01CCMNIjoB+YdoDs
	 LR+5p0MB97FONzxrG+CZuoHMWIHYvyNzhGJ0jj8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63A3FF8065A;
	Sat, 26 Oct 2019 00:42:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2220FF80634; Sat, 26 Oct 2019 00:41:49 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0ADCDF80112
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 00:41:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0ADCDF80112
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 15:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="210458192"
Received: from archagam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.252.139.180])
 by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 15:41:38 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 25 Oct 2019 17:41:02 -0500
Message-Id: <20191025224122.7718-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 06/26] ASoC: SOF: Intel: APL: add
	set_power_state() ops
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Keyon Jie <yang.jie@linux.intel.com>

Using hda_dsp_set_power_state() as set_power_state() ops for apl to do
d0ix platform configuration updates.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 15d26e8d90a9..7daa8eb456c8 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -97,6 +97,7 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.runtime_resume		= hda_dsp_runtime_resume,
 	.runtime_idle		= hda_dsp_runtime_idle,
 	.set_hw_params_upon_resume = hda_dsp_set_hw_params_upon_resume,
+	.set_power_state	= hda_dsp_set_power_state,
 
 	/* ALSA HW info flags */
 	.hw_info =	SNDRV_PCM_INFO_MMAP |
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
