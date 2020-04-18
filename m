Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6DC352BE
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 17:59:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B3220776
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 17:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qsqLk90/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="h7cRdaQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B3220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D05915F9;
	Sat, 18 Apr 2020 19:58:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D05915F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587232755;
	bh=Kw04TPqCldOjIpHJMeDjkWHX5Maz8e0K+RmI4Mp4vv8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qsqLk90/ggGo1KnYlfb+qobH6aMqpWII5lluMGiEZS5O33hkPqPkA2xyAv6OgPyCT
	 MlWEO1/SUnJaRpM9Hkc+Lp3Mj1uSdPlFZqhzvYhe1UCEId3pTZQr4Rxhsr57W1IGf4
	 pJumVLDBuoJzdZnS8tpPmwbaTdOMdtLYwuSqQgxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8FE5F80122;
	Sat, 18 Apr 2020 19:58:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90DE0F8014E; Sat, 18 Apr 2020 19:58:23 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C054F80122
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 19:58:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C054F80122
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="h7cRdaQf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ic5TpljKmfpf3rc5maLqysACbwk/DlWDM/4/SFm230Y=; b=h7cRdaQf3pHvXmZwjP+vRO4r8A
 szml5i7nQA35nTZaaYkV4P6x/9Wm/JAt+EZz08y/BXBDrzuTpUhSbqjicTeSRyjGGM0HYSNpVwJzG
 7LCmouVt4Q5svYD+Vok7EFcyLw7ZeweFPHfDzS6Iw/TUyHW6tCGNpnNomDROqcWAHMRU=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home.puleglot.ru)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1jPrjM-00013n-J1; Sat, 18 Apr 2020 20:58:16 +0300
From: Alexander Tsoy <alexander@tsoy.me>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: usb-audio: Filter out unsupported sample rates on
 Focusrite devices
Date: Sat, 18 Apr 2020 20:58:15 +0300
Message-Id: <20200418175815.12211-1-alexander@tsoy.me>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Alexey Skobkin <skobkin-ru@ya.ru>
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

Many Focusrite devices supports a limited set of sample rates per
altsetting. These includes audio interfaces with ADAT ports:
 - Scarlett 18i6, 18i8 1st gen, 18i20 1st gen;
 - Scarlett 18i8 2nd gen, 18i20 2nd gen;
 - Scarlett 18i8 3rd gen, 18i20 3rd gen;
 - Clarett 2Pre USB, 4Pre USB, 8Pre USB.

Maximum rate is exposed in the last 4 bytes of Format Type descriptor
which has a non-standard bLength = 10.

Tested-by: Alexey Skobkin <skobkin-ru@ya.ru>
Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---

Notes:
    v2: updated description

 sound/usb/format.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 50e1874c847c..5ffb457cc88c 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -277,6 +277,52 @@ static bool s1810c_valid_sample_rate(struct audioformat *fp,
 	return false;
 }
 
+/*
+ * Many Focusrite devices supports a limited set of sampling rates per
+ * altsetting. Maximum rate is exposed in the last 4 bytes of Format Type
+ * descriptor which has a non-standard bLength = 10.
+ */
+static bool focusrite_valid_sample_rate(struct snd_usb_audio *chip,
+					struct audioformat *fp,
+					unsigned int rate)
+{
+	struct usb_interface *iface;
+	struct usb_host_interface *alts;
+	unsigned char *fmt;
+	unsigned int max_rate;
+
+	iface = usb_ifnum_to_if(chip->dev, fp->iface);
+	if (!iface)
+		return true;
+
+	alts = &iface->altsetting[fp->altset_idx];
+	fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen,
+				      NULL, UAC_FORMAT_TYPE);
+	if (!fmt)
+		return true;
+
+	if (fmt[0] == 10) { /* bLength */
+		max_rate = combine_quad(&fmt[6]);
+
+		/* Validate max rate */
+		if (max_rate != 48000 &&
+		    max_rate != 96000 &&
+		    max_rate != 192000 &&
+		    max_rate != 384000) {
+
+			usb_audio_info(chip,
+				"%u:%d : unexpected max rate: %u\n",
+				fp->iface, fp->altsetting, max_rate);
+
+			return true;
+		}
+
+		return rate <= max_rate;
+	}
+
+	return true;
+}
+
 /*
  * Helper function to walk the array of sample rate triplets reported by
  * the device. The problem is that we need to parse whole array first to
@@ -319,6 +365,11 @@ static int parse_uac2_sample_rate_range(struct snd_usb_audio *chip,
 			    !s1810c_valid_sample_rate(fp, rate))
 				goto skip_rate;
 
+			/* Filter out invalid rates on Focusrite devices */
+			if (USB_ID_VENDOR(chip->usb_id) == 0x1235 &&
+			    !focusrite_valid_sample_rate(chip, fp, rate))
+				goto skip_rate;
+
 			if (fp->rate_table)
 				fp->rate_table[nr_rates] = rate;
 			if (!fp->rate_min || rate < fp->rate_min)
-- 
2.25.3

