Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404ECC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:15:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70D964E89
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70D964E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 092C51680;
	Thu, 18 Mar 2021 13:14:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 092C51680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616069711;
	bh=3GpCvRvdqkcgNtN8qcV0oPalO+rbvnWwS+hp/dOrMCQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4HFb8G1zU8YzOx2AMA2De/SagADSqqo0ESOAe+a6W5Rht5qiveo6pBJBP1zhJ6JE
	 OE/BPQKpqOru2zZpblrr6yks9SP1Wjk007XuNxcWQ1DRdc0kQI+PwbpbOqDsLM0hWj
	 aqjqPILNAMn6loMw9g7saZ4HYqtdvoXQqW58Z4w0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C2E3F80163;
	Thu, 18 Mar 2021 13:14:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B2A8F80165; Thu, 18 Mar 2021 13:14:19 +0100 (CET)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74E5FF800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 13:14:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74E5FF800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="vuEU5cYm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=swing;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
 Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nkRWPHh0QcwvwA8p8Hl/OGQO2W0MbT9LeHHjwKHLBiM=; b=vuEU5cYmWimhyH25Jj15e3qDf1
 xQDEf5rxrjgs3zL9ebDcm8ilDTDwf4OOWaYeqkoxOzOW/D2j3DyZVCpflQOr5ei5DwFTvIyLwOlOZ
 ljHL7pApKGpKHZlN4InDZRv6fNZHKOpC2TPGYPEjTbk4sM+EXhJO9Rn6/c1MJhWy/tMw=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
 by jazz.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1lMrXV-000BOh-Me; Thu, 18 Mar 2021 12:14:08 +0000
Received: from localhost (stax.localdomain [local])
 by stax.localdomain (OpenSMTPD) with ESMTPA id 3942d378;
 Thu, 18 Mar 2021 12:14:07 +0000 (UTC)
Date: Thu, 18 Mar 2021 12:14:07 +0000 (GMT)
From: Mark Hills <mark@xwax.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] conf: fix memory leak on the error path in
 parse_args()
In-Reply-To: <s5hv99pkbsk.wl-tiwai@suse.de>
Message-ID: <2103181212170.1962@stax.localdomain>
References: <2103171535560.14556@stax.localdomain>
 <s5hv99pkbsk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org
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

On Wed, 17 Mar 2021, Takashi Iwai wrote:

> On Wed, 17 Mar 2021 16:44:20 +0100,
> Mark Hills wrote:
> > 
> > Having a little trouble which bisected to this patch.
> > 
> > First noticed it's causing Chromium to crash out one of its subprocesses 
> > (stack trace below)
> > 
> > Can actually be replicated with a simple "aplay -L":
> > 
> > aplay: conf.c:2207: snd_config_delete: Assertion `config' failed.
> > Aborted (core dumped)
> 
> That patch seems to have a few flaws.
> Could you check the patch below covers it?

Thanks. Yes, the patch builds ok and resolves my two test cases (aplay and 
chromium). That's the only testing I've done so far.

> --- a/src/conf.c
> +++ b/src/conf.c
> @@ -5080,6 +5080,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
>  		const char *new = str;
>  		const char *tmp;
>  		char *val = NULL;
> +
> +		sub = NULL;
>  		err = parse_arg(&new, &varlen, &val);
>  		if (err < 0)
>  			goto _err;
> @@ -5104,6 +5106,7 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
>  		err = snd_config_search(subs, var, &sub);
>  		if (err >= 0)
>  			snd_config_delete(sub);
> +		sub = NULL;
>  		err = snd_config_search(def, "type", &typ);
>  		if (err < 0) {
>  		_invalid_type:
> @@ -5169,7 +5172,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
>  		err = snd_config_add(subs, sub);
>  		if (err < 0) {
>  		_err:
> -			snd_config_delete(sub);
> +			if (sub)
> +				snd_config_delete(sub);
>  			free(val);
>  			return err;
>  		}
> 
> 

-- 
Mark

