Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA32C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Oct 2022 19:10:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA3B189E0;
	Fri, 21 Oct 2022 21:09:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA3B189E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666379408;
	bh=7tSbZ3o9rnEZxiNzuX4/brBcjhft4z9R+3Odm3eod+c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DZj11b+d978+nbc7UVQQUfrfrx6C5Fk9TuQO1A3Zd/Vbm9S3bjCP7/FIIgH1xbOVF
	 EZnwpZVCBWwrR3Z2b6ndex++Wrznrfc3SFaDNVasfhkWWoUNHzGss9WUotvqVlaKVB
	 UXuyJsOvVcxOzDcprLh1SesOxE1iNnBS96Ncy4cE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D28AF80256;
	Fri, 21 Oct 2022 21:09:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15D2FF800B5; Fri, 21 Oct 2022 21:09:17 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B87CF800B5
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2022 21:09:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B87CF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="lhhM2+K+"
Received: from notapiano.myfiosgateway.com (unknown
 [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 03B5066025FA;
 Fri, 21 Oct 2022 20:09:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666379353;
 bh=7tSbZ3o9rnEZxiNzuX4/brBcjhft4z9R+3Odm3eod+c=;
 h=From:To:Cc:Subject:Date:From;
 b=lhhM2+K+4Va/Ait9eg4Xp6JcNcJOQtx7J0hSCLTEedwUhOxPAvPUB/lvngidszGux
 zUA9LmmgdC548TQKqg2E1tjwxDLgqQ35mWG1U4O0NsUI0NdN5mgbwng4I3q0Njd3nT
 /rHoqEibFAtJ1HVu6HCBKJVECwBwbDnbZyx/NrRXJvfCO+26LM46XtK4Hb1mirCs0r
 Z+wT8lYDalJkeccTmB5tGaXEjWVjsAWn21wbTA/qBJBAjeEl2BgIbGXs+OeeViuxtu
 GI3xwimrJgct2RkGt7Kno4A1OROtVGyw/LP4qJKBx0tBrNKi/aMMizRwuZuJShuNQ1
 z/b4Brc3UJ2Tg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] Add missing dt-binding properties to rt5682(s)
Date: Fri, 21 Oct 2022 15:09:05 -0400
Message-Id: <20221021190908.1502026-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


This series adds the missing sound-dai-cells to rt5682s and supplies for
both rt5682s and rt5682.


Nícolas F. R. A. Prado (3):
  ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
  ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
  ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies

 .../devicetree/bindings/sound/realtek,rt5682s.yaml         | 7 +++++++
 Documentation/devicetree/bindings/sound/rt5682.txt         | 6 ++++++
 2 files changed, 13 insertions(+)

-- 
2.38.1

