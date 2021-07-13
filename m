Return-Path: <SRS0=zwJL=MF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C22C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:27:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE4861026
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE4861026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08E5D16D8;
	Tue, 13 Jul 2021 16:26:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08E5D16D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626186421;
	bh=rXd3rGaZ0EkgeHDojGaFPpZiTaj1DBoxC6XqwIBWSCo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NtTZhSUPgBqWTLrmBGXxfGktElBoFTGgXDobxHAojE0+/TCB169kLTZcbEGFUmABG
	 zBCp/GNDZ1/qQCJsgPrKQpkScHSnj2rR8UG3ggIjxhjm/6mNLealiQLtpHWkKhnnzW
	 CHQ+wD9N0mOSQq6nxLQ0hAVcwHMsjBOgz5mzEKck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88488F804EB;
	Tue, 13 Jul 2021 16:25:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C1D1F804E5; Tue, 13 Jul 2021 16:25:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01D57F80217
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 16:24:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01D57F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="wHz18ElW"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="jmPY17V7"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 17884201E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626186295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+80vNdV6jE9Ou8O5FXAHfr7DOF9xGqto4WGILLz14c=;
 b=wHz18ElWzapSBVkeR3qsJBw1FdUPtWiLrtN2ty2Fvpnad5HbEW/XRTuFwppYd7LhYP7Zgh
 lSrJsJ1p2OcbCvv6a2aDfC48BhGuTGPyrRL31vVUv9AB8RHL7bVM8pHtJ0Z/7CU78u4AaG
 T5HQ8dzK9eHf3skUllH/JmDm8eHZDgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626186295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+80vNdV6jE9Ou8O5FXAHfr7DOF9xGqto4WGILLz14c=;
 b=jmPY17V7x/B53r2r6iylrmdB66p99QOzz5BgXFhaglIz0zuIxdKC6Pd3GA2ei1OLr8jiDD
 4IXloKjjIRS8CZAA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 083BBA3B8D;
 Tue, 13 Jul 2021 14:24:55 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/51] ALSA: doc: Add device-managed resource section
Date: Tue, 13 Jul 2021 16:24:42 +0200
Message-Id: <20210713142445.19252-7-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713142445.19252-1-tiwai@suse.de>
References: <20210713142445.19252-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Give brief explanations about the device-managed resources and the
newly introduced snd_devm_card_new() helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../kernel-api/writing-an-alsa-driver.rst     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 01d59b8aea92..255b7d3bebd6 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -4172,6 +4172,39 @@ module license as GPL, etc., otherwise the system is shown as “tainted”.
   MODULE_LICENSE("GPL");
 
 
+Device-Managed Resources
+========================
+
+In the examples above, all resources are allocated and released
+manually.  But human beings are lazy in nature, especially developers
+are lazier.  So there are some ways to automate the release part; it's
+the (device-)managed resources aka devres or devm family.  For
+example, an object allocated via :c:func:`devm_kmalloc()` will be
+freed automatically at unbinding the device.
+
+ALSA core provides also the device-managed helper, namely,
+:c:func:`snd_devm_card_new()` for creating a card object.
+Call this functions instead of the normal :c:func:`snd_card_new()`,
+and you can forget the explicit :c:func:`snd_card_free()` call, as
+it's called automagically at error and removal paths.
+
+One caveat is that the call of :c:func:`snd_card_free()` would be put
+at the beginning of the call chain only after you call
+:c:func:`snd_card_register()`.
+
+Also, the ``private_free`` callback is always called at the card free,
+so be careful to put the hardware clean-up procedure in
+``private_free`` callback.  It might be called even before you
+actually set up at an earlier error path.  For avoiding such an
+invalid initialization, you can set ``private_free`` callback after
+:c:func:`snd_card_register()` call succeeds.
+
+Another thing to be remarked is that you should use device-managed
+helpers for each component as much as possible once when you manage
+the card in that way.  Mixing up with the normal and the managed
+resources may screw up the release order.
+
+
 How To Put Your Driver Into ALSA Tree
 =====================================
 
-- 
2.26.2

