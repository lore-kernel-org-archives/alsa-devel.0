Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AD7C77B78
	for <alsa-devel@archiver.kernel.org>; Thu,  4 May 2023 11:07:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 780111FA2;
	Thu,  4 May 2023 13:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 780111FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683198472;
	bh=VUqBSpPrY48cG7514tSf8SDz6kybJv2rT/wj7OY60Ro=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HHyqgJJRaLSGXPNZ8Un7QFLN5ofWfv35O98JVjdVJJu33RuLIK8zHqQYDH9PBkFue
	 pufxgS2kUv0tboA9CZV/NN0suBnDNA4R2WVbIMa2anS6ZBJcs967Z9hXZU1+Df/Pb8
	 PPVRo9+uQH2yo8Odx5sxOMxdPon87CntyGfiufTg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95124F8052D;
	Thu,  4 May 2023 13:06:36 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ACADF804B1
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2023 13:06:32 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: How to mix multiple pcm capture stream into one and save to wav
 file as if
 it's from one single multi channel alsa card device
From: semiydsemiyd@163.com
To: alsa-devel@alsa-project.org
Date: Thu, 04 May 2023 11:06:32 -0000
Message-ID: 
 <168319839248.21.13628311961075383599@mailman-web.alsa-project.org>
In-Reply-To: <ZEvrvsooKSynbnzU@geday>
References: <ZEvrvsooKSynbnzU@geday>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: LU2H76B7WJKFLFRLX3VDJ6JTKB6TQVSS
X-Message-ID-Hash: LU2H76B7WJKFLFRLX3VDJ6JTKB6TQVSS
X-MailFrom: semiydsemiyd@163.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OICNBAKAXPC746W4AIKVOLK3RCZALOFP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

thank you Geraldo !  i'll look into these tools.
