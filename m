Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B94C0015E
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Jul 2023 09:14:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D771F820;
	Sat, 29 Jul 2023 11:13:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D771F820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690622058;
	bh=VJy3j+sNBMMTXL8vPpYD6Qz+QKtBQJRjHcPGqugzHaw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HOeOqB4yP1k1ifcWQLc/Rntsb+P6CEwmYIEYYn4fMDdKaiRiLHIa+b/32WCyRfB+9
	 AiQqGt/bEgeWJfz7hIk3pxfdhe6SWiRsXlCXq5wBZJZudlMRayNAIi3faQ0UwqFBId
	 dk5jVa3krvwt4bmI93XcDZRNvB5N++7NRgs+hkLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46ACCF80310; Sat, 29 Jul 2023 11:13:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91967F80520;
	Sat, 29 Jul 2023 11:13:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D00BF80310; Sat, 29 Jul 2023 11:12:51 +0200 (CEST)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0C9CF800D2
	for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2023 11:12:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0C9CF800D2
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.1943245|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0227548-0.000323795-0.976921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U3WkWdS_1690621946;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.U3WkWdS_1690621946)
          by smtp.aliyun-inc.com;
          Sat, 29 Jul 2023 17:12:29 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	wangweidong.a@awinic.com,
	shumingf@realtek.com,
	ryans.lee@analog.com,
	13916275206@139.com,
	herve.codina@bootlin.com,
	ckeepax@opensource.cirrus.com,
	doug@schmorgal.com,
	fido_max@inbox.ru,
	povik+lin@cutebit.org,
	liweilei@awinic.com,
	yijiangtao@awinic.com,
	colin.i.king@gmail.com,
	trix@redhat.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zhangjianming@awinic.com
Subject: [PATCH V3 0/5] ASoC: codecs: Add awinic AW88261 audio amplifier
 driver
Date: Sat, 29 Jul 2023 17:12:18 +0800
Message-ID: <20230729091223.193466-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IJ34EKV6GBYTJ4WWEGNC2ZHK5DOJUKGR
X-Message-ID-Hash: IJ34EKV6GBYTJ4WWEGNC2ZHK5DOJUKGR
X-MailFrom: wangweidong.a@awinic.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJ34EKV6GBYTJ4WWEGNC2ZHK5DOJUKGR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

The awinic AW88261 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier

v1 -> v2: Submit the yaml file as a separate patch file
          Modify word capitalization in the Kconfig file
          Delete unused macro definitions 

Weidong Wang (5):
  ASoC: dt-bindings: Add schema for "awinic,aw88261"
  ASoC: codecs: Add code for bin parsing compatible with aw88261
  ASoC: codecs: Add aw88261 amplifier driver
  ASoC: codecs: aw88261 device related operation functions
  ASoC: codecs: aw88261 chip register file, Kconfig and Makefile

 .../bindings/sound/awinic,aw88395.yaml        |   4 +-
 sound/soc/codecs/Kconfig                      |  15 +
 sound/soc/codecs/Makefile                     |   3 +
 sound/soc/codecs/aw88261/aw88261.c            | 517 +++++++++++
 sound/soc/codecs/aw88261/aw88261.h            |  52 ++
 sound/soc/codecs/aw88261/aw88261_device.c     | 877 ++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_device.h     |  79 ++
 sound/soc/codecs/aw88261/aw88261_reg.h        | 374 ++++++++
 sound/soc/codecs/aw88395/aw88395_lib.c        | 193 +++-
 sound/soc/codecs/aw88395/aw88395_reg.h        |   1 +
 10 files changed, 2097 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/aw88261/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h


base-commit: ffabf7c731765da3dbfaffa4ed58b51ae9c2e650
-- 
2.41.0

