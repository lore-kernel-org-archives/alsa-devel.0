Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C6ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 16:57:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 173D97037;
	Mon, 24 Oct 2022 18:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 173D97037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666630618;
	bh=ecwTYSJzfw8h4pBdyqNmwYRhL/nekFQRaP7eeAtO+bQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RPF8YjHbgn2dn2fgqO8DmhbPNQFPk9X8ZnuY954vutvlGskKtDeWXrMR82Gy1ZyOj
	 /buyWeBRP5rHNAkQwRCVkTr2+bf5e3zHxLOJqcJ5Yr1qfJzWTWoHAm6D8vkAy/Wak9
	 6Dv2M/6kxW3pqF/WDnN/7o5lki0kDRqKEnwUqU4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D9E4F805AB;
	Mon, 24 Oct 2022 18:53:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EBAFF8057E; Mon, 24 Oct 2022 18:53:41 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A513F8054A
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 18:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A513F8054A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hMvIlQTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666630412; x=1698166412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ecwTYSJzfw8h4pBdyqNmwYRhL/nekFQRaP7eeAtO+bQ=;
 b=hMvIlQTOVtlh9pWA1lT2fTsuCFSHkNZuKQ9fR2djRCserUVEfFmTWElH
 6CQ00PwDBmMTJWX8v76nnAKMkrOSR/ksNejnIWEaRVp0vzyD31Dq8TVaO
 +oJ8HFHmcxL/KN3MC0EWvAe6YxEQTl2TAyXHIPP7p5yaw8ijD8s+LrwbO
 UsjasDPaiDYqYbxDbsOvGaX31cA3QWLt9jCeB32kOruMxxgL5tzR/IwZb
 mBeCxQlogGQDlNsDXM+DTEATEytMw2cslFXZkj6YHZ8RZgr9slMf2Ksda
 iHmSM4oknQ8q5VcQPOPsZzOFHkvqPb5eniH61lPEkyR+flAHf9VszwTOa w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287868644"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="287868644"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609263064"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="609263064"
Received: from tdsilva-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.186.236])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:27 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/16] ASoC: SOF: Intel: hda-dai: remove useless members in
 hda_pipe_params
Date: Mon, 24 Oct 2022 11:53:02 -0500
Message-Id: <20221024165310.246183-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024165310.246183-1-pierre-louis.bossart@linux.intel.com>
References: <20221024165310.246183-1-pierre-louis.bossart@linux.intel.com>
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

Some settings were never or are no longer used, remove useless
definitions and assignments.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 2bce8dff4627a..6e368974abd16 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -32,11 +32,8 @@ MODULE_PARM_DESC(sof_use_tplg_nhlt, "SOF topology nhlt override");
 struct hda_pipe_params {
 	u32 ch;
 	u32 s_freq;
-	u32 s_fmt;
-	u8 linktype;
 	snd_pcm_format_t format;
 	int link_index;
-	int stream;
 	unsigned int link_bps;
 };
 
@@ -235,10 +232,8 @@ static int hda_link_dma_hw_params(struct snd_pcm_substream *substream,
 	/* set the hdac_stream in the codec dai */
 	snd_soc_dai_set_stream(codec_dai, hdac_stream(hext_stream), substream->stream);
 
-	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
 	p_params.s_freq = params_rate(params);
-	p_params.stream = substream->stream;
 	p_params.link_index = hlink->index;
 	p_params.format = params_format(params);
 
-- 
2.34.1

