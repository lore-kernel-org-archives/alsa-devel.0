Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2970EC1975A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B80620775
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KdzjhLrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B80620775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02BA3167E;
	Wed, 25 Mar 2020 11:36:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02BA3167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585132649;
	bh=DJtpIsw2wgLdNVLUZ/V3otYyLeJT0euxFUcw7D3bFg0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KdzjhLrFdm2pfjJ48aQ/U603TyPlWI7dxFaMPpOqLJkWZdIm89Ctef9E9kFZB1twE
	 jAWhKZfZyvXxQMpSHDg0zFZkaPeI/STSnX1bIY3s/KPGHQWIpxBFFw8i1MdLmxr9Ze
	 7YGp1iKSXejL/ThesDVhVf20fhvFiCr9thU2WZKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F35DF80292;
	Wed, 25 Mar 2020 11:34:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1685F80147; Wed, 25 Mar 2020 11:33:32 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 535C4F80158
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 11:33:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 535C4F80158
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8C115ACD0
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 10:33:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ALSA: usb-audio: Update the documentation for the new
 delayed_register option
Date: Wed, 25 Mar 2020 11:33:22 +0100
Message-Id: <20200325103322.2508-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200325103322.2508-1-tiwai@suse.de>
References: <20200325103322.2508-1-tiwai@suse.de>
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

Just adding a brief explanation to alsa-configuration.rst.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa-configuration.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 392875a1b94e..72f97d4b01a7 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2234,6 +2234,19 @@ use_vmalloc
     buffers.  If mmap is used on such architectures, turn off this
     option, so that the DMA-coherent buffers are allocated and used
     instead.
+delayed_register
+    The option is needed for devices that have multiple streams
+    defined in multiple USB interfaces.  The driver may invoke
+    registrations multiple times (once per interface) and this may
+    lead to the insufficient device enumeration.
+    This option receives an array of strings, and you can pass
+    ID:INTERFACE like ``0123abcd:4`` for performing the delayed
+    registration to the given device.  In this example, when a USB
+    device 0123:abcd is probed, the driver waits the registration
+    until the USB interface 4 gets probed.
+    The driver prints a message like "Found post-registration device
+    assignment: 1234abcd:04" for such a device, so that user can
+    notice the need.
 
 This module supports multiple devices, autoprobe and hotplugging.
 
-- 
2.16.4

