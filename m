Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B0C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 11:30:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33064FD7
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33064FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BBEA1774;
	Wed, 10 Mar 2021 12:29:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BBEA1774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615375813;
	bh=k/kOLf7vyDkIdrVDw42NKXl95W9UpVNTu/6TaH5xdm4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KVL6Qad8bCJNpFL8HSt4a12Z8/BQZ6sBphKc/I8j3tuc2aLtLBJ/SBunTFw71mqDo
	 TaezGMf3zpmROOjrH2JKd7ve8upUexRCN280hw9DBPc9XwOnpyseLWaypG3UY8FI0A
	 gzMuaZ22z7IwHirmBoxGNk8lS1qbvwPPREbeaVaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AD69F801ED;
	Wed, 10 Mar 2021 12:28:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 806D8F8020D; Wed, 10 Mar 2021 12:28:26 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB847F801ED
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 12:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB847F801ED
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 679ECAE89;
 Wed, 10 Mar 2021 11:28:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: hda: Fix potential bad accesses at suspend/resume
Date: Wed, 10 Mar 2021 12:28:06 +0100
Message-Id: <20210310112809.9215-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Abhishek Sahu <abhsahu@nvidia.com>
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

this is a small patch series to address the bugs that triggers the
unexpected accesses during the system suspend/resume.  It happens
often with Nvidia driver and HDMI codec driver, and it may lead to the
serious CORB/RIRB errors.

Although the issues are seen mostly on DP/HDMI, a part of the problems
is rather generic to all platforms.


Takashi

===

Takashi Iwai (3):
  ALSA: hda: Flush pending unsolicited events before suspend
  ALSA: hda: Avoid spurious unsol event handling during S3/S4
  ALSA: hda/hdmi: Cancel pending works before suspend

 sound/pci/hda/hda_bind.c   |  4 ++++
 sound/pci/hda/hda_intel.c  |  2 ++
 sound/pci/hda/patch_hdmi.c | 13 +++++++++++++
 3 files changed, 19 insertions(+)

-- 
2.26.2

