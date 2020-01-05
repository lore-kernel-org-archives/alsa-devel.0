Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01082C33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:56:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCAB2077B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n2Q1FhvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCAB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC9C817AC;
	Sun,  5 Jan 2020 15:55:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC9C817AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578236178;
	bh=LHNM6QwOomgNhDkFZJlh/bSPjjSJPAcnA1f6dF8cgFs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2Q1FhvFkm/pCpVV/ImuBpIm3ew4s7yDv3n2cpkHlSU3LJofIcQycqzXxHTuUnlxw
	 HLGBG3hl6huTFVmkCeJ3p1Sjv4PMpY7ZW7zJSIk9hZjCI6HDM5rlQygcopLdzog5v1
	 jfjX4aQfKgZy1UvE2Kghpv0rY0AZ/A5qwh6am6xc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FC8DF80344;
	Sun,  5 Jan 2020 15:49:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7169F80323; Sun,  5 Jan 2020 15:48:50 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E37BF80271
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E37BF80271
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 30ED6B1CF
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:27 +0100
Message-Id: <20200105144823.29547-13-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 12/68] ALSA: caiaq: More constifications
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

Apply const prefix to each possible place: the rate table, the
controller tables, and the key tables.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/caiaq/audio.c   |  2 +-
 sound/usb/caiaq/control.c | 20 ++++++++++----------
 sound/usb/caiaq/input.c   | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 41993a5c0537..e9243d53a107 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -179,7 +179,7 @@ static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 #error "Change this table"
 #endif
 
-static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
+static const unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
 				48000, 64000, 88200, 96000, 176400, 192000 };
 
 static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 532e354f6124..af459c49baf4 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -163,14 +163,14 @@ struct caiaq_controller {
 	int index;
 };
 
-static struct caiaq_controller ak1_controller[] = {
+static const struct caiaq_controller ak1_controller[] = {
 	{ "LED left", 	2 },
 	{ "LED middle", 1 },
 	{ "LED right", 	0 },
 	{ "LED ring", 	3 }
 };
 
-static struct caiaq_controller rk2_controller[] = {
+static const struct caiaq_controller rk2_controller[] = {
 	{ "LED 1",		5  },
 	{ "LED 2",		4  },
 	{ "LED 3",		3  },
@@ -196,7 +196,7 @@ static struct caiaq_controller rk2_controller[] = {
 	{ "LED 7seg_3g",	23 }
 };
 
-static struct caiaq_controller rk3_controller[] = {
+static const struct caiaq_controller rk3_controller[] = {
 	{ "LED 7seg_1a",        0 + 0 },
 	{ "LED 7seg_1b",        0 + 1 },
 	{ "LED 7seg_1c",        0 + 2 },
@@ -244,7 +244,7 @@ static struct caiaq_controller rk3_controller[] = {
 	{ "LED pedal",		32 + 8 }
 };
 
-static struct caiaq_controller kore_controller[] = {
+static const struct caiaq_controller kore_controller[] = {
 	{ "LED F1",		8   | CNT_INTVAL },
 	{ "LED F2",		12  | CNT_INTVAL },
 	{ "LED F3",		0   | CNT_INTVAL },
@@ -278,7 +278,7 @@ static struct caiaq_controller kore_controller[] = {
 	{ "LED control",	26  | CNT_INTVAL }
 };
 
-static struct caiaq_controller a8dj_controller[] = {
+static const struct caiaq_controller a8dj_controller[] = {
 	{ "Current input mode",			0 | CNT_INTVAL 	},
 	{ "GND lift for TC Vinyl mode", 	24 + 0 		},
 	{ "GND lift for TC CD/Line mode", 	24 + 1 		},
@@ -286,11 +286,11 @@ static struct caiaq_controller a8dj_controller[] = {
 	{ "Software lock", 			40 		}
 };
 
-static struct caiaq_controller a4dj_controller[] = {
+static const struct caiaq_controller a4dj_controller[] = {
 	{ "Current input mode",	0 | CNT_INTVAL 	}
 };
 
-static struct caiaq_controller kontrolx1_controller[] = {
+static const struct caiaq_controller kontrolx1_controller[] = {
 	{ "LED FX A: ON",		7 | CNT_INTVAL	},
 	{ "LED FX A: 1",		6 | CNT_INTVAL	},
 	{ "LED FX A: 2",		5 | CNT_INTVAL	},
@@ -327,7 +327,7 @@ static struct caiaq_controller kontrolx1_controller[] = {
 	{ "LED Deck B: SYNC",		8  | CNT_INTVAL	},
 };
 
-static struct caiaq_controller kontrols4_controller[] = {
+static const struct caiaq_controller kontrols4_controller[] = {
 	{ "LED: Master: Quant",			10  | CNT_INTVAL },
 	{ "LED: Master: Headphone",		11  | CNT_INTVAL },
 	{ "LED: Master: Master",		12  | CNT_INTVAL },
@@ -500,7 +500,7 @@ static struct caiaq_controller kontrols4_controller[] = {
 	{ "LED: FX2: Mode",			133 | CNT_INTVAL },
 };
 
-static struct caiaq_controller maschine_controller[] = {
+static const struct caiaq_controller maschine_controller[] = {
 	{ "LED: Pad 1",				3  | CNT_INTVAL },
 	{ "LED: Pad 2",				2  | CNT_INTVAL },
 	{ "LED: Pad 3",				1  | CNT_INTVAL },
@@ -568,7 +568,7 @@ static struct caiaq_controller maschine_controller[] = {
 	{ "Backlight Display",			59 | CNT_INTVAL }
 };
 
-static int add_controls(struct caiaq_controller *c, int num,
+static int add_controls(const struct caiaq_controller *c, int num,
 			struct snd_usb_caiaqdev *cdev)
 {
 	int i, ret;
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 533eb69fe4e6..1e2cf2f08eec 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -14,13 +14,13 @@
 #include "device.h"
 #include "input.h"
 
-static unsigned short keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
-static unsigned short keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
+static const unsigned short keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
+static const unsigned short keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
 					 KEY_5, KEY_6, KEY_7 };
-static unsigned short keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
+static const unsigned short keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
 					 KEY_5, KEY_6, KEY_7, KEY_8, KEY_9 };
 
-static unsigned short keycode_kore[] = {
+static const unsigned short keycode_kore[] = {
 	KEY_FN_F1,      /* "menu"               */
 	KEY_FN_F7,      /* "lcd backlight       */
 	KEY_FN_F2,      /* "control"            */
@@ -60,7 +60,7 @@ static unsigned short keycode_kore[] = {
 #define MASCHINE_PADS      (16)
 #define MASCHINE_PAD(X)    ((X) + ABS_PRESSURE)
 
-static unsigned short keycode_maschine[] = {
+static const unsigned short keycode_maschine[] = {
 	MASCHINE_BUTTON(40), /* mute       */
 	MASCHINE_BUTTON(39), /* solo       */
 	MASCHINE_BUTTON(38), /* select     */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
