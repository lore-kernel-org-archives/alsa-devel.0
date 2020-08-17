Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39FC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:24:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600442078D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jc8F40K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600442078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF1351694;
	Mon, 17 Aug 2020 10:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF1351694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597652660;
	bh=CzCw1SU94tqoJCEIVFDaxn8Dj3cm/jKVaH0xu+zqKUc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jc8F40K/TQDPgk+EvksNGvpRLl0qBYV29SNQjtc60c3cdx6TDOcMrt1RjDte6yT9l
	 qQkYT39weVgr3pNgpjHTENWxS+AmHCiivg1NAOYjWcdTmsV8w6MvdRu1yv2YAramlB
	 3vH40t/N1IMV4YIlumHeik+QF1Bp/08EZaSOBp3Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E30CF800F0;
	Mon, 17 Aug 2020 10:21:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3825F80264; Mon, 17 Aug 2020 10:21:51 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA012F80218
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 10:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA012F80218
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 09CBBABF4
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 08:22:08 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: usb-audio: Reduce device table
Date: Mon, 17 Aug 2020 10:21:37 +0200
Message-Id: <20200817082140.20232-1-tiwai@suse.de>
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

this is a patch set for USB-audio driver to reduce the unnecessary
entries from the exported device table.  Also it contains the
corrections of the device matching for a few entries to be more
strict.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Move device rename and profile quirks to an internal
    table
  ALSA: usb-audio: Simplify quirk entries with a macro
  ALSA: usb-audio: Properly match with audio interface class

 sound/usb/card.c         | 133 +++++++++++++++++++++--
 sound/usb/quirks-table.h | 276 +++++++----------------------------------------
 sound/usb/usbaudio.h     |   1 -
 3 files changed, 162 insertions(+), 248 deletions(-)

-- 
2.16.4

