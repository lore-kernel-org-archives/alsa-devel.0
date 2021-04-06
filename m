Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F299C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:25:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF21613B3
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF21613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8446684D;
	Tue,  6 Apr 2021 16:24:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8446684D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617719144;
	bh=CGpQIePXzYIoTcCdMP82u1kfVOMX5FW6heOv/Q1pgnI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mtcgLgDQ4H2P7YicaoQIpe+G7wvmGGe6fS0UC/dvKSPKVqfMqzlh9bNTh93BjQx3e
	 /REasyVkP7r+F2eaMZ52ciRWZgapmM11mTc6jk3zBKW0MHYoS2tOaqulLFLdKTgg7H
	 seKAD3XazwPJz+4lQWhAnsOjBJgtMQdTb0iTK4dA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D025BF80246;
	Tue,  6 Apr 2021 16:24:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 563D6F80259; Tue,  6 Apr 2021 16:24:52 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B7A8F800E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 16:24:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B7A8F800E1
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id BCFD83FA38;
 Tue,  6 Apr 2021 16:24:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id 50r0R8RM4mMZ; Tue,  6 Apr 2021 16:24:43 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 0D04B3FA29;
 Tue,  6 Apr 2021 16:24:42 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] Adds SPI support
Date: Tue,  6 Apr 2021 16:24:35 +0200
Message-Id: <20210406142439.102396-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, Liam Girdwood <lgirdwood@gmail.com>
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

Moved I2C stuff to separated file, shered thingk to header file.
Added SPI in separeted file.

Jiri Prchal (4):
  ASoC: codecs: tlv320aic3x: move model definitions
  ASoC: codecs: tlv320aic3x: rename probe function
  ASoC: codecs: tlv320aic3x: move I2C to separated file
  ASoC: codecs: tlv320aic3x: add SPI support

 sound/soc/codecs/Kconfig           |  16 ++++-
 sound/soc/codecs/Makefile          |   4 ++
 sound/soc/codecs/tlv320aic3x-i2c.c |  70 +++++++++++++++++++
 sound/soc/codecs/tlv320aic3x-spi.c |  76 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.c     | 108 ++++++++---------------------
 sound/soc/codecs/tlv320aic3x.h     |  12 ++++
 6 files changed, 204 insertions(+), 82 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic3x-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic3x-spi.c

-- 
2.25.1

