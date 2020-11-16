Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A91C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 03:07:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894A22080C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 03:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AFmyKMkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894A22080C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FE561784;
	Mon, 16 Nov 2020 04:06:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FE561784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605496049;
	bh=F/1BeAlgpWEC9J/1HkQktcgCv1JdIFewGl8y2XO6AYQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFmyKMkTbPPVm5XBGVWo9bnUtv8xDziYBsaXEtKYfDfHVSdnkFAeWvzBkd9rb8bKs
	 51gPExHQCUdY5ezzsoUQlMkQc4JY0ifZESM2ms3RfTgIhWVeXZFiHtE0nP8rJj2B7f
	 w6/vSZh0hhEIdPVMAzA3wo7aJNxCuu3la6C4SXfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0178EF80167;
	Mon, 16 Nov 2020 04:06:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87E47F80168; Mon, 16 Nov 2020 04:06:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 20E1FF8010A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 04:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20E1FF8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605495994224057913-webhooks-bot@alsa-project.org>
References: <1605495994224057913-webhooks-bot@alsa-project.org>
Subject: rawmidi: substream 0 is always selected, ignoring parameter
Message-Id: <20201116030637.87E47F80168@alsa1.perex.cz>
Date: Mon, 16 Nov 2020 04:06:37 +0100 (CET)
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

alsa-project/alsa-gobject issue #53 was opened from takaswie:

This issue is confirmed in v0.1.0 release.

`ALSARawmidi.StreamPair.open()` has `subdevice_id` to select one of
substreams supported by the Rawmidi device. However, this parameter is
ignored and the first substream is always selected.

Currently, the procedure in `ALSARawmidi.StreamPair.open()` to open Rawmidi
character device is:

1. open control character device
2. ioctl call with SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE
3. close control character device
4. open rawmidi character device

The cause to ignore is step 3. After closing control character device,
private structure assigned to file descriptor of control character
device is dropped in kernel land. At step 4, the selection information
is already lost and the first substream is assigned to file descriptor
of rawmidi character device.

The solution is to keep file descriptor of control character device
when opening rawmidi character device, thus the procedure should be:

1. open control character device
2. ioctl call with SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE
3. open rawmidi character device
4. close control character device

Issue URL     : https://github.com/alsa-project/alsa-gobject/issues/53
Repository URL: https://github.com/alsa-project/alsa-gobject
