Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8498FCA5FDD
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:42:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CED366028D;
	Sat,  3 Oct 2026 01:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CED366028D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790984534;
	bh=zqk1gAJJP2wHN25oURUcwIACiXQQR57x990hMGDVGdI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=N++VQnJ8WeHDjVrWz5HY0vya5Jl5aK7LqENKcTcu2oqii4WAVEaTUCEzMdHHTzLMy
	 cb6ajYx6YF6BMHE3Mi1KNWodQ3RHshZHfx/Q/lvaYFEzwtFJrQwMlaqyA+Fj5/hiFF
	 KfMJPJdIGTmu3ai1sLLRWEWH54114MTSJJVyBdUI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4287CF805FF; Sat,  3 Oct 2026 01:41:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E88CBF80602;
	Sat,  3 Oct 2026 01:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52547F80548; Sat,  3 Oct 2026 01:41:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790984492;
	b=LK9ow3UUDTB6kEvl0U2qBy7yFCE/vScJ/cQfRvkPQSsPwsRQAwEHijoKJ3IyTzbeSkDQ
	 NKgnyeVzXEXu/I0vlvvJ26MK/qJ0EwKrAcV75dS2T5czAI2BUO89hyoBprtetiDY+2TyH
	 AbYCfW5IMYul5JzdeKpFhp4IKiNWwmtKThju+kmFQtzho0HMCH6aoPyWGExWDTZKntlSP
	 ZMvy6sGicmSdPCgDvpk01gsTn9IQ+yar9eeIPN8fDyKJIL5tJXAHhAm0LH+xtSuyd50eB
	 2jo6N14T24GC95J2Wb059b6ZBDRsG3iQ+avfHJK7mq8r+A3Egvcd9HpLYvWFpU6wG1Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790984492;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=zqk1gAJJP2wHN25oURUcwIACiXQQR57x990hMGDVGdI=;
	b=kNG7mUlatIoWHZAR1GZtRQgithrytJYre8/rQVFkPMcYUlSGB2Fe85FgAQ2fyPiQV3jj
	 aqQ/tFet1JFc6E/RjkN9wWkINbTMmehWdKRhQXQSddnWqa2gWE3YjRKXSshUibEsBo0IQ
	 5NI0PJaWnxREOvefiRCQ3qAyIxT6S8VRrfDil+Afhp0XCYHWhQmnUH4vlcxf8FUrK3eZ7
	 1I6/s9lfxmHG+HleXINU+9ocYyM4+B/7cTQF5YssRGFjIHkAWJ1zmt2hHAaDi9h7W9AWc
	 z9OstnifyvKR5FLlCwz8xlOkjLuCwdI+48+y3GZhbSRmh+4TUptfS7WW8vc/DgK2u9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C1B6F80246
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 01:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C1B6F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dadae7c21b6b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/866@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/866@alsa-project.org>
Subject: ucm2: Intel: avs_rt5663 - Fix headset mic JackControl name
Date: Sat,  3 Oct 2026 01:41:33 +0200 (CEST)
Message-ID-Hash: 4OVYUKZZCHUEJ5WES5QBIIQNM773OC7P
X-Message-ID-Hash: 4OVYUKZZCHUEJ5WES5QBIIQNM773OC7P
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4OVYUKZZCHUEJ5WES5QBIIQNM773OC7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #866 was opened from Sha01in:

The avs rt5663 board driver registers its headset mic jack pin as
"Headset Mic", so the jack control is "Headset Mic Jack". The profiles
named "Headset Mic", which doesn't exist: PipeWire logs
'Invalid JackControl value: "Headset Mic"' and headset mic detection
can't work.

Same fix as 02f4fb7 for avs_nau8825.

Tested on a Google Pixelbook (Eve) with snd_soc_avs.obsolete_card_names=1:
the warning is gone and the Headphones, Headset Microphone and Digital
Microphone devices still come up. HP Soraka uses the same board driver.



Found and tested with help from Claude Code.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/866
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/866.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
