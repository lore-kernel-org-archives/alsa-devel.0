Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BFC2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:22:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA6D20692
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MdTCOqW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA6D20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76FCB16D4;
	Mon, 13 Apr 2020 10:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76FCB16D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586766149;
	bh=HP9DVudVJVHQYnNfYXdNXgmdUdxQiEcnkGl0pSU/kAg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MdTCOqW8yeaXfh7hvYUt+jpbQzJO4piP78F74tBmb5BMuN7WC8kiHE9Upr7ZExOBi
	 aHdG4Qh4xh4znoP05QArIX9GRjhfd7WdMNxnsoa+fcVrAf6UEY7mGPpcBEZ9OFwFBa
	 O0RTNKd5EMxpuVit/As5/zVp+QE71HEAGbSfmJQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FD2BF80266;
	Mon, 13 Apr 2020 10:20:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C42EF8028C; Mon, 13 Apr 2020 10:20:48 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24B9FF80245
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 10:20:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24B9FF80245
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 67412AC26;
 Mon, 13 Apr 2020 08:20:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ALSA: hda: Fix/improve no-codec bus
Date: Mon, 13 Apr 2020 10:20:28 +0200
Message-Id: <20200413082034.25166-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Roy Spliet <nouveau@spliet.org>
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

here is a patch set for fixing / improving the error handling of
HD-audio bus without codecs, which can be seen on some GPUs, for
example.

It's been debugged and tested in bugzilla:
  https://bugzilla.kernel.org/show_bug.cgi?id=207043


Takashi

===

Roy Spliet (1):
  ALSA: hda: Explicitly permit using autosuspend if runtime PM is
    supported

Takashi Iwai (5):
  ALSA: hda: Don't release card at firmware loading error
  ALSA: hda: Honor PM disablement in PM freeze and thaw_noirq ops
  ALSA: hda: Release resources at error in delayed probe
  ALSA: hda: Keep the controller initialization even if no codecs found
  ALSA: hda: Skip controller resume if not needed

 include/sound/hda_codec.h |   5 +++
 sound/pci/hda/hda_codec.c |   2 +-
 sound/pci/hda/hda_intel.c | 106 +++++++++++++++++++++++++++-------------------
 sound/pci/hda/hda_intel.h |   1 +
 4 files changed, 69 insertions(+), 45 deletions(-)

-- 
2.16.4

