Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C1DC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 04:16:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90077206F1
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 04:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a7nxXHSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90077206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAEB81607;
	Fri, 15 May 2020 06:16:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAEB81607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589516214;
	bh=i71ITxgRhAvhS2eQyHPYe5WKcQwlnFq9YtULV96ViDs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a7nxXHSUYEr/tEHTa7geGhHkS0RPcbb0ieGMczjzX+PU1idwvCBlRc5sA2wAKTxG1
	 VYRzMYOEPzR/TGUUqvxgcMJf9gmCVqNNFffh//m71xKMiWXGj9PScdpLDtGTfuqobT
	 pBwbAjF6Lb3ttJUoPpC0zx4Fl9eMlj3jhvNsKyq4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E167F8022D;
	Fri, 15 May 2020 06:16:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B664EF80247; Fri, 15 May 2020 06:16:00 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 922EBF800E3
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 06:15:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 922EBF800E3
IronPort-SDR: LdUSV3SrlPGW7jYtPRx8iyraExoVUNR0pwKT2QxmJekPCY0Fiw5f926nsMGGkr0aazV7YM25AF
 aCDi9H6jbPBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 21:15:47 -0700
IronPort-SDR: h21gBEuc1WSXsq8NSuif0vOqjl206dBqGYH1UlpT5XC4yIptNdSmDunNfMV8M5pQJWRmKg1I1p
 4q4+5QVdf89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; d="scan'208";a="253683839"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga008.fm.intel.com with ESMTP; 14 May 2020 21:15:42 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Date: Fri, 15 May 2020 12:09:39 +0800
Message-Id: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 paulhsia <paulhsia@chromium.org>, Brent Lu <brent.lu@intel.com>,
 linux-kernel@vger.kernel.org
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

The hw_base will be increased by runtime->buffer_size frames
unconditionally if the runtime->status->hw_ptr is not updated for over
half of buffer time. As the hw_base increases, so does the
runtime->status->hw_ptr which could lead to invalid return value when
user space program calls snd_pcm_avail() function.

By updating runtime->hw_ptr_jiffies each time the HWSYNC is called,
the hw_base will keep the same when buffer stall happens, so does the
hw_ptr.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/core/pcm_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 872a852..d531e1b 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -433,6 +433,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 
  no_delta_check:
 	if (runtime->status->hw_ptr == new_hw_ptr) {
+		runtime->hw_ptr_jiffies = curr_jiffies;
 		update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
 		return 0;
 	}
-- 
2.7.4

