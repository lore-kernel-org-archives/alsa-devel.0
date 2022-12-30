Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20364C4167B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Dec 2022 09:36:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D0C172A;
	Fri, 30 Dec 2022 10:35:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D0C172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672392972;
	bh=qhkQ47hb70UZeHlvM6cBn7xtvlrwkZzsy/YaIws3y60=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HOtBiPznK6TTBpnZfSRZnSzK0QP3rYrv8bXMqe5C898EV9z/Pm3260jT/fBtiB9vC
	 Zwcrxe5A36W4//viL62YDPuD4ALq8MHEPDMSvyEQIcWWOm4duQ5zf/FE5mGvOt3iqb
	 fjxfptHBBNFq4X/7FSBcNRWFkZx1vrS3/VLQez8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B15DF8049E;
	Fri, 30 Dec 2022 10:35:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B060F8042F; Fri, 30 Dec 2022 10:35:20 +0100 (CET)
Received: from out29-7.mail.aliyun.com (out29-7.mail.aliyun.com [115.124.29.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BEA9F80424
 for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2022 10:35:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BEA9F80424
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09643909|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00387715-6.27374e-05-0.99606;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047192; MF=wangweidong.a@awinic.com; NM=1;
 PH=DS; RN=27; RT=27; SR=0; TI=SMTPD_---.Qh0QfiN_1672392896; 
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.Qh0QfiN_1672392896) by smtp.aliyun-inc.com;
 Fri, 30 Dec 2022 17:35:04 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
 ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
 povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
 james.schulman@cirrus.com, flatmax@flatmax.com, cezary.rojewski@intel.com,
 srinivas.kandagatla@linaro.org, tanureal@opensource.cirrus.com,
 steve@sk2.org, stephan@gerhold.net, zhuning0077@gmail.com,
 shumingf@realtek.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangweidong.a@awinic.com
Subject: [PATCH V8 0/5] ASoC: codecs: Add Awinic AW883XX audio amplifier driver
Date: Fri, 30 Dec 2022 17:34:49 +0800
Message-Id: <20221230093454.190579-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: yijiangtao@awinic.com, duanyibo@awinic.com, zhaolei@awinic.com,
 liweilei@awinic.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

The Awinic AW883XX is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
controlled using I2C

v7 -> v8: Delete retry for double loops Enable PA
          Delete useless initialization and use reverse x-mas tree style
          Add Spaces in comments
          Modify aw883xx_switch_set function
          Delete our own workqueue, use a default one
          Change variable name
          Modifying function name
          Use dev_ replace pr_ function
          Use define replace number
          Modify the compatible of the awinic,aw883xx.yaml file

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw883xx and their
    associated operation functions
  ASoC: codecs: Aw883xx function for ACF file parse and check
  ASoC: codecs: Aw883xx common function for ALSA Audio Driver
  ASoC: codecs: Aw883xx chip register file, data type file and Kconfig
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw883xx"

 .../bindings/sound/awinic,aw883xx.yaml        |   49 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    6 +
 sound/soc/codecs/aw883xx/aw883xx.c            |  667 ++++++
 sound/soc/codecs/aw883xx/aw883xx.h            |   59 +
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c  | 1067 ++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h  |   92 +
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  |  143 ++
 sound/soc/codecs/aw883xx/aw883xx_device.c     | 1790 +++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h     |  198 ++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h |  384 ++++
 11 files changed, 4465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h


base-commit: bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a
-- 
2.38.1

