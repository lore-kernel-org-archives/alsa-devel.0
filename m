Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA078C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 22:07:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00FC11AEE;
	Fri, 17 Jun 2022 00:06:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00FC11AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655417263;
	bh=HodmLaeije9RtxZHyILx5m7Ze8bov7hZMNKhqP0nbhw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdH7BAWlaCeLCqltdYt6y23UXB+P6T39za0TaDWnBThd0wOo39IMmKGGmmOfGR5Uo
	 70+uk8E1cLraBx3pHyuiZtgGrncBLrQSz7SSzrZijSQX/VJ5JD1lrAZizwrj5AZRAA
	 20V/MAFvQgzi0ulgXY+p/3+NBhIOf2CLSbmFlIWg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BD57F80557;
	Fri, 17 Jun 2022 00:04:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6ED7BF8053E; Fri, 17 Jun 2022 00:04:54 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DEFDF80528
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 00:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DEFDF80528
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Oq0eMQfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655417087; x=1686953087;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HodmLaeije9RtxZHyILx5m7Ze8bov7hZMNKhqP0nbhw=;
 b=Oq0eMQfYUl0MrGlFv5+JfRWac+GE3M6WeqxZD+2+CmwdD6CsliLsa/mr
 EyDxnDa2CesNCxZW24DZ/53LUze8CtSGXvvvCqOaMBV9Bhp+HcTEcd95o
 oT5QbtxKjd1UybGXD7dBvNeRc5l+SCafLumS70anrSBP7Pl6sVbJL/jLt
 m7TJbGOB2dWfvIxtv9LfOv5ue7XEdc3oIUm5q9ewnbZ0wGzcrga9wOjqD
 OAlHrdlRsnzb/V/6vsVs9FIXmOw9lVN3wb5/d7yLwXfII37GcHEN4mfU0
 Xc5ZBiX4VMEQmFCWOk3cSVRbaz6H1z7Lfw2CPhITvtG1/T8pkQ4JyEoli Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304810933"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="304810933"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="728084999"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:43 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/11] ASoC: wsa881x: use pm_runtime_resume_and_get()
Date: Thu, 16 Jun 2022 17:04:21 -0500
Message-Id: <20220616220427.136036-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

simplify the flow. No functionality change, except that on -EACCESS
the reference count will be decreased.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/wsa881x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index f3a56f3ce4871..dc954b85a9881 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -749,11 +749,9 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 	unsigned int mask = (1 << fls(max)) - 1;
 	int val, ret, min_gain, max_gain;
 
-	ret = pm_runtime_get_sync(comp->dev);
-	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_put_noidle(comp->dev);
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret < 0 && ret != -EACCES)
 		return ret;
-	}
 
 	max_gain = (max - ucontrol->value.integer.value[0]) & mask;
 	/*
-- 
2.34.1

