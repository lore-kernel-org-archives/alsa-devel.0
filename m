Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24045C433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:23:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4A521974
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EGD8/l+K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwpPinI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4A521974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCFC3168B;
	Wed, 16 Sep 2020 11:22:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCFC3168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600248224;
	bh=ST44XWI4JEq9jDCOsNTEzqbIQc3wrwZ3vQpyZ+GQc5I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EGD8/l+K8q+jFnVCsYbdTKeVuNP7t20Oj1TXuuXqrMNa3ZQOONctPRHrcZGbXMr11
	 UjAgEVt+Bo7WG1JvpH0mc1pG9fswZimyyjFoaQ3pbyYywzd4QYWy/csQUSWauxeWuu
	 3VwQEACeCvEisU/QBFbghZf2CD3kDzcCFb87/VVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97CB6F8020B;
	Wed, 16 Sep 2020 11:22:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5440F800E8; Wed, 16 Sep 2020 11:21:58 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9FB4F800F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 11:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9FB4F800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zwpPinI/"
Received: by mail-wr1-x42d.google.com with SMTP id g4so6124076wrs.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QcLuhNnrX/nQCZhthEE8aR8w/AwdzuMVVfrZbO3TD9g=;
 b=zwpPinI/Rr9H8iwdQqSgkeJmlIy6IG6vrUVdUIT8CJAniqdNZru9Waie7WlTmyyT1S
 Nug/KefJnhLLIoDZ2hqapgVx3xE9lSEoMX3AWOv7ZC+TyZc/6H5pvGPsGuXFv/C0KQT6
 ds804bTLAjuXkMty18ffemSkElCgDebaL6XPpqiNgr+YPSuMW14nwpACjiHu5buFb+u+
 l6cN2v5iIrJfjl077t+XwqGqbO7ZYbdr98esIhyh1G67UtA15RMhbXGjoCn4l7I70fEw
 aFY2KjAQOMlJfO0+6KcsfM5GFVks9TY+KQSRKTlAWzKIVHqtdLiSDZn/f/+E1KXdEZrE
 jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QcLuhNnrX/nQCZhthEE8aR8w/AwdzuMVVfrZbO3TD9g=;
 b=gu8v/UkXMP7LUzTnD475u6BurYxYhyGwS2tPDyC6BcHmZwwts9lDxbU19SevbK6IdI
 5YXKkjQXo+bArMNdkwxx+0ZGbuwFid9nVWWqbrrQGXN+hmYXnjtk1iKam6229b1sK+da
 tDhqrv5YPc68jlx2EHOz1+hyT96m84JJDwtd1EtA4miI9ngg8WSktAvFixTe/JIdsX2s
 9k7rzjyRzg22S4PgpbGPLD0FhK3kaoKkKiD7e0jJVCr0FbkjAkGlVwAh/1dkxjukunbG
 dUO+VCiFrAQY0oIj5SZzqodhOHVBG+Fhdp9p+VNAmNqIgfQru1b4WPN1x6OMeC3M4gxK
 1rrQ==
X-Gm-Message-State: AOAM532NTaiQMPpFzu24O+4hCDeRsfHq0uIhTZDK5LTDurD1+C96ZnH1
 H+LocS6r+dJcddyA4dzcLiPHKg==
X-Google-Smtp-Source: ABdhPJy5m+mdqlv4OG5JdIdq8YqyOLfF8S9OUft4LXq72Toaw/0mXAlfmewTtZX/SaRKGmW8bN6d1Q==
X-Received: by 2002:adf:e449:: with SMTP id t9mr26130245wrm.154.1600248108935; 
 Wed, 16 Sep 2020 02:21:48 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id f6sm32181670wro.5.2020.09.16.02.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 02:21:48 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH v2 0/3] soundwire: qcom: fix IP version v1.5.1 support
Date: Wed, 16 Sep 2020 10:21:22 +0100
Message-Id: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
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

While testing Qualcomm soundwire controller version 1.5.1, found two issue,
Firstly the frame shape information configured vs the bus parameters
are out of sync. secondly some ports on this ip version require
block packing mode support.

With this patchset I was able to test 2 WSA speakers!

Also I found a regression due to move to REG_FIELD, which patch 1 fixes it!

thanks,
srini

Changes since v1:
 - rebased on top of REG_FILED patch or soundwire-next branch
 - udated qcom_swrm_data to use u32 instead of int as suggested by VKoul

Srinivas Kandagatla (3):
  soundwire: qcom: clear BIT FIELDs before value set.
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 76 ++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 18 deletions(-)

-- 
2.21.0

