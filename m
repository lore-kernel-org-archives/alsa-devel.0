Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA2C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 12:56:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D75E950;
	Wed, 29 Nov 2023 13:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D75E950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701262606;
	bh=paGtmFywowXIennU78XonD4EbtcdQ1JkutrJQ5ngLcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ulP2NMgMQXx3jfi3tgJHTNm2NCTAe9C+xHrtkRT6O6HViBjbQTkVbVd6m0pTDXHIp
	 W3PJeRK6dbUJmxU+U5b3pTFPUevJKd/KXVytCDR4m9yUbUCc4GYvOfuItoICvRRla6
	 NB0fH9+VoVlWjcs5Iv5lhje614MDSdxTucSgD/UY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0EA0F80737; Wed, 29 Nov 2023 13:53:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 726BEF80768;
	Wed, 29 Nov 2023 13:53:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0189F80737; Wed, 29 Nov 2023 13:53:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A792FF80114
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 13:53:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A792FF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OGHBAB4f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701262381; x=1732798381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=paGtmFywowXIennU78XonD4EbtcdQ1JkutrJQ5ngLcs=;
  b=OGHBAB4f51UDmBr4FYZCSe49ybYDxdmUnVWX5b8FfaWByE4QhCQ2Po3+
   AqlvOJopXL2nu1Lgn1LPXPC96c12KdJCYQzBdtiNIhaVTW1qihhPBbUWX
   3eD1NrurArfkYhDySLo4K1cSgRbbnfx5mYmDHFd2tBZqaHoZcBeOCTnUl
   FLKWO6Aan9ksDJ7AGrzQLqZG7XvhIDttSrw/b2GvFW5NyRNX8J6cuLcnt
   64c+0tAiVkigYLkDZtkoeN3pmhXLWskYul8UNloZo+9uw+7UFS8q+NlbC
   XNHHEXsQ0aYzUSoaKv2pGLl+bhi424fEXDOiNiOoMs14YK6TP+oIS9GaB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392022892"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="392022892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="17174608"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.44.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:52:58 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 03/13] ASoC: SOF: Add placeholder for platform IPC type and
 path overrides
Date: Wed, 29 Nov 2023 14:53:17 +0200
Message-ID: <20231129125327.23708-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
References: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QEE5LDYRDWAD7TRYQNTS7LLRRYO7KY52
X-Message-ID-Hash: QEE5LDYRDWAD7TRYQNTS7LLRRYO7KY52
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QEE5LDYRDWAD7TRYQNTS7LLRRYO7KY52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add a struct sof_loadable_file_profile which can be filled by platforms
(sof-acpi-dev.c, sof-of-dev.c and sof-acpi-dev.c) to be able to use common,
generic code to handle path customization.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 268d0ca0f69f..05213bb515a3 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -57,6 +57,18 @@ enum sof_ipc_type {
 	SOF_IPC_TYPE_COUNT
 };
 
+struct sof_loadable_file_profile {
+	enum sof_ipc_type ipc_type;
+
+	const char *fw_path;
+	const char *fw_path_postfix;
+	const char *fw_name;
+	const char *fw_lib_path;
+	const char *fw_lib_path_postfix;
+	const char *tplg_path;
+	const char *tplg_name;
+};
+
 /*
  * SOF Platform data.
  */
@@ -86,6 +98,9 @@ struct snd_sof_pdata {
 	/* descriptor */
 	const struct sof_dev_desc *desc;
 
+	/* platform's preferred IPC type and path overrides */
+	struct sof_loadable_file_profile ipc_file_profile_base;
+
 	/* firmware and topology filenames */
 	const char *fw_filename_prefix;
 	const char *fw_filename;
-- 
2.43.0

