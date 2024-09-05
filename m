Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F50ECE7B17
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:55:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4811E7D;
	Fri,  6 Sep 2024 15:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4811E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725630919;
	bh=sIIPZUk/McFrEGOpzaiTsFXpvninZCb+Pc2SfB0iyAM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JK3gKamqxt47goyBLrzsiygOuz0FdTLYOochSGOHaGlS/rtcWj9ex+ulgPhzsgnja
	 G80ywTroMrWncM+x9flpvrpd0ieumwsrWqEir9Bskm6AeZJmx9qnd8Edc4Xq8WH8hj
	 r3pX/GF9BkulpSwI/g/Kf9V7dWClApkvBXDd0eo0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F3F2F805A1; Fri,  6 Sep 2024 15:54:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 640F9F805A0;
	Fri,  6 Sep 2024 15:54:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8D31F8016C; Thu,  5 Sep 2024 04:21:32 +0200 (CEST)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D05B6F80027
	for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2024 04:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D05B6F80027
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADnyuqeFdlmBX9ZAQ--.17465S2;
	Thu, 05 Sep 2024 10:21:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	brent.lu@intel.com,
	kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: Intel: skl_hda_dsp_generic: convert comma to semicolon
Date: Thu,  5 Sep 2024 10:20:17 +0800
Message-Id: <20240905022017.1642550-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADnyuqeFdlmBX9ZAQ--.17465S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4kCw1kGrg_yoW8XFWfpF
	1v9wn8KF98Xa4vvay7XF17CasxXan7Ja47Ww45J34qqF1rXw1rurWqgFn7ZFWUKF93Gr1j
	vrsrKrykKFyfAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY
	1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gr1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUUXdbUUUUU
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-MailFrom: nichen@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 76UMHFVF7T5WIIOOA6MUSENZCUAK4IPH
X-Message-ID-Hash: 76UMHFVF7T5WIIOOA6MUSENZCUAK4IPH
X-Mailman-Approved-At: Fri, 06 Sep 2024 13:54:42 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/76UMHFVF7T5WIIOOA6MUSENZCUAK4IPH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 225867bb3310..8e104874d58c 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -217,14 +217,14 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card = &ctx->card;
-	card->name = "hda-dsp",
-	card->owner = THIS_MODULE,
-	card->dai_link = skl_hda_be_dai_links,
-	card->dapm_widgets = skl_hda_widgets,
-	card->dapm_routes = skl_hda_map,
-	card->add_dai_link = skl_hda_add_dai_link,
-	card->fully_routed = true,
-	card->late_probe = skl_hda_card_late_probe,
+	card->name = "hda-dsp";
+	card->owner = THIS_MODULE;
+	card->dai_link = skl_hda_be_dai_links;
+	card->dapm_widgets = skl_hda_widgets;
+	card->dapm_routes = skl_hda_map;
+	card->add_dai_link = skl_hda_add_dai_link;
+	card->fully_routed = true;
+	card->late_probe = skl_hda_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.25.1

