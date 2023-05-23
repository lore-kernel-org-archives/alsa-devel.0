Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCEC77B75
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 15:16:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 673ED6C0;
	Tue, 23 May 2023 17:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 673ED6C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684854982;
	bh=W3MeMMTxy+pVlU3P67UfZXzoEsayT5B8rpJp8L3Sx9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lqbxr+RyMqUT8QfD8FFloxyb1jDBZU1cC8NKzpDgLr1HARZgPaJNS8pVpyA/ySan0
	 4BBpTF16C3pSmBjCSYFfgjM5zyekIMEVEkM60wyc9TGew7oOonyfJyC//LpF4yAnBt
	 S+0sTSTk81rh7bxfMMczncDcQOH5IaiJCPuazLF8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F98F805EF; Tue, 23 May 2023 17:13:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DCAA9F805EC;
	Tue, 23 May 2023 17:13:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 796F9F805D7; Tue, 23 May 2023 17:13:04 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B840AF805B4
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 17:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B840AF805B4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=EBpNWx/8
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPA id 40781C0018;
	Tue, 23 May 2023 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1684854774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyrbVwxZ0KTdJmelqko+tUdutg5HmqXXq7T/rn7OWng=;
	b=EBpNWx/8LcFOktzb/W/4ZB5ZW9iPWLEYoo9hpOU2o5gxHr7fzxt9ecSz33yHx/0Or82Un7
	G7WTwex35OTs3Ydmuwv/GHXCM2fZ7NVPyxKLIaiXEX0WSU5pdrxe15H8feq5tkB5mA6okY
	Bob3oDS6NogidlnIGqFHA5U2bhdthUhj+xwEjEAHCbPBWC0I+vTscCosqMjTF2ZJLKYONm
	TbF+yjcNp86S30P7Csq1jV6kGBuvAANsR2HPuoKyNKAdVqJvz62yyZ2efUYPRvX+8MfBgk
	JSVdO4I0WM+x1rPMw75o0xNTbWMDdWs9wYhU0mkgWBjfX1MCFhj7YbEWpIrqhg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 8/9] ASoC: simple-card: Add missing of_node_put() in case
 of error
Date: Tue, 23 May 2023 17:12:22 +0200
Message-Id: <20230523151223.109551-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZMDUZCD5SUNIEM6TCT7UHHR6SY5LSHDN
X-Message-ID-Hash: ZMDUZCD5SUNIEM6TCT7UHHR6SY5LSHDN
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZMDUZCD5SUNIEM6TCT7UHHR6SY5LSHDN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In the error path, a of_node_put() for platform is missing.
Just add it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6f044cc8357e..5a5e4ecd0f61 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -416,6 +416,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.40.1

