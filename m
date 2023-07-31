Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2C3C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:39:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9923AFA;
	Mon, 31 Jul 2023 23:38:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9923AFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839566;
	bh=sNsN8EC1sC6pKQi+Ke0PT79DyXqCkZVD5XZycTAyHgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QAM7nVnwo4foYeS8gzDHokO8Z1jnili7jo70XdzAulQRcWP0GRyLZ8Vjojh/+Nvh1
	 l/8vGCl3AJc13hhoRRB056HG7EcB3GbPYYihfNTQRrp9SpBARygFqii7+Ymz3OGJ7w
	 QJ4Mtj1IJR1FKrpGraBMxuArgyzlZos938z6eMbk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85377F8055C; Mon, 31 Jul 2023 23:38:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 701F4F80563;
	Mon, 31 Jul 2023 23:38:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1085BF80549; Mon, 31 Jul 2023 23:38:13 +0200 (CEST)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07288F8053B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:38:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07288F8053B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cuhRacWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839490; x=1722375490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNsN8EC1sC6pKQi+Ke0PT79DyXqCkZVD5XZycTAyHgQ=;
  b=cuhRacWWoXFTlHTsIvxpbtwI9cAp7dRqGtqutxdwmrp+hfACK6IjOenU
   yWMF5lONZkUQnfx6+ruBW8nr6NHxmMZrsHAljprz7a6aLj0CpyG2HPAEv
   V2mVldUs6+GpzeJm8bdKSQ7+TuWd4Ckg/ioANOTkNauYOTRYfvxWvoY2W
   4hMzWQ0C1tEsxkg6SkIUzMBbE9u1i1XDPotwWGa1r4w0MNGw5uRFPjQHB
   w8LQF8GCDxA2MPZvTmLoTycsS/wDBa8AOrgct9gElUAL3DknOJrtxlf4U
   1e1WGOaEZwrvWl3IccYDE957n2WqmoI6RWQN2opjKYrazqKzsSjBTiGW+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366604091"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="366604091"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793880026"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="793880026"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:03 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Yaochun Hung <yc.hung@mediatek.com>
Subject: [PATCH 1/8] ASoC: SOF: sof-client-probes-ipc4: add checks to prevent
 static analysis warnings
Date: Mon, 31 Jul 2023 16:37:41 -0500
Message-Id: <20230731213748.440285-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5LMDGNHSMBWTKTAWKJK6KXXYY5GITK62
X-Message-ID-Hash: 5LMDGNHSMBWTKTAWKJK6KXXYY5GITK62
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5LMDGNHSMBWTKTAWKJK6KXXYY5GITK62/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

make KCFLAGS='-fanalyzer' sound/soc/sof/ reports several NULL pointer
dereference paths.

sof_ipc4_probe_get_module_info() can return a NULL value, but it's
only tested in the init state. Static analyzers cannot know the probe
state machine and hence flags a potential issue for all calls of that
function.

Squelch these errors by adding the same check consistently.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/sof-client-probes-ipc4.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/sof-client-probes-ipc4.c b/sound/soc/sof/sof-client-probes-ipc4.c
index ea21ef176c42..c56a85854d92 100644
--- a/sound/soc/sof/sof-client-probes-ipc4.c
+++ b/sound/soc/sof/sof-client-probes-ipc4.c
@@ -146,6 +146,9 @@ static int ipc4_probes_deinit(struct sof_client_dev *cdev)
 	struct sof_man4_module *mentry = sof_ipc4_probe_get_module_info(cdev);
 	struct sof_ipc4_msg msg;
 
+	if (!mentry)
+		return -ENODEV;
+
 	msg.primary = mentry->id;
 	msg.primary |= SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_DELETE_INSTANCE);
 	msg.primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
@@ -197,6 +200,9 @@ static int ipc4_probes_points_add(struct sof_client_dev *cdev,
 	struct sof_ipc4_msg msg;
 	int i, ret;
 
+	if (!mentry)
+		return -ENODEV;
+
 	/* The sof_probe_point_desc and sof_ipc4_probe_point structs
 	 * are of same size and even the integers are the same in the
 	 * same order, and similar meaning, but since there is no
@@ -247,6 +253,9 @@ static int ipc4_probes_points_remove(struct sof_client_dev *cdev,
 	u32 *probe_point_ids;
 	int i, ret;
 
+	if (!mentry)
+		return -ENODEV;
+
 	probe_point_ids = kcalloc(num_buffer_id, sizeof(*probe_point_ids),
 				  GFP_KERNEL);
 	if (!probe_point_ids)
-- 
2.39.2

