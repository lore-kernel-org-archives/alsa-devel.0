Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A6BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 10:54:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A662C20738
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 10:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A662C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96E321673;
	Thu,  7 Jan 2021 11:54:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96E321673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610016895;
	bh=6fVevfrhaM5gr1AhsJYkPKg5M4wvdw51UTZMfZ2P5o8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qBox3uJXn7TbsrS2xzc85e6cbaW1FiQ+Ss9Ebo9E5x3iblNnBM6BXOVausIGIawyL
	 uV7AWsoANC8tTFjmojvMHeHIG6e93wXGaMxHn0Mczf1ufbz1zQ5O9CmKC9vdNKiWHM
	 8/sjd62kr80QFtzgW1iH8whUomrskkFeN5HECu8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC92CF80258;
	Thu,  7 Jan 2021 11:54:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44ED5F80096; Thu,  7 Jan 2021 11:54:03 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3AF5F80096
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 11:53:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3AF5F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="UzAWpcLJ"
Received: by mail-pl1-x635.google.com with SMTP id x18so3292722pln.6
 for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2021 02:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wj1ygJR5+FaqE4ft+YDdxBj7ZFRXR4m0BwjI6oUvI+E=;
 b=UzAWpcLJBQSsqf6X+xsUgXjtFcgW393dKOcDhPA0nzD3e1PFuOgSL64k4cDABYnTlT
 lobfa801yCVwreawYN27jxjEUyj3dZ/WHR3vF0364EfQ1VASGxmXjpQjDpksxA2TmfXX
 8Vk2hTssx9SUVtT3m1nTcB+xGl98vLiCEAFsL0uL5sW8TPt8oX8EwDgQcUOsvihLCkZ9
 vu4QrSgHyH0AkyX2Ci5cUijIscZmdQxd5Ca9hh2308Cxi6+V0RxSRzM9RfE7qSXSlE4D
 ePCoWvJV+3qtybmcV/oCMwwXRDzHDjIcn3ny57XD0hVZ5iSwZReOJFLGNv3d/tKhJXAu
 dd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wj1ygJR5+FaqE4ft+YDdxBj7ZFRXR4m0BwjI6oUvI+E=;
 b=n6+AdyP5FQETQVZsBH/a1vS4+XM4WuYBDauLWrcnR61pWfM39k9UrHYQ8A+Q0JgPl1
 wl9p14GpXsb0toMvRuIiUMaNNepcpT2rIoJa2zhokfNb6u4dGPh0UIeJnAVVyfmqkKSP
 5V7igz5XrIyDi+OplCv/PRQ5pDKGpph5AiKIEsP8vpUREAxcHN5T7fA/nBMni6+mxqwz
 HNM3sYskoqbK8hZgx/KETEGUcFEJRbZj92bCICS1u9y0GmtMQqHOINOlOwv8rjO5uIpb
 1JyRcEGSwc7OxM3vWx62QqeVMXLMVUEUV9nixJkjFQSwFfZOjqkNdWwknpkm2+wDSbaw
 YVRg==
X-Gm-Message-State: AOAM5321nkBHgllAWoVJNrcX2ouV7LvJT6PKp5ri7DnOeMjVfY4GoN6w
 mChKA1Glv4tm3f0jWeJKBt0Iyg==
X-Google-Smtp-Source: ABdhPJxObwz+sTsR5viQerIB0RWI0i44SwygcnPBJnPFMGURLrM2mImOiO/zb4QdmtgohbFdEDiB1A==
X-Received: by 2002:a17:90a:d70e:: with SMTP id
 y14mr8641686pju.9.1610016836314; 
 Thu, 07 Jan 2021 02:53:56 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 02:53:55 -0800 (PST)
From: Chris Chiu <chiu@endlessos.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 0/4] ASoC: rt5645: Enable internal mic and headset on ECS
 EF20
Date: Thu,  7 Jan 2021 18:53:25 +0800
Message-Id: <20210107105329.146988-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Chris Chiu <chiu@endlessos.org>,
 linux-kernel@vger.kernel.org, linux@endlessos.org
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

These patches are trying to fix the jack detection and internal
microphone problems on ECS EF20 series laptops which are empowered
by Intel Atom x5-Z8350 CPU (CherryTrail) with Realtek rt5645 audio
codec.

---
  v1 -> v2:
	Invoke callback() of the DMI quirk if it exists, because
	the dmi_first_match() doesn't.

---

Chris Chiu (4):
  ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
  ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
  ASoC: rt5645: add inv_hp_det flag
  ASoC: rt5645: Enable internal microphone and JD on ECS EF20

 include/sound/rt5645.h    |  2 ++
 sound/soc/codecs/rt5645.c | 48 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.20.1

