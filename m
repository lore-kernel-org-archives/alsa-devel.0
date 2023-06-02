Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA24C7EE24
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 20:31:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73CA183A;
	Fri,  2 Jun 2023 22:30:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73CA183A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685737903;
	bh=8z1zD0JI78WHxoBkWezVCz+6ah9oURTcPtOrUqDAjdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VswBQQB0AwPlU2Ammn+ZWvIzK3ihhG4x//G0sX5WM8HBQnZVU+qQvuDiiyz31wXGD
	 jFS9ogW4IVgN60wP+Lx3O7gbFxU2yvIbsKYp+l7YmWHLnuHTTWDmDjcSaqufHZxG6m
	 eJ/5DcYyH8YplyEBv8+Ju6ot0/cOIFylJsT/avaY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B04DF805AB; Fri,  2 Jun 2023 22:25:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC0D6F805A1;
	Fri,  2 Jun 2023 22:25:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69969F805A1; Fri,  2 Jun 2023 22:25:11 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CE84DF80199
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 22:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE84DF80199
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ihBwi4h/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685737389; x=1717273389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8z1zD0JI78WHxoBkWezVCz+6ah9oURTcPtOrUqDAjdk=;
  b=ihBwi4h/XVPpbj6s9q0VcYqemsVjUMJ8vK2UNG74XAPYvz7/V3WspVra
   h7s3eFG6nioi+4rehiI69NLqq/YKvOwCLEM7sTuqa4/xpFmlg4cu8ZUej
   F+bkucqYiQJdE4YiRwDXJppWl2VrNOZEKaQJyH3aAX4r30jt29wBPES8s
   p0IKxGfpAsV/hVUuPOutSfghzmJWI+OHy+NJZkiyWhnzxvVTTJy74m5hy
   RnzEpLcyzzUqNje28L5kR5ukU8fxNk3k+NVljv+3/+9d7bWww7A33CU8a
   yk+fDTJpmbH6zoqpAMAO+738pQDAMiCdYeM2m5fE/wcxt9qs4LoshMxYj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354811222"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="354811222"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="773020013"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="773020013"
Received: from clatorre-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.190.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/28] ASoC: Intel: sof_sdw_rt_sdca_jack_common: test
 SOF_JACK_JDSRC in _exit
Date: Fri,  2 Jun 2023 15:22:04 -0500
Message-Id: <20230602202225.249209-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
References: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3X3YDM5FDTO3SU2PTAAW5JG4T3RLKYGD
X-Message-ID-Hash: 3X3YDM5FDTO3SU2PTAAW5JG4T3RLKYGD
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3X3YDM5FDTO3SU2PTAAW5JG4T3RLKYGD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

if (!SOF_RT711_JDSRC(sof_sdw_quirk)) is tested in rt711_sdca_add_codec_
device_props(), and we don't add software node to the device if jack
source is not set. We need to do the same test in
sof_sdw_rt711_sdca_exit(), and avoid removing software node if jack
source is not set.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
index 7f16304d025b..cf8b9793fe0e 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
@@ -143,6 +143,9 @@ int sof_sdw_rt711_sdca_exit(struct snd_soc_card *card, struct snd_soc_dai_link *
 	if (!ctx->headset_codec_dev)
 		return 0;
 
+	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
+		return 0;
+
 	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
 
-- 
2.37.2

