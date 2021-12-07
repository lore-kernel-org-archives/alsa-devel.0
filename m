Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F0EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Dec 2021 19:41:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F8FB2515;
	Tue,  7 Dec 2021 20:40:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F8FB2515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638906108;
	bh=IhC/HNInnSAVjYhguHZ5uijLK5KwkEhhKT1MJHyzd0w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bcOB7i0D3KfYagMiSlUJ88bb0UWaBBcSizZkGM9M5xUiFAiM93tN6ph8RMbqP896a
	 5Ezh6Uj4v3TSS9hmE75EoGQNLn/JX9PWFP2LfNvM92EUArrlDpdDUonqpdaDlTqGnF
	 KH6snZvKCmuuMlw2mmHNY1kQQKVhF48GY61fLo8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB469F804FD;
	Tue,  7 Dec 2021 20:40:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE05EF804FE; Tue,  7 Dec 2021 20:40:23 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12BC9F80259
 for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2021 20:40:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12BC9F80259
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="236407809"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="236407809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 11:40:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="479641159"
Received: from nthiag2-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.74.17])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 11:40:09 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/7] ASoC: SOF: Intel: hda-ctrl: apply symmetry for DPIB
Date: Tue,  7 Dec 2021 13:39:43 -0600
Message-Id: <20211207193947.71080-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207193947.71080-1-pierre-louis.bossart@linux.intel.com>
References: <20211207193947.71080-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

we use 'bus->use_posbuf && bus->posbuf.addr' in
hda_dsp_ctrl_init_chip(), use the same for hda_dsp_ctrl_stop_chip()

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index fa5f0a718901..0c29bb196e59 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -353,7 +353,7 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev)
 	snd_hdac_bus_stop_cmd_io(bus);
 #endif
 	/* disable position buffer */
-	if (bus->posbuf.addr) {
+	if (bus->use_posbuf && bus->posbuf.addr) {
 		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
 				  SOF_HDA_ADSP_DPLBASE, 0);
 		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
-- 
2.25.1

