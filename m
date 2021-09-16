Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD11C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:21:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D3B6113E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7D3B6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 887A518CC;
	Thu, 16 Sep 2021 17:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 887A518CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805683;
	bh=7ND8+x5ohSVv865HcZjPNRfhInmEqN3znp6iMFLRZzo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/PSoeq7CXU09W1PU5kkVPQ/X90KE4z+DUm7FMNw+FVrRyjXbgrV6ZBRo74yfxCKK
	 ZwPbwKqnyqslOawRR0sc0j34mBw9oMRCSi2hSLXJPLDaiMmaDnvW8Vbu+r5ScaLNcE
	 zkAvmymxJcvT3pdjl7TT3n/nV/pGzy3mNZJu5hug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AC71F804CA;
	Thu, 16 Sep 2021 17:19:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DCD7F804ED; Thu, 16 Sep 2021 17:19:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 374FEF804E2
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 374FEF804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Mo+KgcMz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35F0861246;
 Thu, 16 Sep 2021 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805539;
 bh=7ND8+x5ohSVv865HcZjPNRfhInmEqN3znp6iMFLRZzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mo+KgcMzwS/LhpKhiQCaoxvxv2uxhpJycIcLPm7EkKwyF009+hMgpAclUMwZp+/bS
 WDpCceVlknI945ompauv/XPLFGJZ8KbbctHEfir8oFnOlSexVPqB3Qnpy/c26g2OIK
 vbR+e0fACIkAW2lZ1LIdNSQs85r2TP2DzYGGLc6AueBICN3mNnjdCqjYiSD9y9Fx+R
 oykNxv6aw8MnXWnF1BtHFuNOpsBiV7M1XFUXmJe9TI0xcvqGmsCCtth2W7n6Ctn4JZ
 4/HywtuCsfzgeIB08QLpuEzyoWJ8g+RK1lAB3/dHi/+vsSrCtnAc1DKVtUXAI71amx
 NKVLTHcmcfV+g==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 4/6] ASoC: adau17x1: Update to modern clocking terminology
Date: Thu, 16 Sep 2021 16:18:04 +0100
Message-Id: <20210916151806.20756-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916151806.20756-1-broonie@kernel.org>
References: <20210916151806.20756-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; h=from:subject;
 bh=7ND8+x5ohSVv865HcZjPNRfhInmEqN3znp6iMFLRZzo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ1+qTlVGaM86FSVIWJi/QOpu9/4c/iemRtjFZ9h6
 CA+L0VmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNfqgAKCRAk1otyXVSH0OciB/
 9Imfey9ng7taRlCbz36xMCyurLzZH5M++qlUaglYQwQMBpf0yOFHRD/mBZBiAKlxxliGQFHtikJ/1H
 Wcfb1N3f5ldivGgaDrLLHmaCcOYCSB28PDT69LrGMB/JWydF3mar53BQxxgIv90Ug17vy2TvPIEw6L
 C6RLzMaFISwfyaMbF8aJzDhWiCgXXXNMgjEm/KTQY01LbRKx0VrMzf2/DNDYE4NYN+QBKEWytvf7pP
 O1rLega+ExI7uoY8YNjYiIGkIGpCaJYxoM7V6Vr2pZsUXWeNueiA0B7dDfFV8JL+VIvJFjMGCgdkkI
 UOWDYXNeq0C/y9+2xKY2iOJ3qOppJ8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

As part of moving to remove the old style defines for the bus clocks update
the adau17x1 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 8aae7ab74091..af05463af4ac 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -556,12 +556,12 @@ static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 	unsigned int ctrl0_mask;
 	int lrclk_pol;
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		ctrl0 = ADAU17X1_SERIAL_PORT0_MASTER;
 		adau->master = true;
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBC_CFC:
 		ctrl0 = 0;
 		adau->master = false;
 		break;
-- 
2.20.1

