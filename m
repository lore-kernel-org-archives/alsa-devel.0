Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAEDC32774
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 11:58:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DFF6E11;
	Tue, 23 Aug 2022 13:57:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DFF6E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661255919;
	bh=wulxSZLwXmYWou/ouwEu8EvMS3+wzOc0DEyPv0w/5sQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BDNcIr0Bi4RCiP4NcFvPzaS1wVwhyPcRADfjiFt+D4U80nljHhiZBgvT6bJQYBcJf
	 ammGb1TKy34z8LrclNYCvi+Ej84Ssokl99uAN/jkro1Oo15mTKfGRa/AeOYU8XN0or
	 6uV8TMJ9F8Ri5FWQepbOSZRop3T5BAVKE0LMK6Y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8CD3F800A7;
	Tue, 23 Aug 2022 13:57:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9878CF800A7; Tue, 23 Aug 2022 13:57:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 403A0F800A7
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 13:57:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 403A0F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="o04Ga/Lm"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="IfXhG437"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D64C8336BA;
 Tue, 23 Aug 2022 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661255863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yt8TXnf1Pm+uAk2XxFjARvyi/I6HK3K1O2YepFzlH7c=;
 b=o04Ga/LmLXNYbHB7LiJ7yfgiAkumS4bxE2zbO988ykFHCUWdhI0EwR1Kn4FYTu6Bb88Q1n
 keJmXxsygg7SCDJ4CKC8ANjN5jTZ4VHygtZXz8HhlghBvHhUdGFkVJKSL3SUc/YWGuGfNc
 4KnSuKJFiXCJUfBF4F+pLlQrHagkiUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661255863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yt8TXnf1Pm+uAk2XxFjARvyi/I6HK3K1O2YepFzlH7c=;
 b=IfXhG437Q6w+qRlPJEdoVuSVRRuBKS0M0C0VwwUYBCRp/iUu6XNntHNxcAGrd7OZ4BjRb/
 mndfKCMiY5uUzsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCD8213AB7;
 Tue, 23 Aug 2022 11:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LrtULbfABGP1OAAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 23 Aug 2022 11:57:43 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ALSA: Drop hackish GFP giveaway for CONTINUOUS pages
Date: Tue, 23 Aug 2022 13:57:35 +0200
Message-Id: <20220823115740.14123-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

this is a series of cleanup patches for dropping the current hackish
way of passing the GFP_* flags for CONTINOUS and VMALLOC memory
allocations.  There are only three users for this legacy feature, and
all of them seem superfluous.  And, if any driver requires the memory
restriction in future, it can now pass the proper device pointer for
specifying the DMA mask.


Takashi

===

Takashi Iwai (5):
  ALSA: vx: Drop superfluous GFP setup
  ALSA: pdaudiocf: Drop superfluous GFP setup
  ASoC: Intel: sst: Switch to standard device pages
  ALSA: memalloc: Drop special handling of GFP for CONTINUOUS allocation
  ALSA: doc: Drop snd_dma_continuous_data() usages

 .../kernel-api/writing-an-alsa-driver.rst     |  21 ++--
 include/sound/memalloc.h                      |   3 -
 sound/core/memalloc.c                         | 113 ++++++++----------
 sound/drivers/vx/vx_pcm.c                     |   3 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c        |   3 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   7 +-
 6 files changed, 61 insertions(+), 89 deletions(-)

-- 
2.35.3

