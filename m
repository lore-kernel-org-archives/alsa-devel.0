Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEBC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Mar 2022 15:44:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D839170C;
	Fri, 25 Mar 2022 16:43:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D839170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648223067;
	bh=kvALX1GJRsikz9wglWA8DXnAH18Khh6iJNApWrtipi0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p9swasIGg8jpvDzeO0KToKGurmFcdci3SdBXrwhCgPywR+FBftMgqZ6tR33BdixAI
	 V+xSs6Ds3S2c0Xk9j8/S9SBdCkeCDnulsLJ+MRx+x3gjGo5bZNpnUoP2bVhj+0vVX3
	 zpkQuV8xmA9ucMrDI8TcG4tMjwl+Pigfs6PMb+PE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E0E9F8012C;
	Fri, 25 Mar 2022 16:43:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40218F800F4; Fri, 25 Mar 2022 16:43:35 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B12E3F800F4
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2022 16:43:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B12E3F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FeaMGugQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E4155B82902;
 Fri, 25 Mar 2022 15:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B4C340E9;
 Fri, 25 Mar 2022 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648223010;
 bh=kvALX1GJRsikz9wglWA8DXnAH18Khh6iJNApWrtipi0=;
 h=From:To:Cc:Subject:Date:From;
 b=FeaMGugQPDt/lwn+bP33kq6xL6BSdHmcsJP2+AlHmU04rriz7pj1k9tmRWoymWKlt
 6ZNov9hq5DF9oekL9XkvbN3HUrkdd1PJNZ5dz3/r62TS+POgWuWANDMiZThcp96kY9
 6g40dh5HdftZNbJ6JoFMTeK8wejCGQmfSHlM27TNH92z89fFUwfGBm7v51ZWYt6vAy
 knfcPjDe4DAB4hy2SE2TqrnHZyUY01EL/7AMfnsm4Dh3x0Jk4Sd/iknpkz2+1r89kx
 hRae28Wy/00WhOKtgn0Yj1bSzu8WQDZbPhE143xeg6DHQ6in880j348drbHvS9Jz5w
 iYxWI+njyFz5A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v1 0/3] ASoC: atmel: Fixes for AT91SAM9G20-EK audio driver
Date: Fri, 25 Mar 2022 15:42:38 +0000
Message-Id: <20220325154241.1600757-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; h=from:subject;
 bh=kvALX1GJRsikz9wglWA8DXnAH18Khh6iJNApWrtipi0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiPeLue07qKZxiK1ZOQl5HhxWfyc9LGOA7BpN4Ic5L
 5ooL/gOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYj3i7gAKCRAk1otyXVSH0AjQB/
 45+EhNxvdb1yLrk0HQcrWRWXLueX50zygITAFyZznW41guRPhBRTPHYDx3Ptdz+R+scC5y0ibVUSZf
 6m89/3Ty1MidAbhurBzAdacr6OVB10MTlUNEPcImgt2mgjZpj/X7Y36w/Z43zldrUJiTPxugwBSofA
 s0lehhkTS5aZU7RqxPWZeEsk7d8ndjsOSaopMowaf6dYfDVfK1LmMxBagvqeDnhdgDnR0wRyk2vc+R
 Q/bit3B0pH9qyP6J370BrSqy5JZPjEhbtLk0u+5fVHJiFrWL5gcuInNozfU+ir2UweN8g85t1ziyXG
 +lsGMvbWIDGZ3w0Xq63N7QDFuhrI0g
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

At some point the machine driver for the audio subsystem on the
AT91SAM9G20-EK appears to have bitrotted, no longer probing due to
effects of the transition to the common clock framework. The first patch
in this series fixes the initial probe problem, with the rest of the
series being random other fixes and cleanups I noticed while looking at
the driver.

Mark Brown (3):
  ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek
  ASoC: atmel: Fix error handling in at91samg20ek probe()
  ASoC: atmel: Don't squash error codes from atmel_ssc_set_audio()

 sound/soc/atmel/sam9g20_wm8731.c | 74 ++++----------------------------
 1 file changed, 8 insertions(+), 66 deletions(-)


base-commit: f590797fa3c1bccdd19e55441592a23b46aef449
-- 
2.30.2

