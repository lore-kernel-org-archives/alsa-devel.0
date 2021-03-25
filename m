Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:32:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AD761962
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AD761962
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E7A816AD;
	Thu, 25 Mar 2021 12:31:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E7A816AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616671951;
	bh=5mITberqG7UgwW6RZuOELf841627VhEq59zXJ/OyvFo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=voOLcB9RSYLX8I5S/hleww1/XfyYl/2kv2qsz3bLx2KZ4x+Tygzusly+j9KNFhAgK
	 KunJv7TZsGygkhCoJPo9NYj6JU0eP+raKS5Lh/wRtTQxpvCS35/lDaw4QJ0Z7iK7us
	 P/p+qw1Hf2rUEHWVPpRWtHV6dsFnyIANGrNKS5Lc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 604A8F8051E;
	Thu, 25 Mar 2021 12:26:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA420F8050F; Thu, 25 Mar 2021 12:26:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1C75F80104
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1C75F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Np3dwTTu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5637961A2C;
 Thu, 25 Mar 2021 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671518;
 bh=5mITberqG7UgwW6RZuOELf841627VhEq59zXJ/OyvFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Np3dwTTufqkJ+YhSer5+jF9dTewgZGePyFfA0S9F4/zuenuL9a43UtbA6xQN7k5L4
 P57OjoHBY1lqEpr947wOnYsHDKvNwBn35yDIejgZIP0Tj+uHEBf+85k4h+y2misLah
 EtbPQBzOJDhCirdjhGXNk6b74ChQc9iIdfYGvEaU7sJZagiDkb3JmS35bU3i6ieGRZ
 PaJOoJ012n7yRRBaDWtCbbUJxvyb9J1XIkFDAAxLgK5ud4lPoKLOH6YOaH4vCdTfe0
 EJX47URzrmaetDfcEGVK2JIRiEaUKAjoyQtQcT2FdsHA10RwVDyVIsHYtZRtsFCNpo
 czaXn1PiGnrbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 14/44] ASoC: soc-core: Prevent warning if no DMI
 table is present
Date: Thu, 25 Mar 2021 07:24:29 -0400
Message-Id: <20210325112459.1926846-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112459.1926846-1-sashal@kernel.org>
References: <20210325112459.1926846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
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

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 7de14d581dbed57c2b3c6afffa2c3fdc6955a3cd ]

Many systems do not use ACPI and hence do not provide a DMI table. On
non-ACPI systems a warning, such as the following, is printed on boot.

 WARNING KERN tegra-audio-graph-card sound: ASoC: no DMI vendor name!

The variable 'dmi_available' is not exported and so currently cannot be
used by kernel modules without adding an accessor. However, it is
possible to use the function is_acpi_device_node() to determine if the
sound card is an ACPI device and hence indicate if we expect a DMI table
to be present. Therefore, call is_acpi_device_node() to see if we are
using ACPI and only parse the DMI table if we are booting with ACPI.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20210303115526.419458-1-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f6d4e99b590c..0cffc9527e28 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/dmi.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1573,6 +1574,9 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	if (card->long_name)
 		return 0; /* long name already set by driver or from DMI */
 
+	if (!is_acpi_device_node(card->dev->fwnode))
+		return 0;
+
 	/* make up dmi long name as: vendor-product-version-board */
 	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 	if (!vendor || !is_dmi_valid(vendor)) {
-- 
2.30.1

