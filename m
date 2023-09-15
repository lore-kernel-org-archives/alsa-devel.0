Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC6EE6459
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 11:42:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5A27886;
	Fri, 15 Sep 2023 13:41:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5A27886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694778144;
	bh=cV7AHlontMovqDlnpniU2t4nIcmYa9dc2wIMkhwQasI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gzo8IkmfkQ7tButz3QqA/fWr4z8vXqx6B2uvfbpxQkARfiTVJ5kLZsNwydagCCGea
	 NA3VNm14uffd2tWa+f7l21mMittrujPubIPoS7QiJ8btDH8WWvJqu1JPTSAeK590Vu
	 GG5T3j+XUkhBzQEk25uj8Jo+78QdWM8IZgzj8+6A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 621AAF805B6; Fri, 15 Sep 2023 13:40:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DF0A9F805B1;
	Fri, 15 Sep 2023 13:40:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BB9EF805BB; Fri, 15 Sep 2023 13:40:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3CCD9F80425
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 13:40:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CCD9F80425
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=neBsl/nP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694778029; x=1726314029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cV7AHlontMovqDlnpniU2t4nIcmYa9dc2wIMkhwQasI=;
  b=neBsl/nPr2dTcpnogEOkqJJ2uEzW4TohNBky/syEK8+oOAvVyT0N7ZzG
   oFNQnLuzbh8R5DJFbbkH/uje1d1yfcFr+9JBa9NqXufd0qcWo6vO33BsP
   kvNP4pEy4uh5PNCl6gUowb57bJu0mbtFt2lz+zHR4ZVLKWZabs2++yiUn
   SgIJgUXWSgW3CQDQ4miYE+pmVMJqHTI/uCjfdxJinsQllD2gqOOm9XBiL
   YmqQ59YUDx69j4YCSZBxo2NutnoQ1s2GHx/5sfb9Jri+9L9hiUN98ix0u
   DDwUoMpGzEzk51DlXZScheBlj78HjPeWN5anR75cLKfgblrPob8ehZAu2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358642920"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="358642920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 04:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="721652890"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="721652890"
Received: from brhacker-mobl26.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.48.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 04:40:18 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	guennadi.liakhovetski@linux.intel.com,
	chao.song@linux.intel.com
Subject: [PATCH 2/4] ASoC: SOF: Intel: hda: Add definition for SDxFIFOS.FIFOS
 mask
Date: Fri, 15 Sep 2023 14:40:16 +0300
Message-ID: <20230915114018.1701-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230915114018.1701-1-peter.ujfalusi@linux.intel.com>
References: <20230915114018.1701-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TBTHTLWRKKWCJ47MH7BGK7KDM6XNYYTE
X-Message-ID-Hash: TBTHTLWRKKWCJ47MH7BGK7KDM6XNYYTE
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TBTHTLWRKKWCJ47MH7BGK7KDM6XNYYTE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The FIFOS (FIFO Size) field is in bit 0-15 of the register.
Use the defined mask instead of a magic number for the FIFOS value
masking in hda_dsp_stream_hw_params().

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 2 +-
 sound/soc/sof/intel/hda.h        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 0b0087abcc50..65e9242365be 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -668,7 +668,7 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 			snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR,
 					 sd_offset +
 					 SOF_HDA_ADSP_REG_SD_FIFOSIZE);
-		hstream->fifo_size &= 0xffff;
+		hstream->fifo_size &= SOF_HDA_SD_FIFOSIZE_FIFOS_MASK;
 		hstream->fifo_size += 1;
 	} else {
 		hstream->fifo_size = 0;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 5c517ec57d4a..2b228c63905b 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -135,6 +135,9 @@
 #define SOF_HDA_ADSP_REG_SD_BDLPU		0x1C
 #define SOF_HDA_ADSP_SD_ENTRY_SIZE		0x20
 
+/* SDxFIFOS FIFOS */
+#define SOF_HDA_SD_FIFOSIZE_FIFOS_MASK		GENMASK(15, 0)
+
 /* CL: Software Position Based FIFO Capability Registers */
 #define SOF_DSP_REG_CL_SPBFIFO \
 	(SOF_HDA_ADSP_LOADER_BASE + 0x20)
-- 
2.42.0

