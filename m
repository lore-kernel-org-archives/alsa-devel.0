Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A745C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 03:49:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A0CE9278;
	Thu, 20 Oct 2022 05:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A0CE9278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666237774;
	bh=8NyuWNdKFst7IG1YneetK5Xf4+tkKRAZlcKbuNYvrpw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=frivfMiBQsGqVXhnL7nxCqn6owrqKA0ih+Kews/qfPGUL11bA0hEg9Ezw6Phd2DVQ
	 gW/YjCpCtXGxcoVauvwozluGKxprBiCcUTlZB2sV2qoK7bR7YMPjWowEjbXyWadreU
	 ylb+Oww01XC9DmfG5UgEwq0hyrW1WFOUzYWrh2Nw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08031F8032B;
	Thu, 20 Oct 2022 05:48:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A01AF804E5; Thu, 20 Oct 2022 05:48:42 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F93CF800EC
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2022 05:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F93CF800EC
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtD3T61Flz1P78c;
 Thu, 20 Oct 2022 11:43:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 11:48:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 11:48:33 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH] ASOC: SOF: Intel: hda-codec: fix possible memory leak in
 hda_codec_device_init()
Date: Thu, 20 Oct 2022 11:47:52 +0800
Message-ID: <20221020034752.2392283-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Cc: cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com, tiwai@suse.de,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 yangyingliang@huawei.com
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

If snd_hdac_device_register() fails, 'codec' is leaked, free it
in snd_hdac_device_exit(). And device_initialize() is called in
snd_hdac_device_init(), it should call put_device() to give up
reference or the name allocated in dev_set_name() is leaked.
The snd_hdac_device_exit() will be called in dev->release().

Fixes: 829c67319806 ("ASoC: SOF: Intel: Introduce HDA codec init and exit routines")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/sof/intel/hda-codec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 1e9afc48394c..f8cbcc25154b 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -111,7 +111,11 @@ EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
 static void hda_codec_device_exit(struct device *dev)
 {
-	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+	struct hdac_device *hdac_dev = dev_to_hdac_dev(dev);
+	struct hda_codec *codec = container_of(hdac_dev, struct hda_codec, core);
+
+	snd_hdac_device_exit(hdac_dev);
+	kfree(codec);
 }
 
 static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
@@ -131,7 +135,7 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 	ret = snd_hdac_device_register(&codec->core);
 	if (ret) {
 		dev_err(bus->dev, "failed to register hdac device\n");
-		snd_hdac_device_exit(&codec->core);
+		put_device(&codec->core.dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.25.1

