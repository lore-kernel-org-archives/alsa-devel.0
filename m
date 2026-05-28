Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5DACD6E44
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2026 11:45:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AD1C60274;
	Thu, 28 May 2026 13:45:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AD1C60274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779968727;
	bh=Zqk8DEywL3HMHo7G0zQdMowldPhjHbHWpahwbPi0nHI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hYMdpQ2UxPs1Xye3XO6gTUA4mIneDlXHypw1lkBVtf66VuP1KrZepWgdc12SJ4666
	 hIDJtiMyEgaDVGYzu1moaf6B1WfiUqjWo+03uEsAhLcj9KKBI0G9340PvB8px7zyK9
	 ZEq/huvAch6eG5vu53WyeGdyormBZyYYvqUERc+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB828F805EE; Thu, 28 May 2026 13:44:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 78C97F805E9;
	Thu, 28 May 2026 13:44:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61EB1F8026A; Thu, 28 May 2026 13:44:39 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 8530EF80132
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2026 13:44:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8530EF80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C3T6BNiq
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 51C2F60123;
	Thu, 28 May 2026 11:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 862231F00A3A;
	Thu, 28 May 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779968675;
	bh=IIhEmWp+l0voi1piL7DpHRW5/30yIJ0X7XVFzUtMa1g=;
	h=From:To:Cc:Subject:Date;
	b=C3T6BNiqklmDe4SwBrv2IdH2OUJbkHaVKNUu5mHqFbHx+07X6Q9mqJlCnIdLPn4vt
	 eM0iyLq6BzlQopMCTEPbJKTwaJ2l6PTw3tD557PmHRmOgEXzYWOcWtrPmriXSdSNGy
	 fxOQNP1yDC6l6HDDNgzMtOm7qyCXHVUqaz/ne3WR9k1nOEgPYPS+kVqz7BbbKoCk7O
	 /FvBsEL8kaxpZgx1roqi2wjNyG36eEPoxXY1QQxV5OG/HfRvVnJIXbustq2EgjPr2a
	 Kz1CrwSNQM/qWQl/v2nBsRczthbKGJGeTrBahYDjoxOBJWOdZLYU/7J9AkxkuVC7I6
	 //Nab4R6Lb2eQ==
Message-ID: <69088c924b372c57eeb1e4e49a2c09ba@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc5
Date: Thu, 28 May 2026 12:44:09 +0100
Message-ID-Hash: MDQ6QAO2624ONL5R4ZBS5LMLEPE7AKNS
X-Message-ID-Hash: MDQ6QAO2624ONL5R4ZBS5LMLEPE7AKNS
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MDQ6QAO2624ONL5R4ZBS5LMLEPE7AKNS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc5

for you to fetch changes up to f63ad68e18d774a5d15cd7e405ead63f6b322679:

  ASoC: codecs: simple-mux: Fix enum control bounds check (2026-05-27 13:43:20 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.1

This round of fixes is mostly Sirini's Qualcomm cleanups that have been
in review for a while, we also have a couple of small fixes from Cássio.

----------------------------------------------------------------
Cássio Gabriel (2):
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check

Mark Brown (1):
      ASoC: qcom: q6asm-dai: fix error handling

Srinivas Kandagatla (5):
      ASoC: qcom: q6asm-dai: do not set stream state in event and trigger callbacks
      ASoC: qcom: q6asm-dai: close stream only when running
      ASoC: qcom: q6asm-dai: fix error handling in prepare and set_params
      ASoC: qcom: q6asm-dai: remove unnecessary braces
      ASoC: qcom: q6asm-dai: use pointer type with kzalloc_obj()

 sound/soc/codecs/simple-mux.c          |  2 +-
 sound/soc/intel/boards/bytcht_es8316.c | 29 ++++++++++++++++++--
 sound/soc/qcom/qdsp6/q6asm-dai.c       | 48 ++++++++++++++++++----------------
 3 files changed, 53 insertions(+), 26 deletions(-)
