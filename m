Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6039ECA9EA0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:24:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE8120862
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DEEQXg0s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLuW/hoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE8120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28A8E1AF4;
	Mon, 28 Oct 2019 08:24:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28A8E1AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572247495;
	bh=VX2Vdq7pQiwVhfElVqGT0KKoNlv5DlRLHhgvaHgqyAw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEEQXg0sA4ESrBBvGlxWFwRSn5WSTVnPjyuJosAfqPhfV9DIyKEtOgsPzuRULkXv9
	 G6hCMsMxBofp28SEntHNNCoVeMDzcneRd8DEoyzq7qN2pwM1YjBGT4IxeLYGNN9cjf
	 /A2+QuXGQ/U+0151bIIro+BRK9Bw7W13QINJ400s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 923D1F8044A;
	Mon, 28 Oct 2019 08:21:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE1E3F8063D; Mon, 28 Oct 2019 08:21:34 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 373D8F802BD
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 08:21:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 373D8F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="LLuW/hoC"
Received: by mail-pg1-x543.google.com with SMTP id p12so6296049pgn.6
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4rbGb1xeN7CoEMiXrmYQTMXVCXS/HU0F9W4cYEOILvE=;
 b=LLuW/hoCz0kb7qlhmY1LiUcIcgWwr7eNcpXZvUZYIIfw+1Y/hSQlFpMmHrr3w2w0Ql
 wwL6EKwOH3u9eYdO3vXO3rqqHyfTy8JUURWOa4FF78ZBdrZl952TfClRmjTZLhgmFIBu
 Qn6O3CVnphnd2Pyti/yjGyPJI9oJih7MC5738=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4rbGb1xeN7CoEMiXrmYQTMXVCXS/HU0F9W4cYEOILvE=;
 b=e1Aq9gu9WSkMf4Wvdy/5nL74yppjl9HBhzDIWqZkixESGoCVZ8Hf0ZpL6/86J5cxM+
 ZuN2sDnoVrrniP6g5FW0X86u/12yTJ7O98CKKiogzlRoj3viLWiUoeHD0vp4+xeaQl5D
 lihYEn5ZN9Hk5SDctgNgmRmj88ZwuuoKusGpyfQrLjKZnsSCKl34milfAl4BYAMw/avM
 k1L2gBeDayrQS5qSvYdXhUaoxzvbw3QIwaGgR2gTg6OAumOO7owrQkrp1UdvSwgpa5oV
 QjsLugtv3ndoI0tY23GXQZPgpZjwUm6F5xj8r/rMGlzV+GJGMwF70aya0t/fkcRsj9kf
 6NJw==
X-Gm-Message-State: APjAAAWbF14yuT8OJThrVooO3hGvsxXw69IOCBxs3jz3sj1BJJwKfATd
 KA7PxjFi0LQMTaX2VOV5ondfcQ==
X-Google-Smtp-Source: APXvYqx/hdNJw8hOBpqJnyg7o7+cJPqViehbs5Haz5us8Y755g6iC5ZO8EJknw7fLaGsymzzXl+PJA==
X-Received: by 2002:a63:2c45:: with SMTP id s66mr1198158pgs.248.1572247290245; 
 Mon, 28 Oct 2019 00:21:30 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
 by smtp.gmail.com with ESMTPSA id w6sm9811583pfw.84.2019.10.28.00.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2019 00:21:29 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2019 15:19:30 +0800
Message-Id: <20191028071930.145899-7-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191028071930.145899-1-cychiang@chromium.org>
References: <20191028071930.145899-1-cychiang@chromium.org>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <narmstrong@baylibre.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Liam Girdwood <lgirdwood@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 linux-rockchip@lists.infradead.org, dgreid@chromium.org,
 Cheng-Yi Chiang <cychiang@chromium.org>, devicetree@vger.kernel.org,
 tzungbi@chromium.org, Jonas Karlman <jonas@kwiboo.se>,
 Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 dianders@chromium.org, Mark Brown <broonie@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [alsa-devel] [PATCH v9 6/6] ARM: dts: rockchip: Add HDMI audio
	support to rk3288-veyron-mickey.dts
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

Add HDMI audio support to veyron-mickey. The sound card should expose
one audio device for HDMI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index aa352d40c991..cf53cb4594c4 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -28,6 +28,13 @@
 		regulator-boot-on;
 		vin-supply = <&vcc33_sys>;
 	};
+
+	sound {
+		compatible = "rockchip,rockchip-audio-max98090";
+		rockchip,model = "VEYRON-HDMI";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,hdmi-codec = <&hdmi>;
+	};
 };
 
 &cpu_thermal {
-- 
2.24.0.rc0.303.g954a862665-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
