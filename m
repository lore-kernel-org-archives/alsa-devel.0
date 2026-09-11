Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1306C88E53
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:22:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0873560293;
	Fri, 11 Sep 2026 21:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0873560293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789154545;
	bh=3Kau1Go6aJjuQ+pbmfvtkY13be+oKP0qyUvfjgZul+w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vMFl2VuX2zqS/iE3SUBsNlKHdte/j1Jyn/l2sT8zfQle04IkkaHYHptNbp0gBNwdr
	 Q8Y6QEG/uAdbS3Gpeg+ctkZeZOT1rAjVq9v9ihNeHXTmqJsPLSuuzSg1jQ239ESSlJ
	 mzy0wXzIwGiSRMKQGkPOZcFNjfTgsiNX4OSbQGDs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB826F805F5; Fri, 11 Sep 2026 21:21:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73D4BF805F3;
	Fri, 11 Sep 2026 21:21:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72C43F804F3; Fri, 11 Sep 2026 21:21:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789154499;
	b=VjEyqfwCHPePBHXTaefbvlOi3Bu2jTikkUqDxVaidQiErm38Xx8VTBzAHVUnFt0XzcWU
	 nYDUGCVGuVZ/fpp1muU6Xw6PQS6/3LWFAmTL/Vz/3qPPdojqzqQ7ofbtD66pHu/5VUDFj
	 gOVW0rsMg8dWLNi5LVRvgEVJsfcaz36sND3i9wp/XBZ0BRgvEGTKL3tjjVepfkNx9zwAv
	 8cAEzcIJ2ydg5IQKoGgSRBS+nC8gCiOK5N1/+4OQ/ogkTVuYE4pwq+FMRWd+llhoPqCWD
	 4SI3fWpxamFBgWB1jWCDXKsjaC9Lp4jAEEEO3XMYP85zsyJitAOx/RmP/qAo3Y+XktA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789154499;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=3Kau1Go6aJjuQ+pbmfvtkY13be+oKP0qyUvfjgZul+w=;
	b=GolhEwTo/x+TldGFHYqbeRwPv+/8MDHFiUk75VGuQ1DrXeDO3pACAeILcp+aQe8UYvZv
	 tPWs5MraIanfsf4rsiONahlgQNHtzF15qTwczgKZr5Yz/3uCPTm9v2k5DQAO8RQ1nSYVO
	 D/dUYBQhaQBmeaTdpfgV9AWFzfSe+JmNADM1F1LerKC466xevBU8k+e4lYxDVEudy8OYr
	 i1bulFoGONndlqaDAmcAriiRZVhmReCxn3HKp/buggz0k73/LiJIeEK0HIKgWPseADLu1
	 /viihoWBixx6mjlE4EbNgd6K6CveqnZD0kWfYyNU19HzcAxra3hxg1MKB/DzVKsXS6g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E7C22F80246
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2026 21:21:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7C22F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d45a8939a95000-webhooks-bot@alsa-project.org>
In-Reply-To: <18d45a893983c000-webhooks-bot@alsa-project.org>
References: <18d45a893983c000-webhooks-bot@alsa-project.org>
Subject: pcm_multi accepts sparse/unbound bindings and aborts via assertion
Date: Fri, 11 Sep 2026 21:21:43 +0200 (CEST)
Message-ID-Hash: JDG5TKGPU4UHRKYKDFU2NNOZQDO4NVIH
X-Message-ID-Hash: JDG5TKGPU4UHRKYKDFU2NNOZQDO4NVIH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JDG5TKGPU4UHRKYKDFU2NNOZQDO4NVIH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #523 was opened from HarshRajSinghania:

### Summary

The `multi` PCM configuration parser can leave intermediate binding slots unbound (`slave_idx == -1`), but `snd_pcm_multi_open()` evaluates `schannels[i] < schannels_count[sidxs[i]]` before checking whether `sidxs[i]` is negative. A sparse binding therefore indexes `schannels_count[-1]` and, in builds with assertions enabled, aborts the process.

### Reproducer

```
pcm.null { type null }
pcm.poc {
    type multi
    slaves.a.pcm "null"
    slaves.a.channels 2
    bindings.0.slave a
    bindings.0.channel 0
    bindings.5000.slave a
    bindings.5000.channel 1
}
```

Opening `poc` with alsa-lib 1.2.14 reaches `snd_pcm_multi_open()` and terminates with:

```
pcm_multi.c:1125: snd_pcm_multi_open: Assertion `schannels[i] < schannels_count[sidxs[i]]' failed.
Aborted
```

The configuration documentation explicitly permits binding entries indexed by `N`, so sparse binding indices are representable configuration input.

### Suggested fix

Treat an unbound slot as unbound before indexing `schannels_count`, and return `-EINVAL` for an invalid slave index/channel instead of relying on assertions.

I have a patch prepared that makes these checks explicit and avoids the negative-index access/assertion abort.

Reported by Harsh Raj Singhania.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/523
Repository URL: https://github.com/alsa-project/alsa-lib
