Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:11:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E943F21D93
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E943F21D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74EBD167C;
	Mon,  4 Jan 2021 15:10:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74EBD167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609769487;
	bh=M4n8kd7XFsA8AwGbQf+NVjrVgVITtjPitOVyj9TTQAs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXz8O4cuCALs6GbVHNIVhaiAc0jhC6Dne9gSk0gWQm/cP1eiyj2Tdigxy1mfQsl9D
	 8hIA0r9jsY0do5wJbw1CTNdiPyjUwkSRI2TeJE1R+ZjrVx8hSN/nVmjyHdCe3Nr9fA
	 MELrbKeH8iRzCq2sz0tpqus7jeJRKnuTmacGPUHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF911F804D6;
	Mon,  4 Jan 2021 15:09:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 186F2F8026F; Mon,  4 Jan 2021 15:09:30 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D27BF8012C;
 Mon,  4 Jan 2021 15:09:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D27BF8012C
Received: from 36-229-96-78.dynamic-ip.hinet.net ([36.229.96.78]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kwQXq-0006q1-7Q; Mon, 04 Jan 2021 14:09:15 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com
Subject: [PATCH v2 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system
 suspend
Date: Mon,  4 Jan 2021 22:08:52 +0800
Message-Id: <20210104140853.228448-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104140853.228448-1-kai.heng.feng@canonical.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Marcin Rajwa <marcin.rajwa@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Keyon Jie <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

System takes a very long time to suspend after commit 215a22ed31a1
("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
[   90.065964] PM: suspend entry (s2idle)
[   90.067337] Filesystems sync: 0.001 seconds
[   90.185758] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   90.188713] OOM killer disabled.
[   90.188714] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   90.190024] printk: Suspending console(s) (use no_console_suspend to debug)
[   90.904912] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C], continue to suspend
[  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
[  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
[  329.490933] ACPI: EC: interrupt blocked

That commit keeps codec suspended during the system suspend. However,
SOF driver's runtime resume, which is for system suspend, calls
hda_codec_jack_check() and schedules jackpoll_work. The jackpoll
work uses snd_hda_power_up_pm() which tries to resume the codec in
system suspend path, hence blocking the suspend process.

So only check jack status if it's not in system PM process.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 No change.

 sound/soc/sof/intel/hda-dsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 7d00107cf3b2..1c5e05b88a90 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -685,7 +685,8 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 	/* check jack status */
 	if (runtime_resume) {
 		hda_codec_jack_wake_enable(sdev, false);
-		hda_codec_jack_check(sdev);
+		if (sdev->system_suspend_target == SOF_SUSPEND_NONE)
+			hda_codec_jack_check(sdev);
 	}
 
 	/* turn off the links that were off before suspend */
-- 
2.29.2

