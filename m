Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF0CEB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 07:16:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E5E4839;
	Fri, 16 Jun 2023 09:16:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E5E4839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686899810;
	bh=1jsL0MNDFPDm2x0vXDt0JuNPRl3uGfeylHKrs56Pcr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gmUJeGpLwtqTsx/yjUiZrHJnG0WAkpwxVaP9EVX0HddoKyZFUZ/yOr+9ytsATHDFP
	 SfwiFGnuRp4Sr+CwoIjZZQAnLQZHCsTVrPhMFWG1BYjsnuRB5JS9/GiZvtrUfQTXT7
	 IkibeNUdEDdFLDjiW/25CRNgNw6UOTQSMuH9MWUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FBFAF805A1; Fri, 16 Jun 2023 09:15:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21E36F8057A;
	Fri, 16 Jun 2023 09:15:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22710F80149; Thu, 15 Jun 2023 17:26:19 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 008AAF80093
	for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2023 17:26:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 008AAF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20221208 header.b=U+3bso/V
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666acbdfc86so287519b3a.2
        for <alsa-devel@alsa-project.org>;
 Thu, 15 Jun 2023 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686842772; x=1689434772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTxeaxXFn5GNkcVsWJTf9D5g3nTYEaM86Nc45vNWBR4=;
        b=U+3bso/Vm9pUh7xz0npUzHyVDR5CzodEcM7fFoco4BuXpWwCjquik+lxENBhrMcsOj
         47Ax7BphyLNVPJtOvGwxU7iIoUcYpizzcBRj5urmQYZCCcoQdeIrsNIWpI+/klxOwyJ8
         rSeQ35lLDEKNLBw1GKnC3v2STOrd17u5fZiRJmCbaoONzjRkpjdgTVGYNcEJOvKMZ0Zq
         znHO1uxq1JyIbH93OcfJe2V8LiSfeihsjC9/Q4TBmmP7236UKtmm9AqXxTiS//zyfkA2
         QLuFK1SD8fY8z7zaxBTIbR0OOXmJugf9fyhb/8t49LxdyOhrxB8io/WGjavrSVdxUflL
         cewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842772; x=1689434772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTxeaxXFn5GNkcVsWJTf9D5g3nTYEaM86Nc45vNWBR4=;
        b=gCqHX3Q/uwiGn+3G6Qwyqu73A48u3ba0tBgMG8Kd7upnXpZdoFmzmWcNrMplH+2A6m
         zhM5aO5PDF1zJpSM3m25cZ2r6CKvC/iQT4qLjkGqXTcIXPq+F3Ya2S9SrytMmmFppNAs
         Rmi6LvTp/NRcd4j102cZYFICMIkTte9ZxoOQoc2guAQkmZV4v/c4miOSGXd3NObYYp91
         NPoD3XzS65M0ptTG1aeUu+MeX6fIxD7BpDL9r+x+9bfQjks1RSUblYavYQN4zSHF87eq
         5Otw+Cu5BhYwVAR+DOGlu5IAIVLuJN3ZfQz03kH9h7D0EBJ01DX3Ns3sgCmL/FntrDJQ
         ZIzA==
X-Gm-Message-State: AC+VfDyLd/7H6IvbyZ9eSsgECTonEvQ0J5R+JSaXNREJsaB0hi0P2zgz
	kv1LsgqpLUbowG1c4p19DV9vkQ==
X-Google-Smtp-Source: 
 ACHHUZ6zhkxnK3m0+W2oZ3v6Wv41P+H4hsW2NlUutS9ndUuE/gSDgZwQhIQlfr5b/Sh8t/0At9tMIQ==
X-Received: by 2002:a17:902:c94f:b0:1b0:7c3c:31f7 with SMTP id
 i15-20020a170902c94f00b001b07c3c31f7mr17437450pla.28.1686842772232;
        Thu, 15 Jun 2023 08:26:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id
 j11-20020a170902690b00b001b02bd00c61sm14181120plk.237.2023.06.15.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:26:11 -0700 (PDT)
Date: Thu, 15 Jun 2023 15:26:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: yixuanjiang <yixuanjiang@google.com>, vkoul@kernel.org,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
Message-ID: <ZIstjzsar5a4bCFN@google.com>
References: <20230613062350.271107-1-yixuanjiang@google.com>
 <92159f51-2e17-4c6b-8fd4-0bde8b1dd38a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92159f51-2e17-4c6b-8fd4-0bde8b1dd38a@sirena.org.uk>
X-MailFrom: cmllamas@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BFHHZ5JUU7VOZ4EX3SIGZ5I56E47RAN5
X-Message-ID-Hash: BFHHZ5JUU7VOZ4EX3SIGZ5I56E47RAN5
X-Mailman-Approved-At: Fri, 16 Jun 2023 07:14:57 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BFHHZ5JUU7VOZ4EX3SIGZ5I56E47RAN5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jun 15, 2023 at 01:56:35AM +0100, Mark Brown wrote:
> On Tue, Jun 13, 2023 at 02:23:50PM +0800, yixuanjiang wrote:
> > Modify the error handling flow by release lock.
> > The require pcm_mutex will keep holding if open fail.
> 
> > +++ b/sound/soc/soc-compress.c
> > @@ -166,6 +166,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
> >  	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
> >  out:
> >  	dpcm_path_put(&list);
> > +	mutex_unlock(&fe->card->pcm_mutex);
> >  be_err:
> 
> This is really hard to follow due to the lack of any mutex_lock()s in
> the function, I think because this is intended to undo
> snd_soc_dpcm_mutex_lock(fe) but if that's the case why is it not using
> snd_soc_dpcm_mutex_unlock(fe) like the success path does?  Given the use
> of classes not doing that looks like it'll create lockdep issues.
> 
> I'd expect the unlock to match the lock.

Yes, and judging from the context of the patch I believe this was based
off of stable 5.15.y tree. The locking has been refactored since. So
Yixuan, please rebase/adjust your patch on top of Linus's mainline tree
and resend. Thanks!

--
Carlos Llamas
