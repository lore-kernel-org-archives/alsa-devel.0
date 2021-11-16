Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:49:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3823B61502
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 11:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3823B61502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81BB7168D;
	Tue, 16 Nov 2021 12:48:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81BB7168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637063355;
	bh=Uputm70XbRtZvinSo/chk3AXPFrd3C10d8URUtGpKgQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BP9jXZaVGme885LIzixbaJzt33ucU27uguTtB7nmyGDYqO50FPMrBXBQ3z5O7a/QC
	 sat6CRe5z6E6gD5GlhefCdFIMKdsLsdut2/Umd0U69iePUJ9IeVDe9rbUxZgAs3y3D
	 EpTKHfU0SIkfDl97sGDLlV5/XiCesy1Lb46x2XwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56518F804F2;
	Tue, 16 Nov 2021 12:47:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3732DF804F3; Tue, 16 Nov 2021 12:47:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81765F804BC
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 12:47:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81765F804BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ZGZPiOSv"
Received: by mail-wm1-x32c.google.com with SMTP id z200so16655263wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5VTKFZ3UHlKVEvhBxdelrrUd+IoBwj07WMlzbJjG60c=;
 b=ZGZPiOSvuZoyHffbMO8UmtX8MH/I7hLxkUcA39bxnARX3XosmvJu8/glDYZYCF14wr
 61XkqY6YUNk4G2dHEY+HM61Qs8xgFi3GIMxFgTK5xch5cr/7dkABSSGWQtwJC0qq+LnA
 m8baZQEE/Kc07KgIrnziMGTXpeL7qeOjMoAU3YEAPm+PYlzf5far+Igu9isPkI4VdjGp
 WI4eD/OsTfBDM8XnlHGEv7mZYC16Wldu3cGh+RwRVYE1qesDOYE/jkadQGuHdk75d4q4
 H4CKa1Um6zTeJhGNZIy2WridZpOEULrFzcgB4DrIqy0/iQM0N7aj7tVlP6c3XXw6I27v
 Kyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5VTKFZ3UHlKVEvhBxdelrrUd+IoBwj07WMlzbJjG60c=;
 b=3znwhUVIf+i+0zYEDHh60mQgx6PZq65Zgpj5O1CFole/VAjT1aCF6USgaHwzm6d9Z9
 IhCjgYppsuezjVLjW8OCPq4I7+c1GT2ITQC8l0HelhG6S8M2UQfpiTdn8IAo0qMOeWg9
 LGgYjmU4+0Yfb4vkWzYfL57zfU7d8rGaSgaobNYM6Z2TOyGbbkj7wHK1Fl7HKsKaFL1k
 7nJg7zdExNEQnzSoDYhMO6a5nF4Bm0NSZEnRh4hU/7n45y2P4fqoIH79RIKu6QV3ROdv
 ILv0cebl8uI8lBk/pEXYVqC6DN/fweNr2Qa3Kl95Zyexb53GwiUfoCjCbh2v5t5GObK/
 I3Ew==
X-Gm-Message-State: AOAM533lNTn8IzeY7oAp3eaqWdN23Y1jSmU7aVqUQgmybGfjSDRxKZME
 P2acKT+uVKAuNRZw+vGrAZY/6A==
X-Google-Smtp-Source: ABdhPJzdnugagYt3FM4qtXzfJw+oltqGPDs6tl0+j14MTPcqlp5YEf96GmxgZXA/yY2EEHMnccS5jQ==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr6982075wmj.91.1637063259539; 
 Tue, 16 Nov 2021 03:47:39 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:47:39 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/5] ASoC: qdsp6: fixes and improve error reporting
Date: Tue, 16 Nov 2021 11:47:16 +0000
Message-Id: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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

Hi Mark,

During testing on a laptop we found few issues with the existing q6dsp code, 
first 3 patches should fix these issues. Also during debug we found that
some of the errors reported are not very useful, so update error reporting
in two places.

Thanks,
srini

Srinivas Kandagatla (5):
  ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
  ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
  ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
  ASoC: qdsp6: q6adm: improve error reporting
  ASoC: qdsp6: q6routing: validate port id before setting up route

 sound/soc/qcom/qdsp6/audioreach.h |  4 +++
 sound/soc/qcom/qdsp6/q6adm.c      |  4 +--
 sound/soc/qcom/qdsp6/q6asm-dai.c  | 19 +++++++----
 sound/soc/qcom/qdsp6/q6prm.c      | 53 +++++++++++++++++++++++++++++--
 sound/soc/qcom/qdsp6/q6routing.c  | 12 ++++++-
 5 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.21.0

