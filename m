Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F1C33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:43:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8270820720
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kzAzWpL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8270820720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D88CD16BA;
	Thu,  6 Feb 2020 17:42:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D88CD16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581007390;
	bh=xxcRQzuNggVxqf7dsVyYzG5YLpyqX6yH0FUoe39UXq0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kzAzWpL9iePHQ91xS4mTDSNxFqmDtmMwJ+G68BMs3pL3BUZVLM97MGn2IGt0VVuKU
	 G7WtpZ1emDXW/XPAUwSYdC4kK7JW2ikFYg+ALTv7pNdIjTPp1jxng6HE/0wkpCbnvh
	 Yhnl+xjhKsmczcvhIYPEW5GWeVjQ93LmJFqEGAbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4716BF8028B;
	Thu,  6 Feb 2020 17:40:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28B03F80277; Thu,  6 Feb 2020 17:39:56 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D76A4F80212
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D76A4F80212
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 17D02AEE7
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 16:39:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:39:40 +0100
Message-Id: <20200206163945.6797-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200206163945.6797-1-tiwai@suse.de>
References: <20200206163945.6797-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 3/8] ALSA: usb-audio: Use pcm_for_each_format()
	macro for PCM format iterations
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

The new macro can fix the sparse warnings gracefully:
  sound/usb/proc.c:73:31: warning: restricted snd_pcm_format_t degrades to integer
  sound/usb/proc.c:73:38: warning: restricted snd_pcm_format_t degrades to integer
  sound/usb/proc.c:73:61: warning: restricted snd_pcm_format_t degrades to integer

No functional changes, just sparse warning fixes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index ffbf4bd9208c..4174ad11fca6 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -70,7 +70,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
 		snd_iprintf(buffer, "    Format:");
-		for (fmt = 0; fmt <= SNDRV_PCM_FORMAT_LAST; ++fmt)
+		pcm_for_each_format(fmt)
 			if (fp->formats & pcm_format_to_bits(fmt))
 				snd_iprintf(buffer, " %s",
 					    snd_pcm_format_name(fmt));
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
