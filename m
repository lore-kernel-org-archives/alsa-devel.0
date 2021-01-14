Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7789DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 13:34:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD6F23A55
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD6F23A55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 062F116A4;
	Thu, 14 Jan 2021 14:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 062F116A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610631279;
	bh=quuezsVrkLaHl70ZIlY1dFXsT6i79/Q2fkJtdnssMAc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BtJdcMs9n9cXY97nFbULiB7I2VIdUcGAS7mx/Ff7hADOoD7imqIbn2FMvjDM6282w
	 ajEoCtN57hWriTLZKoY6uIx0Xi6iNFrCcZ8j1CPKgA+7Ju8BHe85SRkXPlE7D1sElT
	 8OtAC25dYKw9LOlR57tYoOscmpos6/QrmNWC6UTQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D044F80279;
	Thu, 14 Jan 2021 14:33:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83E3EF80475; Thu, 14 Jan 2021 14:33:46 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97409F8026F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 14:33:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97409F8026F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C3A7EAD78;
 Thu, 14 Jan 2021 13:33:40 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: Simplify with dma_set_mask_and_coherent()
Date: Thu, 14 Jan 2021 14:33:34 +0100
Message-Id: <20210114133337.1039-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

Simple conversions from two dma_set_mask*() calls into the single
dma_set_mask_and_coherent().

Just a minor code refactoring, no functional changes.


Takashi

===

Takashi Iwai (3):
  ASoC: intel: skl: Simplify with dma_set_mask_and_coherent()
  ASoC: SOF: intel: Simplify with dma_set_mask_and_coherent()
  ASoC: tegra: Simplify with dma_set_mask_and_coherent()

 sound/soc/intel/skylake/skl.c | 8 ++------
 sound/soc/sof/intel/hda.c     | 8 ++------
 sound/soc/tegra/tegra_pcm.c   | 6 +-----
 3 files changed, 5 insertions(+), 17 deletions(-)

-- 
2.26.2

