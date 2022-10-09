Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5990FC433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Oct 2022 10:43:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 459371F2;
	Sun,  9 Oct 2022 12:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 459371F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665312190;
	bh=4DDqoCxVDOHTohl0gQ5OJKp0HLUtZQHk5QqopdCAvO4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IGZ+xdbRcblx8SWvOyzpDHjJ7B4j3JZjExkMyhqOfWNGjbvkYUvaTaZlbkkGfueg9
	 y4sD8pIQuBBzqd1BbLRF0BEXFrAXAJUBv72E2eJqlybo/ZEoZa1hl46Dws8NwXySGm
	 DExTEBR7AeAQJRxxehCfQ6IJpxtJkAZKZZDE6qSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFC8DF804F1;
	Sun,  9 Oct 2022 12:42:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EFAFF80517; Sun,  9 Oct 2022 12:42:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11711F80137
 for <alsa-devel@alsa-project.org>; Sun,  9 Oct 2022 12:42:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11711F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="lQY/I4B9"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="50k/AQZZ"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EA3E1F38C;
 Sun,  9 Oct 2022 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665312135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CzdK35GOXe0FHQWGBcfhD4Hk2nPPzbv9LsYZrzXTzko=;
 b=lQY/I4B9QhJ354jp/Go84SF5ppVSqVls+nGCC97f7/ZtfGJaohk64BeRgt7jmk2Jd0+D/2
 owACVVlpSXg3/EZtj9ZAi11kQN/CNYUyaNwIKfuPGnslj+c90H0rGFuwttEbFC/49WBiSz
 agohhOZZcfPgMtLPyQL0sPK24271fzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665312135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CzdK35GOXe0FHQWGBcfhD4Hk2nPPzbv9LsYZrzXTzko=;
 b=50k/AQZZ6WkbLokZ/aj/R5Nf7XjJXXG7cRi4iTKwOllDaRBiIA57t7uqsme7Juq7Oh31ZX
 p3utzdw7hEyhTsAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B5B4139F0;
 Sun,  9 Oct 2022 10:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r1dQHYelQmMsfAAAMHmgww
 (envelope-from <tiwai@suse.de>); Sun, 09 Oct 2022 10:42:15 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: usb-audio: More EP-related fixes
Date: Sun,  9 Oct 2022 12:42:08 +0200
Message-Id: <20221009104212.18877-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

This is a series of small fixes for USB-audio endpoint management
after the latest change to split prepare/hw_params.


Takashi

===

Takashi Iwai (4):
  ALSA: usb-audio: Avoid unnecessary interface change at EP close
  ALSA: usb-audio: Apply mutex around snd_usb_endpoint_set_params()
  ALSA: usb-audio: Correct the return code from
    snd_usb_endpoint_set_params()
  ALSA: usb-audio: Avoid superfluous endpoint setup

 sound/usb/card.h     |  3 ++-
 sound/usb/endpoint.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.35.3

