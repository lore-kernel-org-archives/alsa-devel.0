Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE8AC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:49:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F0F2222E
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qhmRdXR7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/P6lB+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F0F2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71B2217D2;
	Tue, 17 Nov 2020 20:48:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71B2217D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605642545;
	bh=cdCnhWNwtTkMNU7okWv2gCB2pWFhZYO+A3MGfiypVqQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qhmRdXR7kQAxDqSYS2ugr6U+YVIbi+jythCxIOnqsbkZvwGqxqEi9ZjczmLJwS71S
	 Nyk3YInwK5Q4t4IJv1ckivyTqUq+lxDKiP5tWXZX03+FbBELaoHuHC+pRRfu0wF5jd
	 E75KlYEiuFeJsQCh2rXfpUgel2SqpUFO06YlR4w4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90E63F804F1;
	Tue, 17 Nov 2020 20:45:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3486F804CC; Tue, 17 Nov 2020 20:45:39 +0100 (CET)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B2C3F804BD
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 20:45:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B2C3F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="j/P6lB+w"
Received: by mail-ed1-x542.google.com with SMTP id k4so7031389edl.0
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
 b=j/P6lB+wO6vdZOi5Agv1mqQVbIrni+q+ALO6i+QbbntEAjO3ALjbyoaIccUUaOa0Yj
 o6cvV+wMx3wOdDlbzNzxjXywYGNQbe72oR4JacgcqedptYB1kV4gPGE+9dGv9jes269G
 Bq0r064CiJxLQraZzATdDk96xLcU/rIXbMJPuKTx1omwbiBt8qZeYKJpGfqDIPuYdMfY
 kyat5CUjgA9yeRMemvobcamXiv2alDl+Dd1uzPC8Lmqx7g7WXqB3glUF4qtkFkoaYh1h
 ZI4XdciXwfyp2DhlBEthUhQgPupbBA3tggimAtRPScUSsyZY2QGd69uiH5vjBKPHREA3
 /ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MNzWsDtU39BR4iFEfSJQ9mnoYu92ToJLMEGgLWUUrPw=;
 b=dLsjQpHHG2XT5eVG10D7T+TBq/Sbj+bDxUPRI7MRdYqYA4Tx++BVMkccP0Gsx8GqUN
 GoNueS0cgHo82nRjlGpwlc6F+VdSlAZsrBQG5gSr85y2jvJ36sEMHtMJU4DdOXhabrIB
 s9l9Brepsv2eNoaT5bgHh1fkT5Z24ZifWxRJG7DBONI3DSpVtDMm/qtcbeDl4OAS3U/l
 pItSW48kWFgeaSYWZnpOo/NojDjk9aOoyRpJkkj653rNQkPezZveKNxzx0ArGOsUenYn
 oLS940lq1yOc2cyPTqat5M7S1h7MSMqSFdLMuksuJeMMxbJe5Na3NHqEoT1aJ8tIGF8l
 l4bA==
X-Gm-Message-State: AOAM532jpUju38XCsXN/lA032X0eK+idlJofDjoF6yHZoHx61uEoX6tb
 mhXtY+sX4E1GxVprTbqzpok=
X-Google-Smtp-Source: ABdhPJyrzzhxGF5lvPmDjYfPklRS9F51sz7rQAaESr2rA6OkcPjado8yI8xHELXCq5r82ignHt0H3A==
X-Received: by 2002:a50:a105:: with SMTP id 5mr21926061edj.165.1605642324325; 
 Tue, 17 Nov 2020 11:45:24 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2020 11:45:23 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v4 7/7] ARM: dts: rockchip: enable hdmi_sound and i2s0 for
 rk3066a-mk808
Date: Tue, 17 Nov 2020 20:45:07 +0100
Message-Id: <20201117194507.14843-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201117194507.14843-1-jbx6244@gmail.com>
References: <20201117194507.14843-1-jbx6244@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
 airlied@linux.ie, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org, lgirdwood@gmail.com,
 sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, daniel@ffwll.ch,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Make some noise with mk808. Enable the hdmi_sound node and
add i2s0 as sound source for hdmi.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index eed9e60cf..5fe74c097 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -116,6 +116,14 @@
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.11.0

