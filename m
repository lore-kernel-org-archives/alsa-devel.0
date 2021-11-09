Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E87C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6465F6115B
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6465F6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F751168F;
	Tue,  9 Nov 2021 07:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F751168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636441228;
	bh=4qWdVjjY1iocZurh4EePlGKkSTxgaiYe7eyYvxWH9Tk=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tZm9ZotRZQXpXCQxY14wsPLBlvDgAuoSowPDuqlCAoeJPyx7cfO6TKj0fsGdapZoF
	 Y2K5vRC2ORdIeyscGYjblbM1++6qo1+8QILOYkqHvcBZ/P+qqCSvawjesduUGb/keE
	 8TQodkoKzCLJThkSxvX3bbXs5w5h9OzRCUKnAg64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25970F80515;
	Tue,  9 Nov 2021 07:57:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6319AF8049E; Tue,  9 Nov 2021 01:38:01 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8304EF801D8
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 01:37:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8304EF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="osLlh7wM"
Received: by mail-pl1-x634.google.com with SMTP id p18so17637318plf.13
 for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2021 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=n2y5uM6W39UUewevKc2q7vpt51dJGo4Ea4brCbFJv0w=;
 b=osLlh7wMKgm3zPegAe8U7FuoEoPOCP3zbMR683xR04/0AndAYJl/fjTqoPMtuai56i
 P5aJyfAi9XpG5tjOpfoLaNFSa8N7xGbfQun6YIkOQBvIzthQajl4AU2iYpZorIYFAgxG
 66u0ZJMmh6vE8hbrXFnf0GlYdrpcT/BV7z8Lsr+E7XaXhAdqOI3DpFJ2wxt49dB3dLEd
 1K4Hg6pWVk8MIrceEZogSexwkFzGY+kKipbbTT5zz5CyzF622UUs6SO4nqFPOVqQwJMO
 n/xbFoh49gkB1XnarxC0UatSuyT1wKJd/O46ZTQElmFpIuFw3pnYOUSwaV7uOjeU0pDB
 84wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=n2y5uM6W39UUewevKc2q7vpt51dJGo4Ea4brCbFJv0w=;
 b=yKUICsxmoIZsiaSj+wEZqVdR/rQEBbXOpEsad/o6TVzjvQVt3YiuDyiubVKTlJcKzV
 vIgssmN1cl84b2N9dvf+fr3FkIwQ0J9y+ZPj/w2kRCh+lFaDq7vQwc58PfSoen6iy6zL
 MnwE7FNlMlUfSp9+nLsmpGS5kr7Z0yWFDg9zW2nBVTpZi0uTBZOQWmXKlQgg/PT54eUi
 0F665vnhjywcT7Gb9qNd4bYnhMByAF8NVqH0neerPQA3TJu99KBjXEjIFsr/xy4QjfXy
 wQG20XIUhR9YO0scgyqMFXOS0L80Ba4lWK7mJQjKBOUFcdaZvgq3s59YEpvPgiQfh67K
 gMxA==
X-Gm-Message-State: AOAM533eZlX67JhFpxRQih2dg7GDmyjGSsW9o586025VXSLNNrVh+9VS
 Tedx7V19wRL4LyWDyfjA9rk=
X-Google-Smtp-Source: ABdhPJyqVBxYAt7idy0hOca8/rOgyDPasaYfn7MRr9QBPjTtT9TWgAL6hc2NPatJbQrxxcLf1/gbLw==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id
 o4-20020a170902bcc400b00141bfc40adamr2990079pls.20.1636418266871; 
 Mon, 08 Nov 2021 16:37:46 -0800 (PST)
Received: from raspberrypi ([49.166.114.232])
 by smtp.gmail.com with ESMTPSA id c9sm13308705pgq.58.2021.11.08.16.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 16:37:46 -0800 (PST)
Date: Tue, 9 Nov 2021 00:37:42 +0000
From: Austin Kim <austindh.kim@gmail.com>
To: tiwai@suse.com, perex@perex.cz
Subject: [PATCH] ALSA: missing check for possible NULL after the call to
 kstrdup
Message-ID: <20211109003742.GA5423@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 09 Nov 2021 07:57:02 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 austin.kim@lge.com
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

From: Austin Kim <austin.kim@lge.com>

If kcalloc() return NULL due to memory starvation, it is possible for 
kstrdup() to return NULL in similar case. So add null check after the call 
to kstrdup() is made.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 sound/synth/emux/emux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 49d1976a132c..6dab3c5bac00 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -88,7 +88,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	emu->name = kstrdup(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(struct snd_emux_voice),
 			      GFP_KERNEL);
-	if (emu->voices == NULL)
+	if ((emu->name == NULL) || (emu->voices == NULL))
 		return -ENOMEM;
 
 	/* create soundfont list */
-- 
2.20.1

