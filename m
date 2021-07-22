Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85425C63793
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 11:52:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B468E61353
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 11:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B468E61353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C735416D2;
	Thu, 22 Jul 2021 13:51:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C735416D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626954762;
	bh=kOFBp4v2qkcodZtyNPfTvOp2J0QrY170TFIEjpCtOBI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cn+fcpWfUvo9AZzYiYYipBsXHS8G2EL3Ue63s11LLseQCxJoZbSqS5Wmeh/NqKYnF
	 YkPsf4gjfPsidgUztBpuZ9bIlJlRsvGpCCV+7CBNp2lLOui2SrL+yCs8Kap3/EheFV
	 sBVkBTfwdVXZiivHGVBVkz5M3SX8jGnySfv1aeJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65EECF80218;
	Thu, 22 Jul 2021 13:51:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39C79F80256; Thu, 22 Jul 2021 13:51:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C88CF800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 13:51:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C88CF800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz
 header.b="BsmbrtiP"; 
 dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz
 header.b="3WMc1EBu"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 788071FF03;
 Thu, 22 Jul 2021 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1626954702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBgN2J1JHNvtg8ki+S6zhAqVVORKz+BHkhKDPGGQs2M=;
 b=BsmbrtiPzgRZ/EcioZyTluiYZE3+GI1zcZxERNztahQ4B8XEERSYU7smUKT4Q6dCKZVRM+
 yakOzNp3pqQj3wKmoGa62nMbdtzdbE9H0GkpAJVxIU9u4JUbZVrjtj7f5v3p1UcIoFaZ5Y
 VrWShh8t88um/57T1YDokZzSZfBGs+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1626954702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBgN2J1JHNvtg8ki+S6zhAqVVORKz+BHkhKDPGGQs2M=;
 b=3WMc1EBuPtDbrB61bo1cz7dMSkrLlgF2HD8HbPFRk8v33ZP5eZrekg6q9Mc6letjnQcXdc
 1m/JwxuQXVV6DqCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3AC8CA3B85;
 Thu, 22 Jul 2021 11:51:42 +0000 (UTC)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/2] v253_init: eliminate pointer to string
Date: Thu, 22 Jul 2021 13:51:41 +0200
Message-Id: <20210722115141.516-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722115141.516-1-jslaby@suse.cz>
References: <20210722115141.516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.cz>
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

There is no need to have an extra pointer to a string (v253_init).
Convert it to an array.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/cx20442.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 65c6b92d7b5f..13258f3ca9aa 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -206,7 +206,7 @@ static int cx20442_write(struct snd_soc_component *component, unsigned int reg,
  */
 
 /* Modem init: echo off, digital speaker off, quiet off, voice mode */
-static const char *v253_init = "ate0m0q0+fclass=8\r";
+static const char v253_init[] = "ate0m0q0+fclass=8\r";
 
 /* Line discipline .open() */
 static int v253_open(struct tty_struct *tty)
-- 
2.32.0

