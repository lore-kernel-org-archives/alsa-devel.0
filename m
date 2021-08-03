Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A8C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:30:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8416660F56
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 12:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8416660F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 426C4176E;
	Tue,  3 Aug 2021 14:29:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 426C4176E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627993847;
	bh=cx4qYFuuQhP+mp5AN7QZ18jrdDNYsJrQY7dX+jSM8C0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A+GnIDpemIax757osbIQB1dyRtbPe0UBUfj40T6AVLHXQ424BIiQ4wMYbh9hDxdUP
	 IhSvhngUKtqsrABrBNbYVBwx4BMtssWGuGG1wYUAaI4u5xHzlxXXb+BUTXc8ILMWzi
	 +2bX2ZMltO/PaUfHytH3A/kMGHbV6Oa/7YXMvbNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85663F80082;
	Tue,  3 Aug 2021 14:29:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54F30F8032D; Tue,  3 Aug 2021 14:28:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF01FF80082
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 14:28:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF01FF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="cl6lKJkA"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D154A3F09C; 
 Tue,  3 Aug 2021 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1627993719;
 bh=oXGtMXBZ6/OGmpA64zDaYIoChgBpydPk9ddxo6Jrg+c=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=cl6lKJkA1kWqtnek77yG6ZDauzengYEyslQAmlke+/fKzcUd5URP+119L6+WU4+0J
 vufZbJu/7E2+bvdxVwlBBfgO9FEyuOOOtAH9/9kPLQPfuDDZHO0Dna27WuGK2J+aBr
 yGtbQOaRQ+gu2mUOXIbDzUpN1kT73/BC48lbrSUPKJbD3A+R8xzguds9yWO2QdOBmm
 +/2kl6c0ZOMYamQv3YsqP8Ydziv70so/hF/HmYgzV325PQq4i7P49ryTu19ixD0yIe
 KCbhtM5JuEMLA0Ti84hcJaT4Klobkthv1o1AQwto30KyIFZtsMrgtBkM9eA7JHLMeI
 vwJQ9N/nJjkPA==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH][V2] ALSA: usb-audio: make array static const,
 makes object smaller
Date: Tue,  3 Aug 2021 13:28:39 +0100
Message-Id: <20210803122839.7143-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Don't populate array names_to_check on the stack but instead it
static.  Makes the object code smaller by 56 bytes.  Also clean
up checkpatch warning by adding extra const for names_to_check
and pointer s.

Before:
    text    data     bss     dec     hex filename
  103512   34380       0  137892   21aa4 ./sound/usb/mixer.o

After:
    text    data     bss     dec     hex filename
  103264   34572       0  137836   21a6c ./sound/usb/mixer.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Clean up checkpatch warning on const-ness for names_to_check.
    Add extra const to clean up build warning on pointer s.
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index db7cb6b6dc4e..43bc59575a6e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1572,9 +1572,9 @@ static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 static void check_no_speaker_on_headset(struct snd_kcontrol *kctl,
 					struct snd_card *card)
 {
-	const char *names_to_check[] = {
+	static const char * const names_to_check[] = {
 		"Headset", "headset", "Headphone", "headphone", NULL};
-	const char **s;
+	const char * const *s;
 	bool found = false;
 
 	if (strcmp("Speaker", kctl->id.name))
-- 
2.31.1

