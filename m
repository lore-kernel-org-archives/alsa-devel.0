Return-Path: <SRS0=yPb/=66=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA94C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:30:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597EC20709
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FSmtxcIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597EC20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BE4D1655;
	Sat, 16 May 2020 08:29:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BE4D1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589610600;
	bh=6kCMl6h/eb2fCnGsH7eUqC6yl8RzioKQW+yOOzg4TUc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FSmtxcISYBBoL9mOgyZDsmUsVAZJXGS8n8Q0wLgzbp4tk7xOcvglvOES447oVbzEH
	 qUSfZp9JeJ0+2mR/UJ6Hr0Mdlfscmx0MQ+QGgcTxexEZmjqjoKGGMYhrnrXbZHg8mk
	 lfm0aXVJJGlyq08rE9yZFHO6jNrJ+taeVUgm96Pw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32E2CF800FE;
	Sat, 16 May 2020 08:29:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7CE2F801DB; Sat, 16 May 2020 08:29:01 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13109F800DD
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 08:28:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13109F800DD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8F956ABEC
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 06:28:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: hda: Cleanup helpers
Date: Sat, 16 May 2020 08:28:52 +0200
Message-Id: <20200516062854.22141-1-tiwai@suse.de>
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

Some helper functions are used only locally or not used, here just
a simple cleanup.


Takashi

===

Takashi Iwai (2):
  ALSA: hda: Drop unused snd_hda_queue_unsol_event()
  ALSA: hda: Unexport some local helper functions

 include/sound/hda_codec.h   | 7 -------
 include/sound/hdaudio.h     | 3 ---
 sound/hda/hdac_bus.c        | 2 --
 sound/hda/hdac_controller.c | 1 +
 sound/hda/local.h           | 3 +++
 5 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.16.4

