Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55974C71155
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 19:35:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7642075A
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 19:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7642075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C71D4177F;
	Wed,  2 Dec 2020 20:34:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C71D4177F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606937696;
	bh=TZnsTmHi5IFcCU6Ky6WBEdNl1oN50y6Ely/z3gWEcc4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L3wPWZkYukHw/FVC2P/7vIS155MSy6XNjBzNNGIv7SKEbnPSegjXE3Vx7M0EkqnJy
	 GWX6fOIL0P2cgWOinccTGEpJ/NFM3aA3v2qE+aLNvikh+K99nN95n+Lu0OsVV+Lr1k
	 FWIpUu2rfSkowWdWlwm6KbxbS+4RtBw4fWBlUoJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44FF9F8025F;
	Wed,  2 Dec 2020 20:34:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D7E4F8026B; Wed,  2 Dec 2020 20:34:05 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4441F80168
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 20:33:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4441F80168
IronPort-SDR: f5fsmEGWLwjXugXYNiCzr1jvXglsic/DK9qCXDWOYuqfg8RCvBeK8vNHwlATu1P733iI6iWaxJ
 xk7QhHB0knrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="172293920"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="172293920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 11:33:50 -0800
IronPort-SDR: gnoVE8NeXxQYw4LIyhNUuFQn6kMGfD9kXO0dceEFW47MEGb+jDYQuxaBXptDdLLJqf4oQGt9N0
 IylW2OzhVOOg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="405630851"
Received: from emohamma-mobl.amr.corp.intel.com (HELO
 rsridh-mobl1.localdomain) ([10.212.9.30])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 11:33:50 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: pcm: send DAPM_STREAM_STOP event in dpcm_fe_dai_shutdown
Date: Wed,  2 Dec 2020 11:33:43 -0800
Message-Id: <20201202193343.912942-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, hdegoede@redhat.com, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

A recent change removed the call to send the DAPM_STREAM_STOP
event in dpcm_fe_dai_shutdown. But this causes a regression
when a PCM prepare is not paired with a hw_free. So, add
the DAPM_STREAM_STOP event back to dpcm_fe_dai_shutdown()
to fix this.

The new sequence would be:
soc_pcm_prepare()
    -> SND_SOC_DAPM_STREAM_START

soc_pcm_hw_free()
    -> soc_pcm_hw_free()
	-> SND_SOC_DAPM_STREAM_STOP

dpcm_fe_dai_shutdown()
    -> SND_SOC_DAPM_STREAM_STOP

Note that the DAPM_STREAM_STOP will be called twice but it seems
harmless.

Fixes: a27b421f1d04 ('ASoC: pcm: call snd_soc_dapm_stream_stop() in soc_pcm_hw_clean')

Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5250124dc8f5..ae062e4d1ce8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1860,6 +1860,9 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	/* now shutdown the frontend */
 	soc_pcm_close(substream);
 
+	/* run the stream stop event */
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
+
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	return 0;
-- 
2.25.1

