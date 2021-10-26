Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C19C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 09:55:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218D56109E
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 09:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 218D56109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E198716CC;
	Tue, 26 Oct 2021 11:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E198716CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635242142;
	bh=nyUiNsWaXu7J7EBCjgMBONE2lBGC6AijnH3+208gHk0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=byefgdJENmnXSc4uRjr2RknVtMXDSmvos7u3VpXihzVKCe4pGCa8wWDJthGPvCfAR
	 BA8n/LKsyHOO260RbCCkdK1CsybN7+LSGSYOPJolgDLUN+7k16bV/499bd43IsYauW
	 XfjmYblt+cVrTT5EpgFc5ciT5r7wLtO1dy4SfkZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77295F802C8;
	Tue, 26 Oct 2021 11:54:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2139F802E7; Tue, 26 Oct 2021 11:54:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E42F7F80269
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 11:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42F7F80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IcCrcZA6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A7D60F24;
 Tue, 26 Oct 2021 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635242081;
 bh=nyUiNsWaXu7J7EBCjgMBONE2lBGC6AijnH3+208gHk0=;
 h=From:To:Cc:Subject:Date:From;
 b=IcCrcZA6ot/XDbhxUd+ZROF+GVbjsIi9MGCTkO6xkTLTMrWzMPIMvHk4UN7tysl63
 bxH75ZdPC3kMW433GIjN69XarQu5ic2SukukWUrfVH+r/KSgDpiKqMQL8kGzfYUGwr
 xKidZ4eZJ+7PhkdMPIdIbsYgw+C0Gy51P1VNLtMc2Um1/QshPAHvuGPW97v5vspN8B
 QA9y2RGbc+LV0xQKVzUW6EU8XkeKkJuaTyRmkYvH7Eg/izoy8RmsZ8fyI8Wkt3Iufw
 euwNO+WFOFl4jwQsrKfTg9NU3lGnkXLLxzVW827kUnKihjDoTw5gSEID1TAYHpUPhm
 0YnwekDKkhszg==
Received: from johan by xi.lan with local (Exim 4.94.2)
 (envelope-from <johan@kernel.org>)
 id 1mfJA0-0006uh-Kv; Tue, 26 Oct 2021 11:54:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] sound: ua101: fix division by zero at probe
Date: Tue, 26 Oct 2021 11:54:01 +0200
Message-Id: <20211026095401.26522-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>
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

Add the missing endpoint max-packet sanity check to probe() to avoid
division by zero in alloc_stream_buffers() in case a malicious device
has broken descriptors (or when doing descriptor fuzz testing).

Note that USB core will reject URBs submitted for endpoints with zero
wMaxPacketSize but that drivers doing packet-size calculations still
need to handle this (cf. commit 2548288b4fb0 ("USB: Fix: Don't skip
endpoint descriptors with maxpacket=0")).

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org      # 2.6.34
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/usb/misc/ua101.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 5834d1dc317e..4f6b20ed29dd 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1000,7 +1000,7 @@ static int detect_usb_format(struct ua101 *ua)
 		fmt_playback->bSubframeSize * ua->playback.channels;
 
 	epd = &ua->intf[INTF_CAPTURE]->altsetting[1].endpoint[0].desc;
-	if (!usb_endpoint_is_isoc_in(epd)) {
+	if (!usb_endpoint_is_isoc_in(epd) || usb_endpoint_maxp(epd) == 0) {
 		dev_err(&ua->dev->dev, "invalid capture endpoint\n");
 		return -ENXIO;
 	}
@@ -1008,7 +1008,7 @@ static int detect_usb_format(struct ua101 *ua)
 	ua->capture.max_packet_bytes = usb_endpoint_maxp(epd);
 
 	epd = &ua->intf[INTF_PLAYBACK]->altsetting[1].endpoint[0].desc;
-	if (!usb_endpoint_is_isoc_out(epd)) {
+	if (!usb_endpoint_is_isoc_out(epd) || usb_endpoint_maxp(epd) == 0) {
 		dev_err(&ua->dev->dev, "invalid playback endpoint\n");
 		return -ENXIO;
 	}
-- 
2.32.0

