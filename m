Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83039C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 15:15:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A13B2AE9;
	Fri, 29 Apr 2022 17:14:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A13B2AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651245304;
	bh=vGI/iNrFn7TTDnTQWbfw411Jxz9StaA1hmo7FYHNf5o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZXUaPJQDAqGIA4ISssq3t1cymsvT9bGkVWS43KcjCVwez34VA1Ddy7cjnbj3F3OJw
	 5aDLN3+JJKbj25I3rpnudEcYFQkfd0MvuivPbOstQqpA+xdYrPDAN4ZMok+s7/ZGvX
	 tDvCUCqO5I6p56X3hcFSpjL2Aqzm37X63VsOSbqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CACEF80237;
	Fri, 29 Apr 2022 17:14:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEFF2F8025D; Fri, 29 Apr 2022 17:14:12 +0200 (CEST)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com
 [115.236.121.145])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 173F6F8016E
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 17:14:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 173F6F8016E
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C22A08002E3;
 Fri, 29 Apr 2022 23:13:56 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: hdmi-codec: Add option for ELD bypass
Date: Fri, 29 Apr 2022 23:13:38 +0800
Message-Id: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWRoaHklWTBpNHUtMQk
 pPQ01JVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Tyo*GT06LhcCIjg8DjUN
 N0wKFEhVSlVKTU5KSU9OSUhMSE5DVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0xPTTcG
X-HM-Tid: 0a8075e2c346b03akuuuc22a08002e3
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>,
 Maxime Ripard <maxime@cerno.tech>, Dmitry Osipenko <digetx@gmail.com>
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

This patch allow users to enable "ELD Bypass" who don't
care anything from EDID Link Data.

Currently, this driver gets ELD(from EDID) to constraint
channels and rates.

Unfortunately, EDID is not always valid, maybe caused by
the fragile HDMI port or cable, in this situation, the max
features are limited to 48kHz stereo.

So, add this option to allow user to select the manual way
to output audio as expected. such as multi-channels LPCM(7.1),
or HBR bitstream for these sink devices.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/codecs/hdmi-codec.c | 44 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b07607a..3b78aa8 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -275,6 +275,7 @@ struct hdmi_codec_priv {
 	unsigned int chmap_idx;
 	struct mutex lock;
 	bool busy;
+	bool eld_bypass;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 	u8 iec_status[AES_IEC958_STATUS_SIZE];
@@ -427,6 +428,44 @@ static int hdmi_codec_iec958_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hdmi_codec_eld_bypass_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+
+	return 0;
+}
+
+static int hdmi_codec_eld_bypass_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = hcp->eld_bypass;
+
+	return 0;
+}
+
+static int hdmi_codec_eld_bypass_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	hcp->eld_bypass = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+#define HDMI_CODEC_ELD_BYPASS_DECL(xname) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = hdmi_codec_eld_bypass_info, .get = hdmi_codec_eld_bypass_get, \
+	.put = hdmi_codec_eld_bypass_put, }
+
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -447,7 +486,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			goto err;
 	}
 
-	if (tx && hcp->hcd.ops->get_eld) {
+	if (tx && !hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		if (ret)
@@ -770,6 +809,7 @@ static struct snd_kcontrol_new hdmi_codec_controls[] = {
 		.info	= hdmi_eld_ctl_info,
 		.get	= hdmi_eld_ctl_get,
 	},
+	HDMI_CODEC_ELD_BYPASS_DECL("ELD Bypass"),
 };
 
 static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -854,7 +894,7 @@ static void plugged_cb(struct device *dev, bool plugged)
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
 
 	if (plugged) {
-		if (hcp->hcd.ops->get_eld) {
+		if (!hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 			hcp->hcd.ops->get_eld(dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		}
-- 
2.7.4

