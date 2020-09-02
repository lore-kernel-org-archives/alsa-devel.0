Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B53CC433E6
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:03:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC132068E
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 04:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vH314a5+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxGijTf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC132068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BE2717F3;
	Wed,  2 Sep 2020 06:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BE2717F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599019417;
	bh=ntSAwP69kNrJTN1q32dLXJpp4kdBx9VHVfDeKsBcVJA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vH314a5+reppy2y2rgeVoLMwzfyHbeAPmJZ+7kvkQbA1wrfXSGwO4e3VwAbHyyYn4
	 CiE1jQgtN95+M/MqlmfT9ssy1H40A7HV0cH4po3Q1BQMxMiCGV/W/LtTD3jOIsJmN7
	 IgL2uRZZGo4ezqsj1496GQf6AxQ+whaASo0tfAyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC5D9F8024A;
	Wed,  2 Sep 2020 06:02:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 734E1F8024A; Wed,  2 Sep 2020 06:02:43 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3BDDF801DA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 06:02:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3BDDF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cxGijTf5"
Received: by mail-pg1-x543.google.com with SMTP id l191so1865152pgd.5
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a92rMmkgBaxQ0KF0jZFhP8Cjz7jmJSw15umu/HKGj/U=;
 b=cxGijTf5wz24yWww5R57c2DzLi1cWLuughf/7vxF4fP+9VT3Vf4WuFx2hvzxBAlirt
 5+PIVPt2/6j+CnKikXcwfFZLFG8GSZkMxyx+nj6sDvaz/plKE9aAb7jNiA32wHPO7csL
 CepajR1A95TN7blXXWVhU02FmKQ//aWv4Rzq1wEFiBSWYZ4kjZSsMKgyY+xEk27xjYyT
 Wf8ziDIZhMqGp4jrNdJl0Elo72kjixx+eZgqWKgs0IMf14Ptyo43Wl5L3TNqShrMAB6E
 PBh5JgSC7gZp28H92+zBgL136nDfTGaoXOe6BjO9dgyaO/+rURnuKg3ubRIStfmpD9St
 7q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a92rMmkgBaxQ0KF0jZFhP8Cjz7jmJSw15umu/HKGj/U=;
 b=BQAGNtSEtADLFoU1I5KhXTyIkE2ipnl+Kl4mZNbdtSrU0TNG6gt/Kd3uORh1vFr6QE
 nkd7qsPPz8wQMhx5p70SMvePMGkOGaGqP7B4LM3Qblvn/DFJiwhPScCreVrUwd2v1MsV
 3vOVS67wOKu6OIm7Nw/DjgexeJS6u0u1vKiJUKQFwNVlYRpBGhSn3Wrf0ZnIg90ViLPp
 xl8mYmDT7xdLIo1Y3AqgK8gbJNunHtXmbvSAlPGXtBkiXJOjNgiBCBwkYYRp0aqT8ZSS
 IwqXsnrLl9lKei8sj3JS1/usV8vBueHd6yUyh0BtvNs1oZSPU9zC/8V7ILCLMm+cHvjp
 0o2A==
X-Gm-Message-State: AOAM53372NXsSdw5mO5obOIrlTgAuXwNGjGYPfXhTLQa7XSFvFca8wko
 /08xZH1idgz6ci0ErAiZ1DA=
X-Google-Smtp-Source: ABdhPJwculL4P8SaxKnmwIXpSj6B8GGWhm4eXf8gYEvs/+TUpkx0bXRPiPGPdN2ZP/BQkjByUeMswQ==
X-Received: by 2002:a65:4208:: with SMTP id c8mr419427pgq.266.1599019351695;
 Tue, 01 Sep 2020 21:02:31 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
 by smtp.gmail.com with ESMTPSA id q71sm3058350pjq.7.2020.09.01.21.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 21:02:31 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org
Subject: [PATCH v2 00/10] ALSA: convert tasklets to use new
Date: Wed,  2 Sep 2020 09:32:11 +0530
Message-Id: <20200902040221.354941-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 clemens@ladisch.de, Allen Pais <allen.lkml@gmail.com>, nicoleotsuka@gmail.com
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

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts
all the sound drivers to use the new tasklet_setup() API

The series is based on 5.9-rc3 (f75aef392f86) 

v2:
  Fixed subject lines.

Allen Pais (10):
  ALSA: core: convert tasklets to use new tasklet_setup() API
  ALSA: firewire: convert tasklets to use new tasklet_setup() API
  ALSA: pci/asihpi: convert tasklets to use new tasklet_setup() API
  ALSA: riptide: convert tasklets to use new tasklet_setup() API
  ALSA: hdsp: convert tasklets to use new tasklet_setup() API
  ASoc: fsl_esai: convert tasklets to use new tasklet_setup() API
  ASoC: siu: convert tasklets to use new tasklet_setup() API
  ASoC: txx9: convert tasklets to use new tasklet_setup() API
  ALSA: usb-audio: convert tasklets to use new tasklet_setup() API
  ALSA: ua101: convert tasklets to use new tasklet_setup() API

 sound/core/timer.c            |  7 +++----
 sound/firewire/amdtp-stream.c |  8 ++++----
 sound/pci/asihpi/asihpi.c     |  9 ++++-----
 sound/pci/riptide/riptide.c   |  6 +++---
 sound/pci/rme9652/hdsp.c      |  6 +++---
 sound/pci/rme9652/hdspm.c     |  7 +++----
 sound/soc/fsl/fsl_esai.c      |  7 +++----
 sound/soc/sh/siu_pcm.c        | 10 ++++------
 sound/soc/txx9/txx9aclc.c     |  7 +++----
 sound/usb/midi.c              |  7 +++----
 sound/usb/misc/ua101.c        |  7 +++----
 11 files changed, 36 insertions(+), 45 deletions(-)

-- 
2.25.1

