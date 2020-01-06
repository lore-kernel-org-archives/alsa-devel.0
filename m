Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD543C33C8C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:42:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD7A208C4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NtyrM6bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD7A208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Fries.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A106017B5;
	Mon,  6 Jan 2020 22:41:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A106017B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578346950;
	bh=fZuPiOJ9iN00YepaRASXXue4zUAI1B2FA0Z64LRtYtM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NtyrM6bhkbWYIbX02ax519XdQr0kk309trWap3OqgjTVYsoHtlOXJRIKio631Tu+9
	 +KIZVobqsS6DNvwjbPm3bbwzJ5Q9m/KmgvwXQ75d43DeAPStAXsNyKYcT7xTzztfx9
	 KvPeHst2+aKiAWwmqzVFtfLLCQfAqtgrLhpiQM9o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB154F80116;
	Mon,  6 Jan 2020 22:41:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BE7CF80159; Mon,  6 Jan 2020 22:41:37 +0100 (CET)
Received: from SpacedOut.fries.net (spacedout.fries.net
 [IPv6:2001:470:3832:200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00C66F80116
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 22:41:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00C66F80116
Received: from SpacedOut.fries.net (ip6-localhost [IPv6:0:0:0:0:0:0:0:1])
 by SpacedOut.fries.net (8.15.2/8.15.2/Debian-8) with ESMTPS id 006LfVhj008772
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2020 15:41:31 -0600
Received: (from david@localhost)
 by SpacedOut.fries.net (8.15.2/8.15.2/Submit) id 006LfTJB008771
 for alsa-devel@alsa-project.org; Mon, 6 Jan 2020 15:41:29 -0600
Date: Mon, 6 Jan 2020 15:41:29 -0600
From: David Fries <David@Fries.net>
To: alsa-devel@alsa-project.org
Message-ID: <20200106214129.fnrokzkh4qnbvzdl@spacedout.fries.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.5.11
 (SpacedOut.fries.net [IPv6:::1]); Mon, 06 Jan 2020 15:41:31 -0600 (CST)
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

---
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
