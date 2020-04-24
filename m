Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E79C54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8D220776
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NR3afhM2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkYoexPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8D220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 236B5844;
	Fri, 24 Apr 2020 14:25:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 236B5844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587731187;
	bh=nprC1j+z7yCrfd7kywGe0BwtCDzgQONM+DigRXbQ1G0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NR3afhM2YDRgFWtrLcHOsa/f9Jfriw4Fwa6ZsqF0UN+VXYCaat8n8qlLyWO2YR8+M
	 2hHuJe+fBaPVN/Sh7P4nPOSrPgahafYb321kXO/NKvXFDQt6Du/9vdmJHRXV0BOXVI
	 5xzwSS0Py4y0cW+iCIgtPtTznPcdSZqe1bGtQKqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E505F80299;
	Fri, 24 Apr 2020 14:23:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0041F80290; Fri, 24 Apr 2020 14:23:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BDC6F8028F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 14:23:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BDC6F8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YkYoexPT"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5DBB021582;
 Fri, 24 Apr 2020 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587730983;
 bh=nprC1j+z7yCrfd7kywGe0BwtCDzgQONM+DigRXbQ1G0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YkYoexPTPt/n9Xim1ROwHPUEbIV8ME3uI8vPX0sXdqB40M9dkL0Jzqah5wLWl/Vs6
 odTUMGn2S74AXG08FqM9913i+abfC2mluvvQ2NA80NDvx0Utr31s6R4Qs/lQQJHIM9
 t9XPTBZkmUow+T5jUE5TKSDPNPkaV+a3qlkLHShs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 22/38] ALSA: hda: call runtime_allow() for all hda
 controllers
Date: Fri, 24 Apr 2020 08:22:20 -0400
Message-Id: <20200424122237.9831-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 9a6418487b566503c772cb6e7d3d44e652b019b0 ]

Before the pci_driver->probe() is called, the pci subsystem calls
runtime_forbid() and runtime_get_sync() on this pci dev, so only call
runtime_put_autosuspend() is not enough to enable the runtime_pm on
this device.

For controllers with vgaswitcheroo feature, the pci/quirks.c will call
runtime_allow() for this dev, then the controllers could enter
rt_idle/suspend/resume, but for non-vgaswitcheroo controllers like
Intel hda controllers, the runtime_pm is not enabled because the
runtime_allow() is not called.

Since it is no harm calling runtime_allow() twice, here let hda
driver call runtime_allow() for all controllers. Then the runtime_pm
is enabled on all controllers after the put_autosuspend() is called.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200414142725.6020-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8519051a426e7..a5fab12defde2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2356,6 +2356,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
+		pm_runtime_allow(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
 	}
 
-- 
2.20.1

