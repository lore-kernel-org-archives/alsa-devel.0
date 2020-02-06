Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553DC33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:30:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4EE214AF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="psXikO0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4EE214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5245A16AD;
	Thu,  6 Feb 2020 17:29:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5245A16AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581006648;
	bh=vlRqPBiDS5lKSDejDC+RA0fD8JA1SeyTgDw/RKRxF5g=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=psXikO0AkCDuqEdoMVJ//ydmh6L+KLXavpkp6ucAq+KBI+IgNmpgtiITVCdcfTAOF
	 tN8L8RC0xeGmgr4E9ymXyyauivoGv9EIewDRXvFeEO4gfxZl7MBsKJIHCmZ7n9UAl0
	 dPO/ZwIO2prj6yKF4TtgPnV9c28oK9eCH2OGCpsA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFB5AF80274;
	Thu,  6 Feb 2020 17:28:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA6A6F80212; Thu,  6 Feb 2020 17:28:15 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7813F8015B
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:28:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7813F8015B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CE76CAE9A;
 Thu,  6 Feb 2020 16:28:07 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:28:00 +0100
Message-Id: <20200206162804.4734-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Nikhil Mahale <nmahale@nvidia.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/4] ALSA: hda/hdmi: Clean up jack handling
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

this is a series of cleanup of the jack handling in HD-audio HDMI
codec driver, which I realized after the recent regression fix.
Basically this changes the jack handling from hda_jack to the own jack
objects as Intel HDMI did but applying now to all (generic) codecs.
It resulted in a good amount of code reduction in the end.

As this is no real fixes, and I'd like to rather share the code
between 5.5 and 5.6, it's targeted for 5.7.

Only lightly tested on Intel and nouveau.


Takashi

===

Takashi Iwai (4):
  ALSA: hda/hdmi: Reduce hda_jack_tbl lookup at unsol event handling
  ALSA: hda/hdmi: Don't use standard hda_jack for generic HDMI jacks
  ALSA: hda/hdmi: Move runtime PM resume into
    hdmi_present_sense_via_verbs()
  ALSA: hda/hdmi: Move ELD parse and jack reporting into update_eld()

 sound/pci/hda/patch_hdmi.c | 313 +++++++++++++--------------------------------
 1 file changed, 90 insertions(+), 223 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
