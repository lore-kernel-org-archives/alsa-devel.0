Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E179BC55184
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:41:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 423F7601FC;
	Wed,  5 Aug 2026 03:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 423F7601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785894094;
	bh=Hzay9u2DPt6QgueerB1+/4Y4oxpHHbmFysvgiLZ62wI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mhQM3pxjRTJY63B4bBYj7c1xNFHZKXwlgkV4DHOCX4+iAoWvuGR7pxXL92oU/0Jn6
	 q4VeTaDPjgOQTbxv6uZYA0AXFGo0i3qFYpEQwWpekvsQBW7DmpDDdnlIqGdH1h+3m3
	 GoOglc7CQw5Am/redr2B9PzZJvVDe0A5p92J9IRQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29188F805F3; Wed,  5 Aug 2026 03:40:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB128F805F5;
	Wed,  5 Aug 2026 03:40:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D056F8027B; Wed,  5 Aug 2026 03:40:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785894048;
	b=D+aYDlWZf5uuF3AdaWFgDem2RN7cCBYJ10jRVHa0lTUShMp6K5cfrQOKsIE+F7LUbKX1
	 Kabk9zVCIsvq8KzQO4hJCWNKkBBexdY2bN/Rwgnh2/YANZlmwsDUtPRFSP4b18gAyS6Yu
	 YQywkuTnMCh33Y9hAc/mAmjlVq4bQNgjQiDcaSIlA282zclQFx5g32uwjFn7p2MrAga4U
	 gvWae4Nu93yR4v/2CboT46R3VdAlDQUb2h9nenY6vtpkcOX6wHHQLB5J73SLf/bqBLKG0
	 /A6JH3P4+4zRj7DhraoXMXgMHP76Bvl0h8slSNQM+K/F9m2Cb8QDFxtQkCCsua9igxw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785894048;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Hzay9u2DPt6QgueerB1+/4Y4oxpHHbmFysvgiLZ62wI=;
	b=Ofp6W9mUex+M3LU+tf4EfI6dyQ/Dz1Uipy+PUGl8gPcgyFGUWBXg6O61pz4t+EsWeBq7
	 ZQ6SG2Lq1w1ckqWkRki+vGdU71fSeB9W/gSOWudTloMRIqbXcYOMkP8fIvbylpBU5S+0K
	 6kmF9kqEt9WbSrC0RDI4YRe9Y6mmwwuZA2fkKEDwyv4qbjRQNDFG6JaAOMfd+cHlTuK/1
	 qPhypu92C1aTHxeoQ48HyNkPNw4FlHCW96orm49bHsi07NTHUNywkboLBP8gRsboVHW9S
	 PjlAPtRSX2+ixjnBFLCEXkHtjFrl9TZcxVdKyzJX5Ix+pXYmJKCra9Lh5dq2lpcgCLw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 563D0F80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 03:40:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 563D0F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c8c52c6df08200-webhooks-bot@alsa-project.org>
In-Reply-To: <18c8c52c6dc97100-webhooks-bot@alsa-project.org>
References: <18c8c52c6dc97100-webhooks-bot@alsa-project.org>
Subject: Support ffmpeg 9
Date: Wed,  5 Aug 2026 03:40:49 +0200 (CEST)
Message-ID-Hash: TZKNJ26JYDSL3HP7UXQ4ST7VJNSMCOWE
X-Message-ID-Hash: TZKNJ26JYDSL3HP7UXQ4ST7VJNSMCOWE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TZKNJ26JYDSL3HP7UXQ4ST7VJNSMCOWE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #64 was opened from lfos:

Ffmpeg 9 has been released today [1].

Compilation with ffmpeg 9 currently fails:

```
pcm_a52.c: In function '_snd_pcm_a52_open':
pcm_a52.c:1159:28: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1159 |                 rec->codec = avcodec_find_encoder_by_name(avcodec);
      |                            ^
pcm_a52.c:1161:28: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1161 |                 rec->codec = avcodec_find_encoder_by_name("ac3_fixed");
      |                            ^
pcm_a52.c:1163:36: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1163 |                         rec->codec = avcodec_find_encoder_by_name("ac3");
      |                                    ^
pcm_a52.c:1166:28: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1166 |                 rec->codec = avcodec_find_encoder(AV_CODEC_ID_AC3);
      |                            ^
pcm_a52.c:1205:36: error: 'AVCodec' has no member named 'sample_fmts'
 1205 |         rec->av_format = rec->codec->sample_fmts[0];
      |                                    ^~
```

[1] https://ffmpeg.org/download.html

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/64
Repository URL: https://github.com/alsa-project/alsa-plugins
