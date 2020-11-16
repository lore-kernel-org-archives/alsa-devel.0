Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3AC4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:43:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64B42225B
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nUfyAuJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64B42225B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E42916A1;
	Mon, 16 Nov 2020 14:42:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E42916A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605534210;
	bh=x7FvolylYJUeQ5plvppdf1SPkKEZG/cgAXKPGybtkuk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUfyAuJA9ZiqcHHTEWo+ZpnEqj9OHEC/X72Bo5rtHJpzTG3krZJHM87ySqqTFLRIi
	 jUSfFJdkhXY4+Ag/RWVYjbpiqxqFfHBhCvnMFaTy6jlGowIC7JHzhgPS0jhKINXkmE
	 JCb7F9rBhGP6/yFpIFc7CXvr2NHo4oTPtdCbmt24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D50E9F8014A;
	Mon, 16 Nov 2020 14:42:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84C3DF80168; Mon, 16 Nov 2020 14:42:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A7108F8014A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 14:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7108F8014A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605534150200311899-webhooks-bot@alsa-project.org>
References: <1605534150200311899-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/2] alsa-gobject: rawmidi: fix to select substream
Message-Id: <20201116134237.84C3DF80168@alsa1.perex.cz>
Date: Mon, 16 Nov 2020 14:42:37 +0100 (CET)
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

alsa-project/alsa-gobject pull request #54 was opened from takaswie:

This patchset fixes #53 .

ALSARawmidi.StreamPair.open() has `subdevice_id` argument to select
one of substreams supported by the Rawmidi device. However, this
parameter is ignored and the first substream is always selected.

In ALSA rawmidi core, private structure associated to file descriptor
to control character device assists selection of rawmidi substream.
It requires to keep the file descriptor until the selected substream
is actually attached by open rawmidi character device.

Current implementation of libalsarawmidi is to close the file descriptor
before opening rawmidi character device. This is the cause of the issue.

This commit fixes the bug by keeping the file descriptor till opening
rawmidi character device.

```
Takashi Sakamoto (2):
  rawmidi: query: allow caller to take ownership of file descriptor for control character device
  rawmidi: stream_pair: fix to select substream

 src/rawmidi/privates.h    |  2 +-
 src/rawmidi/query.c       | 16 ++++++++++------
 src/rawmidi/stream-pair.c |  4 +++-
 3 files changed, 14 insertions(+), 8 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/54
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/54.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
