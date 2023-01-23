Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7781BC54E94
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Jan 2023 14:01:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66420332C;
	Mon, 23 Jan 2023 15:00:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66420332C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674482476;
	bh=5MzS3f0ZpQbDZcpdnob6wsuMFNiCdarOpQ0wYURU9hY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UdQs2PwD07kuOvGwQYxDNtmL5HjhwjjbRGgSIB3LFiNzxmvUZgivIWNirCmNBPOUB
	 1FUU8QWO9zbAZt8Hd5+kkM0aY468cLtkvptNzjaezQiQdW6LJbBcjkbLX6hQUPDz75
	 cPrhxQ+hQpvK6d2KrG+E1eGffVA2Lj3ub6Aupf1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16441F80557;
	Mon, 23 Jan 2023 14:59:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BF5DF800FB; Mon, 23 Jan 2023 14:59:32 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2703FF800FB
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2023 14:59:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2703FF800FB
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256
 header.s=axis-central1 header.b=QwWXzb/y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1674482363;
 x=1706018363; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFfgTb34a//0h/wk1qs7LHk+iVK4qzPfVOmAPGqO2dk=;
 b=QwWXzb/ydjA5sNt4oH+PHcb6Y4k46TiZ3JL61hCZvNl/RXltSnVBfR+T
 a931cqxWtVapadnFMoIHlTuIgoH6TLe0g/VvGqRkvyB3QmN/pmerwZvmG
 0tgCRkLLA4P0BxhFLsZoCStMfJhx2WOZb/h4yNAUTJ4GWJBzUA0tpKeUU
 Tv/ReA2YQFKLznw3OvNqwd7wgY8eBx2dXEqMi/w1ekFxjdoSuM6vP0UpJ
 LVMPVyXsj2BU6ptqIoqAE4MesUeMrUmeG4PIywZYwiQTO6BVxoiYKnd+W
 VL4OuXB4VgbTdOiJY7mIETbvS504rrdO2JpA78X/0UNzyFoNeSy9gQ0hM A==;
From: Astrid Rost <astrid.rost@axis.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 3/3] ASoC: ts3a227e: add set_jack and get_jack_type
Date: Mon, 23 Jan 2023 14:59:13 +0100
Message-ID: <20230123135913.2720991-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123135913.2720991-1-astrid.rost@axis.com>
References: <20230123135913.2720991-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 Astrid Rost <astrid.rost@axis.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add set_jack and get_jack_type to allow simple-card-utils to add
a jack for it.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 sound/soc/codecs/ts3a227e.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 2305a472d132..5282112c7d8d 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -258,7 +258,25 @@ int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
 
-static struct snd_soc_component_driver ts3a227e_soc_driver;
+static int ts3a227e_set_jack(struct snd_soc_component *component,
+			     struct snd_soc_jack *jack, void *data)
+{
+	if (jack == NULL)
+		return -EINVAL;
+
+	return ts3a227e_enable_jack_detect(component, jack);
+}
+
+static int ts3a227e_get_jack_type(struct snd_soc_component *component)
+{
+	return SND_JACK_HEADSET;
+}
+
+static const struct snd_soc_component_driver ts3a227e_soc_driver = {
+	.name = "ti,ts3a227e",
+	.set_jack = ts3a227e_set_jack,
+	.get_jack_type = ts3a227e_get_jack_type,
+};
 
 static const struct regmap_config ts3a227e_regmap_config = {
 	.val_bits = 8,
-- 
2.30.2

