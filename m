Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFCC48BCD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:28:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B9610A2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B9610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5564916EB;
	Wed,  9 Jun 2021 18:27:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5564916EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623256085;
	bh=CwcfJ9pmtX36rbshZeKY7SkmDKba0wUts6vOwqb+/kg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YSAqRxHA2YqezTdZtZ0RbocXQoXnEn1gbMYlUwitFoN8dZfnsMcgclHZQDo0h5EwD
	 65+Y7vSql1VoWSM/wmfhDTZp1I9y/eTIY9i4R+as8w7OiUZu2X9s8mMx1m29xQ5j31
	 +QYRevyvqKcNN7+Rtbki+IewgXVEx9P0KiYNWh/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA801F804D0;
	Wed,  9 Jun 2021 18:26:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27627F804D2; Wed,  9 Jun 2021 18:26:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3B83F8026C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 18:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3B83F8026C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="dx8WDbH/"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="k/frhNe2"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3DAC3219B7
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623255954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g/Zaij+MG/pIu0575MK3JYFWwgBVOuh/NAtNmG3beN8=;
 b=dx8WDbH/Cr0/UVTTw1BYxlM4kOH+qN/R3VhungnQaN4ib/IONPikOeH89CYBlc2AzAhA50
 2TMj5Z6Z9T9wZTfKFosiXCrxuIVWNH9RGBh/LH8Y9+LwQxXgUuzSTtUq0VXzJAn6TPdoza
 E/2lJveVKAByuwprrBt1SqnyM0BnBfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623255954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g/Zaij+MG/pIu0575MK3JYFWwgBVOuh/NAtNmG3beN8=;
 b=k/frhNe2g3ooUPAEKQICpfPDXa3N4IZF8mxxAO+ds3U3M+NkzwSCZ34Kn0YxeoK0xHLjsH
 2e58BUvMQaTL0ACA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 2D39CA3B89;
 Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ALSA: More abstracition of memory alloc helpers
Date: Wed,  9 Jun 2021 18:25:46 +0200
Message-Id: <20210609162551.7842-1-tiwai@suse.de>
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

this is a patch set for the code cleanup and refactoring around the
ALSA core memory allocation helpers.  It begins with a cleanup of the
non-used code, then followed by the refacotoring with the new ops,
finally moved the memory-specific mmap handling code from PCM to the
core memalloc.


Takashi

===

Takashi Iwai (5):
  ALSA: trident: Drop shadow TLB pointer table
  ALSA: core: Drop snd_sgbuf_get_ptr()
  ALSA: core: Abstract memory alloc helpers
  ALSA: core: Move mmap handler into memalloc ops
  ALSA: core: Add continuous and vmalloc mmap ops

 include/sound/memalloc.h           |  83 +-----
 include/sound/pcm.h                |  19 --
 sound/core/memalloc.c              | 444 +++++++++++++++++++----------
 sound/core/memalloc_local.h        |  19 ++
 sound/core/pcm_local.h             |   5 -
 sound/core/pcm_memory.c            |  21 --
 sound/core/pcm_native.c            |  39 +--
 sound/core/sgbuf.c                 |  90 ++++--
 sound/pci/trident/trident.h        |   1 -
 sound/pci/trident/trident_main.c   |  11 +-
 sound/pci/trident/trident_memory.c |  53 ++--
 11 files changed, 405 insertions(+), 380 deletions(-)
 create mode 100644 sound/core/memalloc_local.h

-- 
2.26.2

