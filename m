Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C99C43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 11:53:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D384F6020E;
	Sun,  5 Jul 2026 13:53:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D384F6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783252402;
	bh=CLSuzdCc+04rTJajNgr/4YoXL0buOBV+ftEj0jyiyHE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=K1Wc8nUzdL62znPYCmuPEuJpPjOxo05pxEDpV6z8QK7U9XSb/PbMZj2JsnT6je4ki
	 DCVxy4O9WsrqVf117rlzVym36SCdphYHRfP+HMbVACShlYoQ6sqTkVbXBM9z6JB/HQ
	 RoQNZqeUIlzvE1qd6qOHs5ZpyxJ8wJDxtFXhz9f4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59369F805F5; Sun,  5 Jul 2026 13:52:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6AD0F80601;
	Sun,  5 Jul 2026 13:52:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07A5DF80526; Sun,  5 Jul 2026 13:52:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783252355;
	b=LqelTXWB79QDsmFWc8I/KSnfXFE2ekX6fwqikXs4ZEL6Y3l0PWQdoUTPbDo47oAxsLVe
	 T1n59tJgp/sedIN1FK8pLAgkygW1pnRddMc/nvucPA6kJCxBDf3fLoG6SBPXdO5xCjoYa
	 rb7IRCcdq3D+0bRaVRYHWxPyIkE9i9YeY2yGFILggm+2EMD3JaD0trV/TPIG9norbZZHU
	 6/K7JNlsckyO53YMhJWS84OT782/4B/VIAtmalWk9o/vSMh2IfvCCBvaTqSN2gk4na7dS
	 wzOgraqBMck5Am7PXOkc/ob7ptQ/YHMSM9+brwGb424R/22lWUcaswFIioUp7McAL/Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783252355;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=CLSuzdCc+04rTJajNgr/4YoXL0buOBV+ftEj0jyiyHE=;
	b=P7AYr8DRUEjRkYn4ffN7UC0/X0bf6HuPg/J4hFkMSrG1ob2YWjR4M/vKlIcf92VNpA5Y
	 eO9jau7BFae3i4DfuZJ5UND4Sw0U34MVQoZ/bT1aNxNwECVN0d0dLwzd82noYOQnE/TjE
	 cMEMJhFas2cYzGmkPCOEJznAKNywhzB12ncwBTARYFPM6WrlLqzLVREP7Ibojh7peF1Le
	 yShIcGdKro/66fwvf8wFttcnh+8R3h9cXT9TmvZP0TWwajgSPdbuMpBKcppFzdanx+As+
	 GGS95cQlR/OpEXC11MIjD/Y1YIYz8IP85QDO6gEvNwEvZa++kJGZR32tFybxPxlGK5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YE91ZbSN;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E582CF8026D
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 13:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E582CF8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YE91ZbSN
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F26B740089;
	Sun,  5 Jul 2026 11:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6661F000E9;
	Sun,  5 Jul 2026 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783252348;
	bh=dI9q2GiXTUCWlGPiMDSgFHntAYfnC4FC2hwVFyuyAJA=;
	h=From:To:Cc:Subject:Date;
	b=YE91ZbSNOI6MVXfhW9LCEV5FSP0/1DqGx201eZnCv4zFndlWiQht4XfiVZ1aEg528
	 hoUdsH8f0VvCZdwYAzMaiBVMpQQbdcF0xC7q4bStC8iZ2MN9YCk1JSO1gYTPhvNeXj
	 kueMPVV1ct945lLRanOSfi9lJ6XyIXGXR+7BaLePBN+9tXwVNofvySc2XULjHl9d2B
	 m2kOp9aGXGDMEtexSVatLdPh2ZcrwNdHK0ppXUcyy3EYRxI0OsJ3rA9OwS16/9cg/p
	 9ynYc7O1VKhthkfJIdDtmk3VE43xwYq8vGsR+DOoGP8wLj/1gvMcXe+Q580mCEmnYm
	 YVUUsIUXwnKFQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 1C9801AC5AC6; Sun, 05 Jul 2026 12:52:20 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc1
Date: Sun, 05 Jul 2026 12:52:19 +0100
Message-Id: <20260705115220.1C9801AC5AC6@finisterre.sirena.org.uk>
Message-ID-Hash: YK5H7TGQTUKIMPFIS5OXGI5TELQKX2OA
X-Message-ID-Hash: YK5H7TGQTUKIMPFIS5OXGI5TELQKX2OA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YK5H7TGQTUKIMPFIS5OXGI5TELQKX2OA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc1

for you to fetch changes up to 83245e7a436c04e511378af14dd81fd188b41541:

  ASoC: rsnd: src: Add missing scu_supply clock to suspend/resume (2026-07-02 18:56:38 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

A fairly standard set of driver specific fixes and quirks that have come
in since the merge window, plus a MAINTAINERS update.  The tas675x
READ_ONCE change is probably not actually fixing issues properly but we
need a whole new approach to concurrency there and it came along with
some good fixes.

----------------------------------------------------------------
Jetha Chan (1):
      ASoC: amd: yc: Add Alienware m15 R7 AMD to DMIC quirk table

John Madieu (2):
      ASoC: rsnd: adg: make rsnd_adg_clk_control() idempotent
      ASoC: rsnd: src: Add missing scu_supply clock to suspend/resume

Luca Weiss (1):
      ASoC: codecs: lpass-va-macro: Fix LPASS Codec Version for SC7280

Mark Brown (1):
      ASoC: codecs: tas675x: misc bugfixes and minor changes

Sen Wang (3):
      ASoC: codecs: tas675x: use READ_ONCE for params to be used concurrently
      ASoC: codecs: tas675x: Fix CHx temperature range register bit fields
      Documentation: sound: tas675x: Fix temperature range and impedance documentation

Vijendar Mukunda (1):
      MAINTAINERS: ASoC: SOF: add AMD reviewer for Sound Open Firmware

Yousef Alhouseen (1):
      ASoC: SOF: validate probe info element counts

 Documentation/sound/codecs/tas675x.rst | 11 ++++++-----
 MAINTAINERS                            |  1 +
 sound/soc/amd/yc/acp6x-mach.c          |  7 +++++++
 sound/soc/codecs/lpass-va-macro.c      |  7 ++++++-
 sound/soc/codecs/tas675x.c             | 14 +++++++-------
 sound/soc/renesas/rcar/adg.c           | 29 ++++++++++++++++++++++++++++-
 sound/soc/renesas/rcar/src.c           |  2 ++
 sound/soc/sof/sof-client-probes-ipc3.c | 23 +++++++++++++++++++----
 sound/soc/sof/sof-client-probes-ipc4.c | 11 ++++++++++-
 9 files changed, 86 insertions(+), 19 deletions(-)
