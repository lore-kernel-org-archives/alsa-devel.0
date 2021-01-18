Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF7C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 07:59:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7444B224B8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 07:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7444B224B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8233717A8;
	Mon, 18 Jan 2021 08:58:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8233717A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610956760;
	bh=+wJlwOAAlNTxZ0D9Z3UZmvB0g1wIluPO3GBD9kA8Kos=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UPoykWKwGb/Nb4BUDl/biU8wirqXTexDYs094/bBCzVBCwXKHWpJiT0/X5pIggtJ9
	 iIcFOIjJKR9+s1Zv0cwLNnfcEL2LrnOjlu9l3K9ZQNNivs5SvK2v2ldo+OstQEet8i
	 W67oasUbfL0iQHqUWY6biZe7zuXnw5MZIgFo1JBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE37AF80137;
	Mon, 18 Jan 2021 08:58:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4252AF80227; Mon, 18 Jan 2021 08:58:28 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D629F8016E
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 08:58:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D629F8016E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 740C3AB7A;
 Mon, 18 Jan 2021 07:58:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: usb-audio: Yet more fixes for Pioneer devices
Date: Mon, 18 Jan 2021 08:58:13 +0100
Message-Id: <20210118075816.25068-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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

the Pioneer UAC1 devices still didn't work with the recent changes,
and after debugging sessions, a few issues were discovered.  Below are
the patches to cover those errors.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Fix UAC1 rate setup for secondary endpoints
  ALSA: usb-audio: Set sample rate for all sharing EPs on UAC1
  ALSA: usb-audio: Avoid implicit feedback on Pioneer devices

 sound/usb/clock.c    | 21 ++++++---------------
 sound/usb/endpoint.c |  9 +++++++++
 sound/usb/implicit.c | 17 +++++++++--------
 sound/usb/quirks.c   | 28 ----------------------------
 4 files changed, 24 insertions(+), 51 deletions(-)

-- 
2.26.2

