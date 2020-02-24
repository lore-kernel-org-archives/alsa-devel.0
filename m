Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_DISCARD,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330BC11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:30:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821AC2080D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZlxLf6DO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=frantovo.cz header.i=@frantovo.cz header.b="fZ7LaPze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821AC2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=frantovo.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAD7F1687;
	Mon, 24 Feb 2020 17:29:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAD7F1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582561815;
	bh=jAnybuauDBphMtn/lGF1KckBYENahPQCW5gR0c48giY=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZlxLf6DOx30KJtVZMlsmye9kMUHwf5+Tg8Cs9eyiJXPddd9jyc0mHMXgDuRCFIVHN
	 4uLbEEmzaOyrx0A//q2tYF2Ag8j3uYR5odbFD54X3Xt+Ihen/eA+xMZdtDGTTLfVvp
	 GH81qYhAuaJQeQOGIKLWcXLCo/xDSANNugBsrgPM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51C2FF8014D;
	Mon, 24 Feb 2020 17:29:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1E99F8014E; Mon, 24 Feb 2020 17:29:21 +0100 (CET)
Received: from posta.frantovo.cz (czf.frantovo.cz [91.219.244.97])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E9F8F80090
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 17:29:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E9F8F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=frantovo.cz header.i=@frantovo.cz
 header.b="fZ7LaPze"
Received: from [192.168.1.4] (osma.doma.frantovo.cz [192.168.1.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: fiki@frantovo.cz)
 by posta.frantovo.cz (Postfix) with ESMTPSA id E5C88FBAD6
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 17:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=frantovo.cz;
 s=default; t=1582561597;
 bh=jAnybuauDBphMtn/lGF1KckBYENahPQCW5gR0c48giY=;
 h=From:Subject:To:Date;
 b=fZ7LaPzec91GQUDNj6yaCK9sX0+I8tCioB7dludCKKIZhpDybiNWOgCv4cEO5I2Oo
 L9Qb4428Yqga1U9w7yv3oHtLlGOeWxFmoK0+unr5CPHE42/V5lJjCiWf5qWGWnIP/h
 iOj8SZlsDgMRIoaRX7e8Iqum5/3K2JxSxzcTAQmM=
From: =?UTF-8?B?RnJhbnRpxaFlayBLdcSNZXJh?= <konference@frantovo.cz>
Subject: [PATCH] quirk for Pioneer DJ DJM-250MK2 usb sound card
To: alsa-devel@alsa-project.org
Autocrypt: addr=konference@frantovo.cz; prefer-encrypt=mutual; keydata=
 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
 hW6mcblB0mov13r3UFNF1TB7
Message-ID: <e1e0dbc4-7fd0-ac7a-9b15-1f89172257e5@frantovo.cz>
Date: Mon, 24 Feb 2020 17:29:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: cs-CZ
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.98.1 at posta
X-Virus-Status: Clean
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

Hello,

I have created a quirk that adds support for the Pioneer DJ DJM-250MK2 mixer (acts like a USB sound card, but Vendor Specific Class).

Output (from computer to card) is working: 8 channels, 48 000 Hz, S24_3LE.

Input is not working. I tried, but I was unable to make it working even under an officially supported OS with Pioneer drivers - Audacity or Mixxx see the channels, but there is no signal. It probably works only with Pioneer proprietary application. But I hope that even mere output support will be useful for someone. (it is usable for playback, just not for DVS)

Franta

Signed-off-by: František Kučera <franta-linux@frantovo.cz>
---
 sound/usb/quirks-table.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d187aa6d50db..dcaf9eed9a41 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3592,5 +3592,47 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
                }
        }
 },
+{
+       /*
+        * Pioneer DJ DJM-250MK2
+        * PCM is 8 channels out @ 48 fixed (endpoints 0x01).
+        * The output from computer to the mixer is usable.
+        *
+        * The input (phono or line to computer) is not working.
+        * It should be at endpoint 0x82 and probably also 8 channels,
+        * but it seems that it works only with Pioneer proprietary software.
+        * Even on officially supported OS, the Audacity was unable to record
+        * and Mixxx to recognize the control vinyls.
+        */
+       USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0017),
+       .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+               .ifnum = QUIRK_ANY_INTERFACE,
+               .type = QUIRK_COMPOSITE,
+               .data = (const struct snd_usb_audio_quirk[]) {
+                       {
+                               .ifnum = 0,
+                               .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+                               .data = &(const struct audioformat) {
+                                       .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+                                       .channels = 8, // outputs
+                                       .iface = 0,
+                                       .altsetting = 1,
+                                       .altset_idx = 1,
+                                       .endpoint = 0x01,
+                                       .ep_attr = USB_ENDPOINT_XFER_ISOC|
+                                               USB_ENDPOINT_SYNC_ASYNC,
+                                       .rates = SNDRV_PCM_RATE_48000,
+                                       .rate_min = 48000,
+                                       .rate_max = 48000,
+                                       .nr_rates = 1,
+                                       .rate_table = (unsigned int[]) { 48000 }
+                               }
+                       },
+                       {
+                               .ifnum = -1
+                       }
+               }
+       }
+},
 
 #undef USB_DEVICE_VENDOR_SPEC

