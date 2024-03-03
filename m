Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D7BC48BF6
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Mar 2024 11:21:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20B78836;
	Sun,  3 Mar 2024 12:21:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20B78836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709464913;
	bh=+2fy6/YpVwav4dAQCL/bXKWwJneS7Y4+E2iA7bvOiaA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XZUTxeo2oQ60BiPJPqhYssmkx871mAdOYRyHxWpgjOmJKZDvbFI7U6rl3HtvY6Eri
	 sjl5Xw9lQySfN4SM5qsCY/RgEdQRbCdT+nf4h3JeG4vdDVI1lQywNFkXG3WUM7sKv8
	 ZIMImcLr39rX30QHuGSGzkmbGm/K4w30b4KTFBEc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B651CF80563; Sun,  3 Mar 2024 12:21:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1EC2F805A8;
	Sun,  3 Mar 2024 12:21:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDFE4F8024E; Sun,  3 Mar 2024 12:18:14 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 86658F8014B
	for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2024 12:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86658F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1709464688307764292-webhooks-bot@alsa-project.org>
References: <1709464688307764292-webhooks-bot@alsa-project.org>
Subject: Internal mic does not work on IdeaPad 3 Chromebook
Message-Id: <20240303111814.BDFE4F8024E@alsa1.perex.cz>
Date: Sun,  3 Mar 2024 12:18:14 +0100 (CET)
Message-ID-Hash: Z6UJCQQPXOZK7VYGJI2LXXWJW2IPYBX3
X-Message-ID-Hash: Z6UJCQQPXOZK7VYGJI2LXXWJW2IPYBX3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z6UJCQQPXOZK7VYGJI2LXXWJW2IPYBX3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #397 was opened from abhi-deshpande:

Device - IdeaPad 3 Chromebook (Octopus Lick)

OS - Fedora 39

Card - sof-glkda7219max

I recently converted my Chromebook to Chultrabook and installed latest Fedora on it. It seems that most of the audio stuff works, but the internal DMIC doesn't work. I read some previous issues and commits and found that this is due to the fact that the DMIC needs channel split as CRAS does. This was being implemented in #154  I guess. I am currently on lastest alsa-lib and alsa-ucm-conf. What could be missing ?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/397
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
