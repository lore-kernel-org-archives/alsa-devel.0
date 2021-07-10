Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D017FC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:56:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5301C613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5301C613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC46417CB;
	Sat, 10 Jul 2021 04:56:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC46417CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885815;
	bh=+GxOXwBIVChAEIPaJlTqVRD9YIlZFBH0s/v8OF5M8is=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2krjgY1CsUQ4WdtFsZkD9ScO0PnYFqL8gi/MlTnbGEDWe8yqIPrWybBO0WbxNz9g
	 VSrLrke0G7gPrAmtNCScTfq/G/kGb1iIFmKkqIP8qi3KlxiePKfK6XxeowXD8gjZJP
	 pJLPQQ+TwkMKOhKj3peXyaVLnIQUctP7j9K025DM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEAB3F805FF;
	Sat, 10 Jul 2021 04:40:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79C59F80603; Sat, 10 Jul 2021 04:40:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91CD1F80564
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91CD1F80564
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QBRc8JRg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 868D561409;
 Sat, 10 Jul 2021 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884784;
 bh=+GxOXwBIVChAEIPaJlTqVRD9YIlZFBH0s/v8OF5M8is=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QBRc8JRgMf5yDi2YaVcLlvQFWEgdJ7CTSVImLjzdFS9EiG2Z4eWQ+hQTXGc3BWJf9
 k7JJmxZUWvTC38wXxRODnHJm2/Nw53dpYtQ1os6sn26gG5DSacIPGk4mlN1PR825iU
 R1PI5ACcj7hd4pMcHBp/gKP+xLWpPYg9ojiWfvJz85ZwKdb0Tma8zZWQRU9qCY9ZBD
 Jyv5jMjhzal4HujEItagPzKudhUHVPNjjSVrBFE+5i685xM9zR+IMQAKIdSTY0H/4b
 ZYXP6ISLj9dEMpIHdBMtifCbht8ZT+NtNHytwCO08jZseIHzutyoOO4F9T8iftkrLQ
 aFGvEYaKZqnqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 21/23] ALSA: hda: Add IRQ check for
 platform_get_irq()
Date: Fri,  9 Jul 2021 22:39:10 -0400
Message-Id: <20210710023912.3172972-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023912.3172972-1-sashal@kernel.org>
References: <20210710023912.3172972-1-sashal@kernel.org>
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
index 039fbbb1e53c..89359a962e47 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -363,6 +363,9 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	unsigned short gcap;
 	int irq_id = platform_get_irq(pdev, 0);
 
+	if (irq_id < 0)
+		return irq_id;
+
 	err = hda_tegra_init_chip(chip, pdev);
 	if (err)
 		return err;
-- 
2.30.2

