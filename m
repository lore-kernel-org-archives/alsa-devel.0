Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E63C4321E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 16:24:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0DDC16B3;
	Wed, 30 Nov 2022 17:23:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0DDC16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669825476;
	bh=nR09+1Jiztd4hrVWlTtIVUoWH6bkPr6c7Jpk5j5BvKw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qXJya7yEdmKzz/qbQo7kpEZGr4Q6hDUXBX1CvBd4AXEWVSGiTmWCmYzts3qxX5Qv7
	 CVFwEvL6sDVQ+4V6q82bHKeVrH9fIzYko2yHRywrznpMR/czjle8ZER+2O9DxJrU7M
	 NOun7tSiDpiUKVcgPul4Eydf7xraI53Mkm0K3AAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 661C1F8016B;
	Wed, 30 Nov 2022 17:23:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0105FF8023A; Wed, 30 Nov 2022 17:23:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75CA7F800B6
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 17:23:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75CA7F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CkMiTM/T"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BA32561CE6;
 Wed, 30 Nov 2022 16:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F5C433D6;
 Wed, 30 Nov 2022 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669825419;
 bh=nR09+1Jiztd4hrVWlTtIVUoWH6bkPr6c7Jpk5j5BvKw=;
 h=From:To:Cc:Subject:Date:From;
 b=CkMiTM/TMn+A7MKV2AbRLSBASEuxCYcEEIF98QPyv5Y84zFgqDR7YGNKTr1KVDxnf
 jXb44ApgNIVC3KN61TCnvBG5gYFBB1sRIXIC55JxzHihmiLYFOaANQ3ArtLd9MmVug
 TcQFx1Ys/7Ta0bIKUgam9ef3qRCyq6DKIgEdGjD1GD1UYDVQd3Ykjw/njkZ49ePKXf
 u8SqnfflAcHfzj1tEINyZ3ewGRHVA2gdy6V93RWwyqClsnZwlm4SzxuXnGdJ/8SUO+
 IeHb1WYVf0x/BBjo9SFIRzcjafyQP2zlU0MBTYXhjqIHs95RwdyY7kDgsJjPrTZWkI
 3AzoKTD8ZQ1yg==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v6.1-rc7
Date: Wed, 30 Nov 2022 16:23:26 +0000
Message-Id: <20221130162338.BF2F5C433D6@smtp.kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The following changes since commit db8f91d424fe0ea6db337aca8bc05908bbce1498:

  ASoC: soc-pcm: Add NULL check in BE reparenting (2022-11-22 12:23:00 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.1-rc7

for you to fetch changes up to 3d1bb6cc1a654c8693a85b1d262e610196edec8b:

  ASoC: cs42l51: Correct PGA Volume minimum value (2022-11-25 16:29:52 +0000)

----------------------------------------------------------------
ASoC: Fixes for v6.1

Some more fixes for v6.1, some of these are very old and were originally
intended to get sent for v5.18 but got lost in the shuffle when there
was an issue with Linus not liking my branching strategy and I rebuilt
bits of my workflow.  The ops changes have been validated by people
looking at real hardware and are how things getting dropped got noticed.

----------------------------------------------------------------
Charles Keepax (2):
      ASoC: ops: Correct bounds check for second channel on SX controls
      ASoC: cs42l51: Correct PGA Volume minimum value

Hui Tang (1):
      ASoC: tlv320adc3xxx: Fix build error for implicit function declaration

Mark Brown (3):
      ASoC: ops: Fix bounds check for _sx controls
      ASoC: ops: Check bounds for second channel in snd_soc_put_volsw_sx()
      ASoC: Merge dropped fixes from v5.18

Shengjiu Wang (2):
      ASoC: fsl_micfil: explicitly clear software reset bit
      ASoC: fsl_micfil: explicitly clear CHnF flags

 sound/soc/codecs/cs42l51.c       |  2 +-
 sound/soc/codecs/tlv320adc3xxx.c |  3 +++
 sound/soc/fsl/fsl_micfil.c       | 19 +++++++++++++++++++
 sound/soc/soc-ops.c              | 11 ++++++++---
 4 files changed, 31 insertions(+), 4 deletions(-)
