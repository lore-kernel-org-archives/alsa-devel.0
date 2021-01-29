Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7DC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:39:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D6364E09
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6364E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C27AE16BE;
	Fri, 29 Jan 2021 16:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C27AE16BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611934772;
	bh=P7t/k8F7rdkI9HZ1XFQuHhPV5sAlqxo5OQMAnAbIFmE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gp3AJ+22DHiG20kAqHdKzXtWmUuGwPbvfs1jrjqPyjJfXoqPKfApt+cEcvFbV10MP
	 oiDOwHOMOcsoow1s3IxTWa8T9BFP4MCGYj2BUyKuJILB43XQqQHKWvvROVIdQpnfDK
	 KVyG873XrXk+Xvl33qMsvcYwF+VUckRg4sNTeVqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A81F804D8;
	Fri, 29 Jan 2021 16:37:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0F84F804DF; Fri, 29 Jan 2021 16:37:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E66BDF804C2
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:37:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E66BDF804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LcHi4tjF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852BD64E16;
 Fri, 29 Jan 2021 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934657;
 bh=P7t/k8F7rdkI9HZ1XFQuHhPV5sAlqxo5OQMAnAbIFmE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LcHi4tjFTIhrYB4WjzVDtqfGo62uLqiIh8I6xOiCvFFwfBHTOK0mFAAtny9oKFvwJ
 kXAt1A3oorO4R2d73TGeRc6yTfutan2SlEqc4Pa/XRWnDYM2uEY17E4pvW/n4XiJuE
 XyGJ51o9z2ipJuB0cQIJh/qus+7y4qFa/0cseLptLYh0KTcCoXyF7lVyMLSoM2uKqY
 dHm8pD5rufcZfOZ5sV1UEDuGcPsV6KN2w3JyrFzGNQuLdVqf57/1NA73t8zrHbNn4T
 6v3LFgu8vaZiKe3VpcFoBRTvw9iFp0SipLw3sS4gYiy77ydX5Z0OELor1ty6lmAkVR
 R07iALo83tcew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/41] ALSA: hda: Add Cometlake-R PCI ID
Date: Fri, 29 Jan 2021 10:36:50 -0500
Message-Id: <20210129153713.1592185-19-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
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

From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>

[ Upstream commit f84d3a1ec375e46a55cc3ba85c04272b24bd3921 ]

Add HD Audio Device PCI ID for the Intel Cometlake-R platform

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Link: https://lore.kernel.org/r/20210115031515.13100-1-kaichuan.hsieh@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 246d660164691..d393401db1ec5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2484,6 +2484,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* CometLake-S */
 	{ PCI_DEVICE(0x8086, 0xa3f0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* CometLake-R */
+	{ PCI_DEVICE(0x8086, 0xf0c8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.27.0

