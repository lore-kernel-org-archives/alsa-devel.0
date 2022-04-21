Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3D0C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 20:35:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EF3F1713;
	Thu, 21 Apr 2022 22:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EF3F1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650573357;
	bh=42doVDkzqH+3Ckk8toMQBpwdpz4CHxzmvIKuhandJ1E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDxRrJwGlfBfkCGg3SpKkRaL37elN26v6cQsOJ5Ycls2lCixSA6DHuU8yQ38YfHFT
	 spl2MswVo4KGgcVc+mIOp/Pc9pp7AikAGc405SFpiB6Y67easnQyNB01lsZp/8N/bT
	 mxp/jRn+BL9zidQYBGHz3a02VefxkrBfSt6ZBXO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42DF1F80549;
	Thu, 21 Apr 2022 22:33:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9051AF80508; Thu, 21 Apr 2022 22:32:59 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21A4DF804FD
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 22:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21A4DF804FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="CaQ5i1TH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650573166; x=1682109166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=42doVDkzqH+3Ckk8toMQBpwdpz4CHxzmvIKuhandJ1E=;
 b=CaQ5i1THqsFowUV+giJFOqXACoUUGwzF7ndx+hzbq2Heoafz3HkWabJ5
 KPAih9tCxq188L/vvjjiXQEAHGTz/1pqcw5Y+2bVinWNE3GQuoj9fKThs
 03C5fAl9JtyqdD6xHEAXd+I4sarIG5TPKoALp/QWzd0FpJaEv2g0ioBCY
 Y2aqUCxNkdaKaPMBDAEV1B1v+ArXnUwyhukr0Md6wgD9QAa3+bcBs4Vdq
 5hxR0M6WOJPDOZ9CVujkzWzup7cd3oVKdYTTCGNVtLa5JV8hFjkWEfyj8
 OdUMMh1hKW2zc7eNzm7WgZlT4xFcsD9+zMpGNWEgAeMrbUxr3p1U1lJtq A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245047623"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="245047623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 13:32:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="577455785"
Received: from qingsu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.148.250])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 13:32:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/14] ASoC: SOF: sof-audio: flag errors on pipeline teardown
Date: Thu, 21 Apr 2022 15:31:55 -0500
Message-Id: <20220421203201.1550328-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421203201.1550328-1-pierre-louis.bossart@linux.intel.com>
References: <20220421203201.1550328-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Rander Wang <rander.wang@intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

Before suspending, walk through all the widgets to make sure all
refcounts are zero. If not, the resume will not work and random errors
will be reported. Adding this paranoia check will help identify leaks
and broken sequences.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc3-topology.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 572bcbfdb3566..3d00d371fbf31 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2247,6 +2247,18 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 	list_for_each_entry(sroute, &sdev->route_list, list)
 		sroute->setup = false;
 
+	/*
+	 * before suspending, make sure the refcounts are all zeroed out. There's no way
+	 * to recover at this point but this will help root cause bad sequences leading to
+	 * more issues on resume
+	 */
+	list_for_each_entry(swidget, &sdev->widget_list, list) {
+		if (swidget->use_count != 0) {
+			dev_err(sdev->dev, "%s: widget %s is still in use: count %d\n",
+				__func__, swidget->widget->name, swidget->use_count);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.30.2

