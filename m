Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02473C04A68
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jul 2022 13:00:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AB1C1651;
	Thu, 28 Jul 2022 14:59:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AB1C1651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659013247;
	bh=O9qyxK3DScYDRBJeTxvZLUg8NDlR15y7hC2O996CjY8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S6xHXgErBBS13p2xCJKzmMPK+EnQbUoiciPY/cKoXGFuit/Bdpg49MzEAJAmKt9y3
	 s6yMEgJBSq5jIKAPoD/0lXv0Dm8GTJmC3xK7wjeBe3iK3/oaW0f7W2I8SnnqAUxuBN
	 x1RBEm9pqKO4HBiUgx8sfhMkLH6U96aaXyP28lNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D40F5F80544;
	Thu, 28 Jul 2022 14:59:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B172CF80548; Thu, 28 Jul 2022 14:59:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28E07F80520
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2022 14:59:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28E07F80520
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="YWT3O2Qj"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="odSwH7vC"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84F02344A5;
 Thu, 28 Jul 2022 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659013187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+riKxVpJY1OQm0JEnK7/9ldrC6TBfOi8d0U3VBnI/Og=;
 b=YWT3O2QjyFGH9Cn7RXT1UO02dTdzHzjp4S1aoqYpfQhGjt9nK4eoRJhMnSB6V2KODk/kAP
 Xbpmkp1ok++aZyTDxT+x2DzCLhYzoVJtUqVUgIyca7/OvEddsB9MtKTwclp0hHyuDF0Gre
 JO+jkTSLcEZ4IJ5gGGOYnZOI+8Ecxkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659013187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+riKxVpJY1OQm0JEnK7/9ldrC6TBfOi8d0U3VBnI/Og=;
 b=odSwH7vCETBrrmJKCSsiGTxfpI8DumNdIS1dwuMaTOMuNvYXefIresVX782M9ZUbpinPnY
 9i4pAdOskPSQy6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6610C13427;
 Thu, 28 Jul 2022 12:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wammF0OI4mJmOQAAMHmgww
 (envelope-from <tiwai@suse.de>); Thu, 28 Jul 2022 12:59:47 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/4] ALSA: Defer async signal handling
Date: Thu, 28 Jul 2022 14:59:41 +0200
Message-Id: <20220728125945.29533-1-tiwai@suse.de>
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

this is a revised patch series for another attempt to address the
potential deadlocks via kill_fasync() calls that have been reported by
syzbot for long time.  Only a missing linux/fs.h inclusion was added
from v1 series[1].

Instead of the previous series to drop the async handler[2], this
tries to defer the kill_fasync() call.  A few new common helpers are
introduced at first, then the actual usages are replaced in the
following patches.

The patches passed the quick tests with alsa-lib test cases.


Takashi

[1] https://lore.kernel.org/r/20220726153420.3403-1-tiwai@suse.de
[2] https://lore.kernel.org/r/20220717070549.5993-1-tiwai@suse.de

===

Takashi Iwai (4):
  ALSA: core: Add async signal helpers
  ALSA: timer: Use deferred fasync helper
  ALSA: pcm: Use deferred fasync helper
  ALSA: control: Use deferred fasync helper

 include/sound/control.h |  2 +-
 include/sound/core.h    |  8 ++++
 include/sound/pcm.h     |  2 +-
 sound/core/control.c    |  7 +--
 sound/core/misc.c       | 94 +++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm.c        |  1 +
 sound/core/pcm_lib.c    |  2 +-
 sound/core/pcm_native.c |  2 +-
 sound/core/timer.c      | 11 ++---
 9 files changed, 117 insertions(+), 12 deletions(-)

-- 
2.35.3

