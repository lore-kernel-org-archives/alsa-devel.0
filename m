Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49656C2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:52:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C36522384
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FGtaBsL/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gVI6AXHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C36522384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F0C917AE;
	Tue,  3 Nov 2020 08:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F0C917AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604389976;
	bh=nDD731bBWGyU1YcmWFj/6YKYf1oi3QEeQ+I1hiAPNMs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGtaBsL/soxW3QLGiAAH5bUTfrSrCYPsvHXOcTNNjT4zLaNkSPJZg1rTZ+mRrjP00
	 Vp9jE0JMb3kTpQrI0Z02moTX4OOz5EvMYOOLMqQ7uJ2fUWAdaw46SxcSJHp7NVHfG6
	 biP3ebgB8Ub4bJEL+Wx1UCuSMveGtF7sL8Vqfotw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 837F9F80529;
	Tue,  3 Nov 2020 08:45:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 111DBF8015A; Mon,  2 Nov 2020 16:20:57 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 950E1F8015A
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 16:20:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 950E1F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com
 header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gVI6AXHj"
Received: by mail-wm1-x341.google.com with SMTP id d142so1146016wmd.4
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2020 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iECHQmtOjlKNpXGH67tnBHQ9XW515B1GPzEiiSpCWAs=;
 b=gVI6AXHj1TR9hrfeYHb9dFp1mjew1HU6tCdihy0BU74lIamhYA7I2Voy1vdbHNesjR
 p/9fN/OWbbHskwd+E8JR5E7mlF2yPwnRyYtplyTXp1xuKHzcS1KZmAQ11HYDiDqqk7yd
 tY/OlfBK/MIoUqiunGYPPRAv9qXuTyoKnb4oe0deS/0lvO8WRDkT4MMl7YYdbRLIjP6A
 WZTM13vo3qiWMFhDQgKf19/bBsn2+22jmj9vBOz0Wr1g2h4AsIo5xnYen4guGQ+vuB7M
 tIBujecjdmcR/Z2ixrsAyoeQ+6Gr/0jPL5uAk5wnvtIcZr9YQMnQKa+inwhetM8theTJ
 LUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iECHQmtOjlKNpXGH67tnBHQ9XW515B1GPzEiiSpCWAs=;
 b=cr4wQVrVnylU6LXQCY8aPUwnaEHfUAlqj7eSTHv6PKJ6+vIsCN9gwdg+gSTn0y2Dl9
 dX0X/CNbZw87F8O1Qyy0uO9PircabSQ7qrAE2IN48NW7CRRlv17cfR2MseczjlcZ18e6
 Bx90rkntkE5ra5mCdrA0XjooNLvYsnzqflqJOrn+i06T5ddy8B1oyC0fn4m/btUrwKdY
 XqPgECWxg4yg8ApXuImkH60jzgl/65CasaRG1yOKpVJ6YAQNCLAUYtAD44vb6ICEfPvV
 aZpfcXgOfrdaxdzmO1LgAzxRreKb5611hckKRJJZJZ/iiqUoPjPStjJ8zLP5B2dU3K3b
 yZMA==
X-Gm-Message-State: AOAM530GZ3ESRh4dsJFL3diq9kwGB3fI5CFqgjp0UZlNnHxlFD6ycZva
 COqqV9Z5fhgJO7ffeiWhy+aqyg==
X-Google-Smtp-Source: ABdhPJx9fmpXAPU0JQHKuUawZdLrOPu5JMkxXUw7mS4v/KP1pdXlJ+GdMVgsN3hdsL/yk/nVdd3HMQ==
X-Received: by 2002:a05:600c:1497:: with SMTP id
 c23mr13426695wmh.95.1604330449377; 
 Mon, 02 Nov 2020 07:20:49 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr.
 [90.8.158.167])
 by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:20:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Robert Richter <rric@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 4/8] pinctrl: use krealloc_array()
Date: Mon,  2 Nov 2020 16:20:33 +0100
Message-Id: <20201102152037.963-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102152037.963-1-brgl@bgdev.pl>
References: <20201102152037.963-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:45:22 +0100
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-media@vger.kernel.org,
 linux-edac@vger.kernel.org
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the helper that checks for overflows internally instead of manually
calculating the size of the new array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-utils.c b/drivers/pinctrl/pinctrl-utils.c
index f2bcbf62c03d..93df0d4c0a24 100644
--- a/drivers/pinctrl/pinctrl-utils.c
+++ b/drivers/pinctrl/pinctrl-utils.c
@@ -39,7 +39,7 @@ int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
 	if (old_num >= new_num)
 		return 0;
 
-	new_map = krealloc(*map, sizeof(*new_map) * new_num, GFP_KERNEL);
+	new_map = krealloc_array(*map, new_num, sizeof(*new_map), GFP_KERNEL);
 	if (!new_map) {
 		dev_err(pctldev->dev, "krealloc(map) failed\n");
 		return -ENOMEM;
-- 
2.29.1

