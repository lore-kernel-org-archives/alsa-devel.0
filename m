Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC49C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 13:42:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB2F218B9;
	Thu, 10 Feb 2022 14:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB2F218B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644500566;
	bh=5tPW/YqhYGMQLNvAF+hQaPwiACKlUkeaqqMZxviHvtc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hYUxwTK1+o+uou+CHWtB1SoIddzsM/+Avu5nuUDdUpeCULQYtHjOLTcpyf6nOn2YY
	 jbt8bIVtsQ+BtHms1xL4Fcj1y88kbyrUVFD+i1WYh6Jxm52BITUVYPalX9bTces7AU
	 geO24KPEerzyOgRDV91brHO/5LaVO3oBxHuYlyuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64BBAF8016C;
	Thu, 10 Feb 2022 14:41:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EE14F80302; Thu, 10 Feb 2022 14:41:54 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EC21F80054
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 14:41:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EC21F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="W448nmFw"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 566771F46487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1644500506;
 bh=5tPW/YqhYGMQLNvAF+hQaPwiACKlUkeaqqMZxviHvtc=;
 h=From:To:Cc:Subject:Date:From;
 b=W448nmFw8HNSbVxZAR2A51Rd/IldqxV6x12swftrWN1skn1vdP/a/LqokCZ8pva5O
 KjiLJ9ay3IJIsc/3pyILk0vgWoZKIcJKsrKSc01YW+IYa7aTwtLeP1oTIB04cLeZTG
 L/SxRfdvQfzF5Y+vP4At6gFyyXGPWij77LL+SGK0ejIaBHkUdEcjgs8VMWNtaUvF2a
 HQV8WeEIN7OW5u2YiqO/CYai14I97jb6PGdDM44eU/of0IgQN4rkZSpzx0O+4Z7+94
 CcXlf8bmun+VGUvlMsujIqEiecSDZ44+Tg3tvZSe8TycKdzYm6kNGJNmE+7hSqNVcj
 SvGxVMIxB1b3w==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for
 tlv320aic31xx codec
Date: Thu, 10 Feb 2022 10:40:48 -0300
Message-Id: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ariel.dalessandro@collabora.com, krzysztof.kozlowski@canonical.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, lgirdwood@gmail.com,
 robh+dt@kernel.org, broonie@kernel.org, michael@amarulasolutions.com,
 festevam@gmail.com
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

Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
codec to fsl-asoc-card, but missed the related device-tree compatible
string documentation. Fix this.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index b219626a5403..8b4f4015cfe4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -40,6 +40,8 @@ The compatible list for this generic sound card currently:
 
  "fsl,imx-audio-tlv320aic32x4"
 
+ "fsl,imx-audio-tlv320aic31xx"
+
  "fsl,imx-audio-si476x"
 
  "fsl,imx-audio-wm8958"
-- 
2.34.1

