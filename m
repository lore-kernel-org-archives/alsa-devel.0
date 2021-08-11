Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68AEC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 19:16:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EA660F21
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 19:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0EA660F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F2191AD2;
	Wed, 11 Aug 2021 21:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F2191AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628709379;
	bh=aFMKuXuG/+MNQVg3IMq9dt7JPaJpvcVshW2FYEnPy6U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q3kkQcrrrwg4eo+iC4SySX1VFsaYBgzp5XH52byI9KCdOUplF7yY4ae5LFL8uv/FY
	 QM3DreV9oOXVVL1jPG1z1QWGYcfCYY7PocL6ckMIPR4thr+qRKksiRechg0kVvAc1b
	 Iy15CjyMG43/r4AFnMwP2wa9UjyGuW/CLUvULYJQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E4C3F80516;
	Wed, 11 Aug 2021 21:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3BA5F804FA; Wed, 11 Aug 2021 21:12:54 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39F54F8020D
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 21:12:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39F54F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="askMvw6a"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9hd03013981; 
 Wed, 11 Aug 2021 14:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=j3tHuTWLhtwgNgrgfiPxjrp98XZO3yTo+WsWvrUQUtc=;
 b=askMvw6ap7oAzN738nRxcjStdN2efnPK3NSmh9qTBcLAav4yL952ESSCGK0DqGmcIHE1
 VnMfwktNpIZFqc+FPD/lKT1EmP8ROC9S/4qgw9Xc4ogR0wck8fkPyDFTBg/jGZ0vlHW7
 CE2qTpl1vT4FnufQe2irPtxMx4KXn7BWaq84grTKTq4H9KQxXA1bvgJwCknHYo/wbipV
 GtWpozMmBgfsUM381fAVKccRnhkogIUz3xFuXyDF1mXFCaYLuL6scFQ28ykbFRHZs1/y
 NJGogmCb99Rg6cJEnf/bxohU3W04gmOyjCRRLUT0zSbWacbakyoOGPeUlKhBkO/l3Am+ Zg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngpgw-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 11 Aug 2021 14:12:41 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Wed, 11 Aug 2021 19:57:32 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1CFDF2A9;
 Wed, 11 Aug 2021 18:57:32 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4 23/27] ALSA: hda/cs8409: Set fixed sample rate of 48kHz for
 CS42L42
Date: Wed, 11 Aug 2021 19:56:50 +0100
Message-ID: <20210811185654.6837-24-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: db_TbHUaQ3jZqfVzyzlYTCp9Kh9tp2Vb
X-Proofpoint-GUID: db_TbHUaQ3jZqfVzyzlYTCp9Kh9tp2Vb
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110132
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

CS42L42 is configured to use a fixed sample rate of 48kHz.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409-tables.c | 8 ++++++++
 sound/pci/hda/patch_cs8409.c        | 6 ++++++
 sound/pci/hda/patch_cs8409.h        | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index a39b2c20f61c..a9a0b8e3b2a9 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -45,6 +45,14 @@ const struct snd_kcontrol_new cs42l42_adc_volume_mixer = {
 			 HDA_INPUT, CS42L42_VOL_ADC) | HDA_AMP_VAL_MIN_MUTE
 };
 
+const struct hda_pcm_stream cs42l42_48k_pcm_analog_playback = {
+	.rates = SNDRV_PCM_RATE_48000, /* fixed rate */
+};
+
+const struct hda_pcm_stream cs42l42_48k_pcm_analog_capture = {
+	.rates = SNDRV_PCM_RATE_48000, /* fixed rate */
+};
+
 /******************************************************************************
  *                   BULLSEYE / WARLOCK / CYBORG Specific Arrays
  *                               CS8409/CS42L42
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index daf9c07d10c4..897c48140d8b 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -912,6 +912,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		/* Fix Sample Rate to 48kHz */
+		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
+		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
 		/* Set initial DMIC volume to -26 dB */
 		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
 					      HDA_INPUT, 0, 0xff, 0x19);
@@ -1105,6 +1108,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		/* Fix Sample Rate to 48kHz */
+		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
+		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
 		snd_hda_gen_add_kctl(&spec->gen, "Headphone Playback Volume",
 				     &cs42l42_dac_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, "Mic Capture Volume", &cs42l42_adc_volume_mixer);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 1b5a8d04ba0f..2208be2ffad1 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -335,6 +335,8 @@ int cs42l42_volume_info(struct snd_kcontrol *kctrl, struct snd_ctl_elem_info *ui
 int cs42l42_volume_get(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uctrl);
 int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uctrl);
 
+extern const struct hda_pcm_stream cs42l42_48k_pcm_analog_playback;
+extern const struct hda_pcm_stream cs42l42_48k_pcm_analog_capture;
 extern const struct snd_pci_quirk cs8409_fixup_tbl[];
 extern const struct hda_model_fixup cs8409_models[];
 extern const struct hda_fixup cs8409_fixups[];
-- 
2.25.1

