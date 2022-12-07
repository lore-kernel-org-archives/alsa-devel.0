Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED30C47089
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 10:23:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81DD4181C;
	Wed,  7 Dec 2022 11:22:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81DD4181C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670408627;
	bh=9KOWBdrGHjVfr6QRJyHeuqVVOZUmvxofXrhVvKQTNIE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OeI8soxBFKOXuAHbOl0OPBMYbbQuSTlSIchTymN6LRYOC9eCXoLvk3xU6KDpE9k/+
	 P8HT2OP+XcsbaGZVAS49Mis8pxCtEgnbELCDErPj53gu4X9hC7Y3P/ZuMBALVSqTuD
	 iJs8kgK2NwXfHFs3RguMS9WaAQKrHN8xDQyXuqRM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33E0BF8021D;
	Wed,  7 Dec 2022 11:22:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE098F802BE; Wed,  7 Dec 2022 11:22:55 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D413F80169
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 11:22:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D413F80169
X-QQ-mid: bizesmtp85t1670408559tp98jp1j
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 07 Dec 2022 18:22:32 +0800 (CST)
X-QQ-SSF: 01400000000000C0M000000A0000000
X-QQ-FEAT: 3M0okmaRx3hQ3ejzzir6kxAEdcpGlwVKZV2ObtT+XuxHIegLx4pKfS/rgI+AD
 LmHVc9VOhAi9DI76w+Pqjz8EpAo0vSYrVcaixSn7er9JkG4dzLW/Ap2Gk06OTMILIY9Xnes
 /EONVPHo0LuLNNwnmxyr1Fy1UJjCwqdhfpkIafCdq2KE+ZsanKLQw3myFDcyFWvCs6yQ0sS
 hFyt2rLBvFvNeAsnzfH2e/oAY92UFxXWR2jg/DV284U7FYyhJQQyNDO9qN+nPV9crYkp7Ck
 JPmPAKeNd5yuHJCp3sOJyWoLfyHB9Z+K5epkJp2mcrwqQg1PMDRx+VVA4oys2F7fweqzynt
 deD0Jf5whHKUDvolwyLW5UOcHQE7gapk5rsK9emMLkzZjL+TZRFjAjGS57o1Rz3wuni3P97
X-QQ-GoodBg: 1
From: Zhen Ni <nizhen@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ASoc: SOF: Fix sof-audio-pci-intel-tgl shutdown timeout
 during hibernation
Date: Wed,  7 Dec 2022 18:22:29 +0800
Message-Id: <20221207102229.25962-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
Cc: Zhen Ni <nizhen@uniontech.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Dell Latitude 3420 Notebook, sof-audio-pci-intel-tgl may fail to shutdown
sporadically during hibernation as following log:

[   43.281110] PM: Image saving done
[   43.281699] PM: hibernation: Wrote 2828852 kbytes in 2.78 seconds(1017.57 MB/s)
[   43.282359] PM: SI
[   43.345156] kvm: exiting hardware virtualization
[   43.345865] auxiliary snd_sof.hda-probes.0: shutdown
[   43.346359] skl_hda_dsp_generic skl_hda_dsp_generic: shutdown
[   43.346849] skl_hda_codec hdmi ehdaudio0D2: shutdown
[   43.398204] snd_hda_codec_realtek ehdaudio0DO: shutdown
[   43.419621] dmic-codec dmic-codec: shutdown
[   43.420194] sof-audio-pci-intel-tgl 0000:00:1f.3: shutdown

Call wait_xxx_timeout() to process the timeout.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/core/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 5377f94eb211..9bd674d7a0fd 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -574,9 +574,10 @@ void snd_card_disconnect_sync(struct snd_card *card)
 	}
 
 	spin_lock_irq(&card->files_lock);
-	wait_event_lock_irq(card->remove_sleep,
+	wait_event_lock_irq_timeout(card->remove_sleep,
 			    list_empty(&card->files_list),
-			    card->files_lock);
+			    card->files_lock,
+			    msecs_to_jiffies(2000));
 	spin_unlock_irq(&card->files_lock);
 }
 EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
@@ -659,7 +660,7 @@ int snd_card_free(struct snd_card *card)
 	if (ret)
 		return ret;
 	/* wait, until all devices are ready for the free operation */
-	wait_for_completion(&released);
+	wait_for_completion_timeout(&released, msecs_to_jiffies(2000))
 
 	return 0;
 }
-- 
2.20.1


