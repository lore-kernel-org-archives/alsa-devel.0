Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EACFC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 07:15:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DEB60184
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 07:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0DEB60184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B16A216A2;
	Tue, 16 Nov 2021 08:14:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B16A216A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637046911;
	bh=EyJuToFR4H7TS2+MR8rJeytooPKOWf4cLxcp9SuuZ5c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPwkUYRZnfreU6inomT0KeOD7W0G5R5H6mMumd0X6eKFO/aE8Q7VU0AAbmYCehQFN
	 smZxa6EENMBxO/4FEitbHon033JyuDteqze7Yiul52HB5LTDJJe3i5EqqCV8QNanSY
	 GuBBxH/Yiba15KgZsQoeQk9Z0nVSS70cxoDGSIXo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86A02F804C3;
	Tue, 16 Nov 2021 08:13:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59063F804E7; Tue, 16 Nov 2021 08:13:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CA6DF8026D
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 08:13:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CA6DF8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="dK674Yfo"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="gdj74LJc"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 75DF81FC9E
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637046799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx7svMbROXQy3z0yDxLw7KUsN13UGdFAw9oE/A6YTEo=;
 b=dK674Yfo3F0wtqnSSnseM30rc3vk/ktHBjCYmPb5rXHcjX0AOyzkCqLor38SGSDoU/4egq
 vGwJpZreLhrViGzSZuejXgBmMyHyWEgEv3hB/dSVVm5EXTxzfmdFjsXLviVVu1nhsRpBSO
 KV6ABkvI233kfLkiSkYzuGkLC8o1Uyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637046799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx7svMbROXQy3z0yDxLw7KUsN13UGdFAw9oE/A6YTEo=;
 b=gdj74LJc1LXds9OSrevh2HMpxi3ZVfGA6UQxdgiDMXeJcoS7ANfWQwvMe4CcLjimMpwL37
 dgoUnUjo32F2MxDw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 65C49A3B84;
 Tue, 16 Nov 2021 07:13:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA: hda: Add missing rwsem around snd_ctl_remove() calls
Date: Tue, 16 Nov 2021 08:13:14 +0100
Message-Id: <20211116071314.15065-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211116071314.15065-1-tiwai@suse.de>
References: <20211116071314.15065-1-tiwai@suse.de>
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

Fixes: d13bd412dce2 ("ALSA: hda - Manage kcontrol lists")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0c4a337c9fc0..eda70814369b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1727,8 +1727,11 @@ void snd_hda_ctls_clear(struct hda_codec *codec)
 {
 	int i;
 	struct hda_nid_item *items = codec->mixers.list;
+
+	down_write(&codec->card->controls_rwsem);
 	for (i = 0; i < codec->mixers.used; i++)
 		snd_ctl_remove(codec->card, items[i].kctl);
+	up_write(&codec->card->controls_rwsem);
 	snd_array_free(&codec->mixers);
 	snd_array_free(&codec->nids);
 }
-- 
2.31.1

