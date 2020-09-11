Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF6C2BC11
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BCB221EB
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j87H1ofn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BCB221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3240165D;
	Fri, 11 Sep 2020 19:31:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3240165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599845566;
	bh=bO0PFQSYgsmsj9KXWwBYksrFr6D6vxjIDhBZ2Aihc90=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j87H1ofnTp31EmUgxWSag6p9o7fLFqVOJOUOeYy5JHqemxEXeq3Dfh1yTllLolq/H
	 6h7cfgjpWGMMX00X5ge8muKazapX4uW7CKd0nTKe3/EQsNqXDQIwSbXqxYzaTG26w4
	 gXleRCzcy5Mvywapji9coqO/cuwoRIBI4fAkdld4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 785DAF80240;
	Fri, 11 Sep 2020 19:31:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32D4BF80274; Fri, 11 Sep 2020 19:31:53 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B168F800E9
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 19:31:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B168F800E9
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 581EA1BF206;
 Fri, 11 Sep 2020 17:31:41 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] tlv320aic3xx4 updates
Date: Fri, 11 Sep 2020 19:31:37 +0200
Message-Id: <20200911173140.29984-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

Hello,

While doing a kernel update on a sama5-based board I figured out the
sound system was not working anymore, the debug session led me to the
following commits. As I am not an audio expert at all, I am fully open
to comments and suggestions.

Thanks,
Miquèl

Miquel Raynal (3):
  ASoC: tlv320aic32x4: Ensure a minimum delay before clock stabilization
  ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
  ASoC: tlv320aic32x4: Enable fast charge

 sound/soc/codecs/tlv320aic32x4-clk.c |  9 ++++++++-
 sound/soc/codecs/tlv320aic32x4.c     | 17 ++++++++++++++---
 sound/soc/codecs/tlv320aic32x4.h     |  7 +++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.20.1

