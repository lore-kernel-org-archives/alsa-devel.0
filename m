Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E4CCD1BF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:47:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F04160201;
	Wed, 29 Oct 2025 07:47:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F04160201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1761720451;
	bh=rQ8J0p9JDCUyxcfKZimun80/cERVw3/3TEyKhdgDDVM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cxjZ1Nvq9dJfjbeVuBCiFZzu83AAk/SFMg4bAB9tWQHhZOg147KGpts+pCGvTmma4
	 TGUFDcc7DSDxLodEj6bCEun5Jcp8yFMY58/2vH4UgD/2rUx0ZOr808HHmDSsyoMtgV
	 c1IzeufpeBs1Rmk9KP3qUF86cmkUrMGuu6QD3LgY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A02A3F805C7; Wed, 29 Oct 2025 07:46:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC11AF805C0;
	Wed, 29 Oct 2025 07:46:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EAA3F80423; Wed, 29 Oct 2025 07:45:32 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 51C46F800E4
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2025 07:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51C46F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1872e34df2020700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/631@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/631@alsa-project.org>
Subject: Qualcomm: qcs616: Add TALOS EVK HiFi config
Date: Wed, 29 Oct 2025 07:45:32 +0100 (CET)
Message-ID-Hash: 6IETXK2UCGEUDS2ZBZDBACW3OBUJWQJR
X-Message-ID-Hash: 6IETXK2UCGEUDS2ZBZDBACW3OBUJWQJR
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6IETXK2UCGEUDS2ZBZDBACW3OBUJWQJR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #631 was opened from mohsRafi:

Add UCM2 configs for the Qualcomm Talos Board.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/631
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/631.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
