Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA7C982EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:31:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59AA760208;
	Mon, 21 Sep 2026 02:30:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59AA760208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789950661;
	bh=0gv3YjcZUDdTw3vXPiOpIm7O+7mcvjC1+g/Tr2ICmQY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=n07DQW/ZZKXyjLeyCcc8Dfm9xenXXhnYyTSrn0E9y9Y9eJcG7pwoEhv9lmNUvWOpD
	 c0FiAZtaTd7Hp7mfkCGUHKX9Q1zBGzqcAGMhlq1ykb94Uo2VR5Ukgn0v7iYaW8gE0n
	 tK9QGvuSoyepi3GeCYeTDGH05zpYHyHJwVAzSv2o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F25FF800FA; Mon, 21 Sep 2026 02:30:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E867F805F1;
	Mon, 21 Sep 2026 02:30:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83D13F804F3; Mon, 21 Sep 2026 02:30:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789950621;
	b=EkNHmCH/jl+6NVdO+E2PlGsLP0QSy0UBOnNEqzeTQzidKMsuOdbuYzRwEGYQF+dgo0q7
	 nPAnPM8pf7CGisOaPsVDvsQxkBKcGKoU/DWUtYIodYRdFOUPNm9pLRr+TN6vMFebC7hBd
	 gG1Q+JH129PnmOqC7tWay/w2X5fx3N4FtjFi171ku1gaUbWFtcdByEkMov2J4J0dFb27c
	 20r/UwbOwpbRSYmI/CkNqa7LSnrC2hMBpS22i+nGkB06wj5aLhdG6m8m6U9iMA4+Al6Gt
	 vInP4aRN9T8EhDYmP2TYDPXTSSyrXTtXvyVpfvguazWrYv+B+Lc+wSCd57Ey+UOVvcw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789950621;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=0gv3YjcZUDdTw3vXPiOpIm7O+7mcvjC1+g/Tr2ICmQY=;
	b=bOHBla+iOS4OVcuaw3KlniGb7gP5vWUIRzdcuzO5JJzbz3nkdDgkM/SS6DL5O+xZASGg
	 EhCydiyVOndvo4iML/Z5q8b2K9WpI/otIBlGQ7TmsFah72M0V5Jxod28uSaddwPet204T
	 FCflR8FbGIXe0PwtrFMwozdnS90dn3G11eeBlizITihhiV/C7ZrWjEUyxA/B+sK/K5Hlq
	 32PmQ6PKTuE7o1RFW9xT1se2iAsoIc9e4sMoV9m259M2IYSLRoG+kawSemGBcFoT3gk/b
	 BCE3eRL7eYDc8E/GrhTr3O2xIdyMaPSXIsrsuSKA8th4WlZ4ao5f69Hcd9MPBqVPcTQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 84447F800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 02:30:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84447F800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d72e9ad234f100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-plugins/pr/67@alsa-project.org>
References: <alsa-project/alsa-plugins/pr/67@alsa-project.org>
Subject: Fix latency error check in pulse_delay()
Date: Mon, 21 Sep 2026 02:30:22 +0200 (CEST)
Message-ID-Hash: GMWJI64FGWOMWVJJZKDC45PHDYRB6WFS
X-Message-ID-Hash: GMWJI64FGWOMWVJJZKDC45PHDYRB6WFS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GMWJI64FGWOMWVJJZKDC45PHDYRB6WFS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins pull request #67 was opened from argothiel:

There is an issue with `pulse_delay()` which calls `pa_stream_get_latency()`. PulseAudio documents that this function returns `-PA_ERR_NODATA` when timing information is not available yet. The ALSA Pulse plugin compares the result against positive `PA_ERR_NODATA`; it therefore treats that temporary condition as an unrelated failure and returns `-EIO`.

Change `PA_ERR_NODATA` to `-PA_ERR_NODATA` in the comparison to not miss that branch.

Fixes #65.

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/67
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/67.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
