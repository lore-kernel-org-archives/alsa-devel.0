Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF17D58083
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:06:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7CE5850;
	Mon, 25 Nov 2024 13:06:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7CE5850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732536392;
	bh=AaWzNmPanX5YKolifrNLLKttu50LroQ154hrgtAyd3g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=um8IBLIy4uHQ+lFUmZtPSgEuS7zFZ8w3rxySygy3oyr1sQT9hsdPKIYGTpoSLY+Um
	 zV158hVgE4qMfMz6cyVxzKdUKFiBIVpGGCaZRkxU1GuVZw3WSQtUgzILsjynhJNbCL
	 GD9BpRHhp1//yO5t22wP+whMQFPZ8JTgosKj7cDk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 182D4F805B6; Mon, 25 Nov 2024 13:06:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEEB5F805B0;
	Mon, 25 Nov 2024 13:06:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFA62F80496; Mon, 25 Nov 2024 13:05:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 02AD6F80134
	for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2024 13:05:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02AD6F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732536349380672693-webhooks-bot@alsa-project.org>
References: <1732536349380672693-webhooks-bot@alsa-project.org>
Subject: 1.2.13 will lead to mute of speakers and headphone jack on MTL laptop
 Lenovo Youga Pro 7 14IMH9
Message-Id: <20241125120556.AFA62F80496@alsa1.perex.cz>
Date: Mon, 25 Nov 2024 13:05:56 +0100 (CET)
Message-ID-Hash: ZRCRDYLEDAJAXYG2B4GB7Y5JFXBRN2GE
X-Message-ID-Hash: ZRCRDYLEDAJAXYG2B4GB7Y5JFXBRN2GE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZRCRDYLEDAJAXYG2B4GB7Y5JFXBRN2GE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #472 was edited from phush0:

Changing version from 1.2.12 to 1.2.13 will lead to not working sound during plug/unplug of the head phone jack or mute during reboot on Arch install. Other ppl with similar laptops have reported same problem. On my version codec is ALC287 with bass speaker output. I can unmute speaker or headphones trough alsamixer, but plugin headphone and the unplugin will lead to both mute. Sometimes reboot will lead to same problem and I have to operate channels by hand again. Similar problems:

[https://discuss.cachyos.org/t/sound-problems-kde/4350](https://discuss.cachyos.org/t/sound-problems-kde/4350)

edit: reading more seems like problem is with the new HDMI macro, because other report problems with HDMI output.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/472
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
