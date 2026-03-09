Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30E2EFCD6D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:34:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE4386024F;
	Mon,  9 Mar 2026 10:34:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE4386024F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773048873;
	bh=msN3ZiJEnwDLoCFL3ktp3bf7S5AjPmhNHN71nh2kZjg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ggGpntb000endy9TUU/X022j4qzMC5z6W6OQuFH537g09EXt6l5ZhzQPWIVapMDwG
	 eIvtoKOmeiziLVYDOJ5jeG6XsO/MKVh+AFaiJvv38jjFqtuX8tzQDj9e+S2CR4Vzp2
	 p0Oqhxv0ck+gOVBAngBwk3A1CZJCGQ31ObjgZ8YQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7C5DF80624; Mon,  9 Mar 2026 10:33:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D0F0F80622;
	Mon,  9 Mar 2026 10:33:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F4DCF80571; Mon,  9 Mar 2026 08:22:02 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 452CFF8001E
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2026 08:21:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 452CFF8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=FipDDQ/5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ST
	Qwf4PoSneb90M0vtP5ikDTJD5DzHGA/Ui7t+WaGNw=; b=FipDDQ/5Hfe1297mbd
	2cShBsiOGj2SnIdBRKQCJNbQ7MA1dLjmI4zzQmJHYgj7HL5831r6ph8ICjboaU/A
	rMmQAhmDv0S/l8WzqkeDU9XQC/PVNdlghOLIBAgAdamqkLo2ZglfOHvAh3TFbccj
	wzjETc+4PsybJeEg0+8EFWWhg=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wA3bfoPda5p73LiOg--.36932S2;
	Mon, 09 Mar 2026 15:21:52 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Cc: Robert Garcia <rob_garcia@163.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] ALSA: control: Avoid WARN() for symlink errors
Date: Mon,  9 Mar 2026 15:21:51 +0800
Message-Id: <20260309072151.2462506-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3bfoPda5p73LiOg--.36932S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7Kr45CF4UJF47Gw4xXrb_yoW8tFy5pF
	4jganrt3Zrtr9rJa9rur17Wry3Xan7X3W7Z395KrykArWfAryrurykKrnYqFy3AFZ3JFyU
	Xr45JF1v934akrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR_wIhUUUUU=
X-Originating-IP: [60.247.85.88]
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5RFn0mmudRFzgAAA3R
X-MailFrom: rob_garcia@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: H3VMT3YIHT5ALMXAS656UBNFUEKFQJBO
X-Message-ID-Hash: H3VMT3YIHT5ALMXAS656UBNFUEKFQJBO
X-Mailman-Approved-At: Mon, 09 Mar 2026 09:33:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H3VMT3YIHT5ALMXAS656UBNFUEKFQJBO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b2e538a9827dd04ab5273bf4be8eb2edb84357b0 ]

Using WARN() for showing the error of symlink creations don't give
more information than telling that something goes wrong, since the
usual code path is a lregister callback from each control element
creation.  More badly, the use of WARN() rather confuses fuzzer as if
it were serious issues.

This patch downgrades the warning messages to use the normal dev_err()
instead of WARN().  For making it clearer, add the function name to
the prefix, too.

Fixes: a135dfb5de15 ("ALSA: led control - add sysfs kcontrol LED marking layer")
Reported-by: syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/675664c7.050a0220.a30f1.018c.GAE@google.com
Link: https://patch.msgid.link/20241209095614.4273-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Use card->ctl_dev.kobj to keep struct consistent. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 sound/core/control_led.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 3eb1c5af82ad..df836ff550f8 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -693,10 +693,16 @@ static void snd_ctl_led_sysfs_add(struct snd_card *card)
 			goto cerr;
 		led->cards[card->number] = led_card;
 		snprintf(link_name, sizeof(link_name), "led-%s", led->name);
-		WARN(sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj, link_name),
-			"can't create symlink to controlC%i device\n", card->number);
-		WARN(sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj, "card"),
-			"can't create symlink to card%i\n", card->number);
+		if (sysfs_create_link(&card->ctl_dev.kobj, &led_card->dev.kobj,
+				      link_name))
+			dev_err(card->dev,
+				"%s: can't create symlink to controlC%i device\n",
+				 __func__, card->number);
+		if (sysfs_create_link(&led_card->dev.kobj, &card->card_dev.kobj,
+				      "card"))
+			dev_err(card->dev,
+				"%s: can't create symlink to card%i\n",
+				__func__, card->number);
 
 		continue;
 cerr:
-- 
2.34.1

