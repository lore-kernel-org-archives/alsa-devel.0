Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2DC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:20:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729A72065D
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DlqDZGCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729A72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D91541698;
	Tue,  7 Jul 2020 21:20:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D91541698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594149654;
	bh=0J4FVQOVmVbTaQI3tfvU4gnwO3hxp0S86enH1E72diM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DlqDZGCrTD8vgJHQhGEsTA0a6ZDDt40u9vh0CtDZzVKvifJB9FHAJ8x7ET6zNf8Fs
	 C655wdXWoZlYNDT1mxRXZCUNNLSl9IRZR794qBWuQVuC+PQfbRxgtXWH0hFEgizQ3g
	 4mH/DGf0QoIB5CSf4g281BCgCnd7MpyavB7cfSzo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 656E5F802EC;
	Tue,  7 Jul 2020 21:16:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7472F802DD; Tue,  7 Jul 2020 21:16:48 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D49CF800D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D49CF800D0
IronPort-SDR: w6nKnApDTqSHIJkTHa9GwJlR+khF1J2z5sJABU+y+P6sF+qfVvzcgoJF9677kK3KU6DZnV9eE4
 R+umcb5gO2Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147690700"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="147690700"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:40 -0700
IronPort-SDR: /suSIlxaokPqR671iiUxFN6GYWeFBnGgoSr6SrYAdcFMWA592cksoAJz+aA+siuLWXuDPD6XE0
 pqmOvKGkbfZg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="388601639"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:39 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 06/10] ASoC: sti: uniperif: fix 'defined by not used'
 warning
Date: Tue,  7 Jul 2020 14:16:11 -0500
Message-Id: <20200707191615.98296-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Lee Jones <lee.jones@linaro.org>
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

Fix W=1 warning. The table uni_tdm_hw is declared in a header included
by multiple C file. This isn't really a good practice but for now
using __maybe_unused makes the following warning go away.

sound/soc/sti/sti_uniperif.c:12:
sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but
not used [-Wunused-const-variable=]
 1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
      |                                      ^~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sti/uniperif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2dc2da5d458b..a16adeb7c1e9 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
-static const struct snd_pcm_hardware uni_tdm_hw = {
+static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID,
-- 
2.25.1

