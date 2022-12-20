Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C02AC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Dec 2022 12:58:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C74FF1F9B;
	Tue, 20 Dec 2022 13:57:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C74FF1F9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671541096;
	bh=5BI/6+kTZ4fuF2ycWHghLM+X5bYBZ3gOLwrTcMmfyII=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vVG0bPiuKALBbRhCQYo59DWNIMSyrqtv02/OdSZddUV/3pFO8EpNE5+EYs3yXtl5N
	 l/rnCiFPUjNm7iDaCOzohRi/8k4kwXr5abJUHyxQk+Jmi7voEDUv0CVRtZAv30FnT3
	 oPOJm2tKiDm3H810Cav+br3P5Eg2iA09ycqPfzSM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31BB3F80544;
	Tue, 20 Dec 2022 13:56:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1517F8032B; Tue, 20 Dec 2022 13:56:55 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 380F9F8032B
 for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2022 13:56:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 380F9F8032B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fMyh4z9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671541014; x=1703077014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5BI/6+kTZ4fuF2ycWHghLM+X5bYBZ3gOLwrTcMmfyII=;
 b=fMyh4z9Q33gNWURIaOFzUlVnjpqOhTRh+9DHbNwwdtfkx1h3w9zbJXvU
 LQ3re1H1tP8iKsK1wHHs7ab63ng59VkkjIurSbME7YiJ5VUOyukcP43vz
 kAIq47VE3gz6r9KKNF8Nlu21ot5RfF5GtnpVDsE4pqR5PyOmWpafTpq6u
 nDQmIkZurM8WGOPpNf5cS4bRMtOMgbbpGiR/nw2E2xCDU8hb2b+SNjlLI
 I1YNCKHI6IK9MRFSONG6z3x3odV5WuESDzEZkQOSVHEh7yRtSqmJJOSN3
 akeo2mKGBpNj/Jptu6Oz1QbJepSlXwLDFFHHg5zpHOCEZwRAUyJdAj8IM Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299280504"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; d="scan'208";a="299280504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2022 04:56:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="825222255"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; d="scan'208";a="825222255"
Received: from vadimbel-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.20.205])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2022 04:56:29 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH v2 3/3] ASoC: SOF: Add FW state to debugfs
Date: Tue, 20 Dec 2022 14:56:29 +0200
Message-Id: <20221220125629.8469-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220125629.8469-1-peter.ujfalusi@linux.intel.com>
References: <20221220125629.8469-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Curtis Malainey <cujomalainey@chromium.org>

Allow system health detection mechanisms to check the FW state, this
will allow them to check if the FW is in its "crashed" state going
forward to help automatically diagnose driver state.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index d9a3ce7b69e1..ade0507328af 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -353,7 +353,9 @@ int snd_sof_dbg_init(struct snd_sof_dev *sdev)
 			return err;
 	}
 
-	return 0;
+	return snd_sof_debugfs_buf_item(sdev, &sdev->fw_state,
+					sizeof(sdev->fw_state),
+					"fw_state", 0444);
 }
 EXPORT_SYMBOL_GPL(snd_sof_dbg_init);
 
-- 
2.39.0

