Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7481C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:33:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA60864E37
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA60864E37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44A8B15E2;
	Sat,  6 Feb 2021 21:32:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44A8B15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612643596;
	bh=OgLHQDxEjuZ0S/Tq2esdJQRcD/VrQ683nxs77luqyhs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D91psYjRJLIyBbckX1tfHoyPbISmbiIyEocsF64+zPor3UiJMhafe2FaLTlrSyYOp
	 po8v1xnZT/niv6rN9R3waqN9DpfE5mC+KP0TP5icQZJwe/SdfuROYmXMV+S5mOiIfU
	 5vEP5RT8qdE1BX6pZ9WCyEORNiiB6Fbzy1aVjOfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13740F8025D;
	Sat,  6 Feb 2021 21:31:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C10BF80171; Sat,  6 Feb 2021 21:31:17 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EEE8F80139
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 21:30:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EEE8F80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BDBDFABD5
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 20:30:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: a few more USB-audio fixes
Date: Sat,  6 Feb 2021 21:30:49 +0100
Message-Id: <20210206203052.15606-1-tiwai@suse.de>
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

Hi,

here is a small patch set for USB-audio.  The goal of this patch set
is to cover a small race window at the endpoint state transition, and
the preparation for the upcoming patch set for PCM sync_stop fixes.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Handle invalid running state at releasing EP
  ALSA: usb-audio: More strict state change in EP
  ALSA: usb-audio: Don't avoid stopping the stream at disconnection

 sound/usb/card.h     |  2 +-
 sound/usb/endpoint.c | 85 +++++++++++++++++++++++++-------------------
 sound/usb/pcm.c      |  5 +--
 3 files changed, 51 insertions(+), 41 deletions(-)

-- 
2.26.2

