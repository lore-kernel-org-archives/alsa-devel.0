Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076FC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 19:06:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4708D6124D
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 19:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4708D6124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22D4E165D;
	Tue,  5 Oct 2021 21:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22D4E165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633460786;
	bh=uhiTmpad7jSXSe6odxQvqxvmb/tJgJ8eB14IzN4ztnk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VKBvZsEES37hxmqwHoXp2B5277YXKWCl+vSWz5PMOXGTDIHZJI7qoRqNgot7Z2GAX
	 SwMMTmJwVpjbOC8BiBOvNo+BLjeyAOPbouxAVqa6JNAI82aBEWjQuxxzZN2SuyH9sa
	 khII+rFn9y056C9wf8jtqRs+oG6u3eTYUK6Z0sWo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9DF7F80259;
	Tue,  5 Oct 2021 21:05:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E360AF8027D; Tue,  5 Oct 2021 21:05:33 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C1D9F80154
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 21:05:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C1D9F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="jJmIPDiU"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="k0gZXjxX"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id DE96CA1A3D402;
 Tue,  5 Oct 2021 21:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1633460723; bh=uhiTmpad7jSXSe6odxQvqxvmb/tJgJ8eB14IzN4ztnk=;
 h=From:To:Cc:Subject:Date:From;
 b=jJmIPDiUWzsKEjgYU0AR9+OJ1M/hlyEUZsUDFODjGqBB6IEaYIBX335XSQZgWLKx2
 fxjJyMb1D+3/lOY7QeowAE3gHEtynwprCqMj08ygGDUxsfmoip8Dd0F0rlC7u8WJGQ
 I/mSFfX8LyadV5yRaASKCJFqtY2tJyyv0gIgFEvA=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XKRgjtLzuPcS; Tue,  5 Oct 2021 21:05:18 +0200 (CEST)
Received: from precision.doma (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 8BA7FA1A3D405;
 Tue,  5 Oct 2021 21:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1633460718; bh=uhiTmpad7jSXSe6odxQvqxvmb/tJgJ8eB14IzN4ztnk=;
 h=From:To:Cc:Subject:Date:From;
 b=k0gZXjxXTAiNe8i8UwfhZAsafWv7odCLjVBM1amlWfaGDajXkXe8gYoD3ht8hJ3Sf
 G4KKkFZmWMgf34yd2ofeZWHGO1/OSVNoHCjCoLC11zrD10kI42V5+Qyh5O3jY3Ltxw
 bSR8YlJkV+WAyoCLlOH/gmNcAudk4Dyn/gwB5hIg=
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] alsaloop: fixed parsing value 'auto' of option 'sync'
Date: Tue,  5 Oct 2021 21:05:18 +0200
Message-Id: <20211005190518.5801-1-pavel.hofman@ivitera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
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

The value 'auto' was not checked for which resulted in using
SYNC_TYPE_NONE instead of SYNC_TYPE_AUTO.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
---
 alsaloop/alsaloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/alsaloop/alsaloop.c b/alsaloop/alsaloop.c
index 4192712..f5f2e37 100644
--- a/alsaloop/alsaloop.c
+++ b/alsaloop/alsaloop.c
@@ -528,6 +528,8 @@ static int parse_config(int argc, char *argv[], snd_output_t *output,
 				arg_sync = SYNC_TYPE_PLAYRATESHIFT;
 			else if (optarg[0] == 'r')
 				arg_sync = SYNC_TYPE_SAMPLERATE;
+			else if (optarg[0] == 'a')
+				arg_sync = SYNC_TYPE_AUTO;
 			else
 				arg_sync = atoi(optarg);
 			if (arg_sync < 0 || arg_sync > SYNC_TYPE_LAST)
-- 
2.25.1

