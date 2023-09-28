Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3ECE7B1A
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Sep 2023 10:59:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9781DF2;
	Thu, 28 Sep 2023 12:58:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9781DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695898757;
	bh=6d6vS59XD1mh2crea32SZ42FYBqQ+jBcxo9PpIQdXQg=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=d3ZGMfcmvRxepS5syCMDNAg12zs0u4ceaFjm5gBJMvEGgZZSF3QEcAKNHkI+o8ne2
	 n2Yp5qLc5VK2BAdztYgUUCORpkK/OSxink3abwPp3kQwNxT8J9TC+kt6z7bgcfR6PN
	 Xl5ltKqSxs5TCuTeMJFhLNS7/qHu1Bv3d52REJkc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69D11F80558; Thu, 28 Sep 2023 12:57:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A894F80290;
	Thu, 28 Sep 2023 12:57:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8592CF801D5; Thu, 28 Sep 2023 12:57:53 +0200 (CEST)
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com
 [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C6B1F80130
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 12:57:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C6B1F80130
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.07345675|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0406445-0.000234974-0.959121;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=30;RT=30;SR=0;TI=SMTPD_---.UqYH824_1695898649;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.UqYH824_1695898649)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 18:57:38 +0800
From: wangweidong.a@awinic.com
To: girdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	rf@opensource.cirrus.com,
	shumingf@realtek.com,
	herve.codina@bootlin.com,
	rdunlap@infradead.org,
	13916275206@139.com,
	ryans.lee@analog.com,
	linus.walleij@linaro.org,
	ckeepax@opensource.cirrus.com,
	doug@schmorgal.com,
	ajye_huang@compal.corp-partner.google.com,
	harshit.m.mogalapalli@oracle.com,
	arnd@arndb.de,
	yang.lee@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	liweilei@awinic.com,
	yijiangtao@awinic.com,
	trix@redhat.com,
	dan.carpenter@linaro.org,
	colin.i.king@gmail.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 00/10] ASoC: codecs: Add aw87390 amplifier driver
Date: Thu, 28 Sep 2023 18:57:17 +0800
Message-ID: <20230928105727.47273-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LGG4RYIBYBUZVA3DMWCSI6A4VFYUKT22
X-Message-ID-Hash: LGG4RYIBYBUZVA3DMWCSI6A4VFYUKT22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGG4RYIBYBUZVA3DMWCSI6A4VFYUKT22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

The awinic aw87390 is a new high efficiency, low noise,
constant large volume, 6th Smart K audio amplifier.

Add a DT schema for describing awinic aw87390 audio amplifiers.
They are controlled using I2C.

Modify some code for aw88261 and aw88395

v5 -> v6: Adjust the order and context of the patch
          Use "len-1" as a loop judgment modifier
          Use return 0 instead of return ret at the end of a function
          Use dev_dbg instead of dev_info
          Use struct_size to calculate the structure size
          Remove the space before the exclamation mark

Weidong Wang (10):
  ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA
    support
  ASoC: dt-bindings: Add schema for "awinic,aw87390"
  ASoC: codecs: Remove the "fade-enable property"
  ASoC: codecs: Rename "sound-channel" to "awinic,audio-channel"
  ASoC: codecs: Modify the transmission method of parameters
  ASoC: codecs: Modify i2c driver name
  ASoC: codecs: Add code for bin parsing compatible with aw87390
  ASoC: codecs: Rename "sync-flag" to "awinic,sync-flag"
  ASoC: codecs: Modify the transmission mode of function parameters
  ASoC: codecs: Add aw87390 amplifier driver

 .../bindings/sound/awinic,aw87390.yaml        |  58 +++
 .../bindings/sound/awinic,aw88395.yaml        |  16 +
 sound/soc/codecs/Kconfig                      |  15 +-
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/aw87390.c                    | 463 ++++++++++++++++++
 sound/soc/codecs/aw87390.h                    |  85 ++++
 sound/soc/codecs/aw88261.c                    |  27 +-
 sound/soc/codecs/aw88261.h                    |   4 +-
 sound/soc/codecs/aw88395/aw88395.c            |   9 +-
 sound/soc/codecs/aw88395/aw88395.h            |   2 +-
 sound/soc/codecs/aw88395/aw88395_device.c     |  47 +-
 sound/soc/codecs/aw88395/aw88395_device.h     |   6 +-
 sound/soc/codecs/aw88395/aw88395_lib.c        |  25 +-
 sound/soc/codecs/aw88395/aw88395_reg.h        |   1 +
 14 files changed, 686 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
 create mode 100644 sound/soc/codecs/aw87390.c
 create mode 100644 sound/soc/codecs/aw87390.h


base-commit: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
-- 
2.41.0

