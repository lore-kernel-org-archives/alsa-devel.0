Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FA4C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 17:21:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C306318F6;
	Tue, 26 Apr 2022 19:20:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C306318F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650993694;
	bh=B5PwXBEF3UCeQmBS2cVdj1s/2JK/Ad8Y53QUO2OkjJw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFr0NqnZgZiVH8j4TFtPwdC7yFqmWS8KClLGWcC2BNe4LgrO/HtYMlWOZlOXiDLDn
	 jmyKoGdWoMJBzM7qHV4iQGkjPTklsh+4TuklQmZrcDR0T45xMJEBdgUHlBCIQWa+jZ
	 FLUkKobIBKK0aqV/OOv+PMC30F3k6KGkiIrs6ebA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FE07F80534;
	Tue, 26 Apr 2022 19:18:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1774F80538; Tue, 26 Apr 2022 19:18:04 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99EF0F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 19:17:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99EF0F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="RRukzlTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650993479; x=1682529479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B5PwXBEF3UCeQmBS2cVdj1s/2JK/Ad8Y53QUO2OkjJw=;
 b=RRukzlTSTViAeFQFs9fR5eNy5wxr7hnldiW/GDkYnxyRtw0MIy+oOCbu
 9FmIHo4r/pyHS7/2VP8w77mtTgH273BHLY9KQ+vudFnYsldzj9ykePgtx
 DKD1qJZwm5wZZa+ahHpelHU35IUjjNrrm9oAuHI/Q/h+wYRrbz0siMtcc
 ynCpnKtNXvyPI42igpO4l5xPO4qVEb1jwXIsvi2bOKGCLOpxootm4mrNr
 zrMuHslWjZ6AyI5EuI58PKNgE57ZoliTHxIRwwyG79nOOP0z+KjDGw3Tj
 4xx/5VQoPuMEpREBb12nT2luE434bI9TiYfysnVtyTgvvtE03I1wq+yNU w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290807969"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="290807969"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 10:17:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="558431197"
Received: from shashinx-mobl.gar.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.0.53])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 10:17:49 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/11] ASoC: SOF: expose a couple of functions
Date: Tue, 26 Apr 2022 10:17:37 -0700
Message-Id: <20220426171743.171061-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426171743.171061-1-ranjani.sridharan@linux.intel.com>
References: <20220426171743.171061-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

Expose the mixer_to_ipc() and ipc_to_mixer() functions for reuse in
IPC4.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc3-control.c | 20 --------------------
 sound/soc/sof/sof-audio.h    | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index bea26e73a741..4347adcc6543 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -90,26 +90,6 @@ static int sof_ipc3_set_get_kcontrol_data(struct snd_sof_control *scontrol, bool
 	return iops->set_get_data(sdev, cdata, cdata->rhdr.hdr.size, set);
 }
 
-static inline u32 mixer_to_ipc(unsigned int value, u32 *volume_map, int size)
-{
-	if (value >= size)
-		return volume_map[size - 1];
-
-	return volume_map[value];
-}
-
-static inline u32 ipc_to_mixer(u32 value, u32 *volume_map, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++) {
-		if (volume_map[i] >= value)
-			return i;
-	}
-
-	return i - 1;
-}
-
 static void snd_sof_refresh_control(struct snd_sof_control *scontrol)
 {
 	struct sof_ipc_ctrl_data *cdata = scontrol->ipc_control_data;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index eb882ed7d0e4..e3cfc813975b 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -48,6 +48,26 @@ enum sof_widget_op {
 
 #define SOF_TLV_ITEMS 3
 
+static inline u32 mixer_to_ipc(unsigned int value, u32 *volume_map, int size)
+{
+	if (value >= size)
+		return volume_map[size - 1];
+
+	return volume_map[value];
+}
+
+static inline u32 ipc_to_mixer(u32 value, u32 *volume_map, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (volume_map[i] >= value)
+			return i;
+	}
+
+	return i - 1;
+}
+
 struct snd_sof_widget;
 struct snd_sof_route;
 struct snd_sof_control;
-- 
2.25.1

