Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A226FCDB47E
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Oct 2023 00:11:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3A7C836;
	Thu, 19 Oct 2023 02:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3A7C836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697674291;
	bh=E1A/UBESFW0hix0JFxpl9JRSpX67E+rrzT5iIXuz8OE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qYUgLIkZgEy6EIPCLU+W8/Moa93yvCrs2Oh3lENa+CxTqFqyP70cX9Aohaj6pj31D
	 I842strMTHVok1R5aUMaTd2MNJcVx8A2z6Dxp2mIZpUJauxT1Mg9A5s27i2KzdOe5N
	 +LUX+L1DeYufWldWGGQ03tUxtvVZQZXRoyPp7S/8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E112F800C9; Thu, 19 Oct 2023 02:10:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17C32F800C9;
	Thu, 19 Oct 2023 02:10:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8C37F8025F; Thu, 19 Oct 2023 02:09:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DEAB3F8019B
	for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2023 02:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEAB3F8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697674157891312361-webhooks-bot@alsa-project.org>
References: <1697674157891312361-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add FiiO K11 config
Message-Id: <20231019000920.A8C37F8025F@alsa1.perex.cz>
Date: Thu, 19 Oct 2023 02:09:20 +0200 (CEST)
Message-ID-Hash: VPJSIKACHOHM5NKCGAPPJFJG6CWIJO2N
X-Message-ID-Hash: VPJSIKACHOHM5NKCGAPPJFJG6CWIJO2N
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VPJSIKACHOHM5NKCGAPPJFJG6CWIJO2N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #360 was edited from ZVNexus:

Without an ALSA config the device shows up as "Digital" and "Analog", and the Analog option has no volume control. The DAC only exposes the headphone jack in USB DAC mode, so just headphones. 

Attached some information about the DAC

[aplay-L.txt](https://github.com/alsa-project/alsa-ucm-conf/files/13035153/aplay-L.txt)
[proc-asound-K11-stream0.txt](https://github.com/alsa-project/alsa-ucm-conf/files/13035154/proc-asound-K11-stream0.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/360
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/360.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
