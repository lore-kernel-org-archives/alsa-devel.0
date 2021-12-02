Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D303C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 16:32:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 750BB298F;
	Thu,  2 Dec 2021 17:31:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 750BB298F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638462755;
	bh=In3mLWtGDD+dbq28/TAIw2GWqp3plC4mvHCKuvHKlMU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8lV7sPHtRqNwgSlFzRGKPMZ59aBkIEIPdzS8ZrSFj16bagjbMExTTk3/IPtE8Uya
	 4Lp9uEhXh9JYrZYSoECeabEkmaRauPpXe6y2tebGmfsCKUwzjJn+z8c1HaL/BTpXlZ
	 VxM6ZuHSttlD3//XXcnELmz8aSS7mItlAQxeCCd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F7F5F805A0;
	Thu,  2 Dec 2021 17:25:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90CE3F80301; Thu,  2 Dec 2021 17:25:46 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 476B1F804F2
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 17:25:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 476B1F804F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aAmo87x7"
Received: by mail-lf1-x130.google.com with SMTP id t26so72772997lfk.9
 for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2021 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
 b=aAmo87x7MKY0+QkIiV1iYDAGkJpjUtS0nLp1b76Wocjq5LssoGlpY86GAohlboJ8Xx
 PpEV5/ex7E5NW1eoaI3yz6HBQt6qke3IzgiWVpYQOrfDVPLMcWsLt4fZ/SCvocWuWqbP
 kEv+h49CXlKWcQhzjoXBthjasMcdyBUZNY3N4mVCPj707UAa9TToCOvF0yX1+hVoAk1N
 hH7A3ZmokIyA0KxpI/ka5AQp5I8+9P7u3sNOoscPnwd9sk1F1SmALlJkWw4N9Pl//x2T
 yrFfMoKYJGCgMRH4Qh/iOVBKDWY8VdMjsg+kKpjl+HGy0oZblGHVebwNkkG0cLEURfVe
 p3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
 b=iKZx9TOL83kWoxf2DU3z21COstFHqsTWy2tw92jTp3Fat1gPQvBvWuPoH/m6Pq0Ziq
 FgHgXGQX3dLa71AxMQR48W6vvHZCe6vBMASF3od7fI/DBgNJy2CTmerJX534ngZxHiq+
 XKlc0i3tfpnUFsNHmy7D6TP1sqQPRJCKO6rDjkpjHv8mSJ5OrbD3g4pERodNIN6SzEMz
 dmSZSUBaW5ppYDIrhKrgg5u9rt6iwbzJbXpOFHnUStB+pccd9u/G4QwTJ9b+Vr8DXEs3
 wa/3wSFyn7seO0gasU5x0T2NbYLusdesdq0z8jA7sWLRKc090FMI4GGoA3ZeIpPJQxoF
 1UbA==
X-Gm-Message-State: AOAM5300vkBv0VI9K6abp3KD/cna+/4tT2Rre/zmG+kavxrAD7HdGVWw
 G7gLZtPuRk2NIqmVnDc7aBE=
X-Google-Smtp-Source: ABdhPJxCY0oVQ8aH83x+4OlvUDxHC37p5YyeIHFpmCbaFqheC4dbnYNMwVyp5NGlNDxLxHNpXrhAQw==
X-Received: by 2002:a05:6512:138a:: with SMTP id
 p10mr13129433lfa.508.1638462333467; 
 Thu, 02 Dec 2021 08:25:33 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 08:25:33 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Agneli <poczt@protonmail.ch>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 19/20] ARM: tegra: acer-a500: Enable S/PDIF and HDMI audio
Date: Thu,  2 Dec 2021 19:23:40 +0300
Message-Id: <20211202162341.1791-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
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

Enable S/PDIF controller to enable HDMI audio support on Acer A500.
Use nvidia,fixed-parent-rate property that prevents audio rate conflict
between S/PDIF and I2S.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index db388ddd062f..f47b946627c3 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -376,8 +376,16 @@ pta {
 		};
 	};
 
+	tegra_spdif: spdif@70002400 {
+		status = "okay";
+
+		nvidia,fixed-parent-rate;
+	};
+
 	tegra_i2s1: i2s@70002800 {
 		status = "okay";
+
+		nvidia,fixed-parent-rate;
 	};
 
 	uartb: serial@70006040 {
-- 
2.33.1

