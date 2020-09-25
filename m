Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08628C4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:29:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C4420756
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PtiOiCKn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLSNVdwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C4420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D92B185F;
	Fri, 25 Sep 2020 11:28:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D92B185F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601026172;
	bh=NlQGZj5CrSVzzsfX/ryvF9C0FdxLFcXNkHfPc9QQQhk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PtiOiCKn67XybNyc5OE8jGVmwhs2BzydyyxR1SbmXeMHhAVv8zD0iIb6q50fPVwys
	 DhSlwiB5PUSG9P7OqA+xAjKLtoIXrg18MvE47Pm2qCaHJLejEZ3qwES+v4LoA4F0fq
	 h85ba0SZYKs1fwx3VqqKriHOuyMP1O57PZDrWQjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC57DF80171;
	Fri, 25 Sep 2020 11:28:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E47EF801EB; Fri, 25 Sep 2020 11:28:38 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E66A9F800DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 11:28:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E66A9F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ZLSNVdwl"
Received: by mail-wr1-x444.google.com with SMTP id x14so2762544wrl.12
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tO4g88PTeL3YugtnYW8r3i0Fso59FI9gNwUwFSYLPPk=;
 b=ZLSNVdwl9YYdc5LJKcAO7mMSdj4lA8XJUhGTNy18Hiiw0GFeAwVLrt7Ki2kV3M7txN
 FB4OM5DJLspbbfL4dgO15DjaXedxQ/p03/TQ7ej0/iQIXb7CD/As8exF5DufY0yLISji
 Sp7dxFyTz8q0NnDb43/toJ+5jMl9bJ2vd5eK55cmBxDj6IsKkYUC8zP+QFWKOlT2mUgW
 lF0hTDaXhJKQ8HTszaIVUrzVznP2rfuKf37h14Z9l+U0gOsXrNpU2nGdiG3Sy5misyJD
 p459qR0VpIgp/GSl4PTAm/RsrYn8W79l5PmmT9LXStVOabsxia0+9OBdDbwlS8ZRwMKe
 QIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tO4g88PTeL3YugtnYW8r3i0Fso59FI9gNwUwFSYLPPk=;
 b=otmjx2CrOdnxNBSl5DFAeCzdB97oGfvfPvTpmcGyxrYpwiliBXsvsNzeitHn4egnLI
 FrWC+WpyWMvzR6J2iMw01ZOnzayJtk1m6K4NkW7SmBRh6K/JSkgPWgBNJFkEOsbQ6zRE
 3Lk5SjvKDY9nM30Ak1RDwuMTAhB7kbIsW5KgAxaiYPskP5TDU+96eJOYfQ2Kr5OcGLDH
 xplngSgRT2N1ByktgyDUYN9Aqo2BpWKjONSJcQrH6LxrtTBn1V4qOyoG4TLlDbtkFwDY
 VhSU+yggztxYDrYaSuGvkDF1HOBJeJpw5bnX4CVsXwGmzsxbU/Ez6H2xPdzXXavupM+7
 AfWA==
X-Gm-Message-State: AOAM530thbbTyeq2YpdhKBtbPzzNHCsccFaZDQXg6pxGuKb3TpFepMmI
 TOIoOwbcsaWI7lcpnjAm+Lfrvvn7pwEnFw==
X-Google-Smtp-Source: ABdhPJwJO2o7AdUOdSBVxDR9hgvc+Mqpq7gzWgIGyfrUqnmerA7YzUskVs4Tfq5sr41LAZ+6yOt/lA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr3597511wrj.144.1601026113058; 
 Fri, 25 Sep 2020 02:28:33 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id n2sm2366859wma.29.2020.09.25.02.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 02:28:32 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/2] regmap: add support to regmap_field_bulk_alloc/free
Date: Fri, 25 Sep 2020 10:28:02 +0100
Message-Id: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, srivasam@codeaurora.org, lgirdwood@gmail.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, tiwai@suse.com,
 rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
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

Usage of regmap_field_alloc becomes much overhead when number of fields
exceed more than 3. Most of driver seems to totally covered up with these
allocs/free making to very hard to read the code! On such driver is QCOM LPASS
driver has extensively converted to use regmap_fileds.

This patchset add this new api and a user of it.

Using new bluk api to allocate fields makes it much more cleaner code to read!

Srinivas Kandagatla (2):
  regmap: add support to regmap_field_bulk_alloc/free apis
  ASoC: lpass-platform: use devm_regmap_field_bulk_alloc

 drivers/base/regmap/regmap.c    | 100 ++++++++++++++++++++++++++++++++
 include/linux/regmap.h          |  11 ++++
 sound/soc/qcom/lpass-platform.c |  31 +++-------
 3 files changed, 118 insertions(+), 24 deletions(-)

-- 
2.21.0

