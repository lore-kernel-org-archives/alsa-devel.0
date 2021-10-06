Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBACC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:12:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5505C61131
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5505C61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01CEF1687;
	Wed,  6 Oct 2021 13:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01CEF1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518767;
	bh=vggdXMcuMX3b/vlk2ujCxXCsHpAhP0XtnMde2X5J0wU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hs3HhRD6XmmlXcgzgJptoRs0JHA2Jotb4yJUcLiWw2OWkrXtm4KgA0K0EkrxY6bpx
	 jZ72l6Smi/viCDFtaLhqudGOqNfDqlEabsqV7fFRVCOdykgx6xcQ/A5/h8xWjT2oHE
	 QwO40eF2idYAkllekl6psMIvyzIZrVjCwcb7vYhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38F11F80557;
	Wed,  6 Oct 2021 13:07:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E638CF800FE; Wed,  6 Oct 2021 13:07:31 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38048F800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38048F800FE
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223366440"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="223366440"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="439081020"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:06:51 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 05/19] ASoC: SOF: loader: Print the DSP dump if boot fails
Date: Wed,  6 Oct 2021 14:06:31 +0300
Message-Id: <20211006110645.26679-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

It can be useful to print the DSP dump from the core in case the DSP boot
failed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 6a3bc1927627..144b72bf8190 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -819,7 +819,9 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 	/* boot the firmware on the DSP */
 	ret = snd_sof_dsp_run(sdev);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to reset DSP\n");
+		dev_err(sdev->dev, "error: failed to start DSP\n");
+		snd_sof_dsp_dbg_dump(sdev, SOF_DBG_DUMP_REGS | SOF_DBG_DUMP_MBOX |
+				     SOF_DBG_DUMP_PCI | SOF_DBG_DUMP_FORCE_ERR_LEVEL);
 		return ret;
 	}
 
-- 
2.33.0

