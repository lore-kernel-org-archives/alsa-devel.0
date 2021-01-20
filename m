Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D0CC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:40:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8828A235F7
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8828A235F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 243BB17F8;
	Wed, 20 Jan 2021 22:39:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 243BB17F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611178832;
	bh=czcS5jSkmelN6v+tdSHwMiojQOXe9BLMweih0xKBaNY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IMuOTOIQ3ljNzCwQJebUWUiEnja/k9K4j5JQy5hUqB6f1lBM+jbgnb/UoV8e4xHNw
	 1I3udOPmmcC7r4/p4iPB/iBD11bXWYp6p8h0pdzGP9RkNT7PvGSF2Jo3Xsp7nuBOH9
	 /pSgsys55/wsWf7ZFo/DTPLCbqmsS3x11ld3CL7U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99580F80164;
	Wed, 20 Jan 2021 22:39:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC69FF80137; Wed, 20 Jan 2021 22:39:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32879F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 22:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32879F80164
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8F23BAB9F;
 Wed, 20 Jan 2021 21:39:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: usb-audio: Skip the clock selector inquiry for
 single connections
Date: Wed, 20 Jan 2021 22:39:31 +0100
Message-Id: <20210120213932.1971-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Oliphant <oliphant@nostatic.org>
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

The current USB-audio driver gets an error at probing NUX MG-300 about
parsing the clocks.  This is because the firmware doesn't return the
proper connection of the clock selector that is connected to a single
clock; it's likely that the firmware was lazy^w optimized and the
inquiry wasn't handled.  Actually it makes little sense to inquire and
set up the single connection explicitly.

This patch fixes the issue by simply skipping the clock selector
inquiry if it's a single connection.

Reported-by: Mike Oliphant <oliphant@nostatic.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index dc68ed65e478..8243652d5604 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -298,6 +298,11 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	if (selector) {
 		int ret, i, cur;
 
+		if (selector->bNrInPins == 1) {
+			ret = 1;
+			goto find_source;
+		}
+
 		/* the entity ID we are looking for is a selector.
 		 * find out what it currently selects */
 		ret = uac_clock_selector_get_val(chip, selector->bClockID);
@@ -314,6 +319,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			return -EINVAL;
 		}
 
+	find_source:
 		cur = ret;
 		ret = __uac_clock_find_source(chip, fmt,
 					      selector->baCSourceID[ret - 1],
-- 
2.26.2

