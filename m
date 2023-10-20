Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BACDB474
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Oct 2023 08:36:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA10183B;
	Fri, 20 Oct 2023 10:35:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA10183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697790993;
	bh=NxzSpg7Z3h5ZMY3R6IkUDv+gf24Sp9HPcUmniAj7zM8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=p8tFU55N9jCu3KoEOlhNtMBnG5hN7sUA03PKk+6BsSdIgLAYalQ7wU6u+7LWvFovV
	 xF+MLIe9lNGT8cBatO85yjP8flEQG3JbdFsltjo1kDe9oqV1DLojprKzDHxH3NzOCg
	 6B+Mw8eaF73R/M8PF9TKAMVoseKOu3QPZZ3xhsI8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29E60F8032D; Fri, 20 Oct 2023 10:35:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FAE4F8027B;
	Fri, 20 Oct 2023 10:35:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BCB8F8025F; Fri, 20 Oct 2023 10:35:08 +0200 (CEST)
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com
 [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 15BBAF80236
	for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2023 10:34:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15BBAF80236
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.1840043|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00383916-7.02771e-05-0.996091;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V3YjlUW_1697790882;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.V3YjlUW_1697790882)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 16:34:50 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	shumingf@realtek.com,
	rf@opensource.cirrus.com,
	herve.codina@bootlin.com,
	ckeepax@opensource.cirrus.com,
	13916275206@139.com,
	ryans.lee@analog.com,
	linus.walleij@linaro.org,
	sebastian.reichel@collabora.com,
	ajye_huang@compal.corp-partner.google.com,
	harshit.m.mogalapalli@oracle.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	dan.carpenter@linaro.org,
	trix@redhat.com,
	liweilei@awinic.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 0/4] ASoC: codecs: Add aw88399 amplifier driver
Date: Fri, 20 Oct 2023 16:34:22 +0800
Message-ID: <20231020083426.302925-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FJO5WUKIZL5L55KBTHCJY4PLJGEPIZ2X
X-Message-ID-Hash: FJO5WUKIZL5L55KBTHCJY4PLJGEPIZ2X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FJO5WUKIZL5L55KBTHCJY4PLJGEPIZ2X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88399 property to the awinic,aw88395.yaml file.

Add i2c and amplifier registration for
aw88399 and their associated operation functions.

v1 -> v2: Modify the reset mode
          Delete AW88399_DSP_I2C_WRITES macros
           and related debugging statements
          Change the value of max_register in aw88399
          Change the value of max_register in aw88261
          Delete the judgment of unnecessary pointers
          Modify the judgment of the ret return value

Weidong Wang (4):
  ASoC: dt-bindings: Add schema for "awinic,aw88399"
  ASoC: codecs: Modify max_register usage error
  ASoC: codecs: Add code for bin parsing compatible with aw88399
  ASoC: codecs: Add aw88399 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88261.c                    |    2 +-
 sound/soc/codecs/aw88395/aw88395_lib.c        |    3 +
 sound/soc/codecs/aw88395/aw88395_reg.h        |    1 +
 sound/soc/codecs/aw88399.c                    | 1911 +++++++++++++++++
 sound/soc/codecs/aw88399.h                    |  599 ++++++
 8 files changed, 2532 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/aw88399.c
 create mode 100644 sound/soc/codecs/aw88399.h


base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
-- 
2.41.0

