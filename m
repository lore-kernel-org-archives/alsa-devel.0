Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4BC433E6
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 17:17:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E2C23A57
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 17:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2C23A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF196187D;
	Thu, 21 Jan 2021 18:16:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF196187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611249466;
	bh=OSowlHU4ejUY/eBo79MlbskiqGOkIVb+EeZS1VfaOEo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I8YqENLlu6aO7Wy/8ebkRQtUu98eO1ECKxXv3qoN1EqhnKcqMnBVDGawVqYGcmVDV
	 +X3ECi25F8KDf5jNmghRg0N2DRgN3PoMrMZ0nN+HPM51LAMkIMB1sddQeYz81kR/5f
	 egZLwPpwftY7e3XfPmmkQVf3F4PaF7aYZpeZPHCA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 428B3F80255;
	Thu, 21 Jan 2021 18:16:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D0A0F8026A; Thu, 21 Jan 2021 18:16:54 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05744F80125
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 18:16:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05744F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="TlAdl9ky"
Received: by mail-ed1-x52b.google.com with SMTP id g1so3407466edu.4
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0/+GpgvuePk5y5rT7DgZg88TKWg6HgWIEtHm/4SPvYk=;
 b=TlAdl9kykmD1P8xdaBiLP/CVTJil6R0WRqGcjLGa0Xd7IvaLQ5CJNu9qjhbTLlA6lb
 ML325dhK8IoWKsPeX53W58GFHa5wrUYMu8XTItWGvwquES8Q2sgP1sbJhEq+hVHZnlyI
 c3kv1DYo487l03dws8dcvqF3PySCv5rZ0Ln7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0/+GpgvuePk5y5rT7DgZg88TKWg6HgWIEtHm/4SPvYk=;
 b=r0eZo2bgQwmOQdaNaZwm0lkLJPIx4sKYkFi2DNw+ufZQq/yJJZjLmK+oBngmaY8DWS
 mdYUcgVn3z9kzLI7bNIQ1I00qXnK66/F2yt0yXIu8FcD5dGjIYA2GlJskNzG84skizyp
 IrP/heGIl9jRkau09UpNXt/1wb/KWWinbk+ruFulvextHoSibtcKm2wSlOy2HbhXuwXu
 /7rcZCurbs/f88ahNIycz/516+bIwl8XrFIrJyHNpHhEpZVFOdnMIvNjN9aQSeHGeL6F
 Z8qNeUKIwjlUhy65Qo/9IENG+zaPTefMtQGnIaFvqw6MR4ce+UHmIW6Za97cCeBOUryq
 lCKw==
X-Gm-Message-State: AOAM533xyzH/fk8ak8Pg6rbldPeYYsbJXedtfzi5nGvZQmRx6rHORNpO
 y1TQHESFjrQw2dfmSAqkeLb+kQ==
X-Google-Smtp-Source: ABdhPJz/J+IUoG7YQaX0WCLW1b3i8j2HWQ7beFCMR/3jjiug2pWQbt+8OMM7chkSS8NPU00ACx7AXA==
X-Received: by 2002:a50:85c4:: with SMTP id q4mr123923edh.7.1611249406933;
 Thu, 21 Jan 2021 09:16:46 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id q9sm2484024ejd.113.2021.01.21.09.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 09:16:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Lukasz Majczak <lma@semihalf.com>
Subject: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib
 skl_tplg_complete
Date: Thu, 21 Jan 2021 18:16:43 +0100
Message-Id: <20210121171644.131059-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ricardo Ribalda <ribalda@chromium.org>
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

If dobj->control is not initialized we end up in an OOPs during
skl_tplg_complete:

[   26.553358] BUG: kernel NULL pointer dereference, address:
0000000000000078
[   26.561151] #PF: supervisor read access in kernel mode
[   26.566897] #PF: error_code(0x0000) - not-present page
[   26.572642] PGD 0 P4D 0
[   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
[   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
5.4.81 #4
[   26.588232] Hardware name: HP Soraka/Soraka, BIOS
Google_Soraka.10431.106.0 12/03/2019
[   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]

Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 sound/soc/intel/skylake/skl-topology.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae466cd59292..1ef30ca45410 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3619,15 +3619,16 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 
 	list_for_each_entry(dobj, &component->dobj_list, list) {
 		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
-		struct soc_enum *se =
-			(struct soc_enum *)kcontrol->private_value;
-		char **texts = dobj->control.dtexts;
+		struct soc_enum *se;
+		char **texts;
 		char chan_text[4];
 
-		if (dobj->type != SND_SOC_DOBJ_ENUM ||
-		    dobj->control.kcontrol->put !=
-		    skl_tplg_multi_config_set_dmic)
+		if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
+		    kcontrol->put != skl_tplg_multi_config_set_dmic)
 			continue;
+
+		se = (struct soc_enum *)kcontrol->private_value;
+		texts = dobj->control.dtexts;
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-- 
2.30.0.296.g2bfb1c46d8-goog

