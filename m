Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FADC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 12:56:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5169B23A05
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 12:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5169B23A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FAEE16B1;
	Thu, 14 Jan 2021 13:55:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FAEE16B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610628975;
	bh=JHETK9EmQaXmShoeuqjtpWZORz01QWPM8GstaGRR1cI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tTTFVURquHFhIGB6nwkY/pRAl/FWXsXuTWVQaqLrCyXb0nRQZ+HmcElCoTQ1/+AHF
	 Yb7KAfjNlvkFScvPSdpJmWKjWge1R2jg+vEYVKEkbr7bDaKk9BIEdz1S59iyr0Mvv/
	 aQjH9hqcsbYeRoXHXTYJkmPPneWz0ME8t3pOzbIw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B7A0F804B1;
	Thu, 14 Jan 2021 13:54:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A236BF8025E; Thu, 14 Jan 2021 13:54:29 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B61B2F80134
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 13:54:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B61B2F80134
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C4AB7B811
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 12:54:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: Simplify with dma_set_mask_and_coherent()
Date: Thu, 14 Jan 2021 13:54:10 +0100
Message-Id: <20210114125412.993-1-tiwai@suse.de>
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

Simple patches that convert the two calls of dma_set_mask*() into the
single dma_set_mask_and_coherent() helper. 

Just a minor cleanup, there should be no functional changes.


Takashi

===

Takashi Iwai (2):
  ALSA: pci: Simplify with dma_set_mask_and_coherent()
  ALSA: x86: Simplify with dma_set_mask_and_coherent()

 sound/pci/ad1889.c                  | 3 +--
 sound/pci/ali5451/ali5451.c         | 3 +--
 sound/pci/als300.c                  | 3 +--
 sound/pci/als4000.c                 | 3 +--
 sound/pci/au88x0/au88x0.c           | 3 +--
 sound/pci/aw2/aw2-alsa.c            | 3 +--
 sound/pci/azt3328.c                 | 3 +--
 sound/pci/ca0106/ca0106_main.c      | 3 +--
 sound/pci/cs5535audio/cs5535audio.c | 3 +--
 sound/pci/ctxfi/cthw20k1.c          | 8 ++------
 sound/pci/ctxfi/cthw20k2.c          | 8 ++------
 sound/pci/es1938.c                  | 3 +--
 sound/pci/es1968.c                  | 3 +--
 sound/pci/hda/hda_intel.c           | 8 ++------
 sound/pci/ice1712/ice1712.c         | 3 +--
 sound/pci/maestro3.c                | 3 +--
 sound/pci/sonicvibes.c              | 3 +--
 sound/pci/trident/trident_main.c    | 3 +--
 sound/x86/intel_hdmi_audio.c        | 3 +--
 19 files changed, 22 insertions(+), 50 deletions(-)

-- 
2.26.2

