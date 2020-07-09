Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103CC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:19:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA52076A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eUKFm7yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA52076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 342261655;
	Thu,  9 Jul 2020 13:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 342261655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594293572;
	bh=b8kLpssmaRkQbKTuyK6WmzXuuja5jonoXMzeu3uYCxs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eUKFm7yhZx7/2+2rpitazdhT7Je/PIdlhIRRxoRQJrwjX4OdUSnQE9lrKy0/9TNhb
	 NTIvIkUr01EfKRwSAuuqHwMabx8FFQsoGBSpmW+d3mYMsG/SKboUuOOfm8MXprH8TF
	 rH5Tew+WVL4/OthIm0KMQWGLPoONoEK77f4lux6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9E6FF8025A;
	Thu,  9 Jul 2020 13:17:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7513AF80255; Thu,  9 Jul 2020 13:17:56 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB29BF80255
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 13:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB29BF80255
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F22C1AE7B;
 Thu,  9 Jul 2020 11:17:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: Convert remaining fall through comments
Date: Thu,  9 Jul 2020 13:17:47 +0200
Message-Id: <20200709111750.8337-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
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

here is a simple patch set to replace or remove the remaining "fall
through" comments in sound tree (modulo sound/soc/*).
I suppose ASoC parts are coverted by another patch.


Takashi

===

Takashi Iwai (3):
  ALSA: atmel: Remove invalid "fall through" comments
  ALSA: xen: Remove superfluous fall through comments
  ALSA: Replace with fallthrough pseudo keyword in the remaining places

 sound/atmel/ac97c.c               |  4 ++--
 sound/isa/es18xx.c                |  2 +-
 sound/pci/au88x0/au88x0_core.c    | 12 ++++++------
 sound/pci/oxygen/oxygen_pcm.c     |  2 +-
 sound/usb/caiaq/audio.c           |  2 +-
 sound/usb/caiaq/device.c          |  2 +-
 sound/usb/midi.c                  |  2 +-
 sound/xen/xen_snd_front.c         |  4 ----
 sound/xen/xen_snd_front_evtchnl.c |  4 ----
 9 files changed, 13 insertions(+), 21 deletions(-)

-- 
2.16.4

