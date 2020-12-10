Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BF1C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 12:17:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC4F23B70
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC4F23B70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 360E81671;
	Thu, 10 Dec 2020 13:16:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 360E81671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607602627;
	bh=1iAEgMXBoJV8yXtdTsMklFlvKCF0g41zzuHF2EzFwus=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U4DiaNpLWAlKFxQkbreGkkSOLEPa7kxkIsrVfjjK99O6vTNj6bD+G2eJH5VjyvIx9
	 CzPcbloS8+ZpeY1M6QrY9J5tX7OznsjFmo55cDZg8z0KPiLoAGRO7KfUksH7QGEIfc
	 rI3ulmN9hT5mOxdBcxGNBImYa69B9Zb5qryyyokY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C4A8F80164;
	Thu, 10 Dec 2020 13:16:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2233DF8016E; Thu, 10 Dec 2020 13:16:15 +0100 (CET)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6647F800E1
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 13:16:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6647F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com
 header.i=@semihalf-com.20150623.gappssmtp.com header.b="AUwfO51u"
Received: by mail-lf1-x144.google.com with SMTP id r24so7860827lfm.8
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ar8hH53wYzV5EGYe8r+sxUlCl+f/5B2F1ztEQKsN1o=;
 b=AUwfO51u4n2ZNY/p+jCIV9C7+WWCw2x3IN5oJuSbapM89leKpyPW1crbkTLx47kXPF
 6Db/SCJlFb57eoPrDDv275hIkOUEhb7BQLSKEQGQpxeXSGSzb5D0EsgfnAuCM8MHApKt
 i996WZRjVjbBXlo3XnusoTtrKAHb7I1OWadr/chmVHDUQXzjFDe3rj6OMvSH7l1AMPbf
 lasBL0YaS9nRJoEW6MhRLsi+3v7CR0X0eg1n9BRxPMuTeooK2Nbf//WB/zrw43/VpgvW
 3R9j0VkVKNWduT0aSW9Mz3DOqfIJY8eWmbrBcX/VZBVnAmNS0iVnbDn1rK01B5tnvLGG
 qOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ar8hH53wYzV5EGYe8r+sxUlCl+f/5B2F1ztEQKsN1o=;
 b=X1p3ISvdwKk21TvXUdOT6FskfNcuEo2UWX6sZpK8OzghqBrZtDrce+5tAMBY7o4xdc
 9Mg6uJWbKnrafew5bL1954eBnM0PK5Qd4g7/mtBr0QI7lisn+NMG63lSIEs+ZlYQp7Y4
 Ld4xVsckfQPcb2l2fsQ0KaEvhLLjP5v6dFre2tgrK01vJRTUDVJcdybMlQleBm+giiMc
 SsAxl7Uvuu+zqXYrguPAWxtU5PjQsdTCK0MqdZTlk4tgjboawPH7tvyeAlyfqhGo8+97
 sk37yqngcJwzt8rIUeyRwThFMopI4TfezFInYFNALWmnPXON7UhkMwpLir1JEa7rUOQW
 YAFA==
X-Gm-Message-State: AOAM531JF3Ca47OnaZ1rMlDZAPC78Ya2g+As82KzJmxSJOWwZi1DU4b3
 BfLeJLbwWS+/Ys5HGK0dBNeolA==
X-Google-Smtp-Source: ABdhPJxCHO95LPtqlAbB8kQDflAuKBEY7aL5wIPw3NQVdS0JmGyuMshrJuOweO/KpUjPPqsTVKM+7g==
X-Received: by 2002:a05:6512:32ac:: with SMTP id
 q12mr2669530lfe.298.1607602567114; 
 Thu, 10 Dec 2020 04:16:07 -0800 (PST)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl.
 [89.70.221.122])
 by smtp.gmail.com with ESMTPSA id j25sm496090lfh.71.2020.12.10.04.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 04:16:06 -0800 (PST)
From: Lukasz Majczak <lma@semihalf.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mateusz Gorski <mateusz.gorski@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Check the kcontrol against NULL
Date: Thu, 10 Dec 2020 13:14:38 +0100
Message-Id: <20201210121438.7718-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Guenter Roeck <groeck@google.com>,
 Radoslaw Biernacki <rad@semihalf.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
 Lukasz Majczak <lma@semihalf.com>, Alex Levin <levinale@google.com>
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

There is no check for the kcontrol against NULL and in some cases
it causes kernel to crash.

Fixes: 2d744ecf2b984 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHLT")
Cc: <stable@vger.kernel.org> # 5.4+
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 sound/soc/intel/skylake/skl-topology.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae466cd592922..c9abbe4ff0ba3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3618,12 +3618,18 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 	int i;
 
 	list_for_each_entry(dobj, &component->dobj_list, list) {
-		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
-		struct soc_enum *se =
-			(struct soc_enum *)kcontrol->private_value;
-		char **texts = dobj->control.dtexts;
+		struct snd_kcontrol *kcontrol;
+		struct soc_enum *se;
+		char **texts;
 		char chan_text[4];
 
+		kcontrol = dobj->control.kcontrol;
+		if(!kcontrol)
+			continue;
+
+		se = (struct soc_enum *)kcontrol->private_value;
+		texts = dobj->control.dtexts;
+
 		if (dobj->type != SND_SOC_DOBJ_ENUM ||
 		    dobj->control.kcontrol->put !=
 		    skl_tplg_multi_config_set_dmic)

base-commit: 69fe63aa100220c8fd1f451dd54dd0895df1441d
-- 
2.25.1

