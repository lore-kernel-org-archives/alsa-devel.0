Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7613C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 06:27:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F13820776
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 06:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nYinsjO3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ar/mZUlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F13820776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD8D31720;
	Tue, 26 May 2020 08:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD8D31720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590474454;
	bh=R3dTRVKftPoc/aiSFln7/jOqpx7ict6RTGEvEhzwFlw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nYinsjO3W5qmIegL5Dzkqt7ZHJcZ7YCt3MD3Pa7/w7zRSV+G89+GOKyeOm+t1rSoS
	 9NwSCBnghf1kgxszbmlkFfFI7f/ewghsem2WQFFzL0B9eaGVpS+V/e21+VU3VpsDQ7
	 kH5Hexv+sSxfuvAsDMNC7aQRHJH6vC7QY9sAY14I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76DD9F8014A;
	Tue, 26 May 2020 08:26:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 288D8F80150; Tue, 26 May 2020 08:26:43 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10275F80131
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 08:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10275F80131
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com
 header.i=@endlessm-com.20150623.gappssmtp.com header.b="ar/mZUlI"
Received: by mail-pl1-x642.google.com with SMTP id q16so8249370plr.2
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2020 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D3oJjqxF038PAanM9YgOnN3aymIalIBeYa6R2RlB7aM=;
 b=ar/mZUlISeoa/YvBkyRo5k2xzWfkZqVsKjW76QCwIA9CSsBy0Z8NV9gfqv0Wr7ntSD
 1+G1fkBMj0jdKcK8Hie2ZKaa/8l5CaO8eKoAxmXEz771osTlC4ay4BdDoy4YlmlIUuHg
 EKbpQYiqa7ac1trIdzZ3cI8sVLoLUjLHIgPloZ8Udo1OWbME6c5eK0Xbo672MOWmMeYP
 eoZdbsNMgCAAC3PZh3/b5etXBsTe+1KAG5SluLtJOEwZZWxftzxuG0n5KfeoBmCssAle
 FFzEwSM++kKL8upc6+k1Tiep0B7otIZ0WLY7pAZt9ujpNNEajrvLAiruyCdPT/IQ8mLE
 eYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D3oJjqxF038PAanM9YgOnN3aymIalIBeYa6R2RlB7aM=;
 b=GY0eKVORSLsP5qEwdy9V8HbDLYwgtxESAcKpgNU/k63Yhk0YQYXvXU6GqObFRw6rmm
 Wf2Knhtsf+MZa4T1Uhz6Ldxz3B3v3ayAqtqTgWGdP0N2qhHE7OxBpP/6sWVSn9cxgDmk
 CebhQnaJMU+nwYP/RMq+bGipx1vP/jkPzD5eQoarbfTOcUOHJnfOWKOqqyWzmisRAtdU
 C/D+Q67lBDcTmHktNfxM3BYe0OV3OmWIYbxt8gd2L2WVwyEUrdCop+XM9RqWIO+c4BIm
 eZxYEK0Xw8uiT1YTwFMJPHOT7cwWK2v9uXS7Z1vcjB6wtsFW6NdDTi3gsjGuzzEI8l4H
 eJpA==
X-Gm-Message-State: AOAM532eI/daGPTo/+q/C9HxxWOZfcSC2ZH9qeNHtAt7GAVkkV3rof3I
 JHj9vmB25CeaCHb77Yn10sfmEg==
X-Google-Smtp-Source: ABdhPJyGUmR2KNz023iEAm+9LZ7uPanEpwEpqAX6A8/mIJrn0/OKY7UzAd/GWpw14vjA/TPT0D8SJw==
X-Received: by 2002:a17:90a:23a4:: with SMTP id
 g33mr24011855pje.79.1590474393881; 
 Mon, 25 May 2020 23:26:33 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-130.HINET-IP.hinet.net.
 [59.127.47.130])
 by smtp.gmail.com with ESMTPSA id i14sm14584574pfo.162.2020.05.25.23.26.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 May 2020 23:26:33 -0700 (PDT)
From: Chris Chiu <chiu@endlessm.com>
To: perex@perex.cz,
	tiwai@suse.com,
	benquike@gmail.com
Subject: [PATCH] ALSA: usb: mixer: volume quirk for ESS Technology Asus USB DAC
Date: Tue, 26 May 2020 14:26:13 +0800
Message-Id: <20200526062613.55401-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chiu@endlessm.com>, alsa-devel@alsa-project.org,
 linux@endlessm.com, linux-kernel@vger.kernel.org
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

The Asus USB DAC is a USB type-C audio dongle for connecting to
the headset and headphone. The volume minimum value -23040 which
is 0xa600 in hexadecimal with the resolution value 1 indicates
this should be endianness issue caused by the firmware bug. Add
a volume quirk to fix the volume control problem.

Also fixes this warning:
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [5] FU [Headset Capture Volume] ch = 1, val = -23040/0/1
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [7] FU [Headset Playback Volume] ch = 1, val = -23040/0/1

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/usb/mixer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 81b2db0edd5f..0b568a9fdab3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1171,6 +1171,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 384;
 		}
 		break;
+	case USB_ID(0x0495, 0x3042): /* ESS Technology Asus USB DAC */
+		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
+			strstr(kctl->id.name, "Capture Volume") != NULL) {
+			cval->min >>= 8;
+			cval->max = 0;
+			cval->res = 1;
+		}
+		break;
 	}
 }
 
-- 
2.20.1

