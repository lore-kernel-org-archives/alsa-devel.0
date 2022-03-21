Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AD4C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 06:59:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BA2E168E;
	Mon, 21 Mar 2022 07:58:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BA2E168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647845960;
	bh=PjEXYiQq/djtL9gbp8INQnz8P3bpXOGhdXwEnOIQt8k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=py6z9yHy1N30IpWIcgkXO5ZdAQVsVVOALqdVCTIYwOItDI6YuM1nk2vyB/JFzbw1F
	 oRogNtFuDUYJllMBkEZ03QKDBEf4XvaTH5HzJBLNgNqWhlcQqcI17yGehJ7UWZ0KvA
	 vVxifFDeQ3HLqWn//JzTNcKAPewcM2+ebRAUHRpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCF53F801D8;
	Mon, 21 Mar 2022 07:58:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD1CDF80227; Mon, 21 Mar 2022 07:58:27 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E992F80109
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 07:58:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E992F80109
X-QQ-mid: bizesmtp82t1647845884t804rf5r
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 21 Mar 2022 14:57:57 +0800 (CST)
X-QQ-SSF: 01400000002000D0I000000A0000000
X-QQ-FEAT: geCjBjpTnm5MCuhbl7WYFcVXtSlLYe9nC1Ht/79OMySzfSxUeFWMlEVlP+knM
 OezqIH5y7A/rfELeaajZVCAAx4GrtoyySSDJmz7ddbkXeiUfWifuSxk/Bi9creqz6xIm/Jm
 Uu2MMJxb28nTNTn8X70dH7T5IYaZk9lBtgzED1Ka/XyEVb6eqQN4t7L914gqT01Yzk7hw6r
 S42MAr0xF076OqnTq2umNB9bzMI1NIMvSfWdJKMDjmiBsRMEX2aW1VC38gydlWoIJsYmYQF
 6CJjxuUTdWSnPaojt+XOZgN7dpg0tmUTH+g0KM/fHg9zn9nAyVwFJkrsz/DshH06pVsMVOZ
 8lJ+UsPbx8dPh1DVoEcN2sD3aXON/Z9fhYrV5we
X-QQ-GoodBg: 1
From: Meng Tang <tangmeng@uniontech.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2] ASoC: fsl-asoc-card: Fix jack_event() always return 0
Date: Mon, 21 Mar 2022 14:57:54 +0800
Message-Id: <20220321065754.18307-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
Cc: Meng Tang <tangmeng@uniontech.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Today, hp_jack_event and mic_jack_event always return 0. However,
snd_soc_dapm_disable_pin and snd_soc_dapm_enable_pin may return a
non-zero value, this will cause the user who calling hp_jack_event
and mic_jack_event don't know whether the operation was really
successfully.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 370bc790c6ba..d9a0d4768c4d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -462,11 +462,9 @@ static int hp_jack_event(struct notifier_block *nb, unsigned long event,
 
 	if (event & SND_JACK_HEADPHONE)
 		/* Disable speaker if headphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		return snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-
-	return 0;
+		return snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 }
 
 static struct notifier_block hp_jack_nb = {
@@ -481,11 +479,9 @@ static int mic_jack_event(struct notifier_block *nb, unsigned long event,
 
 	if (event & SND_JACK_MICROPHONE)
 		/* Disable dmic if microphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "DMIC");
+		return snd_soc_dapm_disable_pin(dapm, "DMIC");
 	else
-		snd_soc_dapm_enable_pin(dapm, "DMIC");
-
-	return 0;
+		return snd_soc_dapm_enable_pin(dapm, "DMIC");
 }
 
 static struct notifier_block mic_jack_nb = {
-- 
2.20.1



