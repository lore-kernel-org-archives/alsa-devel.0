Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCB2C54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 20:12:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FA320728
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 20:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r7x1Upiq";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snMZPzzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FA320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 874A9167F;
	Sat, 25 Apr 2020 22:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 874A9167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587845566;
	bh=FtGgbHY4Prtv9Xjud09TldujEm0Whs3xCevWoMDLR1A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r7x1Upiq1e08k6WnCctOXYKKDQwAJbfUrpGTAGBw1nhhYU0/1meBS5nnhYPHjdZJY
	 oEGiNF6yK1F0kGP7nWZATARh3Sf/ELkXCGKzLbsmsICXY7aeMLe3XpT6l9IdQF3yLe
	 lnxc1fJzhL5GGUT5mWYAJMQnhbww7JDgWy8tXNDc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01EFAF80159;
	Sat, 25 Apr 2020 22:11:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9438F801EC; Sat, 25 Apr 2020 22:11:53 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AFF5F800BE
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 22:11:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AFF5F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="snMZPzzy"
Received: by mail-pg1-x544.google.com with SMTP id t11so6447654pgg.2
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2k1av1tyvdh6GZhcN5D4YMVgv3ZyjCy2t6rq6Gh3IE=;
 b=snMZPzzyiHGucldZsOb4HyMr7AyHIgLiDE8tusGDu5dHaAbKHiDPfTq/C3t9cE4jB7
 fEv5QnMzvGS0YF7M54Y4+r1QnP8MQ90yA8vMfMFl1r1+vcq7hLWd5EXEy8MgrjmmH2o4
 xJYfd6hOkA1mP2627weH5mVrEhfFP36wE6ZkiLwuypOSLTiJfSImwGkgZmduRS9XZVk8
 g82fvBxbKD0/rb3Gx2uDhxToarFa2CVBo90Nd20pz/jsLaLgiA9MuUi6rvrW1YL/2zsT
 ULyQpF/wDHWDLsxyrZGs0dJh1RXy+t+aBiwLycI2yo57qkBz8kjUMb/yIpY1qPQGQNA0
 32lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2k1av1tyvdh6GZhcN5D4YMVgv3ZyjCy2t6rq6Gh3IE=;
 b=BOkZoBitQxd05KffrTn48a1x1T5TP/SsdXAEQ5W17nfU/jQGo3IydNPxvneF/I42vL
 MZVv2ZlEeduv5sidfYb9SflnVo02cDrVbEtt6FhVoCJy2VsV6l8Kpq61NiDvPAPezvuU
 m+jka/RFIORKd4Gr9402rbMv6W3/3mEeFyR5cVeo4cApUeFsCgjwrf2T8I6LENoAnD8P
 PgKoi2PynlgUdlsBQ1yTqfWGkX8DbK0Vz8mEfZNT1fsSLHAjSjfmtKjAOwIB0m5SR/fW
 fwWM3uBvJxbowmYX9YkN3NYx/qnKqkctexigCw8g9YLZVm5t6oIXCjTPUJE//bCeqb+6
 lPZA==
X-Gm-Message-State: AGi0PuajH3ZbXtHrpcMdfhp7t7rcL5zD0vbgYx08ba8UIdIDnQoRnGwW
 WjQ93HLahBHKWPwjujSToF8=
X-Google-Smtp-Source: APiQypLA7CcCVqPz+pgp7tBCRZNdeaPlgiN2G3MAfcwL2tPJb5G80JNT4t9IIjZDyJgbIJlPjajF1g==
X-Received: by 2002:a62:3803:: with SMTP id f3mr16459171pfa.322.1587845507846; 
 Sat, 25 Apr 2020 13:11:47 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id u188sm8746681pfu.33.2020.04.25.13.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2020 13:11:47 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Allison Randal <allison@lohutok.net>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: line6: Fix POD HD500 audio playback
Date: Sat, 25 Apr 2020 13:11:15 -0700
Message-Id: <20200425201115.3430-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
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

Apparently interface 1 is control interface akin to HD500X,
setting LINE6_CAP_CONTROL and choosing it as ctrl_if fixes
audio playback on POD HD500.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/usb/line6/podhd.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index d37db32ecd3b..e39dc85c355a 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -21,8 +21,7 @@
 enum {
 	LINE6_PODHD300,
 	LINE6_PODHD400,
-	LINE6_PODHD500_0,
-	LINE6_PODHD500_1,
+	LINE6_PODHD500,
 	LINE6_PODX3,
 	LINE6_PODX3LIVE,
 	LINE6_PODHD500X,
@@ -318,8 +317,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	/* TODO: no need to alloc data interfaces when only audio is used */
 	{ LINE6_DEVICE(0x5057),    .driver_info = LINE6_PODHD300 },
 	{ LINE6_DEVICE(0x5058),    .driver_info = LINE6_PODHD400 },
-	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
-	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
+	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500 },
 	{ LINE6_IF_NUM(0x414A, 0), .driver_info = LINE6_PODX3 },
 	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{ LINE6_IF_NUM(0x4159, 0), .driver_info = LINE6_PODHD500X },
@@ -352,23 +350,13 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x82,
 		.ep_audio_w = 0x01,
 	},
-	[LINE6_PODHD500_0] = {
+	[LINE6_PODHD500] = {
 		.id = "PODHD500",
 		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_PCM
+		.capabilities	= LINE6_CAP_PCM | LINE6_CAP_CONTROL
 				| LINE6_CAP_HWMON,
 		.altsetting = 1,
-		.ep_ctrl_r = 0x81,
-		.ep_ctrl_w = 0x01,
-		.ep_audio_r = 0x86,
-		.ep_audio_w = 0x02,
-	},
-	[LINE6_PODHD500_1] = {
-		.id = "PODHD500",
-		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 0,
+		.ctrl_if = 1,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,
-- 
2.25.0

