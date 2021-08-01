Return-Path: <SRS0=FXXq=MY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC6EC4338F
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 06:27:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5928E61057
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 06:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5928E61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E0771891;
	Sun,  1 Aug 2021 08:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E0771891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627799220;
	bh=piRnIqqZll/zh2uB/yFAbghRxPEi+HZiV+iEDPKvNrI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jGd8IAVoXHMuyTIOhycYBaZMxH21b3mOIdp4lzL0kBhkyP3/KNrTM6wwKVmtS1F4d
	 JdD8zpGs6sO/+qmbSp3D54O12VRfaRxzF9SEON2+nGwXU8YuCOiYSosT2pQcA9newj
	 cUZmsXGY9zhyYE0oa0xQvOzeDhPPdCgMOjMtQIBo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A13EF8016D;
	Sun,  1 Aug 2021 08:26:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68AE8F802E8; Sun,  1 Aug 2021 08:26:08 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E730F80095
 for <alsa-devel@alsa-project.org>; Sun,  1 Aug 2021 08:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E730F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="l0vqmorM"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5BF423F10D; 
 Sun,  1 Aug 2021 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1627799154;
 bh=CzjCXhgl0a3d1ieMBVQ+XZEZoQi8gWaJjxi2fu4cq5E=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=l0vqmorMAPZIl0H+3yk13NHRpVICt/c0IN+RqRegnFA+u0JzXwm4dk4mLCtDT2rOp
 CxEdQK8FwEd99CZTNgmKXlzHcPC16tLId1N+7Hgh3M5laWu3nQnXrnypgy2ojYCFPQ
 Dflzt9tyWBBVB7lwGoPaG6MXF2puGBFv2PJtzZamtt7BZOpNeDR7sGbgszKMen+gjJ
 MdnwF+3uE2M9gqJlLa3qwNT0MTIH8aheCZ5qXZcv8lhKDRA8slOEgedO5XHKnDzL7g
 EW0T2pM3VI2400orB+tYgVyqueIEAt9yKsLMHzD2S1hFnyPBDWtQoM4x3ecHKsvkMN
 yxo1jryPTC9hg==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: make array static const, makes object smaller
Date: Sun,  1 Aug 2021 07:25:48 +0100
Message-Id: <20210801062548.137770-1-colin.king@canonical.com>
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
static.  Makes the object code smaller by 56 bytes.

Before:
   text    data     bss     dec     hex filename
 103512   34380       0  137892   21aa4 ./sound/usb/mixer.o

After:
   text    data     bss     dec     hex filename
 103264   34572       0  137836   21a6c ./sound/usb/mixer.o

gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index f4cdaf1ba44a..aec2499284a5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1572,8 +1572,9 @@ static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 static void check_no_speaker_on_headset(struct snd_kcontrol *kctl,
 					struct snd_card *card)
 {
-	const char *names_to_check[] = {
-		"Headset", "headset", "Headphone", "headphone", NULL};
+	static const char *names_to_check[] = {
+		"Headset", "headset", "Headphone", "headphone", NULL
+	};
 	const char **s;
 	bool found = false;
 
-- 
2.31.1

