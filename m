Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C01C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:09:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109860238
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109860238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EC1F1669;
	Wed, 31 Mar 2021 20:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EC1F1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617214145;
	bh=QDHNpeNCdikZ3aR70vvJXIDTtgdbXzHPHMAydXp3jUo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u7Daaf2J3FYotgw7JYXfyqTc3a/pGY0zL8Y3CXXzpaPqVqpdn7mG8VLnFkuOP/hzo
	 xbFhM1UQ6wUHb0DrrIYp5n2BV/KBqTVLRHeAkeTcggNUKb5tidLecgKk9TqGxJZJii
	 StSueSeWw+8vKCn+Ve2miPBbjPlFL+YaJ57hfN/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BA4DF8016E;
	Wed, 31 Mar 2021 20:07:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30A33F8020C; Wed, 31 Mar 2021 20:07:38 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 042CDF8016E
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 20:07:31 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8FB22A0040;
 Wed, 31 Mar 2021 20:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8FB22A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617214051; bh=duEazCV0Ib10+w/eVt5xAYmeSBDAOY/SAMGLTLLK2uU=;
 h=From:To:Cc:Subject:Date:From;
 b=TKosBR00OYE+ebMIulXUujPLgHpwlxDMSNEbwY0t50ZBbOf3TDiXkRRjPfwX+XCwc
 b3c8+13dXf7XtC+N3m6l+F4hUQc24R0oQKcAons5ACbkFs4GLAlSvoNVkQiKv/5t2x
 FiorqbRbz0YB4TM5Rro8btEZWk5Q7Tkhc5IQn86c=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 31 Mar 2021 20:07:28 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: control led - improve the set_led_id() parser
Date: Wed, 31 Mar 2021 20:07:25 +0200
Message-Id: <20210331180725.663623-1-perex@perex.cz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

It may be possible that the string pointer does not move
when parsing. Add a code which detects this state and
simply break the parser loop in this case.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/control_led.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index d4fb8b873f34..788fd9e275e0 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -506,7 +506,7 @@ static char *parse_iface(char *s, unsigned int *val)
 static ssize_t set_led_id(struct snd_ctl_led_card *led_card, const char *buf, size_t count,
 			  bool attach)
 {
-	char buf2[256], *s;
+	char buf2[256], *s, *os;
 	size_t len = max(sizeof(s) - 1, count);
 	struct snd_ctl_elem_id id;
 	int err;
@@ -517,6 +517,7 @@ static ssize_t set_led_id(struct snd_ctl_led_card *led_card, const char *buf, si
 	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	s = buf2;
 	while (*s) {
+		os = s;
 		if (!strncasecmp(s, "numid=", 6)) {
 			s = parse_uint(s + 6, &id.numid);
 		} else if (!strncasecmp(s, "iface=", 6)) {
@@ -546,6 +547,8 @@ static ssize_t set_led_id(struct snd_ctl_led_card *led_card, const char *buf, si
 		}
 		if (*s == ',')
 			s++;
+		if (s == os)
+			break;
 	}
 
 	err = snd_ctl_led_set_id(led_card->number, &id, led_card->led->group, attach);
-- 
2.30.2
