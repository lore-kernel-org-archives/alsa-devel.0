Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C9C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:04:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BB42245F
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HhS7bkzp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="NVNO0hPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB42245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5581417B5;
	Thu, 22 Oct 2020 12:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5581417B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603361066;
	bh=ysyEE8TNfPUmO1fl3XMOCceMyt3I8fiv/UQ7oaR+j24=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HhS7bkzpQngzsy5OkKXZ/iUDto9HRxvphBVwFUWzAM04bKhlEKYIm+3hh64obFIKG
	 TlUQTjnpIU/8Pv926VNBhsXwaE9B0vafF3CjuCjrUG+wI6waCO3+GL5qovJxcDvUjg
	 yjnnH6L8OYIOK2xELW4/4c9uq0ldYz9n1/k9fjs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8336F8049C;
	Thu, 22 Oct 2020 12:03:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9822F804A9; Thu, 22 Oct 2020 12:03:33 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 516E2F80247
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 12:03:29 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3EB98A0040;
 Thu, 22 Oct 2020 12:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3EB98A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1603361008; bh=lXoh+KKoCCjpmbseFyBsxIaO14Gfb2SvYAq3LoV3XpQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=NVNO0hPS0PB46y98mKoU43gSrfjrLeM+6k4x+areXIrgcSKhmUf6h0jkTiQz4K+/6
 NUQAWQjI2K3wzlweVtoxyzDdSOXp8Rya+PwUwm6Lp1dgpuUmsMtXPFE6aseloANrDK
 NKFQ9mksgdiOCNY1j8t4VQ95LNui0CuCI3oha6aw=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 22 Oct 2020 12:03:19 +0200 (CEST)
Subject: Re: Context expectations in ALSA
To: Maxime Ripard <maxime@cerno.tech>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20201022095041.44jytaelnlako54w@gilmour.lan>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <30226f94-72e9-34d2-17d0-11d2501053f0@perex.cz>
Date: Thu, 22 Oct 2020 12:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022095041.44jytaelnlako54w@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Dom Cobley <dom@raspberrypi.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 22. 10. 20 v 11:50 Maxime Ripard napsal(a):

> So, I'm not really sure what I'm supposed to do here. The drivers
> involved don't appear to be doing anything extraordinary, but the issues
> lockdep report are definitely valid too. What are the expectations in
> terms of context from ALSA when running the callbacks, and how can we
> fix it?

I think that you should set the non-atomic flag and wake up the workqueue or
so from interrupt handler in this case. Call snd_pcm_period_elapsed() from the
workqueue not the interrupt handler context.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
