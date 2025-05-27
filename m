Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497BFC54F30
	for <alsa-devel@archiver.kernel.org>; Tue, 27 May 2025 07:58:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC72D601E6;
	Tue, 27 May 2025 09:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC72D601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748332724;
	bh=Bw885He0WZWHVlX8cBwM3ERyZ6ZyASW2E2EfeBFVTNo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DEr35QPUKm2n3gCXguNjXKcmy/rdrOjwCdUQII3R0RWz8zstbTbUEaVx/XH/xKY1v
	 UxBkruXfvFpnsR3aFlSXF8WPq1aWN6cDBsarhNw+CbgXYlGYko4A5TLwOiaQBjCMfl
	 G7wk7ayuVpoVW3rKJVEvmYXq4cKUBXYlRPkCY8zs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B016F805C3; Tue, 27 May 2025 09:58:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31B1EF805C2;
	Tue, 27 May 2025 09:58:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE4E9F800F0; Tue, 27 May 2025 09:58:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 27DA8F800D2
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2025 09:58:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27DA8F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1843535080e42c00-webhooks-bot@alsa-project.org>
In-Reply-To: <1843535080d02c00-webhooks-bot@alsa-project.org>
References: <1843535080d02c00-webhooks-bot@alsa-project.org>
Subject: Regex question
Date: Tue, 27 May 2025 09:58:07 +0200 (CEST)
Message-ID-Hash: VE6ZDWAHF4L3Z5B2QRSS7Y7Z2PDHCEJJ
X-Message-ID-Hash: VE6ZDWAHF4L3Z5B2QRSS7Y7Z2PDHCEJJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VE6ZDWAHF4L3Z5B2QRSS7Y7Z2PDHCEJJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #567 was opened from shumingfan:

We have an Intel platform machine that equips the rt722 multi-codecs and rt1320 amplifier.
This machine driver will use the amp of rt722 and rt1320 both.
Therefore, the component string is shown below.

`Components    : 'HDA:8086281d,80860101,00100000  cfg-amp:2 hs:rt722 spk:rt722 spk:rt1320'`

I tried to modify the regular expression to capture substrings to SpeakerCodec1 and SpeakerCodec2 variables.
However, I can't get SpeakerCodec2="rt1320", even though I changed the regular expression to 
```
SpeakerCodec {
	Regex " spk:(rt722)| spk:(rt1320)"
	String "${CardComponents}"
}
```
The variable SpeakerCodec2 is still an empty string.
What do I miss?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/567
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
