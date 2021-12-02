Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AA5C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 16:27:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 275E8289F;
	Thu,  2 Dec 2021 17:26:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 275E8289F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638462462;
	bh=7pgg+1u0+ZH7zsGEatQ3UB4LT0TWPXgCbu3efrCJQAY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7GHVt5oEWn60MR4OWgRO5KozEqDZoqDMXBs268HWNBO40pCUsHqzlG/BAchtbZ41
	 czw997y+omQSK9D69gMDmrMYVu6chNbeSt4u7Va0zcpwLrhV8NAINsaTC7VyAmgQDG
	 VErTU+TKnWhWL78etoXAZ7n58wYHgBp9+2xWV9zM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A24AF804E2;
	Thu,  2 Dec 2021 17:25:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D5B0F80507; Thu,  2 Dec 2021 17:25:32 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 272E3F802A0
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 17:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 272E3F802A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lMiY1EXt"
Received: by mail-lf1-x136.google.com with SMTP id n12so72862241lfe.1
 for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2021 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
 b=lMiY1EXt4w+RL9u0IPATTDoQY0ybYySCgRRawq7FiQQ6cu8lGKSuRmzHsR0SYmAs9E
 NTwTFVZDuohdN6l5gAxtcgSan+WimVzGGoQLdRUHZccNPI2adS24DLVL1BUaefWqfIhJ
 CJuCuHsM6SA+zRVoRBhK4Okt3KwSdqS3aZhu6TRUnZo97joIoej0hmLU0eSlmKSokw22
 CfKi27lCSZXfyFjaclrJ+rFKYg3dtqoo0SDNuuysa/OSPlnIrAvPuIj9S4s2yzuXwWRP
 kUwBE+9zfZfWrjCsepQmTitsjcgaBbKcoKzsAP6P6BbqXGqxSIfPFu5nWAmeNYtQOQkw
 KG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
 b=XvxyClQX81H15oTA1vsyCjuzyp6zdH5XaBoYPrdoYzJQ8os4xpc88IbGH5DAX5adnJ
 Zt44NnthYSUBMXWWOkTUszlFC+ZMZu/rEgojyklHyM1rVnbZu0sPU72p57xGAWzU5bik
 OlIIDsuf/canNzsD1SuS1XS6UscpnvEsQsy0cRXCSGkvq1ORPmXTqESLjBCjDk7xUBCP
 CGXvDmYgdnGHfay3d3JgRJKa7lUI8kl7Pu0TCJ6y8DSYgFnReFXzl/idibp2f2aXAWPO
 g6cCseZAdGsR4lO4IAltB8X3iQZzEVeZnmOJSRFlsiO26nyeVM8l1N7YVjn76sDYogPh
 zX7w==
X-Gm-Message-State: AOAM533VUKrGWrcQHe3k8qhXU21atfH6umTUX+slHDBWuApDsob5/yol
 24TnjKBOrggDauq9Jtwr32Q=
X-Google-Smtp-Source: ABdhPJwlmJsck7gfHr6wwFHtKiWtjlI65dHudAqSt9x2WsizwLZ0RHza4o9/pwyFMZ5LqykxSAe8yQ==
X-Received: by 2002:a05:6512:2304:: with SMTP id
 o4mr12337688lfu.104.1638462319854; 
 Thu, 02 Dec 2021 08:25:19 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 08:25:19 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Agneli <poczt@protonmail.ch>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 04/20] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
Date: Thu,  2 Dec 2021 19:23:25 +0300
Message-Id: <20211202162341.1791-5-digetx@gmail.com>
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

Document new optional sound-dai-cells property of HDMI node. This node will
be used as endpoint of HDMI sound DAI graph.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index e61999ce54e9..27b746f28f31 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -297,6 +297,7 @@ of the following host1x client modules:
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
   - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - #sound-dai-cells: Should be 0.
 
 - tvo: TV encoder output
 
-- 
2.33.1

