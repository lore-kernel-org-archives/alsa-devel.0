Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6DEC4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 06:07:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041B9229C7
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 06:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041B9229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF277171D;
	Mon, 14 Dec 2020 07:06:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF277171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607926060;
	bh=1KZ2t8Sc5i8qDgy2xhvwuoBxTa9noTTGipn3KiE6uMI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n6LAKAisus0mZYBwQw3FM9qlpyiMl1FUwylHcNVTDk8ksajjvGGVQY0t7aj/pne09
	 RGNyCti3mrwWoCvZtca+8UofliOHxwF90vHOngf7mXQolWjTBN91PrU7A4Gz/bnpV8
	 rNRwIHcEvdynE+GD24qs6uMs80TWGz2sQLQKTEpU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D82BF80171;
	Mon, 14 Dec 2020 07:06:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8450F801F7; Mon, 14 Dec 2020 07:06:48 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99948F800ED
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2020 07:06:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99948F800ED
Received: from 1-171-239-132.dynamic-ip.hinet.net ([1.171.239.132]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1koh07-0004hH-Ao; Mon, 14 Dec 2020 06:06:28 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda: Enable runtime PM when codec probe fails
Date: Mon, 14 Dec 2020 14:06:20 +0800
Message-Id: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mike Rapoport <rppt@kernel.org>
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

When codec probe fails, it doesn't enable runtime suspend, and can
prevent graphics card from getting powered down:
[    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized

$ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
active

So enable runtime PM when codec probe fails, to let graphics card be
able to runtime suspend again.

Merge azx_probe_continue() into azx_probe() and just let probe fail for
this case could be a better approach. However that's a much bigger task
so let's settle with a quirk workaround.

BugLink: https://bugs.launchpad.net/bugs/1907212
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6852668f1bcb..3fd920069268 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2328,7 +2328,7 @@ static int azx_probe_continue(struct azx *chip)
 	if (bus->codec_mask) {
 		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
 		if (err < 0)
-			goto out_free;
+			goto out_enable_rpm;
 	}
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
@@ -2360,6 +2360,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
+out_enable_rpm:
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
 		pm_runtime_allow(&pci->dev);
-- 
2.29.2

