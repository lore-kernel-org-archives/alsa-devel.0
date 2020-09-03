Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B6C433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:51:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D19A206A5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kvVpb7si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D19A206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 830401924;
	Thu,  3 Sep 2020 12:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 830401924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599130292;
	bh=9ewmGijru5K5XWHREyKbu2JyXAi93fxIJVyEj1sFnUk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kvVpb7siyfukBPQ4k/9b5Ji9gCpka9yb9BrFzeZP/JXVvzdqgZAvHeWWw/BhhuwpC
	 dUK6P8KtcPfxRB8w2ym2RnsUXQQHXduSBglnfdfTN6tamlPyr8uARO5gdxtg1jwcg5
	 PFsqJXI2Uu+9+zPHbXFkjUX3p6scM3/Q04mQO52E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A928F802DD;
	Thu,  3 Sep 2020 12:48:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4012DF802A9; Thu,  3 Sep 2020 12:47:59 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5436F800F0
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5436F800F0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 81097B01D;
 Thu,  3 Sep 2020 10:47:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: Kill tasklet usage
Date: Thu,  3 Sep 2020 12:47:46 +0200
Message-Id: <20200903104749.21435-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>
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

this is another series of patches to kill tasklet usages in sound
tree, at this time, applied to ASoC drivers.
The patches are applied on top the tasklet API conversion patches,
found in topic/tasklet-convert branch of sound git tree, which will be
included in 5.9-rc4.


Takashi

===

Takashi Iwai (3):
  ASoC: fsl: Replace tasklet with work
  ASoC: sh: Replace tasklet with work
  ASoC: txx9: Replace tasklet with work

 sound/soc/fsl/fsl_esai.c  | 14 +++++++-------
 sound/soc/sh/siu.h        |  2 +-
 sound/soc/sh/siu_pcm.c    | 21 +++++++++++----------
 sound/soc/txx9/txx9aclc.c | 11 ++++++-----
 sound/soc/txx9/txx9aclc.h |  2 +-
 5 files changed, 26 insertions(+), 24 deletions(-)

-- 
2.16.4

