Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B1C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:45:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B095120708
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GZwbKFGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B095120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01F001665;
	Wed, 29 Jan 2020 19:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01F001665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580323548;
	bh=R0FOIhtzpN8pZWxCuXqM2PNLavGV76Mm+okACxp5fm0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GZwbKFGDt+5k9DsWqci0+8jWDkEspzG9AeCNKVb+bQwTTm2Rqo4sMLS1+o+0D5pOM
	 enUnOHzpOeIkBoB1/1qJjM1g9PfuYtFToSBtrVQdHgHLaQMUz11Q78SKS9ZTSl1+s9
	 3wW3cWiEawBxax7FUz4hSKDHIztLbTcxdGDilSmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82CB4F80218;
	Wed, 29 Jan 2020 19:44:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B31CF8021E; Wed, 29 Jan 2020 19:44:55 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 097C9F80123
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 19:44:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 097C9F80123
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 10:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; d="scan'208";a="309487330"
Received: from akahan1-mobl3.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.255.95.46])
 by orsmga001.jf.intel.com with ESMTP; 29 Jan 2020 10:44:49 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 29 Jan 2020 10:44:48 -0800
Message-Id: <20200129184448.3005-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH] ALSA: uapi: Fix sparse warning
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Fix the following sparse warning generated due to
64-bit compat type having fields defined explicitly
with __32:
sound/soc/sof/sof-audio.c:46:31: warning: incorrect type in assignment (different base types)
sound/soc/sof/sof-audio.c:46:31: expected restricted snd_pcm_state_t [usertype] state
sound/soc/sof/sof-audio.c:46:31: got signed int [usertype] state

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/uapi/sound/asound.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 30ebb2a42983..535a7229e1d9 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -564,13 +564,13 @@ typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
 #endif
 
 struct __snd_pcm_mmap_status64 {
-	__s32 state;			/* RO: state - SNDRV_PCM_STATE_XXXX */
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
 	__u32 pad1;			/* Needed for 64 bit alignment */
 	__pad_before_uframe __pad1;
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	__pad_after_uframe __pad2;
 	struct __snd_timespec64 tstamp;	/* Timestamp */
-	__s32 suspended_state;		/* RO: suspended stream state */
+	snd_pcm_state_t suspended_state;/* RO: suspended stream state */
 	__u32 pad3;			/* Needed for 64 bit alignment */
 	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock */
 };
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
