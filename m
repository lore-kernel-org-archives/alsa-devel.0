Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA4C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:36:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A5C22245
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="miR4qFzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A5C22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8DB51784;
	Mon, 16 Nov 2020 14:35:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8DB51784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605533794;
	bh=Iq9SF2donij1w6J5e1Z90jeUAE+OVsaBiyCnJybshkk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=miR4qFzwjpp4U9rX/U8YWaxHxir3iqENaxFVeGKTynPi3PTaAtaJgT2QW0reRya/p
	 mzB6GntaUoUZ6c8qzd/OUQYCUJ82cvHg9X+enP4V05tA2Boo4osHJMkppg2EjC258a
	 ATLlh0jnY3n3Oq7sNnKtdEF0Fz6fy19YCdv3gs+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D589F8016D;
	Mon, 16 Nov 2020 14:34:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6AD5F80168; Mon, 16 Nov 2020 14:34:10 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00FA7F8016C
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 14:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00FA7F8016C
IronPort-SDR: hLNNhNq4FaqYvr6wygCoKkfzZyBQXb1efNYcxfuDfGjOP/gkRweDZi0TvQDA7TT/EAdFQuZhTv
 wLHJ7CLlD7Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158520538"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="158520538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 05:33:49 -0800
IronPort-SDR: /wTyS+BBd0fApIngLzKQ9pMPwrJUah6CmBV+tCGGP/YDsCb6gd+NF3qexdvvyssJKBYKENna6t
 bkH7f7Rh9pfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="475525017"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 16 Nov 2020 05:33:46 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/5] ASoC: Intel: catpt: Skip position update for unprepared
 streams
Date: Mon, 16 Nov 2020 14:33:28 +0100
Message-Id: <20201116133332.8530-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116133332.8530-1-cezary.rojewski@intel.com>
References: <20201116133332.8530-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, broonie@kernel.org
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

Playing with very low period sizes may lead to timeouts when awaiting
RESET_STREAM reply for offload streams. This is caused by NOTIFY_POSITION
appearing in the middle of trigger(stop).

Stream is unprepared during trigger(stop) where PAUSE_STREAM IPC gets
invoked. However, all data that is already mixed in DSP firmware's mixer
stream will still be played regardless of the pause. For offload streams,
this means possibility for another NOTIFY_POSITION to process. Keep these
notifications in check by only handling them when stream is in prepared
state.

Fixes: a126750fc865 ("ASoC: Intel: catpt: PCM operations")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/catpt/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index ba653ebea7d1..afdf6be605aa 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -534,6 +534,8 @@ void catpt_stream_update_position(struct catpt_dev *cdev,
 
 	dsppos = bytes_to_frames(r, pos->stream_position);
 
+	if (!stream->prepared)
+		goto exit;
 	/* only offload is set_write_pos driven */
 	if (stream->template->type != CATPT_STRM_TYPE_RENDER)
 		goto exit;
-- 
2.17.1

