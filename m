Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCEFC6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:14:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 172FF2CF8;
	Tue,  2 Apr 2024 09:14:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 172FF2CF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712042051;
	bh=eBrVzfGxW4z2+cdjOW1gt9UJqucEzz4vnZ+pYajgHac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W0ludlzS8XbtwfY04ws9xXtsyRLSnJDoZIDFUfk50Tdf4qoQyH6y8XbfxMvrb53Rj
	 h5CUD+lBOBU2dNV0KdH6kvzmt2biAz758l5jBTVC+AbqkeKL7yi1wphI4JyIjKP5ut
	 hoeKm8/GPHcF3C09deIW2YxGz24bDLASD2vr5fVI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50391F89BE4; Tue,  2 Apr 2024 08:58:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88B6BF89CAB;
	Tue,  2 Apr 2024 08:58:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 963CEF8055C; Tue,  2 Apr 2024 08:21:09 +0200 (CEST)
Received: from mail78-50.sinamail.sina.com.cn (mail78-50.sinamail.sina.com.cn
 [219.142.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91DCCF8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 08:20:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91DCCF8016E
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.232.53.71])
	by sina.net (10.75.30.234) with ESMTP
	id 660BA3B800029E89; Tue, 2 Apr 2024 14:20:46 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: B0FAB37DED5C4B23A16B1E56460FA27D
X-SMAIL-UIID: B0FAB37DED5C4B23A16B1E56460FA27D-20240402-142046
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 2/4] ASoC: codecs: ES8326: modify clock table
Date: Tue,  2 Apr 2024 14:20:41 +0800
Message-Id: <20240402062043.20608-3-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240402062043.20608-1-zhangyi@everest-semi.com>
References: <20240402062043.20608-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: J3HEAXEBF72M7EWXTO7AIJ5G63AOHYGP
X-Message-ID-Hash: J3HEAXEBF72M7EWXTO7AIJ5G63AOHYGP
X-Mailman-Approved-At: Tue, 02 Apr 2024 06:54:59 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J3HEAXEBF72M7EWXTO7AIJ5G63AOHYGP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We got a digital microphone feature issue. And we fixed it by modifying
the clock table. Also, we changed the marco ES8326_CLK_ON declaration

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8326.c | 22 +++++++++++-----------
 sound/soc/codecs/es8326.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index d87592747b4e..7f4788265e53 100755
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -404,9 +404,9 @@ static const struct _coeff_div coeff_div_v3[] = {
 	{125, 48000, 6000000, 0x04, 0x04, 0x1F, 0x2D, 0x8A, 0x0A, 0x27, 0x27},
 
 	{128, 8000, 1024000, 0x60, 0x00, 0x05, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
-	{128, 16000, 2048000, 0x20, 0x00, 0x31, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{128, 44100, 5644800, 0xE0, 0x00, 0x01, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{128, 48000, 6144000, 0xE0, 0x00, 0x01, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{128, 16000, 2048000, 0x20, 0x00, 0x31, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{128, 44100, 5644800, 0xE0, 0x00, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{128, 48000, 6144000, 0xE0, 0x00, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{144, 8000, 1152000, 0x20, 0x00, 0x03, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{144, 16000, 2304000, 0x20, 0x00, 0x11, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{192, 8000, 1536000, 0x60, 0x02, 0x0D, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
@@ -415,10 +415,10 @@ static const struct _coeff_div coeff_div_v3[] = {
 
 	{200, 48000, 9600000, 0x04, 0x04, 0x0F, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
 	{250, 48000, 12000000, 0x04, 0x04, 0x0F, 0x2D, 0xCA, 0x0A, 0x27, 0x27},
-	{256, 8000, 2048000, 0x60, 0x00, 0x31, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
-	{256, 16000, 4096000, 0x20, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{256, 44100, 11289600, 0xE0, 0x00, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{256, 48000, 12288000, 0xE0, 0x00, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{256, 8000, 2048000, 0x60, 0x00, 0x31, 0x35, 0x08, 0x19, 0x1F, 0x7F},
+	{256, 16000, 4096000, 0x20, 0x00, 0x01, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{256, 44100, 11289600, 0xE0, 0x01, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{256, 48000, 12288000, 0xE0, 0x01, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{288, 8000, 2304000, 0x20, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{384, 8000, 3072000, 0x60, 0x02, 0x05, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
 	{384, 16000, 6144000, 0x20, 0x02, 0x03, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
@@ -427,10 +427,10 @@ static const struct _coeff_div coeff_div_v3[] = {
 
 	{400, 48000, 19200000, 0xE4, 0x04, 0x35, 0x6d, 0xCA, 0x0A, 0x1F, 0x1F},
 	{500, 48000, 24000000, 0xF8, 0x04, 0x3F, 0x6D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{512, 8000, 4096000, 0x60, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
-	{512, 16000, 8192000, 0x20, 0x00, 0x30, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{512, 44100, 22579200, 0xE0, 0x00, 0x00, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{512, 48000, 24576000, 0xE0, 0x00, 0x00, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{512, 8000, 4096000, 0x60, 0x00, 0x01, 0x08, 0x19, 0x1B, 0x1F, 0x7F},
+	{512, 16000, 8192000, 0x20, 0x00, 0x30, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{512, 44100, 22579200, 0xE0, 0x00, 0x00, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{512, 48000, 24576000, 0xE0, 0x00, 0x00, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{768, 8000, 6144000, 0x60, 0x02, 0x11, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
 	{768, 16000, 12288000, 0x20, 0x02, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
 	{768, 32000, 24576000, 0xE0, 0x02, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
diff --git a/sound/soc/codecs/es8326.h b/sound/soc/codecs/es8326.h
index ee12caef8105..c3e52e7bdef5 100644
--- a/sound/soc/codecs/es8326.h
+++ b/sound/soc/codecs/es8326.h
@@ -104,7 +104,7 @@
 #define ES8326_MUTE (3 << 0)
 
 /* ES8326_CLK_CTL */
-#define ES8326_CLK_ON (0x7e << 0)
+#define ES8326_CLK_ON (0x7f << 0)
 #define ES8326_CLK_OFF (0 << 0)
 
 /* ES8326_CLK_INV */
-- 
2.17.1

