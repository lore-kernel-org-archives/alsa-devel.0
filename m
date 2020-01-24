Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C6C3F68F
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:23:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C2224125
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qdoegvq1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQF6eejB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C2224125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E85716A2;
	Fri, 24 Jan 2020 15:22:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E85716A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579875785;
	bh=dYDd6Kf8+KUg6HA9fynIXfkeFRIfKxvaEcrqpxHRFKk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdoegvq12MBa4UyyftCOK54EILEzukkGQhmidJN83xVjl74NRi0yNNVBdNqLsYKVX
	 wosXjvV6eskBPZcTQL16bltGxvWrM6U3lUfwrMxSBE5IwOb0oYwfVTIDP75vschJUA
	 Yc3Sj+a+K3Ry4/8gpDmyWiDHzkWgtvFLxSkEFHHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99068F80292;
	Fri, 24 Jan 2020 15:19:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 438D9F8028E; Fri, 24 Jan 2020 15:19:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6F85F80278
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 15:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6F85F80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DQF6eejB"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C2E120838;
 Fri, 24 Jan 2020 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579875559;
 bh=VliAeT8Po/eV+MTczlUWIup6JgY6fmjh0jhjULFIku0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DQF6eejBL21HMrBLloIcOE1RUwIudjS34LONfAivMIRtCwrLVEtcikKflKJmvf/0T
 lDVPwERfhVH6ZqoI3ymU4AXs0kJQU+Z6m5HPlOvewRDE6a2PCnDk2j4sYVO/eC6xyp
 umSkp1NzdD23pvsxdHbX1zCK051pF/MHBv07kXVI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 24 Jan 2020 09:17:23 -0500
Message-Id: <20200124141817.28793-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH AUTOSEL 5.4 053/107] ASoC: SOF: Intel: fix HDA
	codec driver probe with multiple controllers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 2c63bea714780f8e1fc9cb7bc10deda26fada25b ]

In case system has multiple HDA controllers, it can happen that
same HDA codec driver is used for codecs of multiple controllers.
In this case, SOF may fail to probe the HDA driver and SOF
initialization fails.

SOF HDA code currently relies that a call to request_module() will
also run device matching logic to attach driver to the codec instance.
However if driver for another HDA controller was already loaded and it
already loaded the HDA codec driver, this breaks current logic in SOF.
In this case the request_module() SOF does becomes a no-op and HDA
Codec driver is not attached to the codec instance sitting on the HDA
bus SOF is controlling. Typical scenario would be a system with both
external and internal GPUs, with driver of the external GPU loaded
first.

Fix this by adding similar logic as is used in legacy HDA driver
where an explicit device_attach() call is done after request_module().

Also add logic to propagate errors reported by device_attach() back
to caller. This also works in the case where drivers are not built
as modules.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200110235751.3404-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 3ca6795a89ba3..9e8233c10d860 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -24,19 +24,18 @@
 #define IDISP_VID_INTEL	0x80860000
 
 /* load the legacy HDA codec driver */
-#ifdef MODULE
-static void hda_codec_load_module(struct hda_codec *codec)
+static int hda_codec_load_module(struct hda_codec *codec)
 {
+#ifdef MODULE
 	char alias[MODULE_NAME_LEN];
 	const char *module = alias;
 
 	snd_hdac_codec_modalias(&codec->core, alias, sizeof(alias));
 	dev_dbg(&codec->core.dev, "loading codec module: %s\n", module);
 	request_module(module);
-}
-#else
-static void hda_codec_load_module(struct hda_codec *codec) {}
 #endif
+	return device_attach(hda_codec_dev(codec));
+}
 
 /* enable controller wake up event for all codecs with jack connectors */
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
@@ -116,10 +115,16 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	/* use legacy bus only for HDA codecs, idisp uses ext bus */
 	if ((resp & 0xFFFF0000) != IDISP_VID_INTEL) {
 		hdev->type = HDA_DEV_LEGACY;
-		hda_codec_load_module(&hda_priv->codec);
+		ret = hda_codec_load_module(&hda_priv->codec);
+		/*
+		 * handle ret==0 (no driver bound) as an error, but pass
+		 * other return codes without modification
+		 */
+		if (ret == 0)
+			ret = -ENOENT;
 	}
 
-	return 0;
+	return ret;
 #else
 	hdev = devm_kzalloc(sdev->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
