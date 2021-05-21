Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B26C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 08:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44AA61363
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 08:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44AA61363
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CDCA1696;
	Fri, 21 May 2021 10:23:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CDCA1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621585485;
	bh=8S9xjRjz+ru9nImjilEiI+jNyVirPdNjjubjBsIntAU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lzoaMF4Hah2L/2KCw8ac5xb2Cb2hBTKGt4vTJZBA7scCkjNkGzfuQzalqfkf/U1zN
	 t3lY7uJ5cUelnMrzf/5YCJgZtRwY/cLTVVaD5yi3utyD9FLZAO9GfvH66dlM8F+mJV
	 5aEkZXLXGK48adoBmZaZ0qeXgZswqn81AdQGFh2M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0F7FF801DB;
	Fri, 21 May 2021 10:23:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2368F800C1; Fri, 21 May 2021 10:23:53 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79AC8F800C1
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 10:23:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79AC8F800C1
Received: by m.b4.vu (Postfix, from userid 1000)
 id 88F2560ABED3; Fri, 21 May 2021 17:53:34 +0930 (ACST)
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ALSA: usb-audio: scarlett2: Fix device hang with ehci-pci
Date: Fri, 21 May 2021 17:50:11 +0930
Message-Id: <cover.1621584566.git.g@b4.vu>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "Geoffrey D. Bennett" <g@b4.vu>
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

This patchset fixes a show-stopper bug with the Scarlett Gen 2 mixer
driver not working with the ehci-pci host driver, and improves the
user experience with better driver startup messages.

Patch 1: Fixes the driver hanging the device by using the correct
direction pipe now.

Patch 2: Improves the user experience with more specific enabling
instructions, positive feedback when it is enabled or if
initialisation fails. The previous instructions were incomplete and
didn't confirm that the driver was enabled.

#Cc: stable@vger.kernel.org please (sorry, not sure if I should be
sending this there myself or if it gets added by Takashi after
review?)

Geoffrey D. Bennett (2):
  ALSA: usb-audio: scarlett2: Fix device hang with ehci-pci
  ALSA: usb-audio: scarlett2: Improve driver startup messages

 sound/usb/mixer_quirks.c        |  2 +-
 sound/usb/mixer_scarlett_gen2.c | 81 +++++++++++++++++++++------------
 sound/usb/mixer_scarlett_gen2.h |  2 +-
 3 files changed, 53 insertions(+), 32 deletions(-)

-- 
2.31.1

