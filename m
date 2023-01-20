Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F359C05027
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Jan 2023 10:22:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3132D3069;
	Fri, 20 Jan 2023 11:21:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3132D3069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674210140;
	bh=5yxAqjfiGWhzAaV5tb1/aoh4K/2VFkiTET4f2w0RHIU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=CLN91bP1xyU/LuNP1FcHXi4VK3rvpgXy0SFfAAL1dxq5I0wi+Xjn7/ly/WJ/s+LfS
	 ySrIVbjN7eqMoEjcQ06WyMyG+CNn39RyAqDlUkkQ0nksQuIjLpJ52tH79BD+8fNHx7
	 wMLUmfSb8b9FoU3O2fnW0clJGYu7Ma3rqZBvKqQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9702F8024C;
	Fri, 20 Jan 2023 11:21:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCEBFF80246; Fri, 20 Jan 2023 11:21:28 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9500DF80246
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2023 11:21:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9500DF80246
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jTLEWGcF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674210086; x=1705746086;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5yxAqjfiGWhzAaV5tb1/aoh4K/2VFkiTET4f2w0RHIU=;
 b=jTLEWGcFRjC/bY9UEUek5Sl9n6g7OhvrWXIkwKmw+ChRGKMyZ8be71rf
 Ev/dNKWpW1GMhHrO5Tw++lKxNwKirnEXSAGjfuiMpgw3IAgfLwZ8qqZuS
 8X/D4CUtv+V39FswKlsTaKlTnDkcLK0eSUQPRuXWNSr+XX7JYAa3qILiA
 wKhb7al6yGrixRjrludOYvY2gDesrC4KN+L4S3cBy7uaEEkAopuFLIaMt
 DFqQKt/zdVBbFQWzLvlPcj2N3QzKACdcLLlvclVMFxNWstGGreqSxNQQl
 koWifQC1TVc3eZzfJ/Gz+gzVO741SsUz1M02K4J9AkslrwH8Ou/EsxxYB w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326827430"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; d="scan'208";a="326827430"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2023 02:21:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="723906651"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; d="scan'208";a="723906651"
Received: from karenodx-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.29.156])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2023 02:21:19 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: sof-audio: prepare_widgets: Check swidget for NULL
 on sink failure
Date: Fri, 20 Jan 2023 12:21:25 +0200
Message-Id: <20230120102125.30653-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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
Cc: alsa-devel@alsa-project.org, error27@gmail.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, linux-mm@kvack.org,
 oe-kbuild-all@lists.linux.dev, angelogioacchino.delregno@collabora.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

If the swidget is NULL we skip the preparing of the widget and jump to
handle the sink path of the widget.
If the prepare fails in this case we would undo the prepare but the swidget
is NULL (we skipped the prepare for the widget).

To avoid NULL pointer dereference in this case we must check swidget
against NULL pointer once again.


Fixes: 0ad84b11f2f8 ("ASoC: SOF: sof-audio: skip prepare/unprepare if swidget is NULL")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index f17d405a9da9..2dff3ae25d27 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -334,7 +334,8 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
 			p->walking = false;
 			if (ret < 0) {
 				/* unprepare the source widget */
-				if (widget_ops[widget->id].ipc_unprepare && swidget->prepared) {
+				if (widget_ops[widget->id].ipc_unprepare &&
+				    swidget && swidget->prepared) {
 					widget_ops[widget->id].ipc_unprepare(swidget);
 					swidget->prepared = false;
 				}
-- 
2.39.0

