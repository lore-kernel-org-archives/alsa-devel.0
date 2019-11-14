Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DCC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:57:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE7E2070E
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bH4huMyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE7E2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CA6D1612;
	Thu, 14 Nov 2019 17:56:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CA6D1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573750631;
	bh=Aag1H8c+Jhn5OWOETJ/ydraSht8V78XX8ZYWmpW+frA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bH4huMyOdhPaGN5aO8FQgHRv0YaaR7KADnBNKlKFeRQ9/g3mYeK3HtO1noRpYoQzE
	 DDGA7Q6mGMK3PiQLtAr9BopUSBmW49Kxo+H6Q5NutS9stoc4SxErMof7K/3TvHdSyV
	 JMMobxXkVtn3b5e4lEy9RZ98brCCN99zmmt3Rjpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB6E3F800CD;
	Thu, 14 Nov 2019 17:56:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0415F800E9; Thu, 14 Nov 2019 17:56:19 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7A63F80084
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 17:56:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7A63F80084
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5538AACD9
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 16:56:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 17:56:12 +0100
Message-Id: <20191114165613.7422-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH 1/2] ALSA: usb-audio: Fix incorrect size check
	for processing/extension units
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

The recently introduced unit descriptor validation had some bug for
processing and extension units, it counts a bControlSize byte twice so
it expected a bigger size than it should have been.  This seems
resulting in a probe error on a few devices.

Fix the calculation for proper checks of PU and EU.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/validate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index a5e584b60dcd..389e8657434a 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -81,9 +81,9 @@ static bool validate_processing_unit(const void *p,
 	switch (v->protocol) {
 	case UAC_VERSION_1:
 	default:
-		/* bNrChannels, wChannelConfig, iChannelNames, bControlSize */
-		len += 1 + 2 + 1 + 1;
-		if (d->bLength < len) /* bControlSize */
+		/* bNrChannels, wChannelConfig, iChannelNames */
+		len += 1 + 2 + 1;
+		if (d->bLength < len + 1) /* bControlSize */
 			return false;
 		m = hdr[len];
 		len += 1 + m + 1; /* bControlSize, bmControls, iProcessing */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
