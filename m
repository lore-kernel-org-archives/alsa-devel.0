Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7FC433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 11:46:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576D661A8D
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 576D661A8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14A32112;
	Fri,  1 Oct 2021 13:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14A32112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633088785;
	bh=TwDt/uMovFpDutf/7j3ylcJP9uuVF4YXHj/o57Iljl4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i9mbllb2EUXVAJbWsOvVpri6UagKPmbOPHdKFldLzlJXhYG0jDT9K/vICJiDky6kr
	 2+Csci87Ools7u2vMfVqgLZNQRfCazkKLSxm28gJQz27ZJqas1nKPJaqmJmQl0abdg
	 icjl2Ehe7zm9Vc+Hwmw/1N+bLqcdrQ9ekbpQzm04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E4B9F801F7;
	Fri,  1 Oct 2021 13:45:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60D04F80245; Fri,  1 Oct 2021 13:45:32 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4490F801F7
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 13:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4490F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="c5pnifb8"
Received: by mail-lf1-x12b.google.com with SMTP id m3so37194132lfu.2
 for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2021 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=teiDv15/wzLe/Wf0K1qlBSWOTN//zgsH/sxmryk5zmo=;
 b=c5pnifb84S3cmH+v6CwyiCpgvnYoIn2qTma9lJrQG/5u3N4pvO/6mEaebzk5ODZ+8/
 T5ilDAGNMAarZMJBsPb0WzWmZqiz6zrVP8amb0v4FjmPuU7Ya5IStGoAevd3FiveOQRo
 fFqfxGUkJyhDiibsC7NzARCE5ReDri7f5s1F2f9uZEMsSAuxtWBRCwX/iH9GGq2gP1JM
 bSQ51+djagI9hzzhdLbhcMD+HUszZEknVeZAuPP4ZFIK5sX8SEC5Ro99S8ptusxHouBQ
 VtkDE/8uC3hQ6CcT3wb4xeAiq+hugvd8gonTzORNtgrfLEoUPoqxvRhYN/K/Yr14CW79
 akkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=teiDv15/wzLe/Wf0K1qlBSWOTN//zgsH/sxmryk5zmo=;
 b=pwbBfIJUP3SL5yiVRfU2qO9ZVtZX9NgVE738IxxpVE/xg7acqW3ZtwwZGBiGaliOq+
 gM9Kx/9ncNCWkrOeKl1anC61agyJbaPmXv+nfbgPvzZRFcG7MA1M+UB9Xsi7ow/aQqkY
 2fSyRQgn+NIv1r1YMPGG83BOlgWbY8Ho0KF4q/h/V/dFd5GAKbw4eeqFafEL709FweB4
 rrm0zDEY74fuZ5TtejuEafE60E3x3T/eMwfrIY9O3TrDX8beUgIKF7aJYiUCEoarOF5N
 jm/KKnZFH49RbOMXhaIoJVT8R08AKjfFaVDfLSye1LD3MGZp6K99QUolzFzWgB+ctQ/g
 sLoQ==
X-Gm-Message-State: AOAM531xR0UCI19Mv0VVkD6szx9UMP3Pji7vxSECrvzqLUoZXdbWvleQ
 Ab+28DHlt9XbHL9B3lAsKG0=
X-Google-Smtp-Source: ABdhPJxtcbH1EXrolybxconjeDFwJnpNlfjqcarbu5zs4BQ+iGKIMEQhjRDzclxuvWBcQ7oOU6nNSw==
X-Received: by 2002:a2e:bf0d:: with SMTP id c13mr11747222ljr.150.1633088727328; 
 Fri, 01 Oct 2021 04:45:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id v27sm710990lfd.127.2021.10.01.04.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 04:45:26 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tegra: Constify static snd_soc_ops
Date: Fri,  1 Oct 2021 13:45:17 +0200
Message-Id: <20211001114517.6752-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
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

The struct tegra_machine_snd_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 735909310a26..3cbe6ef1cf9f 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -313,7 +313,7 @@ static int tegra_machine_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops tegra_machine_snd_ops = {
+static const struct snd_soc_ops tegra_machine_snd_ops = {
 	.hw_params = tegra_machine_hw_params,
 };
 
-- 
2.33.0

