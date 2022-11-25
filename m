Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE144C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 07:41:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16A861712;
	Fri, 25 Nov 2022 08:40:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16A861712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669362059;
	bh=8xedil928i2RmeJFOc+MNJES+LH7RIO/Mk8jTMAX5QY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VUYN6WRG9lRoSooYcBmLzA20SAoz/toulyb61Y5GmZGj4LR98abaFesGZ1dE5uyIP
	 PJ/FdnzoRQQ4/GynSfr8kBQX5LeImW4aAvQGMgBhY1263T700EJPs9EJG9pvcg2UC6
	 QoF2QejqzQzdm1GGd30MpKb75HC9l/2MZLu98p7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9936F800F4;
	Fri, 25 Nov 2022 08:40:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99F86F80236; Fri, 25 Nov 2022 08:40:06 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F178F800F4
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 08:40:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F178F800F4
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJRZf3c78z15Mrl;
 Fri, 25 Nov 2022 15:39:22 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 15:39:55 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 15:39:55 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH] ASoC: qcom: Fix build error if CONFIG_SOUNDWIRE=m
Date: Fri, 25 Nov 2022 15:44:58 +0800
Message-ID: <20221125074458.117347-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org
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

If CONFIG_SND_SOC_APQ8016_SBC=y || CONFIG_SND_SOC_MSM8996=y,
CONFIG_SND_SOC_QCOM_COMMON=y, CONFIG_SOUNDWIRE=m, building fails:

sound/soc/qcom/common.o: in function `qcom_snd_sdw_hw_free':
common.c:(.text+0x294): undefined reference to `sdw_disable_stream'
common.c:(.text+0x2a0): undefined reference to `sdw_deprepare_stream'
sound/soc/qcom/common.o: in function `qcom_snd_sdw_prepare':
common.c:(.text+0x314): undefined reference to `sdw_prepare_stream'
common.c:(.text+0x324): undefined reference to `sdw_enable_stream'
common.c:(.text+0x364): undefined reference to `sdw_disable_stream'
common.c:(.text+0x36c): undefined reference to `sdw_deprepare_stream'
common.c:(.text+0x3a8): undefined reference to `sdw_deprepare_stream'

Make SND_SOC_APQ8016_SBC,SND_SOC_MSM8996 depends on
'SOUNDWIRE || !SOUNDWIRE' to fix this.

Fixes: 3bd975f3ae0a ("ASoC: qcom: sm8250: move some code to common")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 sound/soc/qcom/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8c7398bc1ca8..f5f0b48d74af 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -58,6 +58,7 @@ config SND_SOC_STORM
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
+	depends on SOUNDWIRE || !SOUNDWIRE
 	select SND_SOC_LPASS_APQ8016
 	select SND_SOC_QCOM_COMMON
 	help
@@ -141,6 +142,7 @@ config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
 	depends on COMMON_CLK
+	depends on SOUNDWIRE || !SOUNDWIRE
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	help
-- 
2.25.1

