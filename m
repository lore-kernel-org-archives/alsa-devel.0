Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3116C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8383322518
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PERId7rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8383322518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1035D1607;
	Tue, 14 Jul 2020 19:26:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1035D1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594747659;
	bh=93bSbjzor0WVqy+Nps358qQNb0s4BCwdvutLZeYDTBM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PERId7rPOW8qNqIzgwVkWNcwDykOqDJNm/qWDoHxLG+L+udRySo1H/H6K8ACynqjw
	 nilitcqU/zefcmf57kCQV0QCXkwD7VbNPBPpibFBQJ97FDoKbPlAKwQl9L29LvJKFC
	 gGLFFPUdRkiwWsO+Rcy6dTeL1XQ13fqS9V8PcGgc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F2CEF8028A;
	Tue, 14 Jul 2020 19:26:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 285F0F802BE; Tue, 14 Jul 2020 19:26:46 +0200 (CEST)
Received: from mx2.suse.de (unknown [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB089F8016F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 19:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB089F8016F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F090BACFF
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:26:37 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/10] ALSA: Replace words for inclusive terminalogy guideline
Date: Tue, 14 Jul 2020 19:26:21 +0200
Message-Id: <20200714172631.25371-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Hi,

this is a patch set to replace some words and sentences for adapting
the recent inclusive terminology guidelines.


Takashi

===

Takashi Iwai (10):
  ALSA: Replace the word "slave" in vmaster API
  ALSA: ac97: Replace the words white/blacklist
  ALSA: bt87x: Replace the words white/blacklist
  ALSA: ctxfi: Replace the word blacklist
  ALSA: es1968: Replace the words white/blacklist
  ALSA: hda: Replace the words white/blacklist
  ALSA: intel8x0: Replace the words white/blacklist
  ALSA: nm256: Replace the words blacklist
  ALSA: via82xx: Replace the words whitelist
  ALSA: usb-audio: Replace blacklist word

 include/sound/control.h         |  45 +++----
 include/sound/hda_codec.h       |   2 +-
 sound/core/vmaster.c            | 261 ++++++++++++++++++++--------------------
 sound/pci/ac97/ac97_patch.c     |  34 +++---
 sound/pci/bt87x.c               |  14 +--
 sound/pci/ca0106/ca0106_mixer.c |  18 +--
 sound/pci/ctxfi/ctatc.c         |   2 +-
 sound/pci/es1968.c              |  20 +--
 sound/pci/hda/hda_codec.c       |  94 +++++++--------
 sound/pci/hda/hda_generic.c     |  20 +--
 sound/pci/hda/hda_generic.h     |   2 +-
 sound/pci/hda/hda_intel.c       |  26 ++--
 sound/pci/hda/hda_local.h       |  10 +-
 sound/pci/hda/patch_ca0132.c    |  10 +-
 sound/pci/hda/patch_realtek.c   |   6 +-
 sound/pci/hda/patch_sigmatel.c  |   2 +-
 sound/pci/ice1712/juli.c        |  16 +--
 sound/pci/ice1712/quartet.c     |  12 +-
 sound/pci/intel8x0.c            |   6 +-
 sound/pci/nm256/nm256.c         |   8 +-
 sound/pci/via82xx.c             |   6 +-
 sound/ppc/awacs.c               |  12 +-
 sound/usb/6fire/control.c       |   2 +-
 sound/usb/quirks-table.h        |   2 +-
 24 files changed, 316 insertions(+), 314 deletions(-)

-- 
2.16.4

