Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F07C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:29:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B573060BBB
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B573060BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62231166A;
	Mon, 24 May 2021 13:28:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62231166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621855746;
	bh=nrEHvFIiNCHg4cvJK7rfPHW6l8ILWwZGzVJtaELSJps=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jIdtAjsgkkvHiH2WhVjHoDQbqkB1WVNrEScbf+nQGXgSmZvHnh6y2p6F4G4gbDMM7
	 ANn97RBbQ0A4ILxjbw6ums2hu+1oTV8ZxRReNv8GlZ9LsJKnZA3KXqMnSdcNLDnkpw
	 bgozAGSJfKvZs0z8dmtPT4QgSCu12uPH7Nz1BZiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBCC5F8021D;
	Mon, 24 May 2021 13:28:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56C0FF8022B; Mon, 24 May 2021 13:28:11 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A89CF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 13:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A89CF80137
IronPort-SDR: QrR7xe+laCTL2lVAyqu3SaShrgrgZo1uY2TQkY0UxwdvWlEMCzQCv48J+t7g7QcHA1UNS1Uza1
 arjcSPZwdj5g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201953059"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="201953059"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2021 04:27:48 -0700
IronPort-SDR: mt2kqvJI/s7BZy4c1xRNJDyGZVcQf/mCRmPymK4imtphvn/LY1HUY2iDTBCszFF0/bdEes1c9E
 8wFbk4YDSLUQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="475825638"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO
 peter-virtualbox.ger.corp.intel.com) ([10.249.39.203])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2021 04:27:47 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: tiwai@suse.de
Subject: [RFC] ALSA: hda: Add Lenovo ThinkStation P340 to power_save_denylist
Date: Mon, 24 May 2021 14:27:40 +0300
Message-Id: <20210524112740.19330-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On playback start there is a huge plock/pop noise via the green jack used
in Line out mode.

The only way I was able to fix it to set the power_save to 0 for the
snd_hda_intel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi Takashi,

ever since I have this workstation the plock/pop noise on playback start bugged
me. So far the only solution I have found is to disable the power_save which
I find acceptable on a desktop compared to the pops.

The alsa-info.sh output is can be found here:
http://alsa-project.org/db/?f=414b1b236fc73db386ad4f938bc3b304f6b30b05

The machine have ALC623 codec and the jacks are correctly discovered and they
do what they supposed to be.
When I have the headset connected to the front and audio is routed there the
line out (green jack) from the back still prodices the plock/pop.

Is there a known quirk for similar issue or a better way to handle it?

Thanks you,
Peter Ujfalusi

 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 79ade335c8a0..e16d93d8291f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2213,6 +2213,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* Loud pluck/pop noise via the green jack on playback start */
+	SND_PCI_QUIRK(0x8086, 0x06c8, "Lenovo ThinkStation P340", 0),
 	{}
 };
 #endif /* CONFIG_PM */
-- 
2.31.1

