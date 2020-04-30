Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C63CC28CBC
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B70020774
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JiCE1Oi/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG69HRKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B70020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6845516B0;
	Thu, 30 Apr 2020 16:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6845516B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588255418;
	bh=GYpa3dN/ceeAIktMDNq9xvzagqdZCbUIdjlAwEWSv98=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JiCE1Oi/A31/3c3mF0fJu7PCYXVca2w2e/44iQOEwcR0lSa07ElTlLwRCNih9dMy9
	 7ri2+fv3xU7iL7i+bMoJQZEbgmdRU2IPfRnp4/leKwIYvEb1mBGV1LvEP9rWnMe3S0
	 0BH9BNGK6mXpwqY7htwFwd1t5rm19a+Til12wFd8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9418DF8034D;
	Thu, 30 Apr 2020 15:52:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1B34F80360; Thu, 30 Apr 2020 15:52:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F86FF8034B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:52:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F86FF8034B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dG69HRKc"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5902C21775;
 Thu, 30 Apr 2020 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254744;
 bh=GYpa3dN/ceeAIktMDNq9xvzagqdZCbUIdjlAwEWSv98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dG69HRKc2HmS8Kkqmjw7XmEJjMiC4hMSKoWMOTKwOk9WCkdaGtmHWRgVQEll8ZxSp
 ntC9jsDy8QvrbLL7kIGnpg1dN+9XjaNAIS42AGWsNgvF35bsi1fL76KQO15xu1qXZB
 BJfVmccVU7uIY8U2iAfNbdTJgMDbwuHw9fddZUts=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/57] ASoC: topology: Check return value of
 soc_tplg_*_create
Date: Thu, 30 Apr 2020 09:51:25 -0400
Message-Id: <20200430135218.20372-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 2ae548f30d7f6973388fc3769bb3c2f6fd13652b ]

Functions soc_tplg_denum_create, soc_tplg_dmixer_create,
soc_tplg_dbytes_create can fail, so their return values should be
checked and error should be propagated.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-4-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c2901652a6d04..efe6ad3bfcd9b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1123,6 +1123,7 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_ctl_hdr *control_hdr;
+	int ret;
 	int i;
 
 	if (tplg->pass != SOC_TPLG_PASS_MIXER) {
@@ -1151,25 +1152,30 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 		case SND_SOC_TPLG_CTL_RANGE:
 		case SND_SOC_TPLG_DAPM_CTL_VOLSW:
 		case SND_SOC_TPLG_DAPM_CTL_PIN:
-			soc_tplg_dmixer_create(tplg, 1,
-					       le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_dmixer_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_ENUM:
 		case SND_SOC_TPLG_CTL_ENUM_VALUE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
-			soc_tplg_denum_create(tplg, 1,
-					      le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_denum_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_BYTES:
-			soc_tplg_dbytes_create(tplg, 1,
-					       le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_dbytes_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		default:
 			soc_bind_err(tplg, control_hdr, i);
 			return -EINVAL;
 		}
+		if (ret < 0) {
+			dev_err(tplg->dev, "ASoC: invalid control\n");
+			return ret;
+		}
+
 	}
 
 	return 0;
-- 
2.20.1

