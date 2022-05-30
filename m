Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 30 May 2022 04:06:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D0B71A3B;
	Mon, 30 May 2022 06:05:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D0B71A3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653883560;
	bh=foSEQ447PdQ7UyaBwe3cQe1epqjFZBhabVOzvbeJiEU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vtGJ5c2CVmvzOQg52gXHkfoLM0tlRVFUVRJDmYZSmgaO/sx7EPse3iTz4oF/H76mz
	 uOKUO6DYTRKDCAPanzBMiH8SJskBcamJ72RlcQ8tOg+TxEgRZxL762QzOIWfWnfqUC
	 U9zjuYwndrGO5wV+TkRB7V4EXBf8E+dYRqkfxXaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E90BF80516;
	Mon, 30 May 2022 06:04:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1933AF804EC; Mon, 30 May 2022 06:04:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53011F800E5
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2022 06:04:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53011F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="XSlJ7nf/"
Received: from localhost.localdomain (unknown [123.112.66.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C93AF3FC19; 
 Mon, 30 May 2022 04:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1653883459;
 bh=hklZN1F9pJS+R8QlUQPioN9l4TfwzLaov3Ekgb+TEv4=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=XSlJ7nf/HkNFIE5IbuIJ6BKMupYJ4/oQroIIcTIpCsL233JaGydzcYbIKVzlkwKV0
 w4kpZ5R2DLobRzGqZUVh0TIupUEA/aq0/X98kfImiPkEyHjQ7rzvk6B0oi5LnI2WHL
 ylNmYQXbeqzeJdKjR0J20tDyq/ll2K3x0ClzkwkGZdc91KdQzfO16b8+UA5t7nLwfQ
 AlLPlRrC7pHlulOiGTGBpIU4HGWMgErsMK9vlqGoM4QOdYK5D62qJP0gSldkQDFCpO
 VUgW+nfV8koh6K6RgheEN/Ch/ENIBGP2ZDmUMois85FKZuStc99zn6ToUh2RoKC/Bp
 WYc+nhOfDDlnQ==
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/2] ASoC: nau8822: Disable internal PLL if freq_out is zero
Date: Mon, 30 May 2022 12:01:51 +0800
Message-Id: <20220530040151.95221-3-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530040151.95221-1-hui.wang@canonical.com>
References: <20220530040151.95221-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: wtli@nuvoton.com, kchsu0@nuvoton.com, ctlin0@nuvoton.com,
 ctlin0.linux@gmail.com
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

After finishing the playback or recording, the machine driver might
call snd_soc_dai_set_pll(codec, pll_id, 0, 0, 0) to stop the internal
PLL, but with the codec driver nau8822, it will print error as below:
 nau8822 0-001a: Unsupported input clock 0
 fsl-asoc-card sound-nau8822: failed to stop FLL: -22

Refer to the function wm8962_set_fll() in the codec driver wm8962, if
the freq_out is zero, turn off the internal PLL and return 0.

Cc: David Lin <ctlin0@nuvoton.com>
Cc: John Hsu <kchsu0@nuvoton.com>
Cc: Seven Li <wtli@nuvoton.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/codecs/nau8822.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index b436e532993d..4d3720c69f91 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -726,6 +726,13 @@ static int nau8822_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	struct nau8822_pll *pll_param = &nau8822->pll;
 	int ret, fs;
 
+	if (freq_out == 0) {
+		dev_dbg(component->dev, "PLL disabled\n");
+		snd_soc_component_update_bits(component,
+			NAU8822_REG_POWER_MANAGEMENT_1, NAU8822_PLL_EN_MASK, NAU8822_PLL_OFF);
+		return 0;
+	}
+
 	fs = freq_out / 256;
 
 	ret = nau8822_calc_pll(freq_in, fs, pll_param);
-- 
2.25.1

