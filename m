Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C7C54ED1
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Jun 2025 22:39:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61625601F9;
	Sun, 29 Jun 2025 00:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61625601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751150344;
	bh=g0/lIC8zNaJIJcIQjYugP8XNdsZSe3fwn6STp13ExhE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ufx0k/lXDlayHwxL9041hWa882j1ve11gN7NfHMjIsENGSkjHr4ZSCbgy2b0eOEXG
	 j7kpkbX/JhKihoUwZZMrSAsusTYti71b8kb5ohmcVcsYeb9PEjI7Lq9DE2llfwLe3s
	 n5K1Jc4Kol2+nMByG5Yb9Ct1w35wmbE79MxpmUxY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D753BF805CA; Sun, 29 Jun 2025 00:38:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6A6CF805CB;
	Sun, 29 Jun 2025 00:38:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1963F80254; Sun, 29 Jun 2025 00:38:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 21E7DF800B8
	for <alsa-devel@alsa-project.org>; Sun, 29 Jun 2025 00:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21E7DF800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184d55ec94f37d00-webhooks-bot@alsa-project.org>
In-Reply-To: <184d55ec94ebaf00-webhooks-bot@alsa-project.org>
References: <184d55ec94ebaf00-webhooks-bot@alsa-project.org>
Subject: tascam us 322 / 366
Date: Sun, 29 Jun 2025 00:38:26 +0200 (CEST)
Message-ID-Hash: V4JSI67EMNBPR4N2YINSVCNC5QZRJEBS
X-Message-ID-Hash: V4JSI67EMNBPR4N2YINSVCNC5QZRJEBS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V4JSI67EMNBPR4N2YINSVCNC5QZRJEBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-firmware issue #12 was opened from riramau:

Can someone add support of  tascam 322 / 366 ?

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/12
Repository URL: https://github.com/alsa-project/alsa-firmware
