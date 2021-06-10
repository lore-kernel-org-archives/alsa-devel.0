Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F67C48BDF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7E06135C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7E06135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 304E417E4;
	Thu, 10 Jun 2021 22:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 304E417E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623358619;
	bh=5eNa5kU9nCmfgnI7D+LCESTceHRFJ0/G9yq86FMXnJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZaDmK6DVmoj/uKjKdBib9WQFkw2pcyz/9FWs/QGNy00jqkHiusLLnFO6pgSmVANra
	 fk2IoWSEsDHlyQXojbo6JK8DeQsAbuyP8/qC6ptcjmj5KEofvqBuW9eEvte2MVKEzY
	 Bm1auWoq3cK6dIVqGS7ruXvuxmRRnUPbdNeiJGaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F91BF804D8;
	Thu, 10 Jun 2021 22:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C6A0F804CC; Thu, 10 Jun 2021 22:54:11 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE804F80256
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 22:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE804F80256
IronPort-SDR: IuOd5YGjRXRn9XiCbW8KMSlRArJvrDasaaGuCa5VkXK3tDUKzZvWv0fiB6Fn6vxcySXy+3fG2l
 vzGS/kaiGb9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="226812421"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="226812421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:52 -0700
IronPort-SDR: qUoOJ5jtluiz2jtFhgMMd+80mGtjereWZDYaxQhPO1NGEJ3kDY1z266BXuj5Uc/XZ6jTHkvQ0R
 XwMO6reOtCPQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="620183635"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.170.65])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/8] ASoC: SOF: Intel: enable DMI L1 when pause is not
 supported
Date: Thu, 10 Jun 2021 15:53:23 -0500
Message-Id: <20210610205326.1176400-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
References: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
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

DMI L1 entry is incompatible with pause on a capture stream, so if
pause is not supported we can enable DMI L1 unconditionally.

Experimental results show an increased residency in higher C states
and a significant decrease of system power consumption for "work from
home" usages such as VoIP calls.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-pcm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 47ff2c757d0a..aaa7686c00ee 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -221,6 +221,7 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		     struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_component *scomp = sdev->component;
 	struct hdac_ext_stream *dsp_stream;
 	struct snd_sof_pcm *spcm;
@@ -233,7 +234,13 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		return -EINVAL;
 	}
 
-	/* All playback and D0i3 compatible streams are DMI L1 capable */
+	/*
+	 * All playback and D0i3 compatible streams are DMI L1 capable, others need
+	 * pause push/release to be disabled
+	 */
+	if (!(runtime->hw.info & SNDRV_PCM_INFO_PAUSE))
+		hda_always_enable_dmi_l1 = true;
+
 	if (hda_always_enable_dmi_l1 ||
 	    direction == SNDRV_PCM_STREAM_PLAYBACK ||
 	    spcm->stream[substream->stream].d0i3_compatible)
-- 
2.25.1

