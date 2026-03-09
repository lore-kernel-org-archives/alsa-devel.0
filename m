Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1776EFCD62
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:15:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39D166022E;
	Mon,  9 Mar 2026 10:15:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39D166022E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773047750;
	bh=nqJg3EhBm0ey/EiG0es8hkwJBMX4kxMDHPd1RGiEUmI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CwM5eHDA8IUXjoV6MNRJnbVBor3o4F+9dsWKxiwJDfxRPy1FrEFhwAp46+ngQLDqK
	 VhVy2skXZKCjsyGVvjAVCcOVgh/T55oGk7zYBHStKbToG1PPEmoYBqZNoP5MOq14Yu
	 43v0d0kyBCkhbGJ6dSMR9GkwTKRzvnA2HgqsllCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0494F805F6; Mon,  9 Mar 2026 10:15:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73881F805F5;
	Mon,  9 Mar 2026 10:15:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3261F80571; Mon,  9 Mar 2026 10:15:07 +0100 (CET)
Received: from mailman (unknown [10.254.200.5])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CBF2F8001E
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2026 10:15:07 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rockchip-i2s-tdm
From: zib43236@laoia.com
To: alsa-devel@alsa-project.org
Date: Mon, 09 Mar 2026 09:15:07 -0000
Message-ID: <177304770752.21.12739413982324586422@mailman>
In-Reply-To: <87342wratj.wl-tiwai@suse.de>
References: <87342wratj.wl-tiwai@suse.de>
User-Agent: HyperKitty on http://mailman.alsa-project.org/
Message-ID-Hash: CTVP5BEVVGQTRYTE3X43ZISGJSV62BAY
X-Message-ID-Hash: CTVP5BEVVGQTRYTE3X43ZISGJSV62BAY
X-MailFrom: zib43236@laoia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CTVP5BEVVGQTRYTE3X43ZISGJSV62BAY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thank you for the detailed insights on the ASoC fixes! It’s refreshing to see how these updates enhance functionality. I wonder if exploring a more collaborative approach with community feedback could yield even broader improvements in future iterations.
https://slope-play.com
