Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44756C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:41:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237D923120
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RJtSydcj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=l4m1.de header.i=@l4m1.de header.b="tqnFcuBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237D923120
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=l4m1.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41C0E1667;
	Thu,  6 Aug 2020 18:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41C0E1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596732116;
	bh=mr4KYtkXB/7cupz8vVHJRXGV9zXb+caWtI7DYWXEFaE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RJtSydcjt8xFie0ZQxE92ycioTf/uL2VoUmKPB3kyKYi30T8lDBtuatHoy+qQLcWY
	 Jy9XhTpkSBA/v50cChtP4hf0OvOhhXno5F2EpHlS8DP/LFnZw6Xq6m/K/0DcH5QGle
	 CshIx0y56cuMgdYYpG/lwQnxMfBrNqD2LR74Qzos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5AF9F802F7;
	Thu,  6 Aug 2020 18:36:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2DF7F80159; Thu,  6 Aug 2020 14:49:05 +0200 (CEST)
Received: from fillips.l4m1.de (fillips.l4m1.de [185.207.104.9])
 by alsa1.perex.cz (Postfix) with ESMTP id A5169F800B7
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 14:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5169F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=l4m1.de header.i=@l4m1.de
 header.b="tqnFcuBL"
Received: from l4m1.de (x590ebe1d.dyn.telefonica.de [89.14.190.29])
 by fillips.l4m1.de (Postfix) with ESMTPSA id 02F812989EB;
 Thu,  6 Aug 2020 14:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=l4m1.de; s=mail;
 t=1596718138; bh=mr4KYtkXB/7cupz8vVHJRXGV9zXb+caWtI7DYWXEFaE=;
 h=From:To:Cc:Subject:Date;
 b=tqnFcuBLZ8/ec7KrMkdlbUIJsljAZtBkbrbkDIcVsZnQyyPmyvR/YfDeYGYq/B9gQ
 FkmqSa8RCvFWFk270m1gzVIzWjZtOsUCnXNIammEBl5QRxS5CwJ7O/PE9GLGDZCMaT
 aX3v10gGUsgQFMBchT9ZPtbQ6ZYUdYM2MGJ09E5c=
From: buzz@l4m1.de
To: buzz@l4m1.de
Subject: [PATCH] ALSA: usb - Creative USB X-Fi Pro SB1095 volume knob support
Date: Thu,  6 Aug 2020 14:48:50 +0200
Message-Id: <20200806124850.20334-1-buzz@l4m1.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2020 18:36:48 +0200
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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

From: Mirko Dietrich <buzz@l4m1.de>

Adds an entry for Creative USB X-Fi to the rc_config array in
mixer_quirks.c to allow use of volume knob on the device.
Adds support for newer X-Fi Pro card, known as "Model No. SB1095"
with USB ID "041e:3263"

Signed-off-by: Mirko Dietrich <buzz@l4m1.de>
---
 sound/usb/mixer_quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index cec1cfd7edb7..199cdbfdc761 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -185,6 +185,7 @@ static const struct rc_config {
 	{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 */
 	{ USB_ID(0x041e, 0x30df), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
 	{ USB_ID(0x041e, 0x3237), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
+	{ USB_ID(0x041e, 0x3263), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 Pro */
 	{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6,  2,  0x6e91 }, /* Toshiba SB0500 */
 };
 
-- 
2.28.0

