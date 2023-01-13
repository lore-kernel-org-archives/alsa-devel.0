Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DA3C54EBE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 16:19:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F8F065F9;
	Fri, 13 Jan 2023 17:18:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F8F065F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673626785;
	bh=riUTuc7sHJ+/+4lkWQSnkn1MW6HWbm771+vzimqcx1c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=E/wrggIzgBhP4X0vd08OGSSCXYK1RXZLwYXuih6enwJARUun4VsO0jgFqzCT4j4Nr
	 KjaIJIgFSwABrURJG9TCecF6g7f4dhCRAcCnVWeXqUSoWPp4nrrbU5U4ya1mfDd4x8
	 kkLMi1YeNWyHWhX/oc3f8V2WKSe1THt0/n8rncUU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E81C4F803DC;
	Fri, 13 Jan 2023 17:18:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20EF9F803DC; Fri, 13 Jan 2023 17:18:53 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3CEAF803DC
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 17:18:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3CEAF803DC
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FTArcZEt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673626731; x=1705162731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=riUTuc7sHJ+/+4lkWQSnkn1MW6HWbm771+vzimqcx1c=;
 b=FTArcZEtZZmsrh/HlMw2aodT94z6huX/A3JI/rMEY8G5193hlWD2sljC
 duhrV1rELdaTywc0J0fq2uhH2lebxyaTgbOa5fhFFrTVYJGKTahus2vOY
 P9Dx0mywOubwURPO9e8oy5VdVNCpfn6iHogJGVQpNj/1mJjAuzjogF+sO
 PIAUVA4uS0mnqxDql35YSH6beQ5Z29p3i5szCgjx28MMKchs1dGlEUX3B
 kGJyufZAuUNrJQvHyXn+i9CMvmO/v6fLMbExi9DgdnEjKgm35C5SCg6ys
 xL0V/x2XnozXIfAynsguQEKBRFsc31gxcrfHqCj8wrWwF0RdDPidE/A/I Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324087569"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; d="scan'208";a="324087569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 08:18:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="690547420"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; d="scan'208";a="690547420"
Received: from rjmaskel-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.27.128])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 08:18:42 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 1/3] ASoC: SOF: sof-audio: Unprepare when swidget->use_count >
 0
Date: Fri, 13 Jan 2023 18:18:40 +0200
Message-Id: <20230113161842.22059-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113161842.22059-1-peter.ujfalusi@linux.intel.com>
References: <20230113161842.22059-1-peter.ujfalusi@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 angelogioacchino.delregno@collabora.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We should unprepare the widget if its use_count = 1.

Fixes: 9862dcf70245 ("ASoC: SOF: don't unprepare widget used other pipelines")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e1ab8380e7d8..068501ed7951 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -274,7 +274,7 @@ sof_unprepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widg
 	struct snd_soc_dapm_path *p;
 
 	/* return if the widget is in use or if it is already unprepared */
-	if (!swidget->prepared || swidget->use_count > 1)
+	if (!swidget->prepared || swidget->use_count > 0)
 		return;
 
 	widget_ops = tplg_ops ? tplg_ops->widget : NULL;
-- 
2.39.0

