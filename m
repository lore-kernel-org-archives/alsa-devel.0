Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA341C4321E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 13:21:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11F8516E3;
	Wed, 25 May 2022 15:20:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11F8516E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653484908;
	bh=D9kSCjHK5fzcVjEGYXVbDTo3WKeyBSEp0Zdkksuqj0I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gtzFhRCXIo0YVFwESoV5TJYIb4TOadsr8Rt3rpbVF0h92G1Hu0d7D6uKRjw2CSur0
	 ZsIXr1WNBJXOJ7IR9PxwjqaeuPATLvU+sKa2IlTgz65a4B87HkPfqSF/Jiq6K2lYx2
	 wI999TSU6/Hw67192o/XdsAgRqPAh9WYA0dKAI5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 384C2F805A9;
	Wed, 25 May 2022 15:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 091BBF8054A; Wed, 25 May 2022 15:17:07 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF247F80169
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2022 15:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF247F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="nt9dKgx/"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P7Sjcr031231;
 Wed, 25 May 2022 08:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=i1KBfpmWq85BkKRplVpoCF4sGjk4Y2NdJNchd02pEJA=;
 b=nt9dKgx/6wwZD/E6yEuUvionppErET5wgK0O3dDPSIKMW34I4kjP8HuTJbYGeKuQrIR3
 NuFyL/n9gixEb+TLFWOZMXTc4WqDuhD4unQ/Spw5GeBgFHy4X/ZKZ05CRXfvVwMv1nZg
 WVmPiQTZOBaGDMbelhxhtQfTsnoXjuhYgk5/NXTCPRi7z9I9MSar95qFW8gWGClTLl29
 2qA2zzRA3nTNqOBoPmomdmk1TEi7uH1dL1Q3m8hZid0Un/uOF0AF6hNsFlHn7FzTf8GU
 TuQKr7QGJBbGzV8NqoFE42hXtoke3ugLLUjGDZwVc3iR7UHk81zpsYvxGWyqtNnyvj7I og== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u20web-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 May 2022 08:16:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 14:16:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Wed, 25 May 2022 14:16:45 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.233])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 13BE046C;
 Wed, 25 May 2022 13:16:45 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark
 Brown <broonie@kernel.org>
Subject: [PATCH v4 14/17] ALSA: hda: hda_cs_dsp_ctl: Add fw id strings
Date: Wed, 25 May 2022 14:16:35 +0100
Message-ID: <20220525131638.5512-15-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4svRktvXs-WOUTjLWTNw70CPr-v42idL
X-Proofpoint-GUID: 4svRktvXs-WOUTjLWTNw70CPr-v42idL
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
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

From: Stefan Binding <sbinding@opensource.cirrus.com>

This will be used to define the firmware names.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes since v2:
 - No change
 
 sound/pci/hda/hda_cs_dsp_ctl.c | 8 ++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 3b837d000a00..4cf5f7c2e267 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -30,6 +30,14 @@ static const char * const hda_cs_dsp_fw_text[HDA_CS_DSP_NUM_FW] = {
 	[HDA_CS_DSP_FW_MISC] =     "Misc",
 };
 
+const char * const hda_cs_dsp_fw_ids[HDA_CS_DSP_NUM_FW] = {
+	[HDA_CS_DSP_FW_SPK_PROT] = "spk-prot",
+	[HDA_CS_DSP_FW_SPK_CALI] = "spk-cali",
+	[HDA_CS_DSP_FW_SPK_DIAG] = "spk-diag",
+	[HDA_CS_DSP_FW_MISC] =     "misc",
+};
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_fw_ids, SND_HDA_CS_DSP_CONTROLS);
+
 static inline struct hda_cs_dsp_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
 {
 	return container_of(ext, struct hda_cs_dsp_coeff_ctl, bytes_ext);
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index 65b9c5c68957..265d8024eec9 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -27,6 +27,8 @@ struct hda_cs_dsp_ctl_info {
 	const char *amp_name;
 };
 
+extern const char * const hda_cs_dsp_fw_ids[HDA_CS_DSP_NUM_FW];
+
 int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
 int hda_cs_dsp_remove_kcontrol(struct snd_card *card, const char *name);
-- 
2.34.1

