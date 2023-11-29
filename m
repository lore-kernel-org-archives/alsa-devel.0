Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD596C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 12:54:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E1ECDEF;
	Wed, 29 Nov 2023 13:54:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E1ECDEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701262473;
	bh=jCpn9ZNcLLcLhZMJvK9OlpkgsWy+ExRNpQspOpbl0XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Pw4oacFhF3esDrQ2DBimWwGy35F4lLnCjbQH0wjO+pt13XE7P91U20fUckS+Gy0lF
	 GJsWaOV5U1JFLl1PcvfO9SKiV7X+9FmUOl0TgUxEKtx+zyKT2G03F4a+LxPNrCKWvd
	 x52j4/d8O7fWymKsuopVCRue6xLztbv1qI/+YRSY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F19C7F80610; Wed, 29 Nov 2023 13:53:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6F3FF80610;
	Wed, 29 Nov 2023 13:53:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12B05F805AA; Wed, 29 Nov 2023 13:53:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6D9B6F805A1
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 13:53:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D9B6F805A1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CGqvhvIk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701262389; x=1732798389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jCpn9ZNcLLcLhZMJvK9OlpkgsWy+ExRNpQspOpbl0XY=;
  b=CGqvhvIkoCKMpYEqlVsO2sPNoSeqeeKrpVEyn4E24DZt5BytaL+JTqCf
   5DxNfWoLfcp/fROXzrqGUwqLG2eTA/GMYib6C7YkBMJn7N/xuzsvV5HEt
   ZXT7rTjPQcajOHDX0pX0WrnIY0jZXsoZeocu5K6OjizrCfyV+3dHHeI1q
   TGKr9nh2iVYfp4IWDfKpqVdSOo8Eak2mfuEX5t6mZNas4u3Dn1NWehs1y
   iOeubVMgGqDeU6lE8AqE0BtzJPuH1DmJjpde+riwR4F8Wir89br/u88rI
   c+5GVIhc8CsZ56QT7YloMUMgmwR/Sf+M0MngWgJ1Ura63awyOh28hzwes
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392022924"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="392022924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="17174631"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.44.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:04 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 06/13] ASoC: SOF: sof-pci-dev: Save the default IPC type and
 path overrides
Date: Wed, 29 Nov 2023 14:53:20 +0200
Message-ID: <20231129125327.23708-7-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
References: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BJ22IVZTNOPQ6GYU5FGE5T6L2CIM3Z6R
X-Message-ID-Hash: BJ22IVZTNOPQ6GYU5FGE5T6L2CIM3Z6R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BJ22IVZTNOPQ6GYU5FGE5T6L2CIM3Z6R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Store the default IPC type and the overrides to ipc_file_profile_base

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 64b326e3ef85..becc85b27d51 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -190,6 +190,7 @@ static void sof_pci_probe_complete(struct device *dev)
 
 int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
+	struct sof_loadable_file_profile *path_override;
 	struct device *dev = &pci->dev;
 	const struct sof_dev_desc *desc =
 		(const struct sof_dev_desc *)pci_id->driver_data;
@@ -334,6 +335,20 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 			sof_pdata->tplg_filename = sof_dmi_override_tplg_name;
 	}
 
+	path_override = &sof_pdata->ipc_file_profile_base;
+	path_override->ipc_type = sof_pdata->ipc_type;
+	path_override->fw_path = fw_path;
+	path_override->fw_name = fw_filename;
+	path_override->fw_lib_path = lib_path;
+	path_override->tplg_path = tplg_path;
+	path_override->tplg_name = sof_pdata->tplg_filename;
+
+	if (dmi_check_system(community_key_platforms) &&
+	    sof_dmi_use_community_key) {
+		path_override->fw_path_postfix = "community";
+		path_override->fw_lib_path_postfix = "community";
+	}
+
 	/* set callback to be called on successful device probe to enable runtime_pm */
 	sof_pdata->sof_probe_complete = sof_pci_probe_complete;
 
-- 
2.43.0

