Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A291C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:36:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13CC61100
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E13CC61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 458961692;
	Wed, 13 Oct 2021 16:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 458961692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634135813;
	bh=Mx6Ppv0se/x8K0K0fhjJQSWKHtGzOuXvDrebA1Rp2s8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KTeSl9qh6N4bVreLrsk+Y17fFNsWeKgz/JsKgLsQiCJyw9ed5/6pnz7LhqMPT/tpN
	 vzb6yxHMBIFMhNGgZn3A7fUz49C0PCpPMhzGjwfDkUryhtFj1GW7NwguPR9qOQ7qPw
	 dW91jrh97sWNPf1rDjTRyyg1AUE9FPLzk9JmsezM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12479F80552;
	Wed, 13 Oct 2021 16:31:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA8DDF80548; Wed, 13 Oct 2021 16:31:40 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6B6DF8052E
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 16:31:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6B6DF8052E
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313639614"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="313639614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="524649628"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.164.198])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v3 13/13] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
Date: Wed, 13 Oct 2021 09:30:50 -0500
Message-Id: <20211013143050.244444-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, vkoul@kernel.org, broonie@kernel.org,
 Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

A BE connected to more than one FE, e.g. in a mixer case, can go
through the following transitions.

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
stop FE2    -> BE state is STOP (see note [1] below)
release FE1 -> BE state is START
stop FE1    -> BE state is STOP

play FE1    -> BE state is START
pause FE1   -> BE state is PAUSED
play FE2    -> BE state is START
release FE1 -> BE state is START
stop FE2    -> BE state is START
stop FE1    -> BE state is STOP

The existing code for PAUSE_RELEASE only allows for the case where the
BE is paused, which clearly would not work in the sequences above.

Extend the allowed states to restart the BE when PAUSE_RELEASE is
received.

[1] the existing logic does not move the BE state back to PAUSED when
the FE2 is stopped. This patch does not change the logic; it would be
painful to keep a history of changes on the FE side, the state machine
is already rather complicated with transitions based on the last BE
state and the trigger type.

Reported-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1967980d0f79..88d60d5b60a8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2131,7 +2131,9 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto unlock_be;
 
 			be->dpcm[stream].be_start++;
-- 
2.25.1

