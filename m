Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8F1C678D5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Mar 2023 11:08:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 187681435;
	Tue,  7 Mar 2023 12:07:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 187681435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678187318;
	bh=7Ky1O/caACXy8LBdqnHf3km20pzDVI4lNxvfWyZxDf4=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UEeciXKyP9Z4fhZ4scjJ4JVtLSZWW4suEz3VhTv4nT3/m5HNYFJDzD0zfTpjxO8A7
	 QpDwYDlQ4FyjYkyn+KGKnHbsmhwplCje/GkmVzkq/6Gh2FImaIfTRaSuvyyJ1mKVxe
	 0Et4vNpA2l6C5XPw1eEu6sOoFQ5lV9FiNrbfHHvA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DDA57F80431;
	Tue,  7 Mar 2023 12:07:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAD52F80529; Tue,  7 Mar 2023 12:07:36 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4EA16F8042F
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2023 12:07:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EA16F8042F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=F4QueJRm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678187255; x=1709723255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Ky1O/caACXy8LBdqnHf3km20pzDVI4lNxvfWyZxDf4=;
  b=F4QueJRmlWvLvBX3gjLmkxJUi/APwOdRIjTQIsc/mLY0S6xe8b3M4h+H
   /AmzHPbXwnYH5UoFRsu/tmk2m5eVWrJFoH/XFf+FYB1kaCEhSfIV4AI2D
   xMyFMyQcJPTyg2rCNeuTNPiRk8YMQeRMHf2Sy2Ai+zUtTiHJCUybSAFIY
   Yw/qA3rEsCqdFGnNOFLqNfCPbbW4s+t4GJuKKyHSpY6QMW2dBsOKA7HT8
   oQlBcmdcL4/g+McxGm6FktpUFgmMGSq3IixpvS4G+CXZgFxXAMU1hgzx4
   ttLR8CymDLrwJKE4vgue7g+Ctbj+1VdHFcWpjYgqZQqM79TrqQwotl/D4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333295440"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400";
   d="scan'208";a="333295440"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 03:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653942574"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400";
   d="scan'208";a="653942574"
Received: from rganesh-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.47.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 03:07:29 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Fix incorrect sample rate print
 unit
Date: Tue,  7 Mar 2023 13:07:51 +0200
Message-Id: <20230307110751.2053-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OUPGJY4TZTVGE322MTT56QR7RIBQKGQW
X-Message-ID-Hash: OUPGJY4TZTVGE322MTT56QR7RIBQKGQW
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 seppo.ingalsuo@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OUPGJY4TZTVGE322MTT56QR7RIBQKGQW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>

This patch fixes the sample rate print unit from KHz to Hz.
E.g. 48000KHz becomes 48000Hz.

Signed-off-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index b178e40d2f1f..cc641355ba31 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -155,7 +155,7 @@ static void sof_ipc4_dbg_audio_format(struct device *dev,
 	for (i = 0; i < num_format; i++, ptr = (u8 *)ptr + object_size) {
 		fmt = ptr;
 		dev_dbg(dev,
-			" #%d: %uKHz, %ubit (ch_map %#x ch_cfg %u interleaving_style %u fmt_cfg %#x)\n",
+			" #%d: %uHz, %ubit (ch_map %#x ch_cfg %u interleaving_style %u fmt_cfg %#x)\n",
 			i, fmt->sampling_frequency, fmt->bit_depth, fmt->ch_map,
 			fmt->ch_cfg, fmt->interleaving_style, fmt->fmt_cfg);
 	}
-- 
2.39.2

