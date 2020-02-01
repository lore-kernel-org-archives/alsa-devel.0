Return-Path: <SRS0=KyRj=3V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954AC33C9E
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Feb 2020 08:08:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A9720679
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Feb 2020 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="npA0rSzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A9720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F37A1683;
	Sat,  1 Feb 2020 09:07:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F37A1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580544489;
	bh=gmtCwfEW1pqiIbb63bQp4Cmmq6GEbUmE4ZT19kN0htc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=npA0rSzTJMkwY1ZYSM5fm1YEMMgPu3o9nrJj44zftKwPuJKz90QlOaX1xZAU+ftFn
	 /jq4FQ/LapasecmnhnMaXE1TM7BU2z5u6sy2GXT3EkEQWOarxVrTX2pSLPF0aNn1FB
	 soSSE9EAGyEQxGOShlP+wFxBD9DIL9CoAZ6ttzck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63910F80268;
	Sat,  1 Feb 2020 09:05:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1046F80227; Sat,  1 Feb 2020 09:05:39 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22C21F800D3
 for <alsa-devel@alsa-project.org>; Sat,  1 Feb 2020 09:05:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22C21F800D3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2D3C1AC0C
 for <alsa-devel@alsa-project.org>; Sat,  1 Feb 2020 08:05:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sat,  1 Feb 2020 09:05:28 +0100
Message-Id: <20200201080530.22390-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH 1/3] ALSA: usb-audio: Fix endianess in
	descriptor validation
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

I overlooked that some fields are words and need the converts from
LE in the recently added USB descriptor validation code.
This patch fixes those with the proper macro usages.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/validate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 4034c2072415..6fe206f6e911 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -110,7 +110,7 @@ static bool validate_processing_unit(const void *p,
 	default:
 		if (v->type == UAC1_EXTENSION_UNIT)
 			return true; /* OK */
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC_PROCESS_UP_DOWNMIX:
 		case UAC_PROCESS_DOLBY_PROLOGIC:
 			if (d->bLength < len + 1) /* bNrModes */
@@ -125,7 +125,7 @@ static bool validate_processing_unit(const void *p,
 	case UAC_VERSION_2:
 		if (v->type == UAC2_EXTENSION_UNIT_V2)
 			return true; /* OK */
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC2_PROCESS_UP_DOWNMIX:
 		case UAC2_PROCESS_DOLBY_PROLOCIC: /* SiC! */
 			if (d->bLength < len + 1) /* bNrModes */
@@ -142,7 +142,7 @@ static bool validate_processing_unit(const void *p,
 			len += 2; /* wClusterDescrID */
 			break;
 		}
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC3_PROCESS_UP_DOWNMIX:
 			if (d->bLength < len + 1) /* bNrModes */
 				return false;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
