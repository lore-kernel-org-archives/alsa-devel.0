Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6272C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 07:29:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0DD510A1;
	Mon,  6 Mar 2023 08:28:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0DD510A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678087739;
	bh=SGbXkVvcCidN4IvPeUrttPltUZKfeOLof5Z7jPhtQf0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Sqj91njHCaj3TjT424wZRFPD4bq25Hnb6xezzEBac+OU0W+UladddUBiXnXDmHba7
	 A93+w5IMXljpeIzSCJg4IRbTLf0SXUcMDaWnr2ykYg0CP24dGEeOiylokVlJ45aOUv
	 omHbhXrKgZOqRATyIVW1WzX4i1Pjj1uUj+jWoXD8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ED48F80431;
	Mon,  6 Mar 2023 08:27:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8592DF80431; Mon,  6 Mar 2023 08:27:41 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E5A5F800C9
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 08:27:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E5A5F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TC8pV3Rh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678087657; x=1709623657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGbXkVvcCidN4IvPeUrttPltUZKfeOLof5Z7jPhtQf0=;
  b=TC8pV3RhuX5VnofUnR2ho1zKvlph8O/8bvQT1UsUkhECLmdx7ECsW16A
   T7X7kSs+h6/6F2kxERdL8p0A2KAaDo/O/c8cH7LfsMavCzGJ8pQ9wy6Rs
   paC1uWp2u9QUfrQToVd8cJjOXl65Nxb+tY2YZtVW9mgRjyTO+9GQbToer
   hSPRId7xZQ4Xqm7UdnOrRzETaAGFuTpVQWlPgAtk6H6K8q5H/WXcvcIVl
   vP+I0yFoD2NjCOWbvH1dGhq3IQW3Gr+HA5CHneNaN6/e2TMHBU4nxMJur
   /IkOp5aiVLVxzoiB0T+XBbtwzG7203cpd7dZn6MQAYKaeOaeHrPKoimEt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363103310"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400";
   d="scan'208";a="363103310"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2023 23:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="786103171"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400";
   d="scan'208";a="786103171"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2023 23:27:31 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: intel-dsp-config: add MTL PCI id
Date: Mon,  6 Mar 2023 15:41:01 +0800
Message-Id: <20230306074101.3906707-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: W43KCRTWLE3O4C63KMDRBVWKD4PW6JEM
X-Message-ID-Hash: W43KCRTWLE3O4C63KMDRBVWKD4PW6JEM
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W43KCRTWLE3O4C63KMDRBVWKD4PW6JEM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use SOF as default audio driver.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Gongjun Song <gongjun.song@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index ae31bb127594..317bdf6dcbef 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -472,6 +472,15 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Meteor Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_METEORLAKE)
+	/* Meteorlake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x7e28,
+	},
+#endif
+
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.25.1

