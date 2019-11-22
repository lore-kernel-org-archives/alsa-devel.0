Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEFC432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:30:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BB920674
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kN0ttWEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BB920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D92817F4;
	Fri, 22 Nov 2019 12:29:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D92817F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574422201;
	bh=42l/HadBKYDSShYJbHBfynb5O43BlJE7vQnY+MEi5Pw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kN0ttWEx4meTDu6zBktXlXpqg+XOiIQhjI47C2JjI/xMHmJOE8HB6vYdmB0kf1E6X
	 VGwigIoBPPAYhbWieb3sjE4V0KZmK8NtDSar9efCXCScPtgJ0c7lRRwXk/8G8wg31J
	 cHTF2oM2jKQJUGM/keFcsQv6x7H1LOS/YFcm3iv0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 232F7F80157;
	Fri, 22 Nov 2019 12:28:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE95EF80159; Fri, 22 Nov 2019 12:28:44 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47ECAF80150
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 12:28:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47ECAF80150
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BC12CB2FB;
 Fri, 22 Nov 2019 11:28:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 22 Nov 2019 12:28:40 +0100
Message-Id: <20191122112840.24797-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Fix NULL dereference at
	parsing BADD
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

snd_usb_mixer_controls_badd() that parses UAC3 BADD profiles misses a
NULL check for the given interfaces.  When a malformed USB descriptor
is passed, this may lead to an Oops, as spotted by syzkaller.
Skip the iteration if the interface doesn't exist for avoiding the
crash.

Fixes: 17156f23e93c ("ALSA: usb: add UAC3 BADD profiles support")
Reported-by: syzbot+a36ab65c6653d7ccdd62@syzkaller.appspotmail.com
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 45eee5cc312e..6cd4ff09c5ee 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2930,6 +2930,9 @@ static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
 			continue;
 
 		iface = usb_ifnum_to_if(dev, intf);
+		if (!iface)
+			continue;
+
 		num = iface->num_altsetting;
 
 		if (num < 2)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
