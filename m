Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8474BC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jul 2022 10:32:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BF6418CF;
	Fri, 15 Jul 2022 12:31:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BF6418CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657881135;
	bh=DGcQmCbuhzsWEiJYVi+RzpkjhouCyhi6DIHJOjUgvXU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rK/04UdA9KaP1oTvB7T+KgwhVNVeLKuNznpvFS5xLjwoXnS2MFRFXxDNDN6gBa6a4
	 wB1m292dddSZrYEAikzBa9t62MjJj9xtdLjrqWuJnevLJZr9zezdnI4zBxUb5dotA7
	 EvVY3VOsQzswYaPMQiSnJyaYHHmjk+E7TnOnk2l8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC6EDF80564;
	Fri, 15 Jul 2022 12:30:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E4AEF80566; Fri, 15 Jul 2022 12:29:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A206DF80212
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2022 12:29:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A206DF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="VAuyPn7I"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="pXlbCfXx"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3044A3410C;
 Fri, 15 Jul 2022 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657880978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8nYTSwW25/b/m69kBE7dy50+tcFxUtZRzrCmdMNBIgQ=;
 b=VAuyPn7IUPLd1YgNysKaQz6o4cxynQupOD0rlrAztMlWewt/Fy3zrM7UjLyxiosCHoeU3+
 vGBz0Ed6DWK5tIJf0Fwnjqh/JMUq8I/Z/6S1dL3hQa5+deCsVwTmLeQaoxuAKuH0MuXmHf
 QjaUXl6OUA6lZGGc9zI9FQiR1d+hw9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657880978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8nYTSwW25/b/m69kBE7dy50+tcFxUtZRzrCmdMNBIgQ=;
 b=pXlbCfXxENGv/b9f3HANerd/lrWwaIXij8yZ3dJ5r+IsbOI1rAndH0K6L+Ns6khnrV4uMv
 4QCt1UlCJmEeJgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18C7213AC3;
 Fri, 15 Jul 2022 10:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fbfUBJJB0WI+WwAAMHmgww
 (envelope-from <tiwai@suse.de>); Fri, 15 Jul 2022 10:29:38 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ALSA: Drop async signal support
Date: Fri, 15 Jul 2022 12:29:30 +0200
Message-Id: <20220715102935.4695-1-tiwai@suse.de>
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

this is a patch series to drop one of unused features, the async
signal support, from ALSA core.  The async signal itself is very
difficult to use properly due to various restrictions (e.g. you cannot
perform any I/O in the context), hence it's a feature that has been
never used by real applications.

OTOH, the real problem is that there have been quite a few syzcaller
reports indicating that fasync code path may lead to some potential
deadlocks for long time.  Dropping the feature is the easiest
solution, obviously.

The corresponding update for alsa-lib will follow once when we agree
with this approach.


thanks,

Takashi

===

Takashi Iwai (5):
  ALSA: timer: Drop async signal support
  ALSA: pcm: Drop async signal support
  ALSA: control: Drop async signal support
  ALSA: core: Drop async signal support
  ALSA: doc: Drop stale fasync entry

 .../kernel-api/writing-an-alsa-driver.rst      |  1 -
 include/sound/control.h                        |  1 -
 include/sound/pcm.h                            |  1 -
 sound/core/control.c                           | 11 -----------
 sound/core/init.c                              | 11 +----------
 sound/core/pcm_lib.c                           |  4 +---
 sound/core/pcm_native.c                        | 18 ------------------
 sound/core/timer.c                             | 13 -------------
 8 files changed, 2 insertions(+), 58 deletions(-)

-- 
2.35.3

