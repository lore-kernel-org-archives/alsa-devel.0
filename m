Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF2CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Dec 2021 23:18:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F10A2024;
	Fri, 17 Dec 2021 00:17:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F10A2024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639696711;
	bh=Bua+u+SfEmFCRRGpff3oU6RSHFYxl0mIqnjxsSMN1vs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meoVCsZ3P0EdcK6EhA1iby8VXILAjfHUQEMDNssmoEq5yHCJ/1G7rod4IRmy1awLK
	 9MHkkXtoLLZu3iG1S/UEt1Ks8eV6rfjACpq98OZn4lialAwzIUtYae5Ez+u33UapFa
	 +wuPiWpFRsaUlmrUlxIaq/GWRA46tj3ds+P5UaHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 632DBF802A0;
	Fri, 17 Dec 2021 00:16:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21285F8030F; Fri, 17 Dec 2021 00:16:56 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55CDDF80165
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 00:16:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55CDDF80165
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219641678"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; d="scan'208";a="219641678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 15:16:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; d="scan'208";a="756279937"
Received: from priyosmi-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.100.174])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 15:16:38 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: SOF: Intel: hda: remove support for RESUME in
 platform trigger
Date: Thu, 16 Dec 2021 17:16:28 -0600
Message-Id: <20211216231628.344687-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216231628.344687-1-pierre-louis.bossart@linux.intel.com>
References: <20211216231628.344687-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Kai Vehmanen <kai.vehmanen@intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

The SOF driver removed the support for INFO_RESUME in the commit
"ASoC: SOF: pcm: do not add SNDRV_PCM_INFO_RESUME to runtime hw info".
And resuming is handled by the ALSA core with the .prepare and
.trigger_start stages. So, remove handling of RESUME trigger in the
component driver trigger op. So, remove handling the RESUME trigger in
the platform trigger op for HDA platforms.

Reviewed-by: Kai Vehmanen <kai.vehmanen@intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index e910f68706d9..ba60807fbd8f 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -329,7 +329,6 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 
 	/* cmd must be for audio stream */
 	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_START:
 		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
-- 
2.25.1

