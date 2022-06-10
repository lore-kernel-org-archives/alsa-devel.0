Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F3C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 05:56:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD33F18BA;
	Tue, 14 Jun 2022 07:55:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD33F18BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655186177;
	bh=+whR3axy9Y9dIyAo2Ep6GIGWWJRRWQJHVVK8Cr8qTRE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gv3lUFRjYDgTBkUFqX0TvmzmiOQU7yDYSbtMY62+d0rJ0AwBB1aOhO/YiAPrgUf2a
	 4CcryEH+8iDzPWpKz5Tiy7USZPV87pdWsJcRrqUDXXwBpfQDJE/BXbaRKeao4nZi59
	 6MUAvCl5MTQPn7p/GuV/ai63ayAymxYQhlpH+xhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C7D8F80533;
	Tue, 14 Jun 2022 07:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFA6EF804D2; Fri, 10 Jun 2022 18:58:33 +0200 (CEST)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66C76F800DF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 18:58:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66C76F800DF
Received: from BUMER.localdomain (unknown [93.175.1.252])
 by mail.ispras.ru (Postfix) with ESMTPSA id 1C7FC40737C0;
 Fri, 10 Jun 2022 16:58:21 +0000 (UTC)
From: Daniil Dementev <d.dementev@ispras.ru>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: usb-audio: US16x08: Move overflow check before array
 access
Date: Fri, 10 Jun 2022 19:57:32 +0300
Message-Id: <20220610165732.2904-1-d.dementev@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jun 2022 07:54:10 +0200
Cc: Daniil Dementev <d.dementev@ispras.ru>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 linux-kernel@vger.kernel.org
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

Buffer overflow could occur in the loop "while", due to accessing an
array element before checking the index.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Daniil Dementev <d.dementev@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/usb/mixer_us16x08.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index b7b6f3834ed5..6eb7d93b358d 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -637,10 +637,10 @@ static int snd_get_meter_comp_index(struct snd_us16x08_meter_store *store)
 		}
 	} else {
 		/* skip channels with no compressor active */
-		while (!store->comp_store->val[
+		while (store->comp_index <= SND_US16X08_MAX_CHANNELS
+			&& !store->comp_store->val[
 			COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH)]
-			[store->comp_index - 1]
-			&& store->comp_index <= SND_US16X08_MAX_CHANNELS) {
+			[store->comp_index - 1]) {
 			store->comp_index++;
 		}
 		ret = store->comp_index++;
-- 
2.35.1.windows.2

