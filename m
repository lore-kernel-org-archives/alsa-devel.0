Return-Path: <SRS0=RDt5=PF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378B5C433FE
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Oct 2021 07:50:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CD861152
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Oct 2021 07:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4CD861152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C54B181F;
	Sun, 17 Oct 2021 09:50:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C54B181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634457050;
	bh=/EkBDCO/J7oeJ3iqATpTh/tYXnhf+SmTh/m9oORjXrk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MWxvkYKu62aUKsXx/Teo1v+M5qJduz/R8tYJlIh7uDucCGnocm6gOSSca37mSLHN2
	 sibdjb3KrfAHZg3OosVjv0n/9wGCBtXmJN4EqBAW31EL2axAVg0K2qf/Qq1AaL/cZ1
	 o/YtIHxuk3RXpY7yX9JSKIr0ZRqf0s1Pdl/SXP5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD836F804E5;
	Sun, 17 Oct 2021 09:49:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01908F802E0; Sun, 17 Oct 2021 09:49:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C36E6F800E5
 for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2021 09:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C36E6F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Ukmyfq7o"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="DmjGT8Rs"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9B2C021984
 for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2021 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634456940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+P1rVZxCYkbF2C5iHHYoQzqeIX077BQoH4Vgu2r9Gv0=;
 b=Ukmyfq7oKZ2ln6HechoKyTWBhqfWSygu6XgWyAfB2QRVESW/T03llRxXODMcaJTgXgn7dW
 4pvWAGlt3zPR3mqY4YT9xdJVOlniyxM95sHWLLzXzDz2BAuP/BP3+pUIO8dZs/Vqz1uH93
 mj+00bBdBFWO4d8tLZwYI9fPcbYhEis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634456940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+P1rVZxCYkbF2C5iHHYoQzqeIX077BQoH4Vgu2r9Gv0=;
 b=DmjGT8RsOt2TvpA1BV45tKp16SFWvwkxxvSwJUvEFAuBySzZXh3ljRQjoCA0+Dy/V5Az57
 gO7NAG8A7PZzxiCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 8BC5FA3B81;
 Sun, 17 Oct 2021 07:49:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] ALSA: Support for non-contiguous and non-coherent page
 allocations
Date: Sun, 17 Oct 2021 09:48:56 +0200
Message-Id: <20211017074859.24112-1-tiwai@suse.de>
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

this is a revised patchset that is created from the latest code.
The previous one caused a slight conflict with the recent changes,
also some patch descriptions have been updated.

***

Here is a patch set to add the support for non-contiguous and
non-coherent page allocations to the ALSA core memalloc helpers.
Currently no driver is using, but this also gave a nice cleanup for
the existing SG-buffer helpers on x86.


Takashi

===

Takashi Iwai (3):
  ALSA: memalloc: Support for non-contiguous page allocation
  ALSA: memalloc: Support for non-coherent page allocation
  ALSA: memalloc: Convert x86 SG-buffer handling with non-contiguous
    type

 include/sound/memalloc.h    |  61 +++++++++--
 sound/core/Makefile         |   1 -
 sound/core/memalloc.c       | 207 +++++++++++++++++++++++++++++++++---
 sound/core/memalloc_local.h |   1 +
 sound/core/pcm_lib.c        |   3 +
 sound/core/pcm_local.h      |   7 ++
 sound/core/pcm_memory.c     |  13 ++-
 sound/core/pcm_native.c     |  16 +++
 sound/core/sgbuf.c          | 201 ----------------------------------
 9 files changed, 282 insertions(+), 228 deletions(-)
 delete mode 100644 sound/core/sgbuf.c

-- 
2.26.2

