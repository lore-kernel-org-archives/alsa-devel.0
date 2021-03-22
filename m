Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B804FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8626198D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8626198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 024F71687;
	Mon, 22 Mar 2021 17:41:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 024F71687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616431313;
	bh=nIOZUXsmUUNCG0ZwDA6gycC6fnF48796e0D9XG0p4B4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dPqVPm928Nf4tYq+TzMg4zMg8Gv48FAL0TyQM8U2hiEQSkdT5/MN0mOnlqHeGCSXi
	 7djyp4PqxucBS6ZLdiKHTkYaaYvO0TO6jnxXU9WG8csB/gfLNQj6if/ULWpnLcaQWb
	 4bcpfSbD4bq+61uf2ywH60S5EhKWCwA1va/UXP9M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1936AF804C1;
	Mon, 22 Mar 2021 17:38:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADD63F802E3; Mon, 22 Mar 2021 17:38:05 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0720F80246
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 17:37:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0720F80246
IronPort-SDR: v2tiNW2v8KTiEDu6hvJjGzVZ4feyV1W+mmqx4kkdBTopfVB5p+EInvXKHcQTVL0sn/o70UVTVG
 lYE8BeKk/FCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210376641"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="210376641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:47 -0700
IronPort-SDR: HQ+x8radCPJlvHwq/ZyMCaMfAun1EhGCUdAZ6XYnGSIEAVSAZ6LorGwe5t+nmI3k/RGTAEhJk0
 d/7r94HcTpmg==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="407899131"
Received: from josemari-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.40.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/8] ASoC: SOF: Intel: APL: set shutdown callback to
 hda_dsp_shutdown
Date: Mon, 22 Mar 2021 11:37:27 -0500
Message-Id: <20210322163728.16616-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
References: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

From: Libin Yang <libin.yang@intel.com>

According to hardware spec and PMC FW requirement, the DSP must be
in D3 state before entering S5. Set shutdown call to hda_dsp_shutdown.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index fc29b91b8932..c7ed2b3d6abc 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -27,9 +27,10 @@ static const struct snd_sof_debugfs_map apl_dsp_debugfs[] = {
 
 /* apollolake ops */
 const struct snd_sof_dsp_ops sof_apl_ops = {
-	/* probe and remove */
+	/* probe/remove/shutdown */
 	.probe		= hda_dsp_probe,
 	.remove		= hda_dsp_remove,
+	.shutdown	= hda_dsp_shutdown,
 
 	/* Register IO */
 	.write		= sof_io_write,
-- 
2.25.1

