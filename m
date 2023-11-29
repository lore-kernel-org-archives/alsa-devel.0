Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549E9C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 12:54:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69774A4E;
	Wed, 29 Nov 2023 13:54:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69774A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701262486;
	bh=sYLfqhSfdwPusKgPVDUZjtWRIRsMeQ3oJLzattU+fQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y/tI3xRl0sM361EoDW7Kvom8dDPcMewyTvwkL/Cn9xjh7UXQ0VOx6ptMO+rWZgDSy
	 jBFA+Fcn22OzxMsEvpY3jELHKQf5iwyNSzl6K338TL7NL8sGjFZQzgI5OrQ8C0F4fy
	 O7D7aNwSfgd0S75PGEjRLLhDaRnwwJXynmY1FA1Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2BA9F80639; Wed, 29 Nov 2023 13:53:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 04908F80639;
	Wed, 29 Nov 2023 13:53:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57DB1F805C1; Wed, 29 Nov 2023 13:53:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B323AF801D5
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 13:53:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B323AF801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Erxz/0AJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701262385; x=1732798385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYLfqhSfdwPusKgPVDUZjtWRIRsMeQ3oJLzattU+fQI=;
  b=Erxz/0AJenhYQDG3qBc9mJrmnozPoMHxqIAu3Y2AQXpnfts9XcMifxxo
   8rBZLw/UMeh4we4Um+vlcB5z4sjvWeN5RIfi4rDTybGdf6+UQ6KWpIW+H
   znUWiVRWkP6pEEF/N5ESE0OjOv2PJLofz72NYdkRdhmpjea7+mbLsiA8w
   fiCBlF3rWwezR7bpQNTCM9Y/gwiaXMt1vB7xzKjq1bCqmX1ueOmE8JlG9
   hcDoWYjLoS6toa7AJXW6XSPpKA1ztmh0HacXe35VOTQtt6yQgs/nIQnP+
   UinSArcC2mtjJeqVbmQXKja+2R3k61M9ahE7NfqSXhrm4R9G0AvGUgz0B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392022909"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="392022909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="17174623"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.44.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:02 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 05/13] ASoC: SOF: sof-of-dev: Save the default IPC type and
 path overrides
Date: Wed, 29 Nov 2023 14:53:19 +0200
Message-ID: <20231129125327.23708-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
References: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VDLTUBC5LLKFURUWRIXCQHS5M7BTVMDZ
X-Message-ID-Hash: VDLTUBC5LLKFURUWRIXCQHS5M7BTVMDZ
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VDLTUBC5LLKFURUWRIXCQHS5M7BTVMDZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Store the default IPC type and the firmware and topology path overrides to
ipc_file_profile_base

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-of-dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 432b511bf8c4..7b58f45790f7 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -99,6 +99,10 @@ int sof_of_probe(struct platform_device *pdev)
 	else
 		sof_pdata->tplg_filename_prefix = desc->default_tplg_path[SOF_IPC_TYPE_3];
 
+	sof_pdata->ipc_file_profile_base.ipc_type = desc->ipc_default;
+	sof_pdata->ipc_file_profile_base.fw_path = fw_path;
+	sof_pdata->ipc_file_profile_base.tplg_path = tplg_path;
+
 	/* set callback to be called on successful device probe to enable runtime_pm */
 	sof_pdata->sof_probe_complete = sof_of_probe_complete;
 
-- 
2.43.0

