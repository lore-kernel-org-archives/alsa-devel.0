Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08663C43334
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 13:51:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 260451702;
	Mon,  6 Jun 2022 15:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 260451702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654523492;
	bh=5g35255SQoFWTAPs7cDDInsD+K5S4XI3lK3qyCuevW4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qlEBT0sZvawLbdel6lN1hHen4rfp+1kZh8fv3uzZtBPSIZwII2mrtzfkEH+guLxAQ
	 cQeKLH7DzTyFKOMtcMKqiOmkGzXC1ymXLfuIXmsVEouL5EI9qzqzIWriM9AbMZxuOh
	 QS/KCDxH+qslyQqhS2xECckCO5hr0JsmRVltlKos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1122F80089;
	Mon,  6 Jun 2022 15:50:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBA32F80089; Mon,  6 Jun 2022 15:50:39 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8982F80109;
 Mon,  6 Jun 2022 15:50:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8982F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="WMjQ/v86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654523434; x=1686059434;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5g35255SQoFWTAPs7cDDInsD+K5S4XI3lK3qyCuevW4=;
 b=WMjQ/v86RmJdPImEnx3GdbsjpujV0bZ2AnYP4gRn9vYfTP4p4kGFYNps
 MZDwo5c84ieQmYUW85aweeiTA5s1Nl9cO1W68l4DytwYmJKxJesdbqmZk
 MRpFFTvd5+ce1rvxqoR6vet1lu70s+hu4D3EiONUfhP5pSbhEUGoyp086
 LYw3207x2DIbwfcYmBwlrHkk35naa0pessEI/holH5iugyvy/z98FNWv1
 n8Xu43c4dDLbiF4dGnmhRM4+yPDfld7hS3yuofy42cNKlmHIK/9D3IGVO
 Te9F9QFlZLeJ+kKPt2YljXjEsoxzHnRhPasNNJV5xzEzUfhbemm0YfGs8 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258994101"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="258994101"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 06:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="682253918"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2022 06:50:26 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ASoC: SOF: Fix potential NULL pointer dereference
Date: Mon,  6 Jun 2022 15:49:26 +0200
Message-Id: <20220606134926.3725806-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Cleanup path for sof_prepare_widgets_in_path() should check if unprepare
callback exists before calling it, instead it checks if it does not
exist. Fix the check.

Fixes: 66344c6d9211 ("ASoC: SOF: Add a prepare op to IPC topology widget ops")
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

---

v2 : Fix Fixes hash, apparently I looked at wrong tree

---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 8d740635a4bb..28976098a89e 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -318,7 +318,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
 			p->walking = false;
 			if (ret < 0) {
 				/* unprepare the source widget */
-				if (!widget_ops[widget->id].ipc_unprepare && swidget->prepared) {
+				if (widget_ops[widget->id].ipc_unprepare && swidget->prepared) {
 					widget_ops[widget->id].ipc_unprepare(swidget);
 					swidget->prepared = false;
 				}
-- 
2.25.1

