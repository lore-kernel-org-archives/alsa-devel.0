Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB6D5A6DC
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2024 03:52:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E267DF50;
	Tue, 26 Nov 2024 04:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E267DF50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732593143;
	bh=pViNGV0gfojYoog7teT5wqNqJrywoXoORl8Wpp+roIs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pBame5wL2Ji+vmjj3qdRde9DDlgw8uOXCnFJV4Gu9efnr99mC/Qs9VjdMrKZT0FRt
	 HdqEWK0kv7Of2c0zZSZi4xp69dCMZnptwQeNe7cH+Up8HQg0GLHIYV4zv72EjyLnXL
	 DnVtpXM+lXCqgMyLfiTCkJ/fN7acRg9LAHH2Yyws=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40A55F805C5; Tue, 26 Nov 2024 04:51:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4500FF805C3;
	Tue, 26 Nov 2024 04:51:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C42BF80496; Tue, 26 Nov 2024 04:51:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B7942F80073
	for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2024 04:51:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7942F80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732593105390655994-webhooks-bot@alsa-project.org>
References: <1732593105390655994-webhooks-bot@alsa-project.org>
Subject: Device selection regression in 1.2.13 for LNL
Message-Id: <20241126035147.7C42BF80496@alsa1.perex.cz>
Date: Tue, 26 Nov 2024 04:51:47 +0100 (CET)
Message-ID-Hash: CXYUS2P7DIC2ELDPEZOFS3D6AUHLCAW5
X-Message-ID-Hash: CXYUS2P7DIC2ELDPEZOFS3D6AUHLCAW5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CXYUS2P7DIC2ELDPEZOFS3D6AUHLCAW5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #474 was edited from CarelessCaution:

On Intel Lunar Lake, there seems to be a regression in alsa-ucm-conf that affects device selection in KDE Plasma and probably in other software. In 1.2.12, there are the options Play HiFi Quality Music and Pro Audio for both input and output. However, when upgrading to 1.2.13, there is only the option for Pro Audio.

This problem is immediately remedied by downgrading just the alsa-ucm-conf package on Arch Linux.

According to `aplay -l`, the audio card is sofhdadsp .

Before (1.2.12):

![before](https://github.com/user-attachments/assets/c7fa81e0-97f1-45ae-a14e-8549f85cdd27)

After (1.2.13):

![after](https://github.com/user-attachments/assets/5867886b-6686-4265-ad68-50c7f53e1a47)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/474
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
