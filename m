Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB1C982DA
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:13:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FBC56020A;
	Mon, 21 Sep 2026 02:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FBC56020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789949614;
	bh=MnDMdOiOWkZ1NdvL7AhUoIzA0QYk304KzLKSqJAoNjo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pmkYJ6+3neENhAeWk4YbgnL5NEFXPvS7P4i8eN5J+yG9uxPPXXxv2MR6aM6KNE1v9
	 tN3z6LF2nd3ySTOebpLTeB4Q0UpK9nKPRoSYPPrhngy4RjnbDoOuLaf5DQtTvH17+o
	 VVVHn1SaN2zNqRARZT2pCkatXnl0ktsaAgwQcR0U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2484DF805FE; Mon, 21 Sep 2026 02:13:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0024F80601;
	Mon, 21 Sep 2026 02:13:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E363F804F3; Mon, 21 Sep 2026 02:12:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789949573;
	b=hjD/QWt0PSUpvnKeJKeCDvV+N0joffzem3xhO3alzGSS8SH5ey8PAIaVqjkinD03dZs5
	 gzmg10ZLoYbvJvOQvjMZRLJFyic0Jf37N4dYUYDOmoPVAX9prd2tROPNQs8ikBavDDa4k
	 EYwNTiGUXWjA14K0yB3rwXm1UODe2PU9pf2KSc+Lsrq4+FcMvs0o1rS5XbyDrlrCeE3i8
	 LZKOu4lq1VzJ/35CAGT4B3KQybT2PM/QAWPD804m6pTq6dWoQt9ik6KR0FGVuHvfD/qfm
	 dnOkyCJAIMgar9ugGz9lcWU3g8Ydr4pbq/WYM7V/3Fd1WLngEWHGZdVFhBi1RswhbBw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789949573;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MnDMdOiOWkZ1NdvL7AhUoIzA0QYk304KzLKSqJAoNjo=;
	b=CBUFV8gc3tepre2IPwWknB1glz1O3/voJZBqtCYR24NKr9f4njoco2S3M7MxNHjL3zLd
	 upRO3pHgs7hd6iqDpQYZrgbWSskn9i8Rqx6ZVQMviTqjrqVzFgrKwS9qjdHl1xTNdMYAc
	 kx9R8LBpoBdKP9SUrj6GbPbJ+YwRugEBwgMpBnbowp0qrQEwoOYq8a0rIzhsJ9/SJ27vh
	 veQdD7MG9B7/o4Yh5ekzAfmEWQggzLvYqUFoEKdmQ224pT1CydL2fHYoy/lvMAr/dzW+i
	 l2adEFQu758DvOwCMnHyv/XfJ61HH/RxKlSDyVe0NxwfWNrK4QRkcgWfpmF6IubAp4A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 228E7F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 02:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 228E7F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d72da6d9784800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-plugins/pr/66@alsa-project.org>
References: <alsa-project/alsa-plugins/pr/66@alsa-project.org>
Subject: Fix latency error check in pulse_delay()
Date: Mon, 21 Sep 2026 02:12:54 +0200 (CEST)
Message-ID-Hash: VEYPHRBXRDF54OWCRYVKXXOWFQKIYQXY
X-Message-ID-Hash: VEYPHRBXRDF54OWCRYVKXXOWFQKIYQXY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VEYPHRBXRDF54OWCRYVKXXOWFQKIYQXY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins pull request #66 was opened from argothiel:

There seems to be an issue with `pulse_delay()` which calls `pa_stream_get_latency()`. PulseAudio documents that this function returns `-PA_ERR_NODATA` when timing information is not available yet. The ALSA Pulse plugin compares the result against positive `PA_ERR_NODATA`; it therefore treats that temporary condition as an unrelated failure and returns `-EIO`.

Change `PA_ERR_NODATA` to `-PA_ERR_NODATA` in the comparison to not miss that branch.

Fixes #65.

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/66
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/66.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
