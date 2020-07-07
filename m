Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA07C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:20:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF72206E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G+XytwCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF72206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E75D2168D;
	Tue,  7 Jul 2020 21:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E75D2168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594149619;
	bh=vS23ubr6D07pgFZEvUDoO9KBVy2UiP5mrUFqSmF7REU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+XytwCb6gsBN/QeSLb9gL6GNsGTVxX7WyGNfGkev/i+6VcE5m8sMofVo3SMkwO0q
	 IHrXjckJoZ3W7MW0Kx3WArlnrG71a1ShB+j3wB+iveI7eSAfkM0YSTpkJeipsQI0vn
	 VJhDSKhTCBdtZcETUknNRSiDLqj1kOAda5cMVS1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 721ECF802E8;
	Tue,  7 Jul 2020 21:16:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F1F8F802DC; Tue,  7 Jul 2020 21:16:48 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A292F801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A292F801F9
IronPort-SDR: kwOHqT6cCbMy5TmuwUAlkR2yN0BRNPT6uVGaLFa/9ZH4hzUAC3T4UXXUX+tR1RzPJGU5Ftdxx7
 4fjHyNrJPKGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147690703"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="147690703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:41 -0700
IronPort-SDR: SwqtXOkuo5ynNOdi12dDxKh7z+v7x8FCxMJpHZAly0pP9RSMD+0Vqd5hzqDxQfvGH3pEQpBMW6
 EC0jXWJcKSjQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="388601645"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:40 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 07/10] ASoC: codecs: rt5631: fix kernel-doc
Date: Tue,  7 Jul 2020 14:16:12 -0500
Message-Id: <20200707191615.98296-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Lee Jones <lee.jones@linaro.org>
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

Fix W=1 warning, spurious kernel-doc start and missing arguments

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5631.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index b5184f0e10e3..653da3eaf355 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -64,7 +64,7 @@ static const struct reg_default rt5631_reg[] = {
 	{ RT5631_PSEUDO_SPATL_CTRL, 0x0553 },
 };
 
-/**
+/*
  * rt5631_write_index - write index register of 2nd layer
  */
 static void rt5631_write_index(struct snd_soc_component *component,
@@ -74,7 +74,7 @@ static void rt5631_write_index(struct snd_soc_component *component,
 	snd_soc_component_write(component, RT5631_INDEX_DATA, value);
 }
 
-/**
+/*
  * rt5631_read_index - read index register of 2nd layer
  */
 static unsigned int rt5631_read_index(struct snd_soc_component *component,
@@ -359,6 +359,7 @@ static int check_adcr_select(struct snd_soc_dapm_widget *source,
 
 /**
  * onebit_depop_power_stage - auto depop in power stage.
+ * @component: ASoC component
  * @enable: power on/off
  *
  * When power on/off headphone, the depop sequence is done by hardware.
@@ -397,6 +398,7 @@ static void onebit_depop_power_stage(struct snd_soc_component *component, int en
 
 /**
  * onebit_depop_mute_stage - auto depop in mute stage.
+ * @component: ASoC component
  * @enable: mute/unmute
  *
  * When mute/unmute headphone, the depop sequence is done by hardware.
@@ -435,6 +437,7 @@ static void onebit_depop_mute_stage(struct snd_soc_component *component, int ena
 
 /**
  * onebit_depop_power_stage - step by step depop sequence in power stage.
+ * @component: ASoC component
  * @enable: power on/off
  *
  * When power on/off headphone, the depop sequence is done in step by step.
@@ -507,6 +510,7 @@ static void depop_seq_power_stage(struct snd_soc_component *component, int enabl
 
 /**
  * depop_seq_mute_stage - step by step depop sequence in mute stage.
+ * @component: ASoC component
  * @enable: mute/unmute
  *
  * When mute/unmute headphone, the depop sequence is done in step by step.
-- 
2.25.1

