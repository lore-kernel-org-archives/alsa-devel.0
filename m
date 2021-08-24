Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A9C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:49:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192B961374
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 09:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 192B961374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1B4B1660;
	Tue, 24 Aug 2021 11:49:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1B4B1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629798593;
	bh=7VXPzWYnLHpltXU6CLV6TkVMUVgXzOw466WPIcw5pOA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYSpGNo8u/6FMxHgO6xjKt8Zw1Bi7wkVGgXFOXGUyo/jtyNaH8JHG4EQ6rcsvn3Sw
	 kQivMzkSCXIuTJ2e/8nzq5jJ7l6U0IqtmV2knNvD0nBM28kgmJDZvF5fKuhTZ4urde
	 4IeXOyLR43amrDbbeNl1Jz5+azC0S52Q30qFyBuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D4D7F804E7;
	Tue, 24 Aug 2021 11:48:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7742DF804B4; Tue, 24 Aug 2021 11:48:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CCECF801D5
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 11:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CCECF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="LFv5WK5Q"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Ey2eComZ"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7B023220DF
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629798477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDCWOOXzkS3uFLj0tdTBK+1YuvOwRHLtrbXTfXu/rMg=;
 b=LFv5WK5QJR6J9qiQvGbCWjYSNsMFEkMy43s5QX/tSn1D1w7t605ghKZMrrpNUk3gSezhJ6
 O7E7oTvAvUB0ZiMkrHeT53KQ5kywKSse6XAdManv9Emod3mtHPcLZzbkHjrVxFPNCWdQAv
 3rus8FZjekjgB39AGqoK38W8gLO5tmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629798477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDCWOOXzkS3uFLj0tdTBK+1YuvOwRHLtrbXTfXu/rMg=;
 b=Ey2eComZwIey6tFY94xL6eJWLlvvq6hqrHKMp8IdZXWBhCeSa59zAQZo5MZEVPztXxpqkQ
 2yxtkffaNBnSdqBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 6B1B9A3B87;
 Tue, 24 Aug 2021 09:47:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils 2/5] aplay: Handle 16bit sample negative overflow
 in peak calculations
Date: Tue, 24 Aug 2021 11:47:53 +0200
Message-Id: <20210824094756.12540-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210824094756.12540-1-tiwai@suse.de>
References: <20210824094756.12540-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The handling of 16bit samples in the peak calculations has a bug when
a sample with 0x8000 is passed.  As abs() treats 32bit int, it returns
0x8000.  And yet the code stores back into 16bit value again.

To fix that overflow, use 32bit value (i.e. val instead of sval) for
the further calculations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 aplay/aplay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 91af244edb60..c884346c9f25 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1829,9 +1829,9 @@ static void compute_max_peak(u_char *data, size_t samples)
 			else
 				sval = be16toh(*valp);
 			sval ^= mask;
-			sval = abs(sval);
-			if (max_peak[c] < sval)
-				max_peak[c] = sval;
+			val = abs(sval);
+			if (max_peak[c] < val)
+				max_peak[c] = val;
 			valp++;
 			if (vumeter == VUMETER_STEREO)
 				c = !c;
-- 
2.26.2

