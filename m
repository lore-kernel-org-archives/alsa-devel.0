Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8803CC7EE24
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 20:25:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BF83822;
	Fri,  2 Jun 2023 22:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BF83822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685737501;
	bh=BIAL9VADy2O4E1m+sDTdl/NyVdflykFQduUNcX6a2iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vQ2K5MfSbFiArDyCrznnMfyNro6D3M6i5b5PcfnR6uIMOToRzURdi7+ranSwA//PP
	 fMRfcHX60aOSYx1Ne1HrwV50DDOoFJPyNE4kwUFC8L818Hy5rgsNqnHxiVR1vUH6+q
	 QhFelzEsbE1rq1V8zjp8RHRjqzkVTEM+dmxL4r8c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31C2DF80570; Fri,  2 Jun 2023 22:23:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34A29F80570;
	Fri,  2 Jun 2023 22:23:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12748F8055B; Fri,  2 Jun 2023 22:23:13 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4210CF80149
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 22:23:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4210CF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j9ww7q5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685737385; x=1717273385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIAL9VADy2O4E1m+sDTdl/NyVdflykFQduUNcX6a2iU=;
  b=j9ww7q5uq5OFMlO9s3zVAXRpUEc3gt2YKk+UGz++wftchkIwVxljp3Yz
   851VcBfzOaqciNN1EJTBrvsVR6FQ9TSKxT2xCRCZHa6x9pIesYU8TzEG6
   fnEZFXnW/kwAG3pE43iLNo0uSBoQQO9WQGypDJXE3zYFhxrNLaqFnsTXQ
   j059XPR6qciy86BneRokNclPU0mwXESR4F7TPvl5Bl/m/6Rva0aa/1gzK
   zBGfalfHSoKYYYjU5ASfVlJO+jzsZHR02I1gUnO5IIejgRz8UA6TLsj89
   IR/LUCR+7eeQo4K2X/o/aALT36OT4HXXQpQbsQs5fwm9LLfQwguAEaXPA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354811197"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="354811197"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="773020005"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="773020005"
Received: from clatorre-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.190.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:43 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/28] ASoC: Intel: sof_sdw: add missing exit callback
Date: Fri,  2 Jun 2023 15:21:58 -0500
Message-Id: <20230602202225.249209-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
References: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZCK2NPPUH6NUJODVEKWZ3B64HHIL5R2U
X-Message-ID-Hash: ZCK2NPPUH6NUJODVEKWZ3B64HHIL5R2U
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Somehow .exit = sof_sdw_rt_amp_exit was missing in rt1318 codec info.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d16ceef702a7..2dadde7a7ab9 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -609,6 +609,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.direction = {true, true},
 		.dai_name = "rt1318-aif",
 		.init = sof_sdw_rt_amp_init,
+		.exit = sof_sdw_rt_amp_exit,
 		.codec_type = SOF_SDW_CODEC_TYPE_AMP,
 	},
 	{
-- 
2.37.2

