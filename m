Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1549D609CE
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:27:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86C4360183;
	Tue, 16 Dec 2025 17:26:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86C4360183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765902423;
	bh=SA1KtDDJ/IaXElkb3uO/9E8GKNQQpVB/w4BxUnOErWI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UrGRIpncTISb5OkZByC0O0mp+byVKvgFVuAD1TMHHOt7zgAJbdqdi5dxuNLMyZEwU
	 hSxp22krrpwvl+VFvD6AK5nfsFhaQXT6V0BbPF7mP6bKBMhsD8x4iaKX+hyy6YYH95
	 5tU15F9lXcy0Hgh4ldVWkHVUbNfsTosY8nsd6n4I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C663DF805D9; Tue, 16 Dec 2025 17:26:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA61F805D5;
	Tue, 16 Dec 2025 17:26:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D91CF80217; Tue, 16 Dec 2025 17:26:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CB9D3F80087
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2025 17:26:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB9D3F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1881bed7cdd5dc00-webhooks-bot@alsa-project.org>
In-Reply-To: <1881bed7cb509900-webhooks-bot@alsa-project.org>
References: <1881bed7cb509900-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.15: only fallback stereo available (bisected)
Date: Tue, 16 Dec 2025 17:26:06 +0100 (CET)
Message-ID-Hash: N4QTNOHSKQJCSA6IDXKFZDKFP6V7QTLA
X-Message-ID-Hash: N4QTNOHSKQJCSA6IDXKFZDKFP6V7QTLA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N4QTNOHSKQJCSA6IDXKFZDKFP6V7QTLA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #491 was opened from Just4GH:

With alsa-lib 1.2.15 only stereo is available.

```
git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[ eda76146c5653ff1d5bc4b4c53f7a2d5ccc17da2 ] conf: fix load_for_all_cards() - do not merge the card specific contents
```

Reverting eda76146c5653ff1d5bc4b4c53f7a2d5ccc17da2 allows the usual profiles to load and 5.1 output.

```
$ aplay -l 
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC1150 Analog [ALC1150 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC1150 Digital [ALC1150 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/491
Repository URL: https://github.com/alsa-project/alsa-lib
