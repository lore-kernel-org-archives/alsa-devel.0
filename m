Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706BC433E6
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 13:59:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26EB23340
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 13:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26EB23340
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11FD21678;
	Thu,  7 Jan 2021 14:58:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11FD21678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610027941;
	bh=WNVXTXt0qOFRZW33ysQ0saqQzzLg6axjVhIQzzLFimM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rts0Ict5Z3HK1z8a8woyk1GmQYCNOyPGg06IZhUrYj9PSa9vKPaeCBpldTznNvmCU
	 YXoTufjfK9hGkFtGbt2PC8J5mXngN2hw1MfeK2KesKe1rZDJoEOVG8km7PRrpxzuKa
	 9l26ik/kI8F9GPbzwKDYdvRwO9BP+O+xerYyRFpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97388F802C4;
	Thu,  7 Jan 2021 14:58:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61373F8049C; Thu,  7 Jan 2021 14:58:09 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49558F800E9
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 14:58:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49558F800E9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8D912B718;
 Thu,  7 Jan 2021 13:58:05 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 0/5] ALSA: usb-audio: Fix regression for Pioneer devices
Date: Thu,  7 Jan 2021 14:57:56 +0100
Message-Id: <20210107135801.23860-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <konference@frantovo.cz>,
 Geraldo <geraldogabriel@gmail.com>
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

here is the revised patch set for addressing the regression reported
for Pioneer devices with the implicit feedback mode.


Takashi

===

Takashi Iwai (5):
  ALSA: usb-audio: Fix the missing endpoints creations for quirks
  ALSA: usb-audio: Choose audioformat of a counter-part substream
  ALSA: usb-audio: Avoid unnecessary interface re-setup
  ALSA: usb-audio: Annotate the endpoint index in audioformat
  ALSA: usb-audio: Fix implicit feedback sync setup for Pioneer devices

 sound/usb/card.c         |  5 +--
 sound/usb/card.h         |  3 ++
 sound/usb/endpoint.c     | 84 ++++++++++++++++++++++++++++++++++------
 sound/usb/endpoint.h     |  2 +-
 sound/usb/implicit.c     | 55 +++++++++++++++++++-------
 sound/usb/quirks-table.h |  6 +++
 sound/usb/quirks.c       | 54 +++++++++++++++++++++-----
 sound/usb/usbaudio.h     |  1 +
 8 files changed, 169 insertions(+), 41 deletions(-)

-- 
2.26.2

