Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6971ECAAD8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Sep 2022 08:19:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AB5074C;
	Wed, 21 Sep 2022 10:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AB5074C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663748376;
	bh=4Ob3D41sWCzCrw8sNk0X2e0ieGD8rnn8f6KxSgaSI28=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GmsT1ZgBzE/g4lzhW2wcBgzC9TgXjwzaF59lhhQ1XFmrN14Dg0ZJIrEtTLS3fHt8J
	 Vpcj2CDlBwYda/4DtsZjZD6cjGI+BeezHDnUV9D4AmdRBYjsj+wIZtRalDM1m8mn4E
	 uokGkjaDbpBQ3gHxHDE3L1Fh+uQ5BuPSVm9iV3w8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 940F4F80425;
	Wed, 21 Sep 2022 10:18:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E971AF804C2; Wed, 21 Sep 2022 10:18:43 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF316F800F3
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2022 10:18:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF316F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="bUC/y54Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1663748318;
 x=1695284318;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jiRLDh887L4stWEL7ewRK0p/C0iReg1uXK5CF30Jnd8=;
 b=bUC/y54QJIvkYnXXGmt5R9cdfBrzbbHKYavhda6icvKg+7AfYOl74p1N
 FFaTipMUTw2CsoAvbeYZDgHnIile2Tv2UT174efzcYBZlOZVLd+kA7Zzu
 OQxI7m01RbGiX5gQ08pVvzBLAesG3pFzv8pCJa9THb0FnOWaTkg1msKxI
 QSSrjDmkSRYyycw1+dUskyD71tmjoj+9KSjJPdXYv+n4ftD8eZrSww2L+
 MoEEmogNwgn5pvndMVEtNrjBaT9/102MqIcX3EFNsX8DXmNOtMFm5BC79
 bPmTYMDl0ow4xwjFubyIa43GxGzOOewHVTr8F7MHuLrmtBqkc48jTNFrK w==;
From: Astrid Rost <astrid.rost@axis.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 0/3] ASoC: ts3a227e control debounce times
Date: Wed, 21 Sep 2022 10:18:31 +0200
Message-ID: <20220921081834.22009-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Astrid Rost <astrid.rost@axis.com>,
 kernel@axis.com, linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>
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

From: Astrid Rost <astridr@axis.com>

PATCH 1 - convert ts3a227e bindings to yaml.
PATCH 2 - add ts3a227e bindings to support debounce times.
PATCH 3 - add ts3a227e driver to support debounce times.

v3 -> v4
Removed the comments on enums in Patch2.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>


Astrid Rost (3):
  dt-bindings: sound: ti,ts3a227e: convert to yaml
  dt-bindings: sound: ti,ts3a227e: add control of debounce
  ASoC: ts3a227e: add parameters to control debounce times

 .../bindings/sound/ti,ts3a227e.yaml           | 94 +++++++++++++++++++
 .../devicetree/bindings/sound/ts3a227e.txt    | 30 ------
 sound/soc/codecs/ts3a227e.c                   | 61 ++++++++++--
 3 files changed, 149 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt

-- 
2.20.1

