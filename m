Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAFAC001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 10:00:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07F67EA0;
	Mon, 23 Oct 2023 11:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07F67EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698055236;
	bh=RcSEfi9+6KkNkFc+DB/j4AL/7U7XuX1do84BI9frLzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AOg5mL4OYi2QhaKXVj1sDYEkBMnezfM/kNU86N6WRCrn25JkSQCvGbtyxoWpAXxnX
	 FjktpSujAXkE07LIyPwhHEBQaEUhzlTrc1snwZk6kfnaqMMuMBBCQjCWpieMlQgP4b
	 bTVyc3P5LNoN2/YYcsaijXI3gO0rygrVfsyhBB8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F810F8063E; Mon, 23 Oct 2023 11:55:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A2987F8063E;
	Mon, 23 Oct 2023 11:55:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20EC3F805EC; Mon, 23 Oct 2023 11:55:18 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B47DF805EC
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 11:55:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B47DF805EC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=h+6BvQx8
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32da4ffd7e5so1725556f8f.0
        for <alsa-devel@alsa-project.org>;
 Mon, 23 Oct 2023 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054911; x=1698659711;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G81EZhNEBfjywIhuDWJjtpTXYP61176MP839Y8OZoG8=;
        b=h+6BvQx80gwcMKMTxcT8PnRai20cxYbbhTYjhCwtCEu+o0NDbxxJ74UhatPreWt4my
         Ug05d91w0khW9avfOfDTIFVnQPfQ1VopGwZT0WKMDulBQSeMeR+3kmuFQ288FLxHCcjX
         d+kXhjkuZM9WVvkBqtd0kD9+jBXlyAjQLqEoRalnaSnG7vhiAcaDVzXPcK6d+ByS9uPf
         7jaqptiu+ZoSeuwTCnnWXyqeMMI4EcnVuGT6Jdnf0rhOf45Xx4wWMSZLYlIGekvZTOff
         QQRjZw5Nk2sQalxqXDV50HGYZtUSp8oXSc+lfyM+p2zHI++lnjsY/w5pciUwQMgqi00/
         ND8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054911; x=1698659711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G81EZhNEBfjywIhuDWJjtpTXYP61176MP839Y8OZoG8=;
        b=qXbryqy/SOPu2lOhuuIMQ4Sl+MPc0c4evRJYDkE9zRjcwmbYG7xoFg643kl7gp+YjR
         oREYsE5dVgsMbnh4i0j1mTtGn8VSnfLnVjnxX1MrnDyImBcC5V81XICQPEOrSvOM3bqC
         xZtlXLUJfrhsZv6q4yquxYd9LZoCQsMNMXKmZ1u+loVDCnhFMKIRoLgdh25TN2S9MVOO
         Ehk6rKH4gt71GwMRiMS0XYjgzMKPnAxiRAyOGQxjG2updIgTX9fy7qJXZ8PFfJBQb9L3
         05dLnWfO2VO/zAuoxqDMJbJG8TFscHaSqH3oxUXrYNBg7K6sS8io/h2W/nD/qQqt0Sx7
         ijJQ==
X-Gm-Message-State: AOJu0YyANSjFtDbHbiJYKBLGz0XdCe0jm6c/Qj+s2mbg6hcOoFKUge/1
	LzmUyCw4mQGPspg0umJMD3Fkuw==
X-Google-Smtp-Source: 
 AGHT+IF2iXpBOUlnIxhQVTQ1O4HJJuZY9k94V739kocrPuR1iW5RroQxWCPWTyJ4Y36tYCQLJLsx0Q==
X-Received: by 2002:adf:a499:0:b0:32d:a3f7:f0dd with SMTP id
 g25-20020adfa499000000b0032da3f7f0ddmr10781049wrb.25.1698054911534;
        Mon, 23 Oct 2023 02:55:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:55:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 17/17] ASoC: tegra: machine: Handle component name prefix
Date: Mon, 23 Oct 2023 11:54:28 +0200
Message-Id: <20231023095428.166563-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TN2N2ATWZBIXBDCHDIMRAJCNFFVEKLHU
X-Message-ID-Hash: TN2N2ATWZBIXBDCHDIMRAJCNFFVEKLHU
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TN2N2ATWZBIXBDCHDIMRAJCNFFVEKLHU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/tegra/tegra_asoc_machine.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 3caadee9584f..192e9692bdf2 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -81,19 +81,23 @@ static int tegra_machine_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct tegra_machine *machine = snd_soc_card_get_drvdata(dapm->card);
 
-	if (!strcmp(w->name, "Int Spk") || !strcmp(w->name, "Speakers"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Int Spk") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Speakers"))
 		gpiod_set_value_cansleep(machine->gpiod_spkr_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Mic Jack") || !strcmp(w->name, "Headset Mic"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Mic Jack") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Headset Mic"))
 		gpiod_set_value_cansleep(machine->gpiod_ext_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Int Mic") || !strcmp(w->name, "Internal Mic 2"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Int Mic") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Internal Mic 2"))
 		gpiod_set_value_cansleep(machine->gpiod_int_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Headphone") || !strcmp(w->name, "Headphone Jack"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Headphone") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Headphone Jack"))
 		gpiod_set_value_cansleep(machine->gpiod_hp_mute,
 					 !SND_SOC_DAPM_EVENT_ON(event));
 
-- 
2.34.1

