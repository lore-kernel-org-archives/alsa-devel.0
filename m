Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FBEC25B75
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:08:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74FA7844;
	Thu,  6 Jun 2024 09:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74FA7844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717657688;
	bh=2OUU5c+0oHQOjiWiuROmSRGh8j3BqgUxQjKXgFVzcJo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UM+da2ga6ki8baER0Pxi/X4V7zkjptemhFG64k6G1zrbdJLJX6OoKAvTKdQlNVCMY
	 KULG05RWdoJLyjCUY8m0bpsQl1fpFaU3HDeRRrp+Uj01eMyWuaI2t/wmb4KnPZOKvM
	 hvWk6IO1GSRoa1eDt+K3BeJ+aT8G42guIgHahc28=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C48DF805A9; Thu,  6 Jun 2024 09:07:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E869BF805AA;
	Thu,  6 Jun 2024 09:07:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AEABF8025A; Thu,  6 Jun 2024 09:06:57 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9D23F80088
	for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2024 09:06:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9D23F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=qYmUcVRW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+eJtUnrby00UuoYKS4VrVufy1eG1BTDW7IZPCyp/z7Y=; b=qYmUcVRWvbjX5/xj0PoVu+tz2N
	jF2ZU0UEQ8d2sOcVbXn6+BRC6fxCQ3uCDkQqloOgx/H//mS7FxUesSahfTYB77SffP0Y8q2Ui4PPQ
	1+wzk/MuOoI7sh8+K62MAQwQIoD60b/KelCtq7E/H/l+5GCgsUeQEjiStKxJQYwdk2SgJc87C3j8k
	drPOCeszU7JTRglLz6u5OJuhYqWui+ku6zqKHXE5HTkcwh/VpYQa+jmmvLLSmeUU87SdrIssT6F6n
	J2c++EF+JabD5uKDDnyFRhQenPhaRww3+/TOEzbnZ0m/Yb04vYULkbub+23QD3TmSOgyxUiSGxR1v
	ZIgunZlw==;
Received: from [89.212.21.243] (port=46262 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF7Cw-00BN3X-31;
	Thu, 06 Jun 2024 09:06:46 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-omap@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH] ASoC: ti: omap-hdmi: Fix too long driver name
Date: Thu,  6 Jun 2024 09:06:45 +0200
Message-Id: <20240606070645.3519459-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-ID-Hash: UMSRQQRVCX2EER4YQ4ARBXNMT2Q2VB6Z
X-Message-ID-Hash: UMSRQQRVCX2EER4YQ4ARBXNMT2Q2VB6Z
X-MailFrom: primoz.fiser@norik.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UMSRQQRVCX2EER4YQ4ARBXNMT2Q2VB6Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Set driver name to DRV_NAME. This simplifies the code and gets rid of
the following error messages:

  ASoC: driver name too long 'HDMI 58040000.encoder' -> 'HDMI_58040000_e'

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 sound/soc/ti/omap-hdmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index 639bc83f4263..3f35eedeea41 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -354,11 +354,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
-	card->name = devm_kasprintf(dev, GFP_KERNEL,
-				    "HDMI %s", dev_name(ad->dssdev));
-	if (!card->name)
-		return -ENOMEM;
-
+	card->name = DRV_NAME;
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
-- 
2.25.1

