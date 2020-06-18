Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC059C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4921974
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Aw3kFAGj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSriZMCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4921974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B93751615;
	Thu, 18 Jun 2020 03:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B93751615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592442554;
	bh=qRlnQf7Xk6zFl0P86w1ugikUm53gsBx3fulqKArAxqQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aw3kFAGj3+6gnKgjyu3/R5G//cpK7xUMCXNzmoa1VXpVoj0vbx5ejyun9RxU38S9D
	 rV5gffV+imUjNFOJ1guZmwklXb26+Lt4NVKJ8K9HWeY9zV55MPi8VQbYzwULj0K7lG
	 E8h3SI8bGzieqG5qbWqF1xSmTFrgQykLCjMf/bnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39086F80171;
	Thu, 18 Jun 2020 03:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E233AF801D9; Thu, 18 Jun 2020 03:08:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5733F80116
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:08:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5733F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iSriZMCB"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A20BB2193E;
 Thu, 18 Jun 2020 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442491;
 bh=qRlnQf7Xk6zFl0P86w1ugikUm53gsBx3fulqKArAxqQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iSriZMCBjGO9zQBeug8ur8PelRkcQF4JzdOgjKiGNzqHeBiRoiZAoi4As5c/Dzz/Q
 zLeUgFgN4lkXsvvHWA/k38BdCl+M2Bwu6Y75y0H3wjpBkybKbC6qQa8/X4Pt2NnBNo
 YVKxVHoxeAsheeTYn6Y/aYhSleG7dUHL1oMKUiEg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 004/388] ASoC: tegra: tegra_wm8903: Support nvidia,
 headset property
Date: Wed, 17 Jun 2020 21:01:41 -0400
Message-Id: <20200618010805.600873-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
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

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 3ef9d5073b552d56bd6daf2af1e89b7e8d4df183 ]

The microphone-jack state needs to be masked in a case of a 4-pin jack
when microphone and ground pins are shorted. Presence of nvidia,headset
tells that WM8903 CODEC driver should mask microphone's status if short
circuit is detected, i.e headphones are inserted.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20200330204011.18465-3-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra_wm8903.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 9b5651502f12..3aca354f9e08 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -177,6 +177,7 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = codec_dai->component;
 	struct snd_soc_card *card = rtd->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
+	int shrt = 0;
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		tegra_wm8903_hp_jack_gpio.gpio = machine->gpio_hp_det;
@@ -189,12 +190,15 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 					&tegra_wm8903_hp_jack_gpio);
 	}
 
+	if (of_property_read_bool(card->dev->of_node, "nvidia,headset"))
+		shrt = SND_JACK_MICROPHONE;
+
 	snd_soc_card_jack_new(rtd->card, "Mic Jack", SND_JACK_MICROPHONE,
 			      &tegra_wm8903_mic_jack,
 			      tegra_wm8903_mic_jack_pins,
 			      ARRAY_SIZE(tegra_wm8903_mic_jack_pins));
 	wm8903_mic_detect(component, &tegra_wm8903_mic_jack, SND_JACK_MICROPHONE,
-				0);
+				shrt);
 
 	snd_soc_dapm_force_enable_pin(&card->dapm, "MICBIAS");
 
-- 
2.25.1

