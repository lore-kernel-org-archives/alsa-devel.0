Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA21C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Dec 2022 12:24:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F072718B9;
	Thu,  8 Dec 2022 13:23:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F072718B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670502270;
	bh=2dULZU/qeUJpwL5NnRCgAyaTQYVH2ReBd+MWvJAQxHo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gKtuogJ64bEBxVupHez+onWrhcI4nhvtJOIVasLu8FKeq9+D/5Y6koFnOXWRhRVLO
	 etB/hnqr9EjrrDOoDz4iB8IEuzxrK0W+wD2x365qSkhHrmNot/Lb6e38tPD6UUKkU9
	 f0uxas8Va2BeDgTUTH7A7wLCsiHIpKIIZ+BfSMmA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B019F804AC;
	Thu,  8 Dec 2022 13:23:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DEBCF804D8; Thu,  8 Dec 2022 13:23:37 +0100 (CET)
Received: from out29-105.mail.aliyun.com (out29-105.mail.aliyun.com
 [115.124.29.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E2FAF80089
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2022 13:23:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E2FAF80089
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08798826|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00331091-5.90007e-05-0.99663;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047212; MF=wangweidong.a@awinic.com; NM=0;
 PH=DS; RN=17; RT=17; SR=0; TI=SMTPD_---.QRKcQkM_1670502196; 
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.QRKcQkM_1670502196) by smtp.aliyun-inc.com;
 Thu, 08 Dec 2022 20:23:23 +0800
From: wangweidong.a@awinic.com
To: broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
 tiwai@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
 quic_potturu@quicinc.com, pierre-louis.bossart@linux.intel.com,
 cy_huang@richtek.com
Subject: [PATCH V6 0/5] ASoC: codecs: Add Awinic AW883XX audio amplifier driver
Date: Thu,  8 Dec 2022 20:23:08 +0800
Message-Id: <20221208122313.55118-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: duanyibo@awinic.com, Weidong Wang <wangweidong.a@awinic.com>,
 zhaolei@awinic.com, liweilei@awinic.com, yijiangtao@awinic.com,
 zhangjianming@awinic.com
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

From: Weidong Wang <wangweidong.a@awinic.com>

The Awinic AW883XX is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
controlled using I2C.

v5 -> v6: Modify the return value of Kcontrol
          Delete error prints in Kcontrol  
          Delete the aw883xx_dynamic_create_controls function
          Release firmware immediately after memcpy()
          Change the names of the Widget's input and output
          Delete the alloc and copy for aw_wiget
          Delete all debug nodes and use regmap's debugfs
          Use be32_to_cpup instead of custom macros
          Change inefficient writing
          Verify the size of the bin file
          Changing the function name
          Register directly with the snd_soc_register_component function
          Delete the aw_dev_reg_dump function

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw883xx and their
    associated operation functions
  ASoC: codecs: Implementation of aw883xx configuration file parsing
    function
  ASoC: codecs: aw883xx chip control logic, such as power on and off
  ASoC: codecs: Configure aw883xx chip register as well as Kconfig and
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw883xx"

 .../bindings/sound/awinic,aw883xx.yaml        |   49 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    7 +
 sound/soc/codecs/aw883xx/aw883xx.c            |  909 +++++++
 sound/soc/codecs/aw883xx/aw883xx.h            |   81 +
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c  | 1324 ++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h  |  149 ++
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  |  146 ++
 sound/soc/codecs/aw883xx/aw883xx_device.c     | 1613 ++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h     |  537 ++++
 sound/soc/codecs/aw883xx/aw883xx_init.c       |  615 +++++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h | 2300 +++++++++++++++++
 12 files changed, 7740 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_init.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h


base-commit: 479174d402bcf60789106eedc4def3957c060bad
-- 
2.38.1

