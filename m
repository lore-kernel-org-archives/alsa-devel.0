Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AEFC47082
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:11:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FD9613B4
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 23:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FD9613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5881C1707;
	Thu, 27 May 2021 01:10:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5881C1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622070678;
	bh=cRMn0ajDqYBqhpccDnBXBCyVEEi2ITVy3ZLS9wJAnpU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EJoxcIYoHj/75635LDzYPvLo3EtBtRz0Xg7NZTq5GW8hIFIm3naEX+nAtoJxTIjeL
	 P1LBH2tOuJE7XxGkYhlu+iHJCpJGQni18FyMc1Dc4tG8V99q7COcexM/s0iipn+hLE
	 UnEKNspswwbQ7FdznTfr0dzfmrtqar/2lKwcCRBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5780F8026B;
	Thu, 27 May 2021 01:10:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58707F8026F; Thu, 27 May 2021 01:10:26 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2328F800B1
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 01:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2328F800B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ynrs5OeC"
Received: by mail-lj1-x229.google.com with SMTP id a4so3839638ljd.5
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R5KRURxHuIRN88Pq9m7M0QMDbYSaSSuxjl5MCR9Behs=;
 b=Ynrs5OeCYBdywINKAam25dmM5d9qI4+8NGAxeYx7bbhSmSgJuFGFHW+rWp3qju9chB
 8EFmBYuQotNniMoFuxnj71htVRrWPpuZ6hMOVCylUvb9QZPekJ5wztkAihGO+adT3ndS
 zG9Wgf//E/TNyjng2VKHD+sd7bLmUtnAsB+l0mHYFWlHGBlNBDgeJnOgQz5CGy8Xmomo
 xNG8mTqr3c/cJnrzka2IKRhG5lU4yLWnBzNMmlyp8R5OPFWGgnTGu1njDSoS+qE/6f70
 0FDLjiBlcL7aScPilhXPj/VJdX64s5O/y87dTP4M0494u2zfryyWUNSLUZTYPHRfM/Qh
 u9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R5KRURxHuIRN88Pq9m7M0QMDbYSaSSuxjl5MCR9Behs=;
 b=YHXR0WQztodvFFIm/IsN8JCouWYwxjcnxNlnJk5byvlgYWoyaUEA5j+kBo9v7bVn3L
 w71Mj1mQkfbnKuRzDstzXpbV0nEWdI0OHr9Cm7lk2EGQRJfw3g7jwSFjdnvUMheeOAHY
 WLYmyR+rDe5zCTrINTIklVi0y/dN/RXlMifOEGKy7gpaxg2lIvAKGWTtdQV3wDfHX6qy
 hQcmx2vpxzQRRK8NRb+ZvC/rkn4UHg97bn8Dl7nPXj7mWN7a4s1HNJbJl2oFIAjk8U1m
 ABbYJn4sj0MKUsQYKs+nHm4/yU53rirqCro4rtiJ9RuJJnxWHt19plTSxOlcxB0h4YF/
 xviQ==
X-Gm-Message-State: AOAM5319MNeADVf1+1m2S4QyWeD53rChJiUGjpPAXKYmCBEn70hnyshg
 TVs96umZpg6+UAPafXiPGZU=
X-Google-Smtp-Source: ABdhPJyLm/jqms3TflDkHNXOnrAgQmry/eccJ3qYNO1aroF0i6fo5eMr8i7kxP/p43Jj4WvcG9HzkA==
X-Received: by 2002:a05:651c:1258:: with SMTP id
 h24mr316230ljh.340.1622070622192; 
 Wed, 26 May 2021 16:10:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se.
 [98.128.228.193])
 by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 16:10:21 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] ASoC: Constify snd_compress_ops
Date: Thu, 27 May 2021 01:10:08 +0200
Message-Id: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
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

The only use of the static and global snd_compress_ops structs is to
assign their address to the compress_ops field in the
snd_soc_component_driver struct which is a pointer to const. Make them
const to allow the compiler to put them in read-only memory.

Rikard Falkeborn (5):
  ASoC: cs47125: Constify static struct snd_compress_ops
  ASoC: wm5102: Constify static struct snd_compress_ops
  ASoC: wm5110: Constify static struct snd_compress_ops
  ASoC: qcom: q6asm-dai: Constify static struct snd_compress_ops
  ASoC: SOF: Intel: Constify sof_probe_compressed_ops

 sound/soc/codecs/cs47l24.c       | 2 +-
 sound/soc/codecs/wm5102.c        | 2 +-
 sound/soc/codecs/wm5110.c        | 2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 sound/soc/sof/compress.c         | 2 +-
 sound/soc/sof/compress.h         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.31.1

