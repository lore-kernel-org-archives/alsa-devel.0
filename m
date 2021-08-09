Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88A3C4320A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 07:20:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69B760F92
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 07:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D69B760F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5158E168A;
	Mon,  9 Aug 2021 09:19:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5158E168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628493627;
	bh=rodwL1eaNRDDZu2z/cS6wnwjlfoqf0qWWhCGohfFANc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WQeb5wTIM7OkaGEcYaYngJQ1y+K7+FkUqznP21LglAOj6waXXJZ0uwdGvtwOZR4Ld
	 Z9sjjMw6Ox1PJIlrZKbpBcNxW1Q0lbX3Eqw6Jd67erIN7HylbeN/FPE5uzEVu9Qdes
	 +igOzN4tq271qnEDRtMJnZQ3033gkH9/aJw4KV5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9810F8032D;
	Mon,  9 Aug 2021 09:19:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3891F804E2; Mon,  9 Aug 2021 09:19:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41FB0F800C8
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 09:18:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41FB0F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="F7Fg9r7f"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="CgIgq366"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B33AD1FD96
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628493510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KBRIBjj9uJlH18zN8F41JVv0TcezVk/2ptOAXR35+pw=;
 b=F7Fg9r7fRlQKB/8QHQJDDWBQbClXiipNXA+Qt8ZHK2kIO9I/mN123SiUjHELRcBIcbBlFC
 Z/2rLgG6UOQZR7UDN1CiGOTYwJeQkJEtR42JvGl5KCR5na3RuCkiyZacQsPkD75cPiMsgE
 WkoQZSyBuEZwkJmWl2BTe5rYhZkthOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628493510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KBRIBjj9uJlH18zN8F41JVv0TcezVk/2ptOAXR35+pw=;
 b=CgIgq366OT2qPE+DZ8DwSysE/QISjp3KzRdqerAWVrMpfkm6TDVyRZPrG/jU573maGM3Nc
 aTxDuqsBkv9WItBg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A267FA3B81;
 Mon,  9 Aug 2021 07:18:30 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: pcm: More mmap coverages
Date: Mon,  9 Aug 2021 09:18:26 +0200
Message-Id: <20210809071829.22238-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

the recent regression fix enlightened the potentially missing pieces
in a couple of drivers for mmap on non-x86 architectures.  This patch
series tries to cover those.


Takashi

===

Takashi Iwai (3):
  ALSA: pcm: Check mmap capability of runtime dma buffer at first
  ALSA: pci: rme: Set up buffer type properly
  ALSA: pci: cs46xx: Fix set up buffer type properly

 sound/core/pcm_native.c       |  9 +++++++--
 sound/pci/cs46xx/cs46xx_lib.c | 30 ++++++++----------------------
 sound/pci/rme9652/hdsp.c      |  6 ++----
 sound/pci/rme9652/rme9652.c   |  6 ++----
 4 files changed, 19 insertions(+), 32 deletions(-)

-- 
2.26.2

