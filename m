Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB934C33C8C
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D862087F
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WoxRbilW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D862087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Fries.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 390461844;
	Tue,  7 Jan 2020 16:19:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 390461844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578410399;
	bh=JLucXqHN/Kv6ofqc+R6OxsYGJ6tZjj6MNwZC5P+Yg84=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WoxRbilWcY8yZoCY+n2/xJlhdLO82TjYxv4A0Kwpu+lGhT6ka27fP5W4fcLuEpUeM
	 0LKCsRhbd3ArjoVypK64SI2wGmfMvx8WjosTi7WQsUs5UDTh5A25Or80Tt+hOihLSv
	 GP0wWVKbl4n/FmqAKm+NqXsN1qZr6Kzg/3NE9yw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5152F8010D;
	Tue,  7 Jan 2020 16:18:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E391AF801F5; Tue,  7 Jan 2020 16:18:20 +0100 (CET)
Received: from SpacedOut.fries.net (SpacedOut.fries.net
 [IPv6:2001:470:3832:200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEC09F80140
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 16:18:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC09F80140
Received: from SpacedOut.fries.net (ip6-localhost [IPv6:0:0:0:0:0:0:0:1])
 by SpacedOut.fries.net (8.15.2/8.15.2/Debian-8) with ESMTPS id 007FIAkP009408
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 7 Jan 2020 09:18:10 -0600
Received: (from david@localhost)
 by SpacedOut.fries.net (8.15.2/8.15.2/Submit) id 007FIAnL009407;
 Tue, 7 Jan 2020 09:18:10 -0600
Date: Tue, 7 Jan 2020 09:18:10 -0600
From: David Fries <David@Fries.net>
To: alsa-devel@alsa-project.org
Message-ID: <20200107151810.pzthoz3w2y3wqae7@spacedout.fries.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.5.11
 (SpacedOut.fries.net [IPv6:::1]); Tue, 07 Jan 2020 09:18:10 -0600 (CST)
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [alsa-devel] [PATCH] mixer: Fix memory leak for more than 16 file
	descriptor case
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Signed-off-by: David Fries <David@Fries.net>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
Added signed off.

I saw this when digging through the source code, wrote up a test case,
and verified with valgrind. I don't have that many sound cards so I
modified mixer.c to always take the conditional. alloca seemed like
the least effort way to fix this. Other thoughts were to test pfds !=
spfds and free, but given how little bytes would be allocated putting
on the stack seems reasonable.

I also created the github pull request 20.
https://github.com/alsa-project/alsa-lib/pull/20

 src/mixer/mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 82056474..b1af9945 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -767,7 +767,7 @@ int snd_mixer_wait(snd_mixer_t *mixer, int timeout)
 	if (count < 0)
 		return count;
 	if ((unsigned int) count > sizeof(spfds) / sizeof(spfds[0])) {
-		pfds = malloc(count * sizeof(*pfds));
+		pfds = alloca(count * sizeof(*pfds));
 		if (!pfds)
 			return -ENOMEM;
 		err = snd_mixer_poll_descriptors(mixer, pfds, 
-- 
2.11.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
