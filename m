Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F78C433E9
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 18:14:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C8F2311D
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 18:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C8F2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2856916E9;
	Tue, 12 Jan 2021 19:13:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2856916E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610475243;
	bh=O6eaessh+0r8xGCK2KvUruX7URvglCZCzJn5S29Qdso=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rTsxXMIXuvBOKlipCrJyS9C+IFfwbo1C41pLxAU8panm9mMlCiN1uv7j8Ylg745a5
	 jkvgZWvhkRWzCrWIep8eJgwvj8tmLzYsyZMWqVtZ2qxH/2F0ExDtp63dYIAYAd0HBW
	 S78GPvxVVnuNDD5+4wVNNY02Y4CerKE33m6sltKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1299CF804E3;
	Tue, 12 Jan 2021 19:12:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 699B1F804E1; Tue, 12 Jan 2021 19:12:39 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1692AF804D6;
 Tue, 12 Jan 2021 19:12:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1692AF804D6
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kzO90-0005fK-6P; Tue, 12 Jan 2021 18:11:51 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com
Subject: [PATCH v4 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system
 suspend
Date: Wed, 13 Jan 2021 02:11:25 +0800
Message-Id: <20210112181128.1229827-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marcin Rajwa <marcin.rajwa@linux.intel.com>, broonie@kernel.org,
 Keyon Jie <yang.jie@linux.intel.com>, open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
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

That commit keeps the codec suspended during the system suspend. However,
mute/micmute LED will clear codec's direct-complete flag by
dpm_clear_superiors_direct_complete().

This doesn't play well with SOF driver. When its runtime resume is
called for system suspend, hda_codec_jack_check() schedules
jackpoll_work which uses snd_hdac_is_power_on() to check whether codec
is suspended. Because the direct-complete path isn't taken,
pm_runtime_disable() isn't called so snd_hdac_is_power_on() returns
false and jackpoll continues to run, and snd_hda_power_up_pm() cannot
power up an already suspended codec in multiple attempts, causes the
long delay on system suspend:

if (dev->power.direct_complete) {
	if (pm_runtime_status_suspended(dev)) {
		pm_runtime_disable(dev);
		if (pm_runtime_status_suspended(dev)) {
			pm_dev_dbg(dev, state, "direct-complete ");
			goto Complete;
		}

		pm_runtime_enable(dev);
	}
	dev->power.direct_complete = false;
}

When direct-complete path is taken, snd_hdac_is_power_on() returns true
and hda_jackpoll_work() is skipped by accident. So this is still not
correct.

If we were to use snd_hdac_is_power_on() in system PM path,
pm_runtime_status_suspended() should be used instead of
pm_runtime_suspended(), otherwise pm_runtime_{enable,disable}() may
change the outcome of snd_hdac_is_power_on().

Because devices suspend in reverse order (i.e. child first), it doesn't
make much sense to resume an already suspended codec from audio
controller. So avoid the issue by making sure jackpoll isn't used in
system PM process.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 Clarify why direct-complete path isn't take.
v3:
 Clarify the root cause and why it's needed.
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

