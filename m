Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B22CC6B33
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:10:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0F1360225;
	Thu, 15 Oct 2026 15:10:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0F1360225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792069837;
	bh=MrtPWE17mUklQsmlqfg/AB1DRhsL+Q30/sRtq3RmHpQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pmSiWZyd28nrUuwq643LpPCSe5b9k0MAg/A+vQCArSHomV4/A8qJegg8eaxoLbryz
	 ovBiY04BVVWSkL2nb3oTnXe1mWk/f48odrWyHK1ObRMlE0ztrpKR2zI+h9/qq8r1Z2
	 ANiNJdvIJ8xiZNwq1HsZMcycaOTFSNo65OHsOssU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 705E6F805EF; Thu, 15 Oct 2026 15:10:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D779EF805FD;
	Thu, 15 Oct 2026 15:10:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C23DDF804CF; Thu, 15 Oct 2026 15:09:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792069795;
	b=OBG623BpTZKD16zPT0UPTcYX4JCvcIWT9pj7WY9cOV7b8U76UQSzQviOU1ZgPEnJ6MsR
	 0JsuZb8W8m/NnOKZ8lPH78W0k86yP0AdoLgjNhQSlufCXvnPnFBlrU5efZZNlzK993urR
	 18HpF8z4Q93TjnFIvpxYr4lMdl9ozAtJFW1nvtQDF1Y+jigVWbiRZd/Onl1gidoxwAFqR
	 LSMuI9prVbJY5rwJ7kRtVAMZ1ovHwJ7UGLjdqV1X72tPow6MP/gDbqkqFW5fi2z2xW6OZ
	 TB1W9/QLcuyb2Y39LRH44nXXdeXs0d3noWiWRG0FbbrxybmoO9QUWXE65faiuS1mG6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792069795;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=MrtPWE17mUklQsmlqfg/AB1DRhsL+Q30/sRtq3RmHpQ=;
	b=blvTpOGdZZm03+YePqDwm2OAaFzLaAFVDCpYvdVEQlNnjsxJHYKp3PzuK0vbYyWm2KkW
	 AaiQoz3zWsNER+jPBk7cUJ98S/A+7fj/r8WBs63bdbOKLqy3Kg38M368QVxubNL/YpKOT
	 wIqNH8dc0G1U6VNejnpCen7uVfhfte+lcMvi3X17tj7In3jHt+4Lrfpl3TJn6yA6A2c+v
	 53GfmThl6xLpY94QghXiolZbE0IToEu5OLsJkhXSH1rxdH8sbAdpqer988kUYonosOTtk
	 a7IH6MbRm/kbIAhlqkVRNxUu3aoba7AKygtOd6lZr0wxmS9vS4KpGmT/OKBb7ZhkTUg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="H4T/q/S3";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id C1665F8026D
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 15:09:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1665F8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H4T/q/S3
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id B418543909;
	Thu, 15 Oct 2026 13:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1622D1F000C5;
	Thu, 15 Oct 2026 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069786;
	bh=0JuBE2rFYJnZAWgNyg188EDNsyHskD0MUK++wTZThx8=;
	h=From:To:Cc:Subject:Date;
	b=H4T/q/S3JCHkaiEMEyXy923phwkkOTvNbQ7YB0mzMeinWynUGLaSh4m6nPmlG2e+F
	 gIJundYcUbBDaptMQKvxJxWHQ5O7AqRIAOUXPga+be0bywHHcjriPR9RiAQXT90FG0
	 Pm/Gjm/m026hokvGZkcc8PSduBiR4q4i+aK7RTcOi2LoCGov/x0jpA5YgPIRxuRhVG
	 uX51+ihizo3Ex0MIG5Du1IYVnxTF6cvi54AXhyxum8TcbW4B8y8pnIm2W+X2NDmeo3
	 rev/cRRD5TFxVX2Erw7Xbe/PfeQeukjkruRmvZ+aMWUEF+6yu7Cjanyv38CzeD7JLS
	 50K5XlP+9Xl2w==
Message-ID: <bdcee80ff1b48cbbcfacaa3eb404fbca@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc7
Date: Thu, 15 Oct 2026 14:09:26 +0100
Message-ID-Hash: K2PNMNC2HHEX2EAV3GG3QWKOS3KLTWNK
X-Message-ID-Hash: K2PNMNC2HHEX2EAV3GG3QWKOS3KLTWNK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K2PNMNC2HHEX2EAV3GG3QWKOS3KLTWNK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc7

for you to fetch changes up to 2a31b5378c6db9c4a8d399e5d10d32cd4b732bef:

  ASoC: amd: yc: disable MSI on resume (2026-10-13 14:32:22 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.3

There's a relatively large block of fixes for errors in register field
definitions here, resulting from an audit done after review of a prior
series.  The fixes themselves are very small and can be directly checked
against the datasheets.  Other than that we've got some driver specific
fixes, the AMD fix is a little large but fixes a clear issue and won't
affect other systems.

----------------------------------------------------------------
Avi Weiss (1):
      ASoC: stm32: spdifrx: fix synchronization state check

HyeongJun An (6):
      ASoC: cs42l56: Put the Limiter Cushion control on the limiter register
      ASoC: cs42l52: Fix the NG Type Switch bit
      ASoC: pcm3168a: Fix the DAC zero flag polarity bit
      ASoC: max98371: Fix the Speaker DHT Min Volume bits
      ASoC: wm8978: Fix the 128x oversampling switch bits
      ASoC: nau8822: Fix the 128x oversampling switch bits

Mario Limonciello (1):
      ASoC: amd: yc: disable MSI on resume

Mark Brown (1):
      ASoC: Fix controls that write another control's bits

Peter Ujfalusi (2):
      ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
      ASoC: SOF: sof-client: Use event-handler mutex consistently

Sergey Tiraspolsky (1):
      ASoC: Intel: avs: Reset the stream unless it is already prepared

 sound/soc/amd/yc/pci-acp6x.c  | 38 ++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/cs42l52.c    |  2 +-
 sound/soc/codecs/cs42l56.c    |  2 +-
 sound/soc/codecs/max98371.c   |  2 +-
 sound/soc/codecs/nau8822.c    |  4 ++--
 sound/soc/codecs/pcm3168a.c   |  2 +-
 sound/soc/codecs/wm8978.c     |  4 ++--
 sound/soc/intel/avs/pcm.c     |  2 +-
 sound/soc/sof/ipc4-topology.c |  9 ++++++---
 sound/soc/sof/sof-client.c    |  6 +++---
 sound/soc/stm/stm32_spdifrx.c |  2 +-
 11 files changed, 55 insertions(+), 18 deletions(-)
