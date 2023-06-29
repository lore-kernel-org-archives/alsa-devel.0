Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB4BEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 14:12:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C44F01F1;
	Thu, 29 Jun 2023 16:11:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C44F01F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688047952;
	bh=lgx+RiSzzDkvViE/l/YzeKVXh5tLKNUvtuLe0yKUpb8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Jl3gcDAGXuyAMjBhnUNkk+rpOzYdEQJsQ1uLLFBiUuw16xPwrvhAuwE9/tQTbfAa2
	 DRWz9s+WxyX8hER63p74nxmpDURKhJe7DF7nICQVuk0vUg3vclVCTLwwXTsLgtbuLc
	 0Dz6hXwqrI3WQ3Pv/Se+wEfIABpxdFAn3lN5tDck=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8840BF80571; Thu, 29 Jun 2023 16:10:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B27E9F80563;
	Thu, 29 Jun 2023 16:10:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 368DAF80246; Thu, 29 Jun 2023 16:10:41 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 299D5F80212
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 16:10:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 299D5F80212
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qEsM0-0004bb-E7; Thu, 29 Jun 2023 16:10:36 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1qEsLz-00AvCo-LX; Thu, 29 Jun 2023 16:10:35 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1qEsLy-00BC2Y-UV; Thu, 29 Jun 2023 16:10:34 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: alsa-devel@alsa-project.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/2] ASoC: fsl_sai: Fill Tx FIFO to avoid initial underruns
Date: Thu, 29 Jun 2023 16:10:32 +0200
Message-Id: <20230629141034.2659669-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: DEYG2TR2BUULH7IPR77E7KE4UBGOCH7R
X-Message-ID-Hash: DEYG2TR2BUULH7IPR77E7KE4UBGOCH7R
X-MailFrom: sha@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DEYG2TR2BUULH7IPR77E7KE4UBGOCH7R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series fixes initial underruns that can occur in the TX queue of
the fsl_sai interface when starting playback. These patches are around
here for quite some time and have proven useful. Time to upstream them.

Sascha

Changes since v1:
- Add missing Signed-off-by:

Ahmad Fatoum (2):
  ASoC: fsl_sai: refactor TDM slots calculation into helper function
  ASoC: fsl_sai: Fill Tx FIFO to avoid initial underruns

 sound/soc/fsl/fsl_sai.c | 38 +++++++++++++++++++++++++++++++++-----
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.39.2

