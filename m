Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F93CA9EDB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:04:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4DC217F4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qj9Bw2M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4DC217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D8881723;
	Tue,  5 Nov 2019 09:03:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D8881723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572941057;
	bh=eF6KEpQcO+EHnZ9f6WESfbOtVFQ42JRP38IOFEztoMw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qj9Bw2M1+Joxo94SvlxojsXymDzRZENv5ZeG6DcGU/yq/DMvhzubtS6Y1fyeXuTD5
	 ae2PPbHZXUYIEA8Tbg25f/5KywHILeZmmCXuZuhJcnaiVJoVjm3pWo7kWZkgsoKZLq
	 /XfsOC8ybhCdCE6y0UbXXhXrE3TUY9b5CVBoj3r4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7319EF80600;
	Tue,  5 Nov 2019 09:01:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32B35F8053B; Tue,  5 Nov 2019 09:01:45 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DA4BF80446
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 09:01:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DA4BF80446
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E219AB01E
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 08:01:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 09:01:34 +0100
Message-Id: <20191105080138.1260-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH 0/4] ALSA: enhancement / cleanup on memalloc
	stuff
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

this is a small series of patches to enhance / clean up the core
memory allocation stuff.  The basic changes are:

- The memalloc code accepts NULL device pointer to treat as the
  default mode for the continuous pages
- The new SNDRV_DMA_TYPE_VMALLOC type in the core allocator, so that
  we can drop the PCM-specific helpers
- The PCM mmap default handler checks the buffer type, and the PCM
  page ops can be dropped in almost all cases.

These whole core changes are still compatible with the old code.

The actual cleanup patch for each driver will be posted later once
when this core change set is accepted.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: memalloc: Allow NULL device for SNDRV_DMA_TYPE_CONTINOUS type
  ALSA: memalloc: Add vmalloc buffer allocation support
  ALSA: pcm: Handle special page mapping in the default mmap handler
  ALSA: docs: Update documentation about SG- and vmalloc-buffers

 .../sound/kernel-api/writing-an-alsa-driver.rst    | 80 ++++++++++++----------
 include/sound/memalloc.h                           |  1 +
 sound/core/memalloc.c                              | 23 ++++++-
 sound/core/pcm_native.c                            | 14 +++-
 4 files changed, 80 insertions(+), 38 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
