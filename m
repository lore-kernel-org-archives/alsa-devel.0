Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986DC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 10:16:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D33060F23
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 10:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D33060F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB5441F28;
	Thu, 29 Jul 2021 12:15:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB5441F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627553791;
	bh=3bnfPM4GG2MjvQ939dx7nJOukWA07KCC2REdQKJzFBU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hIHeIjJ0ebFuifqRy0v/pAJ0uDr6OZ2nT3c5nN22AiYVS7XI4lk4PGB9G/m98eeRi
	 EPcV3quhghK4DWNpY/VOD+gSxLnrPq3ip6vEdauPB2CZU8PkvAlBYoAaIxZ7NTOv0F
	 79AFlI1Vr9tIcRSU1uuBqTyzts3G4h8ao7ktsl14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DB1AF804F3;
	Thu, 29 Jul 2021 12:14:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4480F804ED; Thu, 29 Jul 2021 12:14:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B401EF804AF
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 12:13:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B401EF804AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="U7rBRIu5"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="XG43oFyx"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 28A532245B
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627553626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95+K1SFaX3/2ES4SbVBqWht92B49Kiy7Z2Na7fXHABc=;
 b=U7rBRIu5WTUnApmYQBmigmhM5ZwD0CoV5fWZFtX06qDUQv0UDVOchOBIWZAH6dp9T5dr2A
 dqVlyqdXbzqk65SRmy8KXwxzpaI0VIdQkDRUx71ZNTAwm4XP5qiVawCtncn/J+Nd65bZjf
 rQirKm8Btrf0A37l3LfbbsS9d0wv4LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627553626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95+K1SFaX3/2ES4SbVBqWht92B49Kiy7Z2Na7fXHABc=;
 b=XG43oFyxTckftrEmEsnBgswdTzOI1DNXTyxMOgxxHlNe1yLkT5XaJAdq++lJOg28T2iz0q
 oj/2ztSRwFjuLnCw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 20DE8A3C88;
 Thu, 29 Jul 2021 07:44:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 15/15] ALSA: doc: Add the description of quirk_flags option
 for snd-usb-audio
Date: Thu, 29 Jul 2021 09:44:04 +0200
Message-Id: <20210729074404.19728-6-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210729073855.19043-1-tiwai@suse.de>
References: <20210729073855.19043-1-tiwai@suse.de>
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

Just briefly described about the new option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa-configuration.rst | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index b36af65a08ed..f148b58502c0 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2252,6 +2252,25 @@ delayed_register
     The driver prints a message like "Found post-registration device
     assignment: 1234abcd:04" for such a device, so that user can
     notice the need.
+quirk_flags
+    Contains the bit flags for various device specific workarounds.
+    Applied to the corresponding card index.
+        * bit 0: Skip reading sample rate for devices
+        * bit 1: Create Media Controller API entries
+        * bit 2: Allow alignment on audio sub-slot at transfer
+        * bit 3: Add length specifier to transfers
+        * bit 4: Start playback stream at first in implement feedback mode
+        * bit 5: Skip clock selector setup
+        * bit 6: Ignore errors from clock source search
+        * bit 7: Indicates ITF-USB DSD based DACs
+        * bit 8: Add a delay of 20ms at each control message handling
+        * bit 9: Add a delay of 1-2ms at each control message handling
+        * bit 10: Add a delay of 5-6ms at each control message handling
+        * bit 11: Add a delay of 50ms at each interface setup
+        * bit 12: Perform sample rate validations at probe
+        * bit 13: Disable runtime PM autosuspend
+        * bit 14: Ignore errors for mixer access
+        * bit 15: Support generic DSD raw U32_BE format
 
 This module supports multiple devices, autoprobe and hotplugging.
 
@@ -2261,11 +2280,14 @@ check.
 
 NB: ``ignore_ctl_error=1`` may help when you get an error at accessing
 the mixer element such as URB error -22.  This happens on some
-buggy USB device or the controller.
+buggy USB device or the controller.  This workaround corresponds to
+the ``quirk_flags`` bit 14, too.
 
-NB: quirk_alias option is provided only for testing / development.
+NB: ``quirk_alias`` option is provided only for testing / development.
 If you want to have a proper support, contact to upstream for
 adding the matching quirk in the driver code statically.
+Ditto for ``quirk_flags``.  If a device is known to require specific
+workarounds, please report to the upstream.
 
 Module snd-usb-caiaq
 --------------------
-- 
2.26.2

