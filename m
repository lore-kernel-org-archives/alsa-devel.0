Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E580C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:34:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF4620828
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lbf66gwj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFUy24Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF4620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4710A166C;
	Tue, 10 Dec 2019 23:33:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4710A166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576017250;
	bh=GnQNAVMnZEGUb+qWG8+izJnLaezxbQSaJW8HyaiJBoI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbf66gwjueRP8x+5LqbullamU4ncduP1yebIXOZKjiuLdz59VsBn1VsM4Ttzmef7G
	 iz2NXnLiwfzcQ1g7p0pr28cxfqD61cBiEL4gt8pJa2O1IljzXtFuhGECPxYob5JXxz
	 tM8i7y8mJoNJ/YJ2ye1xoY7QN2YPCJAKxFXskZP0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCF3DF80255;
	Tue, 10 Dec 2019 23:32:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 183F5F80256; Tue, 10 Dec 2019 23:32:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A961F80255
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 23:31:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A961F80255
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cFUy24Lw"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB78F206EC;
 Tue, 10 Dec 2019 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576017117;
 bh=MvssEjwJnh3VVajzPGoLHSWU+szWHgDoAPcp1b0ZPVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cFUy24LwWYw1aeHbDzu9J/pypcUIkMD4OhjW+eDWhngXgJGZUa5oEcuyL2nw6LtJO
 hfhrU9BvX3CPEnZFQw899zr/LN0a0WAtWEGAb0QKChth/uLiB47x3NnCWmW+8kStDL
 nW1zH15TbakuWA45oRLmDWFPz1l2q1W1OEWL6IKA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Tue, 10 Dec 2019 17:30:13 -0500
Message-Id: <20191210223035.14270-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Ben Zhang <benzh@chromium.org>,
 Curtis Malainey <cujomalainey@chromium.org>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH AUTOSEL 4.9 69/91] ASoC: rt5677: Mark reg
	RT5677_PWR_ANLG2 as volatile
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ben Zhang <benzh@chromium.org>

[ Upstream commit eabf424f7b60246c76dcb0ea6f1e83ef9abbeaa6 ]

The codec dies when RT5677_PWR_ANLG2(MX-64h) is set to 0xACE1
while it's streaming audio over SPI. The DSP firmware turns
on PLL2 (MX-64 bit 8) when SPI streaming starts.  However regmap
does not believe that register can change by itself. When
BST1 (bit 15) is turned on with regmap_update_bits(), it doesn't
read the register first before write, so PLL2 power bit is
cleared by accident.

Marking MX-64h as volatile in regmap solved the issue.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Link: https://lore.kernel.org/r/20191106011335.223061-6-cujomalainey@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 65ac4518ad060..49ab26e69f2fc 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -305,6 +305,7 @@ static bool rt5677_volatile_register(struct device *dev, unsigned int reg)
 	case RT5677_I2C_MASTER_CTRL7:
 	case RT5677_I2C_MASTER_CTRL8:
 	case RT5677_HAP_GENE_CTRL2:
+	case RT5677_PWR_ANLG2: /* Modified by DSP firmware */
 	case RT5677_PWR_DSP_ST:
 	case RT5677_PRIV_DATA:
 	case RT5677_ASRC_22:
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
