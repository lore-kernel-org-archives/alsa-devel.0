Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF99BC021AF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:55:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09F0E603C9;
	Tue, 18 Feb 2025 16:55:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09F0E603C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1739894153;
	bh=utFfQEGZPAnc6sSLN21wtVVMVZydvPsaAlLxGC6lImQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fhoIvvxnKNH/VUIWCNkOreIhJQXPFYFn2pSzMRIlk9pwxxk4nv4k/C5o9Qaw4T8ME
	 tOIExSP19XegjFsqGcb6diSzsmA1ZBcE6Rt/UjijXsLMfCyfks/FL+Zp2VlD2/q1oh
	 e+ERVMsC9PNxaMGArjRIo0QXDROp0wp7rrHS09i4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FAD6F805CB; Tue, 18 Feb 2025 16:55:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C098F805B1;
	Tue, 18 Feb 2025 16:55:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05964F805C3; Tue, 18 Feb 2025 16:55:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 192B8F805C1
	for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2025 16:55:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 192B8F805C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1739894118033019304-webhooks-bot@alsa-project.org>
References: <1739894118033019304-webhooks-bot@alsa-project.org>
Subject: ALC4080 5.1 don't work - rear speakers recognized as mic
Message-Id: <20250218155521.05964F805C3@alsa1.perex.cz>
Date: Tue, 18 Feb 2025 16:55:20 +0100 (CET)
Message-ID-Hash: NW552MQ2HGVCOLME2IRQZPY2HQTT34I6
X-Message-ID-Hash: NW552MQ2HGVCOLME2IRQZPY2HQTT34I6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NW552MQ2HGVCOLME2IRQZPY2HQTT34I6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #510 was edited from atazx:

kubuntu 24.10
MSI X870 Mag Tomahawk motherboard, with integrated ALC4080 (usb id `0db0:cd0e`)

I tried to install the latest version of alsa-ucm-conf (1.2.13)

On this card to have 5.1 audio you have to connect the rear speakers to the front panel, in what would normally be the microphone input, in fact when I connect the speakers they are recognized as a microphone. (only with ucm-conf 1.2.13)

front speaker always works
rear speakers only work after rebooting from windows
center speakers do not work

is there a way to fix this problem?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/510
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
