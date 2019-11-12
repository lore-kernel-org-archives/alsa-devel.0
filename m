Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967AC17440
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:17:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5E120679
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EDZc5AUj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="LjGp3sY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5E120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 298C7846;
	Tue, 12 Nov 2019 16:16:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 298C7846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573571867;
	bh=7Gq3KhPhlO8Fr1ikNTTaVBaOggLPeJE4iHJaF1ExjGI=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDZc5AUjvVSzPvscIIgBAwE7m/F3WVwTFYWH2luvJj1MNiOpstzw6BNDkCg1o1GKy
	 E0fHnL7/og0Zzqzm3uv7JlIStdzemGEL6ce3ZtFF1K/eo9/zzzAQxne5lwLKUzKN1g
	 lKUkRh7I9FxBJPrczrOGZ07WCPPOOPNorGCttJWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96CA5F8044C;
	Tue, 12 Nov 2019 16:16:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2953F80483; Tue, 12 Nov 2019 16:16:54 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FE57F80275
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 16:16:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 267AEA003F;
 Tue, 12 Nov 2019 16:16:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 267AEA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573571811; bh=7iYub1b9WZQVS2zi5UHt2tS0uZC8da4WJsvy3lOy0jc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=LjGp3sY9ZnS/oEdkfkPFR1tEXbZFt8gLMX8I77AA0j3EB1YEvkzUCikDHevdw7ZrE
 gmNXJ7mmr3WDa2YJksji4Vqthz97s3zwS5aGvnIDLOoZTa/hkFw761GIZdpwBtUI24
 G2g+pS699pRbajD2kh7raGaVaycvNpyVK0T477Ac=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 12 Nov 2019 16:16:49 +0100 (CET)
To: Rolf Eike Beer <eb@emlix.com>, alsa-devel@alsa-project.org
References: <3413798.Kuoc3IQsnZ@devpool35>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <4869792a-6ee9-e88f-b728-75ec1af42f7b@perex.cz>
Date: Tue, 12 Nov 2019 16:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3413798.Kuoc3IQsnZ@devpool35>
Content-Language: en-US
Subject: Re: [alsa-devel] Several problems when trying to run alsa-info.sh
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 12. 11. 19 v 8:37 Rolf Eike Beer napsal(a):
> Greetings,
> 
> I had the need to run alsa-info.sh --stdout from 1.1.9 on our embedded device.
> There were multiple things I noticed:
> 
> -it requires /bin/bash, but seems to run ok with just /bin/sh. We don't have
> bash.
> 
> -it requires pgrep, which we don't have, but replacing all calls with pidof
> seems to work well enough
> 
> -it requires whereis, and does not use that
> 
> -at least in stdout mode the absence of lspci should not be a fatal error

Patches are welcome.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
