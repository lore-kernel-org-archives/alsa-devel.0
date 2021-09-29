Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79E9C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:30:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458C0610A4
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 458C0610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B037167E;
	Wed, 29 Sep 2021 09:30:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B037167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632900656;
	bh=2BGVorrQlZkLWCct2EbrrL/QjRBBQHVvhMt9/mv+/Ms=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uEVyryjgbhbybhcqPcmd5LIIPhiDiIg7C0z07sngT21bW5iUzgfapRITm96FzFpDQ
	 Ue7Ljjl8BBVdMTR2P8RmAL4THn/z+Ar3WZPhXp4/K5ElAoZpOSIuVZC8TvmaS/yjAm
	 brGOn9pXbgau49b6fi5frecgTskPZ2J8TWSwZ0vc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B724F801F7;
	Wed, 29 Sep 2021 09:30:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73809F8026D; Wed, 29 Sep 2021 09:29:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BAF4F801F7
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 09:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BAF4F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="yeQKZwv3"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="+77NJe9T"
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9283B224DF;
 Wed, 29 Sep 2021 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632900577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JOCghnuQtCgVBToD0XByOAuc/2TRA1O48BNQZibE7tY=;
 b=yeQKZwv3KrSqYcj8Ka2ylCm2OEcp4t/2VuRkvFosw2yUozIYR6iUUntffQp4DXhu5uaAqo
 O9t2xyvG6eW3mng2t8mzjdHnZP2jW1/Az4Zc/xZjBOLYfLDCDIuQDMYJdFNAksZUJNxFSs
 1IeFrH49BGOEpA+ZJ5iWt3+gS4Xjpzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632900577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JOCghnuQtCgVBToD0XByOAuc/2TRA1O48BNQZibE7tY=;
 b=+77NJe9THEkB5z25/w0s4F2YGozUOXCzVSEJ6snSaeHNm8wiFjzsY8IJ7CkGqQZIm1fqo1
 UJrHza7bzIB6i7CQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay1.suse.de (Postfix) with ESMTP id 728E425D50;
 Wed, 29 Sep 2021 07:29:37 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] ALSA: hda: Reduce CPU hog with SKL+ position reporting
Date: Wed, 29 Sep 2021 09:29:32 +0200
Message-Id: <20210929072934.6809-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

this is a v2 patch set for reducing the CPU hog with the HD-audio PCM
position reporting.  The first patch is almost same, while the second
patch is added to take back to the position buffer as suggested by
Pierre.


Takashi

v1: https://lore.kernel.org/r/20210910141002.32749-1-tiwai@suse.de

===

Takashi Iwai (2):
  ALSA: hda: Reduce udelay() at SKL+ position reporting
  ALSA: hda: Use position buffer for SKL+ again

 sound/pci/hda/hda_intel.c | 49 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

-- 
2.26.2

