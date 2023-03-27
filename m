Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92079C6FD1D
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Mar 2023 17:38:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 745D83E8;
	Mon, 27 Mar 2023 19:37:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 745D83E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679938699;
	bh=FtfzL+RBfnaAUPJa4KMvw/tXivxLL1QjoheWBdL9VHY=;
	h=To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:Cc:From;
	b=WDDF3sRKvlC/KC57LwGMz53P49PId72rMsxNjqKsGlR9PvHzmfHLq+pAVqzcTH5FX
	 SW/+nwhsIwu6WBZsFpKyg2kKwn9nyvjAleABlIko+AOEedHDcQH+n8MUNag9K6OD8U
	 2QmhjeA7iO0IRH6CuljBIevgoceqOmkWcvu/iWRc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05B02F800C9;
	Mon, 27 Mar 2023 19:37:06 +0200 (CEST)
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4] sound: soc: qcom: sdm845: expose ALSA control for jack
Date: Mon, 27 Mar 2023 19:36:27 +0200
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CRZCT2XLE7NS4GXDRHBI24YTYLZRZO2N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
MIME-Version: 1.0
Message-ID: 
 <167993862458.26.3671334925039974134@mailman-core.alsa-project.org>
From: Dylan Van Assche via Alsa-devel <alsa-devel@alsa-project.org>
Reply-To: Dylan Van Assche <me@dylanvanassche.be>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Dylan Van Assche <me@dylanvanassche.be>
Content-Type: message/rfc822
Content-Disposition: inline

Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E44F1F80272; Mon, 27 Mar 2023 19:36:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.6
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D8CEBF800C9
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2023 19:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8CEBF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=dylanvanassche.be header.i=@dylanvanassche.be
 header.a=rsa-sha256 header.s=MBO0001 header.b=Z+NCmJiR
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Plg3d2hKyz9sQY;
	Mon, 27 Mar 2023 19:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
	s=MBO0001; t=1679938606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=erhiX1kWslYrQnsmeLq0Eijl2/NyUjXUqiUh7SiAOL4=;
	b=Z+NCmJiRBmaI4XZu26q+haVWgnaLtjwJk5782Ya5brwKjCkoB42NhqmmjRNoWgqglT7GEa
	C64Y5mBG9k8MZtgJXz6TjyuawegBFtwFbCGqCBHbHN4HWQXtwI98Ve7sXhymdqkjWV/B42
	2CklB4ntdahmFFaQvzroxdbnEsaXCyu1GxbHylA2p5ModoeqNaTEdsPsgL1mUDbOUJqtGx
	KtxriXyIPhxp9BUlMqhS1s2w4W/l7rfAdf0JiVPzycLmOqgvyQHeYqdTxuS+wUkhB67h3S
	9xGomaoDamqgfj6I8zTY/xDW11XitrRU2IwZae/KKyuX3Ik6rfm5LK+e93ZiJQ==
From: Dylan Van Assche <me@dylanvanassche.be>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4] sound: soc: qcom: sdm845: expose ALSA control for jack
Date: Mon, 27 Mar 2023 19:36:27 +0200
Message-Id: <20230327173627.361533-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Plg3d2hKyz9sQY
Message-ID-Hash: CRZCT2XLE7NS4GXDRHBI24YTYLZRZO2N
X-Message-ID-Hash: CRZCT2XLE7NS4GXDRHBI24YTYLZRZO2N
X-MailFrom: me@dylanvanassche.be
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Dylan Van Assche <me@dylanvanassche.be>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CRZCT2XLE7NS4GXDRHBI24YTYLZRZO2N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Qualcomm SDM845 features a headphone jack via a Qualcomm WCD9340
codec which has jack detection through the wcd-mbhc-v2 driver.
Jack detection is currently fully functional via the input
interface together with multimedia buttons, but is not exposed
as an ALSA control. Therefore, ALSA clients such as PulseAudio [1]
do not pick up the jack detection events as they only support
one of the possible interface (ALSA control or input interface,
but not both). Initialize the audio jack with snd_soc_card_jack_new_pins
instead of snd_soc_card_jack_new to make the jack also available as
an ALSA control.

[1] https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1377

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---

Changes in v4:

- Dropped cover letter because of a single patch.
- Reworked as a patch to the SDM845 Machine driver as suggested
  by Mark Brown.

Changes in v3:

- Improved cover letter
- Added Tested-by from
https://lore.kernel.org/alsa-devel/20221007155716.10594-1-me@dylanvanassche.be/
- Properly added maintainers for sending this patch

Kind regards,
Dylan Van Assche

 sound/soc/qcom/sdm845.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 02612af714a8..95888c5079a0 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -44,6 +44,14 @@ struct sdm845_snd_data {
 
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
 
+static struct snd_soc_jack_pin sdm845_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = (SND_JACK_HEADPHONE | SND_JACK_MICROPHONE | SND_JACK_HEADSET |
+			 SND_JACK_MECHANICAL)
+	},
+};
+
 static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
@@ -242,12 +250,13 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 
 	if (!pdata->jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_HEADPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pdata->jack);
+				&pdata->jack, sdm845_jack_pins,
+				ARRAY_SIZE(sdm845_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
-- 
2.39.2

