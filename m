Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5EEC433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:43:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB5361463
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB5361463
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD257171E;
	Wed,  5 May 2021 18:43:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD257171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233031;
	bh=RTOEkZRNQ4VOpCbfLqSuqXmv2lqlX9b9uqe/SCvsp8U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMXVRcwhO9UAzF7GLOWucIh5qjNuo87p9qXYigVTf7iNI3zESWKUQaWVZRt1i5vvM
	 OMSqk0ae7BN1S6KKD1itBFahhzhEkHSkUyp4iv6KBFTyxwoBpYIy/MIUpDzMVVMnGr
	 MZti5SIdKTHP7r++iSwBGGZZQXbHP9k/WHCVaqIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 964B4F80553;
	Wed,  5 May 2021 18:36:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FE19F80558; Wed,  5 May 2021 18:36:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4D29F804E3
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:36:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4D29F804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Wz8i4Nuv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB9C361933;
 Wed,  5 May 2021 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232560;
 bh=RTOEkZRNQ4VOpCbfLqSuqXmv2lqlX9b9uqe/SCvsp8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wz8i4NuvO5xPshAVWuE9IFRYqrhsRR5xZ/ug1i2itjj83faIK32nimPx0Wkdp8UpT
 E4MwZLMfKmwAJyf/h5Mo2nDHhWuuie4JMnmoaPhZDtRfGmBVguK5/urGXjR9Qpp+01
 GSn7FkgAN9piLapNEzwx/ZqXfXSyHM6nHw9EKkE6aiPwPyBGaVHooiFMcqHEVyLgr/
 YubZbBDRxGiPmFqE26lCl3gnPbHNO0+UkmewiSjlPLpafbb2nTYbSR5oZ/R3lqvaF6
 SUGuiCMmw8pmQrxj93IMt3WQg3cegSoXx8hJPWbEawt+QeibzUA63nVLT192jTdAwj
 R4LCAtWa5Pocg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 073/104] ALSA: hda/hdmi: fix race in handling
 acomp ELD notification at resume
Date: Wed,  5 May 2021 12:33:42 -0400
Message-Id: <20210505163413.3461611-73-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163413.3461611-1-sashal@kernel.org>
References: <20210505163413.3461611-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 0c37e2eb6b83e375e8a654d01598292d5591fc65 ]

When snd-hda-codec-hdmi is used with ASoC HDA controller like SOF (acomp
used for ELD notifications), display connection change done during suspend,
can be lost due to following sequence of events:

  1. system in S3 suspend
  2. DP/HDMI receiver connected
  3. system resumed
  4. HDA controller resumed, but card->deferred_resume_work not complete
  5. acomp eld_notify callback
  6. eld_notify ignored as power state is not CTL_POWER_D0
  7. HDA resume deferred work completed, power state set to CTL_POWER_D0

This results in losing the notification, and the jack state reported to
user-space is not correct.

The check on step 6 was added in commit 8ae743e82f0b ("ALSA: hda - Skip
ELD notification during system suspend"). It would seem with the deferred
resume logic in ASoC core, this check is not safe.

Fix the issue by modifying the check to use "dev.power.power_state.event"
instead of ALSA specific card power state variable.

BugLink: https://github.com/thesofproject/linux/issues/2825
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20210416131157.1881366-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d6387106619f..7b0d9d7a1c38 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2650,7 +2650,7 @@ static void generic_acomp_pin_eld_notify(void *audio_ptr, int port, int dev_id)
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */
-	if (snd_power_get_state(codec->card) != SNDRV_CTL_POWER_D0)
+	if (codec->core.dev.power.power_state.event == PM_EVENT_SUSPEND)
 		return;
 	/* ditto during suspend/resume process itself */
 	if (snd_hdac_is_in_pm(&codec->core))
@@ -2836,7 +2836,7 @@ static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */
-	if (snd_power_get_state(codec->card) != SNDRV_CTL_POWER_D0)
+	if (codec->core.dev.power.power_state.event == PM_EVENT_SUSPEND)
 		return;
 	/* ditto during suspend/resume process itself */
 	if (snd_hdac_is_in_pm(&codec->core))
-- 
2.30.2

