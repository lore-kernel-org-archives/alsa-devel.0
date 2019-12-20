Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DDC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:43:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30DD24682
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O3PeD3pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30DD24682
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC85682A;
	Fri, 20 Dec 2019 16:43:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC85682A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856630;
	bh=Gd6GdR7BdhuywcA3Q/CwOfPe/IiPf2LdJkaExC7iQ9Q=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O3PeD3pEda4/tjjLOqtFTGeFIL4lgNd+FZZ3R10drVWg4W35gWC6DUCWauug/igCa
	 v0VE0TDIixo6gF5csnY6heaqcW+bLK7jeTK5ayl7BagCRQB0R2ngjdMWPs1AEwV8cB
	 ktQ3rWU499MV8j9CoKqjDN/V/rYKaRgHesuPCoXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43A73F8014F;
	Fri, 20 Dec 2019 16:43:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34AF6F8015A; Fri, 20 Dec 2019 16:42:59 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B2D4F8014C
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:42:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2D4F8014C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C9BF1AE35
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:42:55 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:42:54 +0100
Message-Id: <20191220154254.3690-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] hdspmixer: Use __u32 and __u64 for RMS array
	types
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

Some variable types are referring to the field in ioctl struct, which
are actually __u32 or __u64 instead of uint32_t or uint64_t.
This inconsistency may result in the compile error.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 hdspmixer/src/HDSPMixerWindow.cxx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 342efb2b857f..9efc25d0d5c0 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -35,8 +35,8 @@ static void readregisters_cb(void *arg)
     hdsp_peak_rms_t hdsp_peak_rms;
     struct hdspm_peak_rms hdspm_peak_rms;
     bool isMADI = false;
-    uint32_t *input_peaks, *playback_peaks, *output_peaks;
-    uint64_t *input_rms, *playback_rms, *output_rms;
+    __u32 *input_peaks, *playback_peaks, *output_peaks;
+    __u64 *input_rms, *playback_rms, *output_rms;
     
     HDSPMixerWindow *w = (HDSPMixerWindow *)arg;
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
