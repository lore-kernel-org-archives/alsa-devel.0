Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773B6C38A2F
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 13:54:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35802054F
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TAVGe7vP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wrTxhOHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35802054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C22E1681;
	Sat, 18 Apr 2020 15:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C22E1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587218080;
	bh=SC/vqzeMx1k3k9AAbtjSE5BmU6VVJ9MANDBe3abuSXk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAVGe7vPDhHw/AHbLWSU9utl2SGHaw+LFTGDdPI/IMwUQmjdS3tebykIluy4jzXUQ
	 NUQcjVcG8UuqvvnT6UBEwKuLQN0wzAoLGUXZJrkcjA5ChnloJCwkvdfOxffuI71P8m
	 JueFdqX2JZFU3qx4elemhahU9xqPDw/wxzAQQgMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D427EF802E1;
	Sat, 18 Apr 2020 15:49:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BB29F802A9; Sat, 18 Apr 2020 15:49:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B41E6F8029B
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 15:49:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B41E6F8029B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wrTxhOHl"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83C8922202;
 Sat, 18 Apr 2020 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587217779;
 bh=SC/vqzeMx1k3k9AAbtjSE5BmU6VVJ9MANDBe3abuSXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wrTxhOHlUHM9O4TJHrRx6qfXoBGt8wowJrLF3U2XRIwYRTENQ9lt+xccdxDtXbwjm
 TdVpkS0/c5qSKsKHrocscyYAoVNJQQf7nTyWCAz/Uk2AXYVy5/v1YI5ngYwZHksv9u
 tl1tP1Dxfk/+saA9qOVECg13tf7GYrmkgqSLqFEI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 67/73] ALSA: usb-audio: Add Pioneer DJ DJM-250MK2
 quirk
Date: Sat, 18 Apr 2020 09:48:09 -0400
Message-Id: <20200418134815.6519-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org,
 =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>
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

From: František Kučera <franta-linux@frantovo.cz>

[ Upstream commit 73d8c94084341e2895169a0462dbc18167f01683 ]

Pioneer DJ DJM-250MK2 is a mixer that acts like a USB sound card.
The MIDI controller part is standard but the PCM part is "vendor specific".
Output is enabled by this quirk: 8 channels, 48 000 Hz, S24_3LE.
Input is not working.

Signed-off-by: František Kučera <franta-linux@frantovo.cz>
Link: https://lore.kernel.org/r/20200401095907.3387-1-konference@frantovo.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d187aa6d50db0..dcaf9eed9a415 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3592,5 +3592,47 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+{
+	/*
+	 * Pioneer DJ DJM-250MK2
+	 * PCM is 8 channels out @ 48 fixed (endpoints 0x01).
+	 * The output from computer to the mixer is usable.
+	 *
+	 * The input (phono or line to computer) is not working.
+	 * It should be at endpoint 0x82 and probably also 8 channels,
+	 * but it seems that it works only with Pioneer proprietary software.
+	 * Even on officially supported OS, the Audacity was unable to record
+	 * and Mixxx to recognize the control vinyls.
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0017),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8, // outputs
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 48000 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.20.1

