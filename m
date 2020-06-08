Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D7C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:23:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9539920897
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YnAakWCA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z27QsmRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 210BE4E;
	Tue,  9 Jun 2020 01:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 210BE4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591658600;
	bh=O84gu8JATb2e8SHlXObL3eCI/z49fjPGgXDZ+gNoxq8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YnAakWCAG0UCbZvF8TIRrTmrjTLvYHfB1XVJilamQdEQTjwCAfwoSOAT11RU61y6Z
	 qkXbXJ6uqDqLA89aU2z+VM4J+99G9e8KEDSD5HM7c/co6FbGh6WEOVriPsWkBBjpoD
	 BR1soLv2/rinGSEqTHAcGUAJCqrMBDOVMQzqHa0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 288E6F802C4;
	Tue,  9 Jun 2020 01:18:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E2FAF802C2; Tue,  9 Jun 2020 01:18:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C42FF8021E
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 01:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C42FF8021E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z27QsmRK"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74BFA2086A;
 Mon,  8 Jun 2020 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658318;
 bh=O84gu8JATb2e8SHlXObL3eCI/z49fjPGgXDZ+gNoxq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z27QsmRKrm+p4cOdvIJ9vRP0mhGlWM7Zuadsu80JzAHQeFzneWZ3wvir5W8cOduhx
 w/8ouehkQ+Y8X/QoO4V0+L8kfo4vLqCqmpsVnWSd9l2fvV7GDZQAI8cpX9gB/PrWpf
 JSly85/N9rn0qYzZsN6j0Sk0ICaSGSaH4lm85ku8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 318/606] ALSA: hwdep: fix a left shifting 1 by 31
 UB bug
Date: Mon,  8 Jun 2020 19:07:23 -0400
Message-Id: <20200608231211.3363633-318-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Changming Liu <liu.changm@northeastern.edu>
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

From: Changming Liu <liu.changm@northeastern.edu>

[ Upstream commit fb8cd6481ffd126f35e9e146a0dcf0c4e8899f2e ]

The "info.index" variable can be 31 in "1 << info.index".
This might trigger an undefined behavior since 1 is signed.

Fix this by casting 1 to 1u just to be sure "1u << 31" is defined.

Signed-off-by: Changming Liu <liu.changm@northeastern.edu>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/BL0PR06MB4548170B842CB055C9AF695DE5B00@BL0PR06MB4548.namprd06.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/hwdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index b412d3b3d5ff..21edb8ac95eb 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -216,12 +216,12 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 	if (info.index >= 32)
 		return -EINVAL;
 	/* check whether the dsp was already loaded */
-	if (hw->dsp_loaded & (1 << info.index))
+	if (hw->dsp_loaded & (1u << info.index))
 		return -EBUSY;
 	err = hw->ops.dsp_load(hw, &info);
 	if (err < 0)
 		return err;
-	hw->dsp_loaded |= (1 << info.index);
+	hw->dsp_loaded |= (1u << info.index);
 	return 0;
 }
 
-- 
2.25.1

