Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F2C7619A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Apr 2023 05:27:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB23BEC4;
	Wed, 12 Apr 2023 07:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB23BEC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681277240;
	bh=77gmlvtFa9aiZ+o19jFOLL2O9xpTsxBk4JLB2DozhgY=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jciTvwcQjS69a/VzeAMu5fILvUKvfjmtDveFss4BjirmrKuk54BoB3tGrphXnxfWR
	 QQ6joD2hRyfALVvgqZ9jl8miCfgA3YZEaR785aQHBQ2qs2jVULzOZJVlbIpPLNyGZq
	 ejjiwJmCiXBUM5Qs2Njy1VSFaqM7mteL54Z1L+kI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67670F8032B;
	Wed, 12 Apr 2023 07:26:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A038F8032B; Mon, 10 Apr 2023 18:00:47 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2BB6F800E5
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2023 18:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2BB6F800E5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Pi8SoQAA
Received: by mail-ej1-x629.google.com with SMTP id gb34so13674578ejc.12
        for <alsa-devel@alsa-project.org>;
 Mon, 10 Apr 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142442;
        h=content-transfer-encoding:link:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=Pi8SoQAAve+0OUvyEV+VkBuxRpHtC9TyBSEO1J8HAw/MUglKfGzRttwjA/kTdb7ahT
         hN3admwKoJTztCyhT/FItRSe6sFuQDOlP1ryVjfWx9uTAvo9UVsT06MQE8gYUuoAFxds
         I1b/2h9z7VMF7nlAEHd4itXmDR09fQ/sugUSyxDD08ufNgdQDDtU82KJm6KOwEXe0O+j
         kgMtLWvKJfq4kbflgEfRq99zc7xZQrZpmhkyMeuOHbcJwijK7JpQvNvjDsCDblEjexCG
         o+ZeoyW1N68XtLbBazuY8fT9bWu8x/jIVpHueMwTGRouWap9r4/NQ7Uhkf4noGDCi7xp
         hUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142442;
        h=content-transfer-encoding:link:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=XwZtlK+UICQls6Q3EYmGQVi58mDcBXLvrUuXcSTq7jQYE4Y+uRTX9arcDfu8gFXXWo
         2zCC6Ehya+iidI+YZXDQau7Oer7/95k+VyP58LCw6iwpglGy03lHWiotcP/i0UeR7Mvf
         k1/9dpTocoyOn8ivtdCFV5FS7OdhzrQ5QCOflylk9FC2zCloY902NolNi1HCIlABucHq
         rpLrVqDRJVGfnIr7fUV3og2Y3Hy2JGeyFk1zHzLP/tObOolzasJn+PL4ZeIaRnAXbj60
         YE3qQzGnD4APK8LNilItE4aUmtkHj4xv2sGrpUq9UWe6rifmXSPSKddDP398j/JGbfrG
         42+w==
X-Gm-Message-State: AAQBX9fDYCrcDY6ACO1529gTS9zFh7A5ma7bTDGPjFVB95swSSP8H8S8
	b18gREcFV4Ko0DZnDtMYzRan4oVvjq33I3rE5U0Isw==
X-Google-Smtp-Source: 
 AKy350b2UmsDYb6+u+Vkh2+O0oeyflxo5OZ41wo9U/VYajIrNuSaEATSRJfZluAHwU59XNNRxiGldg==
X-Received: by 2002:a17:906:9bed:b0:94a:5615:6a80 with SMTP id
 de45-20020a1709069bed00b0094a56156a80mr7312228ejc.30.1681142442394;
        Mon, 10 Apr 2023 09:00:42 -0700 (PDT)
Received: from localhost.localdomain ([79.142.69.160])
        by smtp.gmail.com with ESMTPSA id
 la26-20020a170907781a00b0094a8e06eaa8sm1095359ejc.185.2023.04.10.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:00:42 -0700 (PDT)
From: Cem Kaya <cemkaya.boun@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v2] Add Dell G15 5525 Ryzen Edition to quirks list for acp6x
 so that internal DMIC works.
Date: Mon, 10 Apr 2023 17:58:44 +0200
Message-Id: <20230410155842.177255-1-cemkaya.boun@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Signed-off-by: Cem Kaya <cemkaya.boun@gmail.com>
Commit: Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that
 internal mic works.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217155
Content-Transfer-Encoding: 8bit
X-MailFrom: cemkaya.boun@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DIRUSVJUHCERAGTBRYQW2SQNKYNQZKWA
X-Message-ID-Hash: DIRUSVJUHCERAGTBRYQW2SQNKYNQZKWA
X-Mailman-Approved-At: Wed, 12 Apr 2023 05:22:31 +0000
CC: mario.limonciello@amd.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Cem Kaya <cemkaya.boun@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DIRUSVJUHCERAGTBRYQW2SQNKYNQZKWA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a428e17f0325..e044d811496e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.0
