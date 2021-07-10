Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D11AC11F6B
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:42:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23556124C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23556124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 892E8169E;
	Sat, 10 Jul 2021 04:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 892E8169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884959;
	bh=7bQyvyrIOLxHq3iMmmb+Sew8OPmdn8AHueo5G5Hq3gI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nY8LhabWRWZ3jb3HIL3EjSPZ1quWAWz5RHhOWU3rgP7R4ictdGnbLdViww8vnfM1N
	 OzFL0o+69K2J5QtjwCR3Tc1NB4g16epJ5K3jUNc6adYOa0NwKWy4fcGVWllTXRqmmz
	 HqysObRQtIxe1ct1KFuLrtq4Db/uPIkpiqEVN9/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B771DF80619;
	Sat, 10 Jul 2021 04:27:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08E0FF80615; Sat, 10 Jul 2021 04:26:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4D35F80608
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4D35F80608
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J/8HuMnz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A249161402;
 Sat, 10 Jul 2021 02:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884011;
 bh=7bQyvyrIOLxHq3iMmmb+Sew8OPmdn8AHueo5G5Hq3gI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J/8HuMnzjR5x4Zc4tvL7D2tfHx6fdJOB7ZaSYQG7vRoIHDiOWkkJzqd2qdG79GtX/
 nUCmsugrRoTuymXUAAbjbuPE0Q/Yrulv8NVTdVfwrBt+lT4/KX9wpGPiTVJi0Wg9ty
 n7CHpiiOiPEAybDaeMvlQp51rMETo/L52p81sbk/j++fIB1l4ba+EmIMdfl+XRoAY7
 B43h5osVxu7yg2cjUVoYMq1cFsp/SW2tjnFDdusoAg9d7o8cDyvbuI/hnjSiTxY7M3
 BvRxnsymgRnH+JI21pO69f4bRI3Y0GYEk59iOELZB5IyRormRGmpPz240mqY0AH9Fh
 fVjKbmi5DMObg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 83/93] ALSA: hda: Add IRQ check for
 platform_get_irq()
Date: Fri,  9 Jul 2021 22:24:17 -0400
Message-Id: <20210710022428.3169839-83-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
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
index 361cf2041911..07787698b973 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -302,6 +302,9 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
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

