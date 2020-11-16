Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1718C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 02:55:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF43F22263
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 02:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YjbLwApK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF43F22263
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DCD21778;
	Mon, 16 Nov 2020 03:55:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DCD21778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605495354;
	bh=itw23dt0/s3QPodsHQd9VUFHQvfz6nIHig74Aqskff0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YjbLwApK6wBtneXbmLEAf4n+44luKVOVym7eoqBCOMt62+uPj+lK8VQM8/Balg2aB
	 PfnNHm+9BS+o7/gPhhtmHvSgJajBF3m3JE1lj5ZLd1Uwt1lMmVWHzDyETqrs6Q2gJQ
	 xhu06bSEUvoIu1zfsLTVEPWRzQ/vHYxvvC+IsalE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A39CF80167;
	Mon, 16 Nov 2020 03:55:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49106F80168; Mon, 16 Nov 2020 03:55:02 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C8E62F8014A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 03:54:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8E62F8014A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605495297316016912-webhooks-bot@alsa-project.org>
References: <1605495297316016912-webhooks-bot@alsa-project.org>
Subject: [PATCH 00/15] alsa-gobject: rawmidi: enhancement for error reporting
Message-Id: <20201116025502.49106F80168@alsa1.perex.cz>
Date: Mon, 16 Nov 2020 03:55:02 +0100 (CET)
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

alsa-project/alsa-gobject pull request #52 was opened from takaswie:

The patchset is the part of work about #47.

Current implementation uses library-wide error domain to report error. this
is partly against rule of GError usage. Furthermore, the error delivers
information just about errno and hard to know the cause of error.

This patchset enhances error reporting. The library-wide error domain is
obsoleted. A new error domain is added just for ALSARawmidi.StreamPair.
The error domain delivers information about the cause of error

```
Takashi Sakamoto (15):
  timer: user_instance: fix code for GFileError
  seq: user_client: fix code for GFileError
  rawmidi: skip check of return value from g_malloc()
  rawmidi: check whether method argument for GError is available
  rawmidi: add checks for method arguments
  rawmidi: stream_pair: just return when character device is not opened
  rawmidi: query: simplify count check
  rawmidi: add GLib enumerations for error reporting
  rawmidi: stream-pair: add GQuark to report error for ALSARawmidi.StreamPair
  rawmidi: report error for ioctl
  rawmidi: report open/read/write/fcntl error
  rawmidi: report error for card disconnection state
  rawmidi: stream_pair: report error about write-only file descriptor
  rawmidi: query: use GFileError to report error
  rawmidi: obsolete library-wide GQuark for error reporting

 src/rawmidi/alsarawmidi-enum-types.h |  14 +++
 src/rawmidi/alsarawmidi.map          |   5 +
 src/rawmidi/privates.h               |   6 -
 src/rawmidi/query.c                  | 117 ++++++++----------
 src/rawmidi/stream-pair.c            | 172 +++++++++++++++++++++------
 src/rawmidi/stream-pair.h            |   4 +
 src/seq/user-client.c                |   6 +-
 src/timer/user-instance.c            |   2 +-
 tests/alsarawmidi-enums              |   6 +
 9 files changed, 216 insertions(+), 116 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/52
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/52.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
