Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0994C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:58:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5656B601EB;
	Thu,  2 Jul 2026 20:57:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5656B601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783018681;
	bh=CLSuzdCc+04rTJajNgr/4YoXL0buOBV+ftEj0jyiyHE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mE3EXR3EQZFp5DxSI6eQnItVfT98v0tdDu2j/ujfF7+qts7BVndoZ8adrHAl3Cxfb
	 InLdVuupKu42ivUUlQyU2S84EfQsTGLVoItHcZWpBYT/pP6qeueKHXrq/3WXezGV2j
	 EQ6qEGr7+FseE6ftxu9/7GW/YcGRmKaHOVmbsAMk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD59FF8027B; Thu,  2 Jul 2026 20:57:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22593F80600;
	Thu,  2 Jul 2026 20:57:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB177F805CB; Thu,  2 Jul 2026 20:57:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783018639;
	b=lDK+AyFltrH/VoWtPHry2Mwk5RjbHHJMuikYszs9ivcwU4dpkHmpTFcoXPcHfQZ3Kzku
	 F6ya0x+XmZm3Oe4YXBtqxFt2ErvLOk7zu/oyA3o7Kj1n6L+Js/fwYjNT/B6natfFuOax/
	 Akcz+xaoMBZztHfF5mWhf2XiObwQLwM+O1qrlgtFo0TzBVhfYcfNREIlBEG3ygwD7M64z
	 8ZwrUY/E7kFlQLriFitA2sckzVRkEsKMxGa0n3nm1DMyQzsH7NXUT31yUJSLktdPhiVkX
	 s4TbozH4dQTGp0fjtganc5F7j2wbPwasywyCBRqFoOBUhxauLcGqF/88HboJr/x4oew==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783018639;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=CLSuzdCc+04rTJajNgr/4YoXL0buOBV+ftEj0jyiyHE=;
	b=Fbc1BYIGxklH8I0ZMv0LdbKpqIP/rPqJ57fj6/TMlUHp4F4FeptqS6Yf0C08Lm927GBU
	 GbEFBztY3A4kgykr4klSC/fLroLIe97mFdYiCWRufvApQvovxWArCuxkF9mHuITCBurF4
	 dxmwjL4qOu90piSDaUzXFYeddemcOY4+GmQGRZ8loSHO901b7+J4/UQKoMGTqZq+9m71B
	 eBQKN2WjBbvfnUT7xV4zMc156+i2QoKjKPhXKUV8mtvLNLJlvBHEUqIlIUIZeapFByv3r
	 Yh2jIjgg2F+oSBTRG8HCn6pyn6QgiGyPBxOlY2HvF4vm6HY0Ui6jkMeB4F0M5uCqAQg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nIcakNYS;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id A824EF805C4
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2026 20:57:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A824EF805C4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nIcakNYS
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 2F84A601CA;
	Thu,  2 Jul 2026 18:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 564A21F000E9;
	Thu,  2 Jul 2026 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783018635;
	bh=dI9q2GiXTUCWlGPiMDSgFHntAYfnC4FC2hwVFyuyAJA=;
	h=From:To:Cc:Subject:Date;
	b=nIcakNYS9VrpIskmzOuMbsPvoqEcbI/h1YxPN7gq2Yb+QTok4BeZi4hCecUVZUSHj
	 zdipYe2JILoWCuNfbkKEGPzgzw//EYmmJgqP3zEjN5Royz04h0lPV0UTAk48OCEOeB
	 f6bO0D1HLSNK+QkLeTfEzvWbWhgTK5r0Z+uNzhBbBBK7Mi3zCH4kSdG84BboZaJdLE
	 fUIgZ9dMVK/cXCInU4tswxkc+h+IAlBx9HZtIa9zDxwZsL5ZAk0fRNcsBO0ejbk7pq
	 MMGIoyc14e564p2vuXenpk70P+alc2KiDbUrswBmNnTl6af/eWt1ta79yNiJt7xvGp
	 9YwjjqCtQeW7w==
Message-ID: <706f31e9c125d17fbca0a5ed648f4933@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc1
Date: Thu, 02 Jul 2026 19:57:06 +0100
Message-ID-Hash: E2NWHYVJHMFS663G227DFHYJSKKJXE4O
X-Message-ID-Hash: E2NWHYVJHMFS663G227DFHYJSKKJXE4O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E2NWHYVJHMFS663G227DFHYJSKKJXE4O/>
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
