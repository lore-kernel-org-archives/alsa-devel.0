Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4531C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jun 2022 08:41:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BD7B15C1;
	Tue, 28 Jun 2022 10:40:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BD7B15C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656405674;
	bh=MPhCa5wq/dqOHotHciCiOrV7rSj1NOc5T/TFisLsoUA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxTIzAHnAh3XMEH1/YnQW57URoROJW4dBdm4PEqiZ8aX2PgFyCVmAWrfZ7xaKaH+q
	 n0CvJc52Sk+yDhMBcSlht9FGfz40cJRqM4goZsx7nUNllA2ZbvQkTuSAhG46wxHHq0
	 cEqjfkITMu9ybxpg36n6dACEUOQd9tUZvEZ3/JRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEFEEF80166;
	Tue, 28 Jun 2022 10:40:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 491DFF80107; Tue, 28 Jun 2022 10:40:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AF3A9F80107
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2022 10:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF3A9F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656405620019170046-webhooks-bot@alsa-project.org>
References: <1656405620019170046-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/4] seq: remove-filter: rewrite as object
Message-Id: <20220628084023.491DFF80107@alsa1.perex.cz>
Date: Tue, 28 Jun 2022 10:40:23 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #81 was opened from takaswie:

Current implementation of ALSASeq.RemoveFilter doesn't
support multiple condition to query events for removal. It's not
necessarily convenient.

This commit rewrites ALSASeq.RemoveFilter.

```
Takashi Sakamoto (4):
  seq: event-cntr: remove obsoleted internal function
  seq: enums: add rest of entries for remove filter flags
  seq: remove-filter: rewrite as GObject-derived object
  update README

 README.rst                   |   9 +-
 src/seq/alsaseq-enum-types.h |  26 ++-
 src/seq/alsaseq.map          |  17 +-
 src/seq/privates.h           |   7 +-
 src/seq/remove-filter.c      | 388 +++++++++++++++++++++--------------
 src/seq/remove-filter.h      |  35 +---
 src/seq/user-client.c        |   7 +-
 tests/alsaseq-enums          |   8 +
 tests/alsaseq-remove-filter  |  25 ++-
 9 files changed, 305 insertions(+), 217 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/81
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/81.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
