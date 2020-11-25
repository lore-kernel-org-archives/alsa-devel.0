Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85269C63798
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:48:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BA92083E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KuOzcdPM";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1P++KKY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BA92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A80B81754;
	Wed, 25 Nov 2020 17:47:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A80B81754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606322919;
	bh=wL5Cw0v5IQ6jysCNVXuwfquOttUg6f8CA6LFRQYC+Ck=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KuOzcdPMpVbAw09KBO4g8fZ/LW/EJwmrvca/tBkru3lMVFFtJYJB2DpIpzxEOkoVc
	 /7WIRSdrTIJ5ajR61WlD3Bpd7+Encho6dvWM5pFilzvgDhFKDlePu8wbg1q1XHhiAY
	 llDKjmuCan0bBGEwxyNYJQZn42FY+DwJv2GAeric=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41A85F804E4;
	Wed, 25 Nov 2020 17:45:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB859F804E3; Wed, 25 Nov 2020 17:45:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDC27F804E3
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:45:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDC27F804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1P++KKY4"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22A632168B;
 Wed, 25 Nov 2020 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606322732;
 bh=wL5Cw0v5IQ6jysCNVXuwfquOttUg6f8CA6LFRQYC+Ck=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=1P++KKY43sRG2yBWSyYwPday8o/UWaDuuB5wrAoSjTLKPdTxiAnsyuYUH9rakrCD8
 KE7gasuucq+j1O9VRu9Kq+MPIqZlRdHBhPjnrtps+YJqKMuIfnddhFladLMvAHWfRX
 XKviBMiTgPSVvX5/SVFFfQzOZWiX5usjzBLZIO6g=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Oder Chiou <oder_chiou@realtek.com>,
 Kevin Cernekee <cernekee@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 05/39] ASoC: rk3328: mark OF related data as maybe unused
Date: Wed, 25 Nov 2020 17:44:18 +0100
Message-Id: <20201125164452.89239-6-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/codecs/rk3328_codec.c:502:34: warning: ‘rk3328_codec_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 940a2fa933ed..bfefefcc76d8 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -499,7 +499,7 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 					       ARRAY_SIZE(rk3328_dai));
 }
 
-static const struct of_device_id rk3328_codec_of_match[] = {
+static const struct of_device_id rk3328_codec_of_match[] __maybe_unused = {
 		{ .compatible = "rockchip,rk3328-codec", },
 		{},
 };
-- 
2.25.1

