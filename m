Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A3C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 14:33:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2984920B1F
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BzBk6dSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2984920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F177184E;
	Fri, 27 Nov 2020 15:33:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F177184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606487636;
	bh=iY+fS0KlEYPhvSiNadg+TsiOgXDmX4r04qS0uT0I8oA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzBk6dSHImEdEeWEiKZ1ft48sX4lDJiLKsKH52JK2I3OiMSgddkB92x+xGwpb4Ep/
	 pajN/vaZE/BkBmnDw1Y7eEN3nZmGjuzW8KcexjJFDr6DOfkdbf1VZy//Y7VC7rC8Yn
	 7i5DnbnauT6+wc1v5JgRqeo1JKbgV6S6ImbkXGOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A774F80269;
	Fri, 27 Nov 2020 15:32:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 255BBF802C4; Fri, 27 Nov 2020 15:32:13 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 975A8F8019D
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 15:32:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 975A8F8019D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3794DAE42;
 Fri, 27 Nov 2020 14:32:02 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: amd: Return -ENODEV for non-existing ACPI call
Date: Fri, 27 Nov 2020 15:31:59 +0100
Message-Id: <20201127143200.16272-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201127143200.16272-1-tiwai@suse.de>
References: <20201127143200.16272-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 alsa-devel@alsa-project.org, Akshu Agrawal <akshu.agrawal@amd.com>
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

AMD Renoir driver tries to identify the presence of DMIC by evaluating
ACPI _WOV entry, and it returns -EINVAL when the ACPI call failed.
This ended up an error message like
  snd_rn_pci_acp3x: probe of 0000:04:00.5 failed with error -22
although the system is correctly set up.

For avoiding such a superfluous error message, change the return value
to -ENODEV.  Then the driver core just skips to the next one without
complaining.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=210359
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index b943e59fc302..877350f38a68 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -224,7 +224,7 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 		handle = ACPI_HANDLE(&pci->dev);
 		ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
 		if (ACPI_FAILURE(ret)) {
-			ret = -EINVAL;
+			ret = -ENODEV;
 			goto de_init;
 		}
 		if (!dmic_status) {
-- 
2.26.2

