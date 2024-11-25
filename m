Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B7D5806E
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:03:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55B87845;
	Mon, 25 Nov 2024 13:02:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55B87845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732536183;
	bh=4GqB3ZGt9a0Dc+QW8P+OU4J06R8tjD1fNDcxSZiYy7k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=a3GNJKDtIOGZy7degCFwPYIZKhvJ8Yu9SRBsMW7c4gqfLfYDDUtz22sEt5QvnYN0d
	 nkgXfvDw5fHHHbSr3bETvj8kubtr3JjMWVrx5uPszfGkP5n+o70aiHEbQQGctluq4h
	 oJOid8vvL0xZeceMW6LDXgvLEMpHe3zaOf4SwAPM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE74EF805C0; Mon, 25 Nov 2024 13:02:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9001FF805C3;
	Mon, 25 Nov 2024 13:02:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24545F80496; Mon, 25 Nov 2024 13:02:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A43EF80134
	for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2024 13:02:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A43EF80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732536134447214127-webhooks-bot@alsa-project.org>
References: <1732536134447214127-webhooks-bot@alsa-project.org>
Subject: 1.2.13 will lead to mute of speakers and headphone jack on MTL laptop
 Lenovo Youga Pro 7 14IMH9
Message-Id: <20241125120216.24545F80496@alsa1.perex.cz>
Date: Mon, 25 Nov 2024 13:02:16 +0100 (CET)
Message-ID-Hash: 6B7DJ2BEIMC67BYMDXUEYEGIJLTOG7QA
X-Message-ID-Hash: 6B7DJ2BEIMC67BYMDXUEYEGIJLTOG7QA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6B7DJ2BEIMC67BYMDXUEYEGIJLTOG7QA/>
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

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/472
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
