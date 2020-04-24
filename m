Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0935C2BA19
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:25:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA682071E
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UsLPc2Xi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="U+08DUsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA682071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93271168F;
	Fri, 24 Apr 2020 04:25:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93271168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587695151;
	bh=NUMO7Ih2K+A56N3vpctIjx/6gFISqAk7kvsTZrnuofE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsLPc2XidCFf1G2ao/29+efhLWYjN/xLwJcHTvgDQ4HA+JcPpblh79VRZoekEoJwg
	 /JmaVZUYA3Fi5DggLlDFN87jykbDbQoVf+SbXmL+hNthwZaB30euifyT763hXgp+5K
	 pTtZUrr6ywTFsGnOqn4YxV+GgLyu8cRPQ8rxFawo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EE13F80117;
	Fri, 24 Apr 2020 04:25:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17089F80121; Fri, 24 Apr 2020 04:24:59 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03B6DF80121
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 04:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03B6DF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="U+08DUsy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y+8vI6JEwOUt5HBMOjjj12KHdpl6prl8nORF/oKMq3w=; b=U+08DUsyn6Gs6x7m+MRHckT+kp
 tILrPODU5jIXx3+fAKgWyxlxh7ftcaftiZOWRtCfY+KDk/iDR4mbFDiEVjDCZlblT8gWOMd5EpyTa
 nSSDy/e29U6eFslacl1DnGmkIYMGGq05Ee9+YqjHy06mNnPnhXwB40ovaa+s3Ld6WJTU=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home.puleglot.ru)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1jRo1L-0001hb-5i; Fri, 24 Apr 2020 05:24:51 +0300
From: Alexander Tsoy <alexander@tsoy.me>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: usb-audio: Remove async workaround for Scarlett 2nd
 gen
Date: Fri, 24 Apr 2020 05:24:49 +0300
Message-Id: <20200424022449.14972-2-alexander@tsoy.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424022449.14972-1-alexander@tsoy.me>
References: <20200424022449.14972-1-alexander@tsoy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Gregor Pintar <grpintar@gmail.com>,
 Roope Salmi <rpsalmi@gmail.com>
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

Frame size computation has been fixed and the workaround is no longer
needed.

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 sound/usb/quirks.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 351ba214a9d3..a8ece1701068 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1806,20 +1806,6 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		 */
 		fp->attributes &= ~UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-	case USB_ID(0x1235, 0x8200):  /* Focusrite Scarlett 2i4 2nd gen */
-	case USB_ID(0x1235, 0x8202):  /* Focusrite Scarlett 2i2 2nd gen */
-	case USB_ID(0x1235, 0x8205):  /* Focusrite Scarlett Solo 2nd gen */
-		/*
-		 * Reports that playback should use Synch: Synchronous
-		 * while still providing a feedback endpoint.
-		 * Synchronous causes snapping on some sample rates.
-		 * Force it to use Synch: Asynchronous.
-		 */
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
-			fp->ep_attr |= USB_ENDPOINT_SYNC_ASYNC;
-		}
-		break;
 	}
 }
 
-- 
2.26.2

