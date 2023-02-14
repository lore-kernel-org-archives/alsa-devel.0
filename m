Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56E1C05027
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 10:35:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF36184D;
	Tue, 14 Feb 2023 11:34:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF36184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676370939;
	bh=Jb/5D9CNBPsYmzXsESctFqxPLV4ldnW34RK779GuQ1s=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rRkeA2bkV5XEZvTUhuPzzYqrzs2QOkeVtWl2LR6zN0jm0rq7bM7usP7EqBkDArVom
	 zqU/R4pd/x4t0aB0O1Qf00oRdH4ipXfWwAfxYAFdoW/I5dVzEuYRCb2h3/cJnNQv9A
	 3FOrO9XWZxrF4KWIuzrpNTtG7A4Elo5ejH1i1lLc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10654F8052D;
	Tue, 14 Feb 2023 11:33:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81810F804B2; Tue, 14 Feb 2023 11:33:48 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CA92F800F0
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 11:33:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CA92F800F0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZWlT557p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676370823; x=1707906823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb/5D9CNBPsYmzXsESctFqxPLV4ldnW34RK779GuQ1s=;
  b=ZWlT557pCZmB2vzLorDX62LjkyifQZl1VjvQzD6sxs4RN7h2i+TR4HSB
   MHwPZmIJbBoUXnBVtMD3GunIXatMMV/DIjXcBk52nbMWm7o57ZRqFn3Iw
   exw+RrA4+fbF7FRNGl2yGWjHvprUIIXZL3MMDzT527GUf2ZQyX+o7heba
   XjNpd0Kh/DQHhCSWKd1FWowI49QBDmPeCG3lcRZsDmZyyLgXlAqzu/pnq
   +gukmp5B5FOATUNOZz7f2o5DPupmTb0gu1xwNw2SgBg5Jkzc75ICE0lvK
   zp+XpFvaCLomU2KOGcbVYbTk3CH593XQ+JVSdh/oslwcLSCoG8NI4lzNl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395745433"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000";
   d="scan'208";a="395745433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 02:33:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="811971908"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000";
   d="scan'208";a="811971908"
Received: from unknown (HELO pujfalus-desk.ger.corp.intel.com)
 ([10.252.18.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 02:33:39 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 3/5] ASoC: SOF: ipc4: Wake up dsp core before sending ipc msg
Date: Tue, 14 Feb 2023 12:33:43 +0200
Message-Id: <20230214103345.30669-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214103345.30669-1-peter.ujfalusi@linux.intel.com>
References: <20230214103345.30669-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LVUYEZPEUQGK2FOJ5BGBOIEBAL3KRYP2
X-Message-ID-Hash: LVUYEZPEUQGK2FOJ5BGBOIEBAL3KRYP2
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 rander.wang@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVUYEZPEUQGK2FOJ5BGBOIEBAL3KRYP2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Rander Wang <rander.wang@intel.com>

The driver shall update the power state to D0i0 before sending
a generic IPC. Power-related IPCs are the exception to the rule,
they may be sent even when the power-state is D0i3

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index b27ec16ebdfa..8ede4b952997 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -370,6 +370,17 @@ static int sof_ipc4_tx_msg(struct snd_sof_dev *sdev, void *msg_data, size_t msg_
 	if (!msg_data)
 		return -EINVAL;
 
+	if (!no_pm) {
+		const struct sof_dsp_power_state target_state = {
+			.state = SOF_DSP_PM_D0,
+		};
+
+		/* ensure the DSP is in D0i0 before sending a new IPC */
+		ret = snd_sof_dsp_set_power_state(sdev, &target_state);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Serialise IPC TX */
 	mutex_lock(&ipc->tx_mutex);
 
-- 
2.39.1

