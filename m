Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E22C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 14:33:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F64520809
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TvNREe4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F64520809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CBFE1850;
	Fri, 27 Nov 2020 15:33:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CBFE1850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606487631;
	bh=fgp+kGiRmFYC4wJgZNZwccHrUi1NMA7ni09p2C3G65A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TvNREe4jLO0CqtH+OUios+e9QWBPQf/+Xn0R/UNIQMOQEGS60xKN1yckJ+XyfhDg5
	 L6+/QNajSydhsR7HVdEkVLmeucxLuzibrSoEqHpRpSv7ZSMKj0kINaOM6qzhXlHMwd
	 D+zTu4b3SRQHjXJ1mfJt0IeF6X1OzAEGBT2iVIOw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1A87F80255;
	Fri, 27 Nov 2020 15:32:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 945F0F80218; Fri, 27 Nov 2020 15:32:09 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 128C8F800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 15:32:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 128C8F800EA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 28AF4ACA9;
 Fri, 27 Nov 2020 14:32:02 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: amd: Downgrade print level for invalid ACP mode
Date: Fri, 27 Nov 2020 15:31:58 +0100
Message-Id: <20201127143200.16272-2-tiwai@suse.de>
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

The acp3x raven driver skips the probing when the given device isn't
connected with I2S.  This skip behavior itself is fine, but the driver
also emits an error message "Invalid ACP audio mode" with KERN_ERR.
This isn't nice since it appears on the boot screen even if a boot
splash is running, although this itself is no real error.

Downgrade the print level to KERN_INFO so that this message won't
appear on the console unnecessarily.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=210359
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/raven/pci-acp3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 31b797c8bfe6..a7de4e607961 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -231,7 +231,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		}
 		break;
 	default:
-		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
+		dev_info(&pci->dev, "Invalid ACP audio mode : %d\n", val);
 		ret = -ENODEV;
 		goto disable_msi;
 	}
-- 
2.26.2

