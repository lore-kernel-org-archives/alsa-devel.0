Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA4CA600A
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:20:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BB55601F2;
	Thu,  8 Oct 2026 10:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BB55601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791447653;
	bh=0zarvz5x3Nk8OyIrLjyRxUGuDWuyXiZCe2ZePYWBHuw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Vo8ewi02atpT8vxKPYfjCVbQNj2tH0SCk9XRAEfI7WC7lIAhH5Aetk3yTWsRv5zCI
	 D52R2ziSTikDCfFgQoeJMMrov/XNwk85SFKkTLTBl/4ewZienoHBq5vLpHEQD7tiTH
	 7QZx+PRreDsB1D2aukBMY8xaeAtRMG8ca+NRBiMk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 589B0F805F6; Thu,  8 Oct 2026 10:20:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFC2AF80601;
	Thu,  8 Oct 2026 10:20:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70314F80571; Thu,  8 Oct 2026 10:20:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791447604;
	b=XQPEKRufKJX+CYQD+815tNKLQAdNoCjuLLRhCEhxBWaJ0VbFisOTTyI8A8w9mi1IprGz
	 DxAywf9iCMo27jSfWEqDsIrxLnv/roA2IvssqQ43E5FUTxwwP8+wrilZUDdROPb3YShv7
	 ShNQUf9+4pulLSwemBf5UhY1v0NHxSywzeVloc8Rs+Y4mw+O/dCW3shqHlJvYmW+6Bxa5
	 4AuQC+vokiA9zpVASahd04LQfxpPPicsnktNfHEBp0uX9VrET1xHmujFW1Vhp5U0U1g/V
	 Rr7vcx0IHUTO4WCJEDDZ+h8EeMqgG8tf8CWiTUB9/or6KSrvBWQA1EQzCzBnKLVwyRQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791447604;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=0zarvz5x3Nk8OyIrLjyRxUGuDWuyXiZCe2ZePYWBHuw=;
	b=aDkZPQS8hUKiOkRBc8kkvy4Mb6XbqaGRnOsEltVr+IqKznOTvyr+JRk2x5MV8y4l/dq0
	 a5eBb7Gh+e3CBuQYFj3bZY6v7/BXJdKyP+MXtAmAzEJX0yCnRQQDp47k+R+a+925N2l+u
	 UvgJA87RLDFAPhQzQhbKuMdoNVY3198ZioHOP0YC07HOClXCqGji+HhCsKr/Ma9DRh2Yf
	 wWxbNu6/Uzl3KghZwVpblz1Lu78f6tr4XeeURG2WmWkM9HDzHkSKssSm7B2PDBd80qQXO
	 kD6hFRcxSs0ZCfHr8AAwLaYTuTCfJLz+JGo1zv3C4WRn7WXX6/aPlgWd48OhyMQd0sw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eomlYSQ0;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D8796F8007E
	for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2026 10:20:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8796F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eomlYSQ0
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0BFAF601EF;
	Thu,  8 Oct 2026 08:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9218C1F000FF;
	Thu,  8 Oct 2026 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447598;
	bh=BsvZFhaaw2FJn5OYj9chWaqMkSIvzRK4fs9/JiJiOvM=;
	h=From:To:Cc:Subject:Date;
	b=eomlYSQ0gklpPV0g46fSLEej16ma8xafegjEw6gxDY2ZS/+64eY0bicFu33db4G2C
	 xJz/nPeiXHqxZ78UCNrXXX4Mjnky8DYDjAnOG24I9tlBjLCZcGohDcHYFRGkPa4kAc
	 Dz2Jm0T3udiwDka/eZMgPe4OfV8dR6/8Qr21K0xFqXALuaIO4TQf02DHUVjFo28qKZ
	 oqIjSUm/HfkonNczxHaTouUeazM6L+As6ThDBHx9YpY/p3h7OHGuGQ9O/rNaz6p0xI
	 Vvv/odq3IY9k2nPZusr0Hp1AZnokRrjHsho3A1uXeihgEk8h3F+6J4Putnu2CTrZMd
	 +pMQbGbsSUjrw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A2A6D1AC57CE; Thu, 08 Oct 2026 09:19:55 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc6
Date: Thu, 08 Oct 2026 10:19:42 +0200
Message-Id: <20261008081955.A2A6D1AC57CE@finisterre.sirena.org.uk>
Message-ID-Hash: MAR4FXD2SPP2SLTOHN7EYZM4IMBCEV57
X-Message-ID-Hash: MAR4FXD2SPP2SLTOHN7EYZM4IMBCEV57
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MAR4FXD2SPP2SLTOHN7EYZM4IMBCEV57/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc6

for you to fetch changes up to 9ca0d0d0249230135dbf6fa1b9168e260151babc:

  ASoC: amd: acp: Add more ACP7.0 match entries for Cirrus Logic parts (2026-10-07 16:21:32 +0200)

----------------------------------------------------------------
ASoC: Fixes for v7.3

A fairly small collection of fixes and a few device quirks, nothing
especially remarkable unless you have the affected system.

----------------------------------------------------------------
Alvin Šipraga (2):
      ASoC: adau1372: allow sleepy powerdown GPIOs
      ASoC: adau1372: fix invalid default state of output ASRC and DAC muxes

Marek Szyprowski (1):
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Mark Brown (2):
      ASoC: adau1372: two small bugfixes for the codec
      ASoC: cs35l56/57/62/63: Use the correct SoundWire DP for feedback

Michael Garland (1):
      ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Richard Fitzgerald (2):
      ASoC: cs35l56: Add DAI for SDCA OT25 stream
      ASoC: sdw_utils: Switch CS35L56/57/62/63 to use OT25 DAI

Simon Trimmer (2):
      ASoC: amd: acp: Add DMI override for ASUS EXPERTBOOK AM7406CKA
      ASoC: amd: acp: Add more ACP7.0 match entries for Cirrus Logic parts

 include/sound/cs35l56.h                  |  1 +
 sound/soc/amd/acp-config.c               |  7 +++++
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 35 +++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c            |  7 +++++
 sound/soc/codecs/adau1372.c              | 18 ++++++++---
 sound/soc/codecs/cs35l56-sdw.c           |  9 ++++--
 sound/soc/codecs/cs35l56.c               | 54 ++++++++++++++++++++++++++++++++
 sound/soc/samsung/i2s.c                  |  8 +++++
 sound/soc/sdw_utils/soc_sdw_utils.c      |  8 ++---
 9 files changed, 137 insertions(+), 10 deletions(-)
