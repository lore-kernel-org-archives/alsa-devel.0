Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C4DC55186
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:00:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74B520735
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jutkEkRD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eQh8+ITX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74B520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3446916A8;
	Wed, 22 Apr 2020 11:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3446916A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587549625;
	bh=P5izvElOmtTq5iYRVHHoZxeD9w+gOORw8a47EJo2N0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jutkEkRDSAQQ63Uk17Cxzf+qybR8hXpQzjWg1UOlLf5NH1NcDzdpbLTUAGQQX1UN4
	 069oRCfLsRb5bc8eNfduY88WnSqq7ZCz/mx4FQJSpM42VfFvpeI3xgN+GcyBzMCCn8
	 k9BFgiIZYv5Wj25wqBWBu6QReAYtfVgqHekMmGoM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99714F80142;
	Wed, 22 Apr 2020 11:59:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D6CFF800F2; Wed, 22 Apr 2020 11:59:33 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7D86F800F2
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7D86F800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="eQh8+ITX"
Received: by mail-io1-xd41.google.com with SMTP id b12so1681660ion.8
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P5izvElOmtTq5iYRVHHoZxeD9w+gOORw8a47EJo2N0o=;
 b=eQh8+ITXgOFqdvcsGMWAVRZFJouNahjtWGoEsg1Hf71TpYgBq6HHkyqn2LB46VXI8j
 sdG0ZTVrFj0V/S7zuZpL3WbQpsfIqCtc51BTEIEq6mAhGLgHEtYxHONu+8fBuyQngqaf
 OaHNzVTcnDbtu2yqatZ6l0tnZxRfRNdHuT2PizWq93ULiDS1uO2HUlxirypIEgo0NF3v
 ZSN+/YZiAEgqpMlRR2qo6ossbYv9AghbFCgtoAxNWLqZydbbNBGTE70CYArQVVKOsipf
 kASBTM0oC9ibh4zqGUjJ+qnOrscUrEfT0jHpJAVNpftqWGmQyE6J23/Gp9wwoZyUItpe
 ctvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P5izvElOmtTq5iYRVHHoZxeD9w+gOORw8a47EJo2N0o=;
 b=WQgEO9+3o2g7IjRYp58JKPys1VmXWyS3vJunHEPo25X5oW9Y8YtBSZM1S8NwDqL9px
 xU5BP4P6kVrTtFQ66b+imCmbXSVy2zXDoVVXP9h01r4w1FbQCD1QgygYtL61tYBxVHBW
 o1RUsESV1yTJZNHiaeIaqxPPUIinq3XVTboY2n/DQmXhvYkJ02AdmUMNKTzhOkvhoT22
 PIh/SkdMfb/APrmWr+0h65Bhf8dZV5ivLkDriqKCkIZ9LUYBWNsioikDUIzzr3vGAs7c
 B2JCu4ThrKIG2JqaV4rwAZyqoyuqs8prP+PZpb5JUa7/2GTLgZ66PdhZ+bcb67bATRDG
 23Mw==
X-Gm-Message-State: AGi0PuZbESpGYhywdRBpp8V+FRUF1nxJ13EDrTh7mdTnYurVYCd8AF/P
 1+bqG8M6ElOkZ/RS+jg3Xkf/byQW3nAicW5AqFtjVw==
X-Google-Smtp-Source: APiQypIpbq9jgp8hPLmgLdnrMpfk7zO+RBTVNTz4rmcXOxnv+oyKWFv/se8X5iOj3f31j97RNYLiiLM1vVLA7nu7lIw=
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr24601321iof.146.1587549566706; 
 Wed, 22 Apr 2020 02:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200422083550.50711-1-broonie@kernel.org>
In-Reply-To: <20200422083550.50711-1-broonie@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 22 Apr 2020 17:59:15 +0800
Message-ID: <CA+Px+wUo1N5ATiQaUJg-9yiUizWXxjv5j7KW-N5UQcynxD399Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dmic: Allow GPIO operations to sleep
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Wed, Apr 22, 2020 at 4:37 PM Mark Brown <broonie@kernel.org> wrote:
>
> If there is a power GPIO provided we control it from DAPM context so there
> is no problem with a sleeping GPIO, use the _cansleep() version of the API
> to allow this.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
