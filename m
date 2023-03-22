Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73B3C6FD20
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 01:45:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63DDD3E8;
	Wed, 22 Mar 2023 02:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63DDD3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679449506;
	bh=IfFNrewpW+W4cofzuPUDqXC+4oJK2QcJanNS6hWPVpI=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iO05kZFiEoo9+eqKCZYSCtMXj2IzWZSO6qSGChUOzyxANpA9j2drzQ6VXBEMmzDKq
	 GbcE0wvLqubBjX+2afacITlkcMMAoDQq98rP0IcdKaLwwrdE+IXzbLWVVP2RhqulkO
	 SQITVDh9WQWkMVo5Goi0AWEv2aOY6xjz7gw2kPt8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0662F8027B;
	Wed, 22 Mar 2023 02:43:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2DC2F8027B; Wed, 22 Mar 2023 02:43:48 +0100 (CET)
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 38A57F80105
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2023 02:43:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38A57F80105
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VeOZfe3_1679449412;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VeOZfe3_1679449412)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 09:43:36 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lgirdwood@gmail.com
Subject: [PATCH] ASoC: tegra: remove unneeded semicolon
Date: Wed, 22 Mar 2023 09:43:30 +0800
Message-Id: <20230322014330.97079-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4WRNGJVGYQYXEICKND2KC4W5WFY5COES
X-Message-ID-Hash: 4WRNGJVGYQYXEICKND2KC4W5WFY5COES
X-MailFrom: jiapeng.chong@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: broonie@kernel.org, tiwai@suse.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, alsa-devel@alsa-project.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4WRNGJVGYQYXEICKND2KC4W5WFY5COES/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

./sound/soc/tegra/tegra_asoc_machine.c:206:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4583
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index c2aaa496468c..f5092b410926 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -203,7 +203,7 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 					  "nvidia,coupled-mic-hp-det")) {
 			tegra_machine_mic_jack_gpio.desc = machine->gpiod_hp_det;
 			tegra_machine_mic_jack_gpio.jack_status_check = coupled_mic_hp_check;
-		};
+		}
 
 		err = snd_soc_jack_add_gpios(&tegra_machine_mic_jack, 1,
 					     &tegra_machine_mic_jack_gpio);
-- 
2.20.1.7.g153144c

