Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE01C07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A551613C5
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A551613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 007D216A5;
	Sat, 10 Jul 2021 04:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 007D216A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884373;
	bh=BBIWsxldfa1/BlZAXDvliQuDJ1M4egHfyUxTTQQcEcA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhiF6Terkbl+bfIQXt+RZB+kfvl6upSbLsKOJFdemDWKYNu+zBxj9jDQh83Na30Rb
	 qN1kYqQm1+oGWZ8BaRUdrWA/CeAshHZ2Z+VQ+QTa3rug3OcU8qWD7YVrKlSCUdmVTW
	 WG9UURBSjCdGmQZsUT9AHWgxiguBnk7qNIlpkY28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28EA5F8057C;
	Sat, 10 Jul 2021 04:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93FBCF805AE; Sat, 10 Jul 2021 04:24:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78DFCF805A8
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:24:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78DFCF805A8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nV4F1bcd"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34891613F8;
 Sat, 10 Jul 2021 02:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883851;
 bh=BBIWsxldfa1/BlZAXDvliQuDJ1M4egHfyUxTTQQcEcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nV4F1bcdaJwGkqh8A4pbZFe21Dy55UmhF5+RsD1jSmsyPMw8kMeqJaKG5UFapTity
 kaqIoXCt2xyXxFicFrHVyrTVWg5hvKzHqWO2G0U8lEh1/O0GSCJevIUaO3HKuiA88+
 YvoHXpiSBZnucfz6nB8e1tg5oYm1iAnsNc+9xWgZpj7KpCslo67iNdHwzcQrRn0aY6
 1vGr3+iEI6Yyk1wk+JhmqGUJOVEVPBWFeVSYqwDqbLWDbKF4gRwN4bZmv2zJMvnBJZ
 n67bkrTY4bDbHJfgVIuIiuo8tyTpdTvV14+V4v+5apk7aL+UwFCiQsrmWtzWfkTEM1
 LZTbHJ6ChzBqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 094/104] ALSA: hda: Add IRQ check for
 platform_get_irq()
Date: Fri,  9 Jul 2021 22:21:46 -0400
Message-Id: <20210710022156.3168825-94-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Xin Tan <tanxin.ctf@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Jiajun Cao <jjcao20@fudan.edu.cn>, linux-tegra@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
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

From: Jiajun Cao <jjcao20@fudan.edu.cn>

[ Upstream commit 8c13212443230d03ff25014514ec0d53498c0912 ]

The function hda_tegra_first_init() neglects to check the return
value after executing platform_get_irq().

hda_tegra_first_init() should check the return value (if negative
error number) for errors so as to not pass a negative value to
the devm_request_irq().

Fix it by adding a check for the return value irq_id.

Signed-off-by: Jiajun Cao <jjcao20@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20210622131947.94346-1-jjcao20@fudan.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 6f2b743b9d75..6c6dc3fcde60 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -262,6 +262,9 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	const char *sname, *drv_name = "tegra-hda";
 	struct device_node *np = pdev->dev.of_node;
 
+	if (irq_id < 0)
+		return irq_id;
+
 	err = hda_tegra_init_chip(chip, pdev);
 	if (err)
 		return err;
-- 
2.30.2

