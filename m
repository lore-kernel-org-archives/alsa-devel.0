Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00FFC4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Apr 2024 19:31:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 147C71930;
	Tue, 23 Apr 2024 21:31:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 147C71930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713900674;
	bh=ebfw6sFCLwjyX8re0NAcxpkPXD7wJcDVYknwDFRbaYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ANiTucw5CwV3JV4tIlAZXydOoJlaaY+Kyc1nk6SwBxKZvw5YId0itZimilYpuoetb
	 xFB8KtZ4ZIrtAZqcaIUayKnptgp0WTxWbyhvbuWiTQu1+mtb3jzW8svjol5IzejPw0
	 MgVQ1SLCHd9yt97/DjucqtAkLMWuCN1AT3vOKl4s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43593F806A2; Tue, 23 Apr 2024 21:29:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D634F806AB;
	Tue, 23 Apr 2024 21:29:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56CA5F80640; Tue, 23 Apr 2024 21:29:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DCD7CF80640
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2024 21:29:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCD7CF80640
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1713900551544367313-webhooks-bot@alsa-project.org>
References: <1713900551544367313-webhooks-bot@alsa-project.org>
Subject: Unhandled asynchronous SIGIO
Message-Id: <20240423192916.56CA5F80640@alsa1.perex.cz>
Date: Tue, 23 Apr 2024 21:29:16 +0200 (CEST)
Message-ID-Hash: IZKMJ2E6MWBSZMUFTIQA4JMHZ6VBUTZ2
X-Message-ID-Hash: IZKMJ2E6MWBSZMUFTIQA4JMHZ6VBUTZ2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IZKMJ2E6MWBSZMUFTIQA4JMHZ6VBUTZ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #394 was opened from jansenmd:

When using `libasound.so` on embedded systems, I've come across several instances where an unhandled `SIGIO` is detected.  This can occur when closing a hardware microphone device that was set up to use asynchronous calls backs via `snd_async_add_pcm_handler`.

Example: when opening a hardware device with asynchronous callbacks:


* Sets up a signal handler for `SIGIO` via `sigaction`.
* Enable generation of signals from the `fd` by setting the `O_ASYNC` flag: `fcntl(fd, F_SETFL, flags | O_ASYNC)`
* Sets the signal to be generated: `fcntl(fd, F_SETSIG, (long)SIGIO)`

Now, when data is available to be read from the `fd`, `SIGIO` should be generated and handled by the signal handler set in `sigaction`.  That appears to work fine.

The current teardown process looks like this:

* Clear/reset the signal handler via `sigaction`.
* Disable generation of signals from the `fd` by clearing the `O_ASYNC` flag: `fcntl(fd, F_SETFL, flags & ~O_ASYNC)`
* Close the `fd`.

This teardown process seems to set up a race condition where an unhandled `SIGIO` can be generated between unregistering the signal handler and actually stopping any more signals from occurring.  Since the default action for `SIGIO` is termination, this can cause an application to unexpectedly terminate.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/394
Repository URL: https://github.com/alsa-project/alsa-lib
