Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0BC56201
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:51:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E917206D8
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WiRBvz0C";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAkP+/pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E917206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05E9117A9;
	Wed, 25 Nov 2020 17:50:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05E9117A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606323109;
	bh=Ju113eZ9V9u7c87HH77J8+nB2ndVCZR+9BZ4I7nAeXw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WiRBvz0CFw4HLfBLVGV24cNMDh5vzkvgag6EcoqbeCFDf8HAMrfxVW9BrrCGKagUe
	 GBJcsiOZaTrorlWZg4oJC3t/ZMHNC0GjtzazTKt4kI/SvVAuAXWAfjnPJ/z+60fdvP
	 NFFm8Pxlki09C2+UgcbZ5XuBvHSJzsU5zj/oFJe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F29E4F8015F;
	Wed, 25 Nov 2020 17:46:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FEFAF80529; Wed, 25 Nov 2020 17:46:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99732F8015F
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:46:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99732F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WAkP+/pw"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CAC02083E;
 Wed, 25 Nov 2020 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606322768;
 bh=Ju113eZ9V9u7c87HH77J8+nB2ndVCZR+9BZ4I7nAeXw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=WAkP+/pwlBjnuNLv/rDQVLWUufs2kpqEVzZNFgXH7fCkShOVgQXt0lJKmXqCEMwGa
 jaoLrqZP1MrTghK4oK4JHMrVxJMrhOHt8FnocGmOn8tirtBJ3msYKAaI7+cmLLcu2w
 uZwW3/96o66N+KeIYn8b0/Cv9vuwN/TcZab3amtY=
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
Subject: [PATCH v2 13/39] ASoC: uniphier: mark OF related data as maybe unused
Date: Wed, 25 Nov 2020 17:44:26 +0100
Message-Id: <20201125164452.89239-14-krzk@kernel.org>
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

  sound/soc/uniphier/aio-ld11.c:375:34: warning: ‘uniphier_aio_of_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/uniphier/evea.c:554:34: warning: ‘evea_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/uniphier/aio-ld11.c | 2 +-
 sound/soc/uniphier/aio-pxs2.c | 2 +-
 sound/soc/uniphier/evea.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 8b44f8dc4970..7b3cf5d751f6 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -372,7 +372,7 @@ static const struct uniphier_aio_chip_spec uniphier_aio_ld20_spec = {
 	.addr_ext  = 1,
 };
 
-static const struct of_device_id uniphier_aio_of_match[] = {
+static const struct of_device_id uniphier_aio_of_match[] __maybe_unused = {
 	{
 		.compatible = "socionext,uniphier-ld11-aio",
 		.data = &uniphier_aio_ld11_spec,
diff --git a/sound/soc/uniphier/aio-pxs2.c b/sound/soc/uniphier/aio-pxs2.c
index a1d05fe9d3c2..899904f7ffd6 100644
--- a/sound/soc/uniphier/aio-pxs2.c
+++ b/sound/soc/uniphier/aio-pxs2.c
@@ -282,7 +282,7 @@ static const struct uniphier_aio_chip_spec uniphier_aio_pxs2_spec = {
 	.addr_ext  = 0,
 };
 
-static const struct of_device_id uniphier_aio_of_match[] = {
+static const struct of_device_id uniphier_aio_of_match[] __maybe_unused = {
 	{
 		.compatible = "socionext,uniphier-pxs2-aio",
 		.data = &uniphier_aio_pxs2_spec,
diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index d27e9ca07856..96343d19a1e0 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -551,7 +551,7 @@ static int evea_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id evea_of_match[] = {
+static const struct of_device_id evea_of_match[] __maybe_unused = {
 	{ .compatible = "socionext,uniphier-evea", },
 	{}
 };
-- 
2.25.1

