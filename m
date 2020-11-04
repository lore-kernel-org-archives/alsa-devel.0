Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A0FC388F7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1EF2236F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KBydFp/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1EF2236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A6B6168D;
	Wed,  4 Nov 2020 12:58:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A6B6168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604491152;
	bh=s2Ql0cdXx8DOOHJcwpW3R7KHRART415PNnFNFVNWUNQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KBydFp/OU7ugFA1i8l0WeLD3nT5AVX3wHpXHywsfioEA+2/4hHXfvTvye1upFSlZ5
	 +IWij1/yJeaUsZbjCHh3qYiHpPQ0rQrer4aAXASZsrE9ot6jl7cz8x4yS2MHPW0Uii
	 MJeqeKd4Hg/U5Y9bp/bzZGK/fyZy93ugaQKCTxo0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E78F5F80232;
	Wed,  4 Nov 2020 12:57:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81A6AF80259; Wed,  4 Nov 2020 12:57:32 +0100 (CET)
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 020B2F80232
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 12:57:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 020B2F80232
Received: from b4.vu (localhost.localdomain [127.0.0.1])
 by b4.vu (8.13.8/8.13.8) with ESMTP id 0A4BvHtg019055
 for <alsa-devel@alsa-project.org>; Wed, 4 Nov 2020 22:27:17 +1030
Received: (from g@localhost) by b4.vu (8.13.8/8.13.8/Submit) id 0A4BvH8l019054
 for alsa-devel@alsa-project.org; Wed, 4 Nov 2020 22:27:17 +1030
Date: Wed, 4 Nov 2020 22:27:17 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add implicit feedback quirk for Qu-16
Message-ID: <20201104115717.GA19046@b4.vu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
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

This patch fixes audio distortion on playback for the Allen&Heath
Qu-16.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---

 pcm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b401ee8..c4915de 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -336,6 +336,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 	switch (subs->stream->chip->usb_id) {
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
+	case USB_ID(0x22f0, 0x0006): /* Allen&Heath Qu-16 */
 		ep = 0x81;
 		ifnum = 3;
 		goto add_sync_ep_from_ifnum;
