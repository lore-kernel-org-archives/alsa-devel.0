Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A27BC43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:36:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059D92078A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c0MlKD9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059D92078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 518E91676;
	Wed, 25 Mar 2020 11:35:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 518E91676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585132588;
	bh=a0oi+Qm1icIwse0E4b+2xl1lBvomRimsd1Bk2XuJfNc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c0MlKD9A/ilVX6TN3NRk0kHki8VpNn3TeV6o95lCf59Ro3UaCXSMjqmx/7TsX8e4L
	 qxDfaTpx3tHQk1zsjxc4Cycg6cQqJq1vUy19qvDb6HYwgGCpKDcA7tKW1WBgbrdYHb
	 E4G5PCs1cdfXKoa/r0y6wvWpp2YvUZCenU58p6Kw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D12CF80273;
	Wed, 25 Mar 2020 11:34:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89266F80147; Wed, 25 Mar 2020 11:33:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5443CF8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 11:33:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5443CF8015A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 655D9ACB8
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 10:33:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: usb-audio: Option for delayed registration
Date: Wed, 25 Mar 2020 11:33:18 +0100
Message-Id: <20200325103322.2508-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

USB-audio driver probes per USB insterface, and this used to be the
cause of the missing device enumeration on user-space because the
driver registers the device per interface probe.  The recently added
quirk allows the delayed registration to sync with the last known
stream, but we must have far more such devices.

This patch set adds a new option to let user specify the delayed
registration device setup and also inform such devices at probe time.


Takashi

===

Takashi Iwai (4):
  ALSA: usb-audio: Rewrite registration quirk handling
  ALSA: usb-audio: Add delayed_register option
  ALSA: usb-audio: Inform devices that need delayed registration
  ALSA: usb-audio: Update the documentation for the new delayed_register
    option

 Documentation/sound/alsa-configuration.rst | 13 ++++++++++
 sound/usb/card.c                           | 28 ++++++++++++++++++++-
 sound/usb/quirks.c                         | 40 ++++++++++++++++++++++--------
 sound/usb/quirks.h                         |  3 +--
 sound/usb/stream.c                         |  3 +++
 sound/usb/usbaudio.h                       |  1 +
 6 files changed, 75 insertions(+), 13 deletions(-)

-- 
2.16.4

