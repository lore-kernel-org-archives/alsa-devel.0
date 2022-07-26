Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D187C00140
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jul 2022 15:36:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 579371630;
	Tue, 26 Jul 2022 17:35:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 579371630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658849777;
	bh=bOZMD4cWRIVYruHbTgq1AELBSuWPMd5IKWzpcpSvKeA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pSKBUt4Q7gXClN2IN9Zhmd5bDbnXPieeOkZhGjSveHQEJs/OHHBgLMGZ2BM/2jlcD
	 b14khhJUr8xrlJuiV6f62MCsrqJ5jio5hlwCYLod9pZwce7UJMZOrZvC5+blBEmEWk
	 zzSxaAcdzgaqZd9TcY4Y2M3yCaxj/ZDJgNv43uzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EABBF8053C;
	Tue, 26 Jul 2022 17:34:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7652DF8053C; Tue, 26 Jul 2022 17:34:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5780FF80271
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2022 17:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5780FF80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="NF/UyPjw"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="LtzbbY6u"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE62238025;
 Tue, 26 Jul 2022 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658849666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cqyMpTkOKj3IgCfo7VhGY/HLntLKy2raClHCYYKguxA=;
 b=NF/UyPjw6eWrllzMBoZzQFuTacKMpdhi0/FT7VYFRSpZFGAFfQ3UM3M6E36nw67QaABilL
 TSPTLefgndEf1kodFDD7wIHsmqNR4YAnj8BsMYs9ypgOVMo/dRXqwHXGm+HxxBZGQCHLaH
 5s3UXi2gVXDvpeLebhY4xJEaFklE/H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658849666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cqyMpTkOKj3IgCfo7VhGY/HLntLKy2raClHCYYKguxA=;
 b=LtzbbY6uOcLtFe0BTe/QH1wb1Nb6YEP6uiArXW/rN0WEE82UgNNzBxvN8dztWESF4rr8U2
 u0D+7YUKqol6KjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF00113A7C;
 Tue, 26 Jul 2022 15:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /S7hKYIJ4GKiWgAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 15:34:26 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: Defer async signal handling
Date: Tue, 26 Jul 2022 17:34:16 +0200
Message-Id: <20220726153420.3403-1-tiwai@suse.de>
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

Hi,

this series is another attempt to address the potential deadlocks via
kill_fasync() calls that have been reported by syzbot for long time.
Instead of the previous series to drop the async handler[*], this
tries to defer the kill_fasync() call.  A few new common helpers are
introduced at first, then the actual usages are replaced in the
following patches.

The patches passed the quick tests with alsa-lib test cases.


Takashi

[*] https://lore.kernel.org/r/20220717070549.5993-1-tiwai@suse.de

===

Takashi Iwai (4):
  ALSA: core: Add async signal helpers
  ALSA: timer: Use deferred fasync helper
  ALSA: pcm: Use deferred fasync helper
  ALSA: control: Use deferred fasync helper

 include/sound/control.h |  2 +-
 include/sound/core.h    |  8 ++++
 include/sound/pcm.h     |  2 +-
 sound/core/control.c    |  7 ++--
 sound/core/misc.c       | 93 +++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm.c        |  1 +
 sound/core/pcm_lib.c    |  2 +-
 sound/core/pcm_native.c |  2 +-
 sound/core/timer.c      | 11 ++---
 9 files changed, 116 insertions(+), 12 deletions(-)

-- 
2.35.3

