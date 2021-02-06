Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF7C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:38:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1B664E55
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1B664E55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6705685D;
	Sat,  6 Feb 2021 21:37:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6705685D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612643901;
	bh=atCjaaziLHrppaGDI+H2i9q/NNQrQh48UCoimNEjmDA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n39edebdDAPPpCp0w3cN/2UjmESkPdLrDYb9gquIOkLycFhmlRHUcff5tZgu3DRDz
	 zhfqhpcaFJ58b/nx/pSIJT6oRbjZjVeJB+W8yeIvG1Vp5JiQ1ZFV3+93xF0qkZ9wrg
	 /aiqFHDRHAawRXQV9fhrY3AvAhJ+P2hSKJKYeYzA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8552F8023C;
	Sat,  6 Feb 2021 21:37:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C264F8023E; Sat,  6 Feb 2021 21:37:29 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EF6CF80095
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 21:37:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EF6CF80095
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0ABC6ABD5
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 20:37:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: pcm: sync_stop fixes
Date: Sat,  6 Feb 2021 21:36:52 +0100
Message-Id: <20210206203656.15959-1-tiwai@suse.de>
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

here is a patch set to cover the missing handling of the recently
introduced sync_stop PCM ops at suspend and disconnect states.
The last patch is a pure cleanup.


Takashi

===

Takashi Iwai (4):
  ALSA: pcm: Call sync_stop at disconnection
  ALSA: pcm: Assure sync with the pending stop operation at suspend
  ALSA: pcm: Don't call sync_stop if it hasn't been stopped
  ALSA: pcm: Use for_each_pcm_substream() macro

 sound/core/init.c       |  4 +++
 sound/core/pcm.c        | 27 +++++++++++----------
 sound/core/pcm_local.h  |  7 ++++++
 sound/core/pcm_memory.c | 12 +++------
 sound/core/pcm_native.c | 54 +++++++++++++++++++++--------------------
 5 files changed, 57 insertions(+), 47 deletions(-)

-- 
2.26.2

