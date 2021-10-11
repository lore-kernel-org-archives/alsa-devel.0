Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A8C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 14:47:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5272460551
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 14:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5272460551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 563901666;
	Mon, 11 Oct 2021 16:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 563901666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633963667;
	bh=+9fXIIwtliU9pVAuGAsjMDtrgvzQBj2iIzOaoM2HHj8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MeDrG7vuMUaSmcJ3hevepAenlMUfPFlyHMRRknWxc7roxmTr3v8YFgWZ8AHyAxhaj
	 4VxpFJQPPFJWhj1u7qnZFkS0P76S1NL3vcnyxwV7oWrG+M8d4hBwDyT4H1H9WiQ0xR
	 aG44h741OWvJlwTWkUBfTV4nMljrGWnDSVF+sHFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D56CAF8025B;
	Mon, 11 Oct 2021 16:46:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C66BCF80269; Mon, 11 Oct 2021 16:46:55 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 316C0F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 16:46:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 316C0F8016D
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="225661434"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="225661434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 07:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; d="scan'208";a="479880865"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.40.144])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 07:45:09 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, jack.yu@realtek.com,
 oder_chiou@realtek.com
Subject: [PATCH v3] ASoC: rt1011: Fix 'I2S Reference' enum control caused error
Date: Mon, 11 Oct 2021 17:45:18 +0300
Message-Id: <20211011144518.2518-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 seppo.ingalsuo@linux.intel.com
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

Access to 'I2S Reference' enum causes alsamixer to fail to load:
$ alsamixer
cannot load mixer controls: Invalid argument

cml_rt1011_rt5682 cml_rt1011_rt5682: control 2:0:0:TL I2S Reference:0: access overflow

The reason is that the original patch adding the code was using
ucontrol->value.integer.value[0]
instead the correct
ucontrol->value.enumerated.item[0]

for an ENUM control.

Fixes: 87f40af26c262 ("ASoC: rt1011: add i2s reference control for rt1011")
Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

Changes since v2:
- Fix typo in commit message s/Is@/I2S

Changes since v1:
- Correct the ENUM declaration as well

Regards,
Peter
 sound/soc/codecs/rt1011.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 508597866dff..bdfcbb81fa19 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1311,12 +1311,11 @@ static int rt1011_r0_load_info(struct snd_kcontrol *kcontrol,
 	.put = rt1011_r0_load_mode_put \
 }
 
-static const char * const rt1011_i2s_ref[] = {
+static const char * const rt1011_i2s_ref_texts[] = {
 	"None", "Left Channel", "Right Channel"
 };
 
-static SOC_ENUM_SINGLE_DECL(rt1011_i2s_ref_enum, 0, 0,
-	rt1011_i2s_ref);
+static SOC_ENUM_SINGLE_EXT_DECL(rt1011_i2s_ref_enum, rt1011_i2s_ref_texts);
 
 static int rt1011_i2s_ref_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
@@ -1325,7 +1324,7 @@ static int rt1011_i2s_ref_put(struct snd_kcontrol *kcontrol,
 		snd_soc_kcontrol_component(kcontrol);
 	struct rt1011_priv *rt1011 =
 		snd_soc_component_get_drvdata(component);
-	int i2s_ref_ch = ucontrol->value.integer.value[0];
+	int i2s_ref_ch = ucontrol->value.enumerated.item[0];
 
 	switch (i2s_ref_ch) {
 	case RT1011_I2S_REF_LEFT_CH:
@@ -1344,7 +1343,7 @@ static int rt1011_i2s_ref_put(struct snd_kcontrol *kcontrol,
 		dev_info(component->dev, "I2S Reference: Do nothing\n");
 	}
 
-	rt1011->i2s_ref = ucontrol->value.integer.value[0];
+	rt1011->i2s_ref = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -1357,7 +1356,7 @@ static int rt1011_i2s_ref_get(struct snd_kcontrol *kcontrol,
 	struct rt1011_priv *rt1011 =
 		snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = rt1011->i2s_ref;
+	ucontrol->value.enumerated.item[0] = rt1011->i2s_ref;
 
 	return 0;
 }
-- 
2.33.0

