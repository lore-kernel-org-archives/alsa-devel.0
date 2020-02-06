Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74417C35247
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:43:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E829821775
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OabwrmeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E829821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C4EB16A3;
	Thu,  6 Feb 2020 17:42:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C4EB16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581007409;
	bh=SsE25Jcp9nTGqbMpb8u/uTvarPYICBZvRc+cZOhgINw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OabwrmeAdBgF8GgcHa9rSvDiNb2XGq0r98p8HdeysQxiDmbaeVuU4YMMPt5b5NtkR
	 bqKTB7/7RgXgZ5/4C8AW1pRc7fsth6tDoN8refXNA+Yd6IbeJNiPvjLceMhgF1LC6Y
	 i38k3m0GeqyhAv923Dit0RWvc+TqwUYN3WZxJsAs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97EA4F8028C;
	Thu,  6 Feb 2020 17:40:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFEB2F80278; Thu,  6 Feb 2020 17:39:56 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0440F80162
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0440F80162
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3F22AB92
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 16:39:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:39:37 +0100
Message-Id: <20200206163945.6797-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH 0/8] ALSA: Another sparse warning fix round
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

this is another pile of patches to fix sparse warnings, at this time,
about the strong-types like snd_pcm_format_t.  The patch 2 introduces
a new macro for the iteration loop and some other tasks so that the
driver doesn't need to use ugly __force cast.


Takashi

===

Takashi Iwai (8):
  ALSA: aloop: Fix PCM format assignment
  ALSA: pcm: More helper macros for reducing snd_pcm_format_t cast
  ALSA: usb-audio: Use pcm_for_each_format() macro for PCM format
    iterations
  ALSA: dummy: Use standard macros for fixing PCM format cast
  ALSA: pcm: Use standard macros for fixing PCM format cast
  ALSA: pcm: Use a macro for parameter masks to reduce the needed cast
  ALSA: pcm_dmaengine: Use pcm_for_each_format() macro for PCM format
    iteration
  ALSA: pcm: Minor refactoring

 include/sound/pcm.h        |  9 +++++++++
 include/sound/pcm_params.h |  7 +++++++
 sound/core/oss/pcm_oss.c   | 19 ++++++++-----------
 sound/core/pcm_dmaengine.c |  2 +-
 sound/core/pcm_misc.c      | 17 +++++++++++------
 sound/core/pcm_native.c    | 47 +++++++++++++++++++++++++---------------------
 sound/drivers/aloop.c      |  6 +++---
 sound/drivers/dummy.c      |  6 +++---
 sound/usb/proc.c           |  2 +-
 9 files changed, 69 insertions(+), 46 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
