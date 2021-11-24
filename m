Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC899C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 22:09:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC6AA17E2;
	Wed, 24 Nov 2021 23:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC6AA17E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637791787;
	bh=L+wkMXZmldTuXsHQy8SCCSvRec8VY7bSCXi2lDMNsJY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtPYUSlTPrcUIfHZjrZMXhGP03esn0SSqX0vpsbyWo4k+XoiWqWApt8D7/68vTA6N
	 7rKJgw+G4VgRLLYJAw+Fjx9RsALMCrESZNcza3JLTimrKU2WcTb6JoEn8VGcKILSsN
	 tK70jI5xGmawjWvKdwc1IBvlUFPj2oM4+T0XHwKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B32AF8051D;
	Wed, 24 Nov 2021 23:06:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E0E3F804FD; Wed, 24 Nov 2021 23:06:47 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA328F8011F
 for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2021 23:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA328F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nJAo4iPf"
Received: by mail-lj1-x234.google.com with SMTP id u22so8382522lju.7
 for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2021 14:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XQZdihin90lA7efVTDzu3CsDg/xeb8H7EeSD4A6ITqg=;
 b=nJAo4iPfwBFY1ROe3048h1ybqQlX//p3YjSX7Pe0idWjl7D5Xl7cOhLCOiOdeHEVtw
 i1TsPOsnewcD5UwgabPKGc1V8ufc2Zd+FJV0+A0q6BgfW74cgH0ysttiHo0JEuKO06Rf
 oSinD/HXvoSsQPpiGhkH5NiAnlXw69WbXOkSEmz5iXw1DnlDdAz0TEcgI6GlEiPRdKb/
 o069dFlaoy5lyEDSGze4gA+OToJs1MdOl69LwnbHH6fpJD3OU8yGdMtR7rBHQx5ehabg
 p1FSHjplifcYroZVsJCoW1Pl7SCG52FqXEMBlrRcXhVCQLxFhlKVMSxxPb7NXXuUNqPG
 2orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XQZdihin90lA7efVTDzu3CsDg/xeb8H7EeSD4A6ITqg=;
 b=AMeObhn6yKuOe5xF2vz8mP8XwBXO4yMuGiSwGD4JFzqbQ2Jd8PJUms62yrpUstVMQt
 srO9ufjwjZQPeASUvXbxKWW+9ZIoHLFNeJkG0fDvhk+cQVaxU3C6KWzLux5wOacf1VGo
 NUsTRwc8veqUQrAzFTcAytNaH1F+vb6VIAPgUTgvOXrlcxCBmRDhqQ1byy24nFmKfaFT
 da5kwI7aXzgNugBgEBViOzWzJookc+1Nq+0qTjwpAUxocSyO8YXW2BMLRvdG7mBZS7mC
 Vaup74gCgbEKLcJMDs+Lo8Ni5aoV69QHApYRxnF/zJpmdQktutk/OHcGVf8g56uDF7tG
 i6/A==
X-Gm-Message-State: AOAM530iWJ4PvRFK40evze3ZsNBJdlK+BcbeZGsIf7Ar/bl2lT+8PzvG
 3b7v49bbJDhk8Ny+mM6pgZbnzbXqg0o=
X-Google-Smtp-Source: ABdhPJz7K2sn4O/88yaV122GJMihQ39VL0qbxsHYUBy+2XB+hcfq/s90uDVNIgFsxMF0NuDwPmYVYw==
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr19708991ljn.354.1637791599934; 
 Wed, 24 Nov 2021 14:06:39 -0800 (PST)
Received: from localhost.localdomain (94-29-48-99.dynamic.spd-mgts.ru.
 [94.29.48.99])
 by smtp.gmail.com with ESMTPSA id w17sm93266ljh.15.2021.11.24.14.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 14:06:39 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Agneli <poczt@protonmail.ch>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 11/20] ASoC: tegra20: spdif: Support system suspend
Date: Thu, 25 Nov 2021 01:00:48 +0300
Message-Id: <20211124220057.15763-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211124220057.15763-1-digetx@gmail.com>
References: <20211124220057.15763-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
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

Support system suspend by enforcing runtime PM suspend/resume.
Now there is no doubt that h/w is indeed stopped during suspend
and that h/w state will be properly restored after resume.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 8b9bac30d5cd..89f7fc5c8aad 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -345,6 +345,8 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 static const struct dev_pm_ops tegra20_spdif_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra20_spdif_runtime_suspend,
 			   tegra20_spdif_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra20_spdif_of_match[] = {
-- 
2.33.1

