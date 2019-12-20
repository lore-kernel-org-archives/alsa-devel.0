Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69611C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:35:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B112146E
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P26QQDM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B112146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CE1882A;
	Fri, 20 Dec 2019 16:34:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CE1882A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576856115;
	bh=f8wE9hcgOeTF7rbhvDXN5k5d7WxpyDz+gFQCjmn/VX0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P26QQDM8wD9A43JQRsdWmoyNSvWqr6UY3a9mz1eeV1nrLmeV03Cb8wyeplEB2+4YY
	 hzY8HIZgFa2QaCh/9Hr9pkffgLSM7YkD/uAqyT7LNTkgjIfRRzLy2/N1CbQrHl1Nj8
	 eiGGQetlbW+22wiSlZhcIwFxnvKLtzSRvTC/vIZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9DECF80059;
	Fri, 20 Dec 2019 16:34:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00A5BF8015A; Fri, 20 Dec 2019 16:34:22 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77A15F80059
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:34:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77A15F80059
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 57723AE37
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 15:34:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 16:34:10 +0100
Message-Id: <20191220153415.2740-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH 0/5] ALSA: Fix uapi headers
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

here is a series of fixes for include/uapi/sound/*.h files and the
relevant code changes, so that they can be used for building
alsa-tools programs again.

The corresponding alsa-lib update will be followed.


Takashi

===

Takashi Iwai (5):
  ALSA: emu10k1: Make uapi/emu10k1.h compilable again
  ALSA: hdsp: Make uapi/hdsp.h compilable again
  ALSA: hdspm: Drop linux/types.h inclusion in uapi header
  ALSA: uapi: Fix typos and header inclusion in asound.h
  ALSA: uapi: Drop asound.h inclusion from asoc.h

 include/uapi/sound/asoc.h    |  1 -
 include/uapi/sound/asound.h  |  6 +++---
 include/uapi/sound/emu10k1.h | 38 ++++++++++++++++++++++++++------------
 include/uapi/sound/hdsp.h    |  4 +---
 include/uapi/sound/hdspm.h   |  2 --
 sound/pci/emu10k1/emufx.c    | 26 ++++++++++++++------------
 sound/pci/rme9652/hdsp.c     |  2 +-
 7 files changed, 45 insertions(+), 34 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
