Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F3CA9EC5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:37:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BE920856
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BBg6uRUP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJDi1GQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC50A2333;
	Wed, 30 Oct 2019 16:37:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC50A2333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572449874;
	bh=84ZdH/WZlfi81SY0hR6VgnYQeKANOwKt7b7+yNpa84A=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BBg6uRUPM6/8HEeW+NqSvLzq+1Yxc7BqfEg+71YLGJS2SpY6v6oH8KvIV2epFv/qk
	 Ra0iB1vPzBJDCWyhZroG6o0q7B8Swnh6pnBztwYmxZR0v7avMWrmGSz1RU3JZGUfW9
	 iD745peCED2EhNXzgUfqFIkQXMcMeuCj3AmpDmOU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84D98F8048E;
	Wed, 30 Oct 2019 16:36:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41E57F8048E; Wed, 30 Oct 2019 16:32:06 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2BD6F802BD
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 16:31:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2BD6F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uJDi1GQ/"
Received: by mail-wr1-x444.google.com with SMTP id a15so2798160wrf.9
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bOpYqI7qFNfEuie9b9D0+Pfm6dLM4BfsV3Kxbb6E+qA=;
 b=uJDi1GQ/rwsgNK2XboHkBzba0ZbgnV1d3dt4JwIvwhCO4QpwTE1L8ATIb6ZX/EGgBk
 zdfZ01Ga0g4iHu0tIt0+WeYHMaxJI70fQjBKoCRiry+ouUXv7DpXlBjlXx4UQPVyBgVU
 CEdjfoE7b6mPJ2uLJnA6gROvG8wNy+UKJOhYn4eqbgTI79wrRAi7FZrMg6Y/tH4VNrtM
 EBUWx2OSOCFLCdkr6Qyy8DQh+HEkRG5UihSPDdkkqb9QO94e1+Fy17kqhjJ/05HEp7mZ
 PS8x/0du51vEhcz2Q0MftXD9v4hCOdbLEcz9qku9sCPi0i6p/80haBYUcLLqb5J8bUfM
 MMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bOpYqI7qFNfEuie9b9D0+Pfm6dLM4BfsV3Kxbb6E+qA=;
 b=I0S0/EepS+ckQgW1KPSbIkob8v+mlhlBIwQCgp9gA3PniAwNumHtYqklZjKqB53WoN
 xwvdUc5QiFqHMcL2sj+F0OpR9pFGUVF/M7sdF40fGyHeR1rV4+ZHzbj8a5/SPqXx58FD
 ArCxRWTPxpMk6EDTDR/M0bexwikwu1jWrdPRjiN1eAjNj7QB1Dq3z9vL9prTaE6pjVz/
 v65bk09bYOWQpxMQyK3jVYM6crs0cuUL+exHINcejXkcRMprdx7H/VaKZB/RI2Yva92t
 XvCoWrTQQagqYDp345RAiFgoVqBzpiSxvg/x7XVnPoTGoti+QxgWXgWF9oXDMDAinkck
 sV4A==
X-Gm-Message-State: APjAAAVHD4IH7/v6AjwrDEAjYScPDE3GnzRWPlSj2MvhPOC9v3coIS1M
 bulGFO1utz6VOW570OqbKmF5rA==
X-Google-Smtp-Source: APXvYqzekYVE+wOXaEjpNAHPVvz/iQyW28UjNldThsXJfbsdUIglMZqJba4lrHUhWU3R38B4gwvcMw==
X-Received: by 2002:adf:f685:: with SMTP id v5mr446677wrp.246.1572449513381;
 Wed, 30 Oct 2019 08:31:53 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id u21sm417329wmu.27.2019.10.30.08.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 08:31:52 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org,
	vkoul@kernel.org
Date: Wed, 30 Oct 2019 15:31:48 +0000
Message-Id: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [alsa-devel] [PATCH v4 0/2] soundwire: Add support to Qualcomm
	SoundWire master
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Thanks for reviewing the v3 patchset.
Here is new patchset addressing all the comments from v3

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v3:
- Updated bindings as suggested by Rob.
- Fixed sdw_disable/unprepare order.
- removed setting stream_name as suggested by Pierre 
- removed v1.5.0 controller support for now, will be added after testing.

Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 179 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 904 ++++++++++++++++++
 4 files changed, 1096 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
