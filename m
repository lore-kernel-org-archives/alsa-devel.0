Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC9BC52D7D
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:29:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 907592BF3;
	Thu, 15 Aug 2024 10:29:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 907592BF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710562;
	bh=IprM8RRessDIJrjofk4Bd2vse0GNObDd/kZ2NqgsEcU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hnpRHihzIjvp3ba649SeayFFWwzUZO9MFW2PbmsEpw4xfsue+IIeNFIrNXke5cxFu
	 1bYu+m5QtywQ4ofwwwy2dRuQs6u4Hu5Iy5CZ4XxtgZ/4h5wkLV5ANnG+930gmkxkL2
	 tn2/XtGYgs673r+FU4f96B0JH9P7+msyCdLdo6Xw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3077DF896B2; Thu, 15 Aug 2024 10:24:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73637F805F2;
	Thu, 15 Aug 2024 10:24:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58082F80423; Tue, 13 Aug 2024 06:52:11 +0200 (CEST)
Received: from smtp134-102.sina.com.cn (smtp134-102.sina.com.cn
 [180.149.134.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36ADDF800BF
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2024 06:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36ADDF800BF
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.172.39.131])
	by sina.net (10.185.250.32) with ESMTP
	id 66BAE666000078BE; Tue, 13 Aug 2024 12:51:51 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 99855257E7354864B1DB43395ACB49FD
X-SMAIL-UIID: 99855257E7354864B1DB43395ACB49FD-20240813-125151
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH] ASoC: codecs: ES8326: Adjust buttons
Date: Tue, 13 Aug 2024 12:51:49 +0800
Message-Id: <20240813045149.106488-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: Q3PR6DKSYHUXW6GFCLRT5PYNFAPZ3ZKI
X-Message-ID-Hash: Q3PR6DKSYHUXW6GFCLRT5PYNFAPZ3ZKI
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:24:37 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q3PR6DKSYHUXW6GFCLRT5PYNFAPZ3ZKI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To adapt to chrome, we have adjusted the buttons to match the system.

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8326.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index d5362b3be484..5b4586d9e67a 100755
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -765,11 +765,11 @@ static void es8326_jack_button_handler(struct work_struct *work)
 	case 0x6f:
 	case 0x4b:
 		/* button volume up */
-		cur_button = SND_JACK_BTN_1;
+		cur_button = SND_JACK_BTN_2;
 		break;
 	case 0x27:
 		/* button volume down */
-		cur_button = SND_JACK_BTN_2;
+		cur_button = SND_JACK_BTN_3;
 		break;
 	case 0x1e:
 	case 0xe2:
@@ -785,7 +785,7 @@ static void es8326_jack_button_handler(struct work_struct *work)
 		if (press_count > 3) {
 			/* report a press every 120ms */
 			snd_soc_jack_report(es8326->jack, cur_button,
-					SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			press_count = 0;
 		}
 		button_to_report = cur_button;
@@ -800,9 +800,9 @@ static void es8326_jack_button_handler(struct work_struct *work)
 		/* released or no pressed */
 		if (button_to_report != 0) {
 			snd_soc_jack_report(es8326->jack, button_to_report,
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			snd_soc_jack_report(es8326->jack, 0,
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			button_to_report = 0;
 		}
 		es8326_disable_micbias(es8326->component);
@@ -845,7 +845,7 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 		if (es8326->jack->status & SND_JACK_HEADPHONE) {
 			dev_dbg(comp->dev, "Report hp remove event\n");
 			snd_soc_jack_report(es8326->jack, 0,
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3);
 			snd_soc_jack_report(es8326->jack, 0, SND_JACK_HEADSET);
 			/* mute adc when mic path switch */
 			regmap_write(es8326->regmap, ES8326_ADC1_SRC, 0x44);
-- 
2.17.1

