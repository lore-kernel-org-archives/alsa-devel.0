Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213BAC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jun 2022 03:08:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09EF718E1;
	Wed,  1 Jun 2022 05:07:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09EF718E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654052904;
	bh=eJdVGuk0qAC5PRBtR3j7J0wSkQIfJ9q7DOai2tLs60M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIymyE4tbIChY6oGqN88USuw7UcW169ITM3OJNY8thERE+2pjDHC29oSC9JfNqDsL
	 7RCrgsDKItFgH7qYWpk3lMP2lDIDdpteK5nH9ykILJL/ncYK3IxHKpw0uINw/rlGGy
	 Dcrh/9tbfDUJnp91bj0Vz3gIVfX1v9+HA9NjPjJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DBF1F8019B;
	Wed,  1 Jun 2022 05:07:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2459F80238; Wed,  1 Jun 2022 05:07:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C82BBF800BD
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2022 05:07:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C82BBF800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1654052845621947050-webhooks-bot@alsa-project.org>
References: <1654052845621947050-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/5] seq: add interface for queue timer
Message-Id: <20220601030731.E2459F80238@alsa1.perex.cz>
Date: Wed,  1 Jun 2022 05:07:31 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #72 was opened from takaswie:

Current implementation uses function of QueueTimer to retrieve data for variants of
queue timer, however it's not enough convenient in the case of language bindings.
The usage of GObject.Value in object property is expected to be supported widely
instead.

This patchset uses object classes derived from GObject to express the variants.
The common properties are expressed by QueueTimerCommon interface. The
ALSATimer variant is currently supported to implement the interface.

```
Takashi Sakamoto (5):
  doc: seq: fix URL to document for ALSATimer
  seq: queue-timer-common: add common interface for queue timer
  seq: queue-timer-alsa: add class for queue timer specialized to ALSA Timer
  seq: user-client: use QueueTimerCommon interface instead of QueueTimer
  seq: queue-timer/queue-timer-data-alsa: remove unused gobject classes

 doc/seq/alsaseq.toml.in                       |   2 +-
 doc/seq/urlmap.js                             |   2 +-
 src/seq/alsaseq.h                             |   5 +-
 src/seq/alsaseq.map                           |  16 +-
 src/seq/meson.build                           |   8 +-
 src/seq/privates.h                            |  21 ++-
 src/seq/queue-timer-alsa.c                    | 134 +++++++++++++++++
 src/seq/queue-timer-alsa.h                    |  22 +++
 src/seq/queue-timer-common.c                  |  87 +++++++++++
 src/seq/queue-timer-common.h                  |  20 +++
 src/seq/queue-timer-data-alsa.c               |  76 ----------
 src/seq/queue-timer-data-alsa.h               |  32 ----
 src/seq/queue-timer.c                         | 138 ------------------
 src/seq/queue-timer.h                         |  26 ----
 src/seq/user-client.c                         |  42 +++---
 src/seq/user-client.h                         |   4 +-
 ...q-queue-timer => alsaseq-queue-timer-alsa} |   8 +-
 tests/meson.build                             |   2 +-
 18 files changed, 325 insertions(+), 320 deletions(-)
 create mode 100644 src/seq/queue-timer-alsa.c
 create mode 100644 src/seq/queue-timer-alsa.h
 create mode 100644 src/seq/queue-timer-common.c
 create mode 100644 src/seq/queue-timer-common.h
 delete mode 100644 src/seq/queue-timer-data-alsa.c
 delete mode 100644 src/seq/queue-timer-data-alsa.h
 delete mode 100644 src/seq/queue-timer.c
 delete mode 100644 src/seq/queue-timer.h
 rename tests/{alsaseq-queue-timer => alsaseq-queue-timer-alsa} (76%)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/72
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/72.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
