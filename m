Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A358C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:08:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4849C206CC
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HmWw5euE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4849C206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05ECD178D;
	Thu, 21 Nov 2019 20:07:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05ECD178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574363288;
	bh=ReO/dKaGb2qS3tB0Ozc3dbZY308UdmtOEo7OwZbZA+k=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HmWw5euEOEZAe4B2moZQ3IGoJ2ZnTGXtUQJomRTjiuA5e1aHGbabWRUXdOUaDrO0S
	 C5NsnuiBM3NkcujYqbYZy6SaStu2Ahyf1H/Nsm3l+V6lYxVVK+6UgoU5V/gUzDpdoO
	 oTo9AiaEw0vWiAUklJ6MGpJyuDbkBWRvdeLM9S1k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81F6EF80145;
	Thu, 21 Nov 2019 20:07:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B6D1F8014C; Thu, 21 Nov 2019 20:07:15 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B92AF800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 20:07:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B92AF800C1
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4A59DAD98;
 Thu, 21 Nov 2019 19:07:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 21 Nov 2019 20:07:07 +0100
Message-Id: <20191121190709.29121-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 0/2] ASoC: Follow the recent ALSA core API
	changes
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

this is a follow-up patch set for ASoC to adapt the recent ALSA PCM
core changes.  It's merely a preliminary and this itself doesn't
change the current driver behavior.  The purpose of this submission is
to get the basic API changes done in 5.5-rc1, so that other trees can
apply the actual changes later individually.  The actual cleanups and
changes in the driver side will be submitted after 5.5 merge window.

Mark, if you are OK with this, please give ACK.  Then I'll merge them
into my tree for 5.5-rc1.


thanks,

Takashi

===

Takashi Iwai (2):
  ASoC: pcm: Make ioctl ops optional
  ASoC: component: Add sync_stop PCM ops

 include/sound/soc-component.h |  3 +++
 sound/soc/soc-component.c     | 19 +++++++++++++++++++
 sound/soc/soc-pcm.c           |  6 ++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
