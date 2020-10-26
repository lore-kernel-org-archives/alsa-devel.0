Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF864C4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:56:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45ED92085B
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h85tGDOf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg6m0j7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ED92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EFCD16B6;
	Mon, 26 Oct 2020 19:56:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EFCD16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603738616;
	bh=pJ2HA7pJk/hapgSMBd5q9PAYzEwhwbKM2AoAgJiq6Lg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h85tGDOfADb2RVGkR35rPQvG9RsOJ8mHCmpHqYrVCO9Vs1Qk43pzVawWogtV7Hry/
	 cfbMyoLXu0MPdjuE13D/c479nrYxVC1S8Xh82OkXSLaoWy1Y1j9GpnH96ZpnPYPlhO
	 XZfl5PcNjrwVR5Nzu2C8LBzjD4FV6YXYajQb7hIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C1EDF804F1;
	Mon, 26 Oct 2020 19:53:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA411F804D2; Mon, 26 Oct 2020 19:52:59 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 456B1F8027C
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 19:52:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 456B1F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="dg6m0j7I"
Received: by mail-wm1-x344.google.com with SMTP id k21so6341436wmi.1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXcJWmCyjE4JV7N+koe+BuRsgR3wUYxT5G2C2Eoj1hs=;
 b=dg6m0j7IUyaxxSU6zNyRyN05sgSBqfSaFqDhCqqDDd8ZXK4r1qkDMD/Iff0QYusv3n
 6O3W79QMEsHQcYuCGB66HkmD4L4AAypNqleJiN32juSxrrpX85xI09ot4GCHdVAUQIeM
 NNTh7Q+qQhGnd20oPBqhsJeBYZJBKlLfXBdA4YL/AhH5tG6UBJSYx33P6qjPOhBiC2Yi
 I2mE4NvyHhSKXRdfZotWWEgpAA4qfZHmil75ENxyaDhLbaMpA2QFq71bg9+8FWRVNm/D
 TSvAZ5ceIaAM8JqX3Xs0r4eIOKrwb4zOFA2ZHyUHAMLA2Eu5GRwMK0upd3YXcRMI9x9B
 4CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aXcJWmCyjE4JV7N+koe+BuRsgR3wUYxT5G2C2Eoj1hs=;
 b=D5b9NJcy3fGSUW4r6jVVdQaX4aImylmPXfSXvbtS/A8cLqUdu0FMAuwXfGd3gigAfZ
 BG+Xo+VS+LWSD1pOd/Lv/xxaM6oEfVOa9iT4/a38fmNG/43WSn2RhfbNMQaV0IdmLJ6k
 z96wtnyN258gIJeajdBN1TG7LJg7ZVIJsWiB6MDfz3C6dfiIlTpR+EXb0gNXcJTuGmNj
 9W4oJslCwbVWQrvssob5nDj+LeVE+5qV+bGixoPiiR8W2nDKsDOgChJxl+u2xNpRvG2R
 XYHHFKpnmNO1MN0AMSvxPJ/ZYp62V3iTYO1aLkej609RxCpkqFbOQsHfzJLQaIsYe5GW
 RxxA==
X-Gm-Message-State: AOAM5334OdgsrA5nj2CoytCU4fUgKNEg/vmMOmXeuYB2WZa065KPwMb1
 fSg+4rlzbxvXS4/NWaeeJXA=
X-Google-Smtp-Source: ABdhPJxBlv541/Lf2h0pguCkcd6pss2YPC6xpTPtHEpX6NnwTD5nRe155Ai0OS1IncDdwxDMq3iWVg==
X-Received: by 2002:a05:600c:2217:: with SMTP id
 z23mr18338599wml.133.1603738372270; 
 Mon, 26 Oct 2020 11:52:52 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 11:52:51 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v8 08/14] ASoC: sun4i-i2s: fix coding-style for callback
 definition
Date: Mon, 26 Oct 2020 19:52:33 +0100
Message-Id: <20201026185239.379417-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Checkpatch script produces warning:
WARNING: function definition argument 'const struct sun4i_i2s *'
should also have an identifier name.

Let's fix this by adding identifier name to get_bclk_parent_rate()
and set_fmt() callback definition.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 703327dc8606..08e9e71f455f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,13 +180,13 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1

