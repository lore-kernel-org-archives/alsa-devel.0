Return-Path: <SRS0=odsy=EP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E600C5517A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:11:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD94B206CB
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kq9GLbCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94B206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A36D844;
	Mon,  9 Nov 2020 22:10:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A36D844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604956268;
	bh=2PFQhqRqq3zp9ZjhDYc6iEnDWLtbHTD/+WUlvCBjCZs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kq9GLbCV+78Fksgx+GAuMlYzYSbrVSj8oJN5XlorQed7xGoB6GYg0MoLfWYn4trMM
	 W9d338UYDVBw27DVqwpvlqEkt2GMRjrR+GiDdMLkYTXVvXFtAo54tXsiWp5yR4Bcfz
	 F9qvjd5qvVRB+v5Y0fxOq+EqBdG5PsZoUE+z4pTQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98DDBF800BA;
	Mon,  9 Nov 2020 22:10:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA431F8020C; Mon,  9 Nov 2020 22:10:16 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72DB1F800BA
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2020 22:10:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72DB1F800BA
IronPort-SDR: aXy2ojnpr3shLb0SoeCz1PVF3DKadrKpXpOi1ljbYl+Bs9DQUsK9cl2QqRC5c7S6HPswj3LKTB
 6EM6mYtl6JsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="169087538"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; d="scan'208";a="169087538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 13:10:04 -0800
IronPort-SDR: iv4hMx76HayE5tM/GIO3TmS1v4jqz150h1MMVV55Abt/e+DmlTIAfoJsPBHL7jYsGTxuA4GDXy
 tg4hzapcWTDw==
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; d="scan'208";a="322585237"
Received: from xvera-mobl.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.209.52.116])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 13:10:03 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Boards: tgl_max98373: add dpcm_capture flag for
 speaker_smart_amp
Date: Mon,  9 Nov 2020 13:09:58 -0800
Message-Id: <20201109210958.84198-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dharageswari R <dharageswari.r@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Dharageswari R <dharageswari.r@intel.com>

Smart_amp_speaker device has the playback stream and capture stream
associated to it. Hence add the dpcm_capture = 1 flag while dailink
creation.
This patches fixes:
ERR kernel [timestamp] SSP1-Codec: ASoC: no backend capture stream

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index e7d9a82ca70d..891f908659f5 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -734,6 +734,8 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 			links[id].num_codecs = ARRAY_SIZE(max_98373_components);
 			links[id].init = max98373_spk_codec_init;
 			links[id].ops = &max_98373_ops;
+			/* feedback stream */
+			links[id].dpcm_capture = 1;
 		} else if (sof_rt5682_quirk &
 				SOF_MAX98360A_SPEAKER_AMP_PRESENT) {
 			links[id].codecs = max98360a_component;
-- 
2.25.1

