Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF746C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:41:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C868235F9
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C868235F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96AC6182C;
	Wed, 20 Jan 2021 22:40:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96AC6182C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611178860;
	bh=h56dbHXLWlPdA89Bvk2IolbCLn1joE5Mw1QdB5ed7ik=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emHPOKlRfkV1MX9A/kRRJZhrjb74Mj75pJIsA3s9zQ/mR3tgG7SJpVqSJ0iC13IC+
	 lbsraeFa0PsR42IB3+pCeEU9FB9URtxeDcNkjo6tsjWrPabHnUu44tD4ozb/dZiEY3
	 5FPw//tDwi/BAaSAoOhRb33aydC/sPXcS99+kvcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55DDAF804C2;
	Wed, 20 Jan 2021 22:39:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C75D9F804BD; Wed, 20 Jan 2021 22:39:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37DA9F80137
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 22:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37DA9F80137
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9DB48ACAC;
 Wed, 20 Jan 2021 21:39:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: usb-audio: Fix "RANGE setting not yet supported"
 errors
Date: Wed, 20 Jan 2021 22:39:32 +0100
Message-Id: <20210120213932.1971-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120213932.1971-1-tiwai@suse.de>
References: <20210120213932.1971-1-tiwai@suse.de>
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

At probing a UAC2/UAC3 device like NUX MG-300 USB interface, we get
error messages "RANGE setting not yet supported".  It comes the place
where the driver tries to determine the resolution of mixer volumes
via SET_CUR_RES and GET_CUR_RES verbs.  Those verbs aren't supported
on UAC2 and UAC3, hence the driver warns like the above.  Although the
driver handles this error and works as expected, it's still ugly to
show such errors unnecessarily.

This patch papers over the errors by applying the resolution detection
only for UAC1 and skipping it for UAC2/UAC3.

Reported-by: Mike Oliphant <oliphant@nostatic.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 12b15ed59eaa..1a6d154a548c 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1232,7 +1232,7 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 				  (cval->control << 8) | minchn,
 				  &cval->res) < 0) {
 			cval->res = 1;
-		} else {
+		} else if (cval->head.mixer->protocol == UAC_VERSION_1) {
 			int last_valid_res = cval->res;
 
 			while (cval->res > 1) {
-- 
2.26.2

