Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3AAC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 07:14:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A343260184
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 07:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A343260184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74F461683;
	Tue, 16 Nov 2021 08:13:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74F461683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637046859;
	bh=DLyty+uVOqgHt3H4tVXA8GTbXuNl8YL/ZbScUIsriWQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LXSHIPssWR0hxgEFFMUhVl3e5W1+j47rZygvF//w+eW7S4GLYD3lfMV6MoJN/SR/3
	 Z4GH1V5lAbUgWLVmmDmiLFvpVgo2qRl1NI/SUV7deiNRKkl5dCbYRGIE062FmUZGRY
	 LIojc+QDX9OqoCYT4Q9ryDrs8UUFAtuswP4Vbsns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02599F80272;
	Tue, 16 Nov 2021 08:13:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E91FFF802C4; Tue, 16 Nov 2021 08:13:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84FAEF800FA
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 08:13:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84FAEF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="h2qtOn55"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="C6ik6hjU"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B8483218BB
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 07:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637046797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EakwiiJVZ4Mbo2CV8wfllOCGcwBMKyBDpXRnCumoCXk=;
 b=h2qtOn55b6+jSTCZrJ4355mGo/0qyCRHwAVdSdFfL2QVX2uAHC+I68JXUIQKCX+PpHRHB5
 XS+TCzSH/k7Du3xe/VNM0IvsfpACwY0zY/N2L4MlLMywYjZ2lzpif3hv+w3HNcpUhL+0hM
 0/TZO4Gww7lSORqLU9DTCliQBB6ltJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637046797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EakwiiJVZ4Mbo2CV8wfllOCGcwBMKyBDpXRnCumoCXk=;
 b=C6ik6hjU8e45/k8iYktfvFM6GZ7hmxP5BzYDMqMSjA0IyLThcM/WzIWV8Ll7Sigi1q1Dk1
 ys1EIX8sGEjKHSCQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A7DDDA3B81;
 Tue, 16 Nov 2021 07:13:17 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ALSA: jack: Add missing rwsem around snd_ctl_remove()
 calls
Date: Tue, 16 Nov 2021 08:13:12 +0100
Message-Id: <20211116071314.15065-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

snd_ctl_remove() has to be called with card->controls_rwsem held (when
called after the card instantiation).  This patch add the missing
rwsem calls around it.

Fixes: 9058cbe1eed2 ("ALSA: jack: implement kctl creating for jack devices")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/jack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 32350c6aba84..f50a1e920e1d 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -62,10 +62,13 @@ static int snd_jack_dev_free(struct snd_device *device)
 	struct snd_card *card = device->card;
 	struct snd_jack_kctl *jack_kctl, *tmp_jack_kctl;
 
+	down_write(&card->controls_rwsem);
 	list_for_each_entry_safe(jack_kctl, tmp_jack_kctl, &jack->kctl_list, list) {
 		list_del_init(&jack_kctl->list);
 		snd_ctl_remove(card, jack_kctl->kctl);
 	}
+	up_write(&card->controls_rwsem);
+
 	if (jack->private_free)
 		jack->private_free(jack);
 
-- 
2.31.1

