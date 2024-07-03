Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD624C3DA41
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:52:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38338219F;
	Tue,  9 Jul 2024 17:52:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38338219F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720540358;
	bh=9Qs5ol2ze5oiR2DbW9m/2gue58457PaRyAxDKiR93+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m+z60flb/YsNjWvf0DR/uluP6+F5wrZqmOLMB3IpedGs8emsPWHy5XDhg4/ojSDte
	 DjWCOS1R7mtLkcif6xIvBjo/7btJ667j9lZwT2bppOpqjJNhkhJXZU9cUxFw/1k+LK
	 TUH44A4ZGhXNUwAG/dtLz6IlfPksiTLjVzQ7gvN4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA7D9F808E7; Tue,  9 Jul 2024 17:49:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F48FF8087C;
	Tue,  9 Jul 2024 17:49:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02A45F8025E; Wed,  3 Jul 2024 19:23:36 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7AF14F800FE
	for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2024 19:23:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AF14F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=AnlfFGwH
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6518f8bc182so5754687b3.0
        for <alsa-devel@alsa-project.org>;
 Wed, 03 Jul 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027408; x=1720632208;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti6v24oTe1MEKhNZLLn/dVPsQr2JQWNo5ls87iglapk=;
        b=AnlfFGwH8WWr1xvPyhxXj0yOrpMNZTIQX4clfFJCkP37cnzeS+iZi66/a5HTyIzprP
         gkX0thqOd61nGnckeHQShtqJZ2ZBv2/CO+Dv/N93amJmH+1zAsoN3QSVPgKCtenxkchZ
         CnwCUF+fhCxllUHPvtb4wqRcernLgAQ5KAUqpITbDzoiOl/YAhVutX5Pq/268kZ4L7Yw
         Cfg4gvKqhCuxNFozHW0s3AfDUhsq2TGtwe03O0gDCOERGLcWRWiJfBD5gpgLvwkZ/z0X
         bIcWg4mHIS1d1Xl4QEueSP9TY8eqWlpJOMUO4WPmhGcuJmyAnTly52gMRMG3i9SYS7JL
         yFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027408; x=1720632208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti6v24oTe1MEKhNZLLn/dVPsQr2JQWNo5ls87iglapk=;
        b=tfFcjHHxn/1Bfz+LytLnXh7Z7o/BNeLn2zYeVwMW7IBO4HApQBn7ass+4xX6Fy0HaY
         LCZtLB1pxVMRoCtQtp/3UIWd6bjPC0TxfsEgLOweKuJRVMDzcxqQ0xftBpBjKwcm6gHB
         MxFCpxOXcSrRnme1qXJc83qpkeSyUk1MZndg75W60KzDQAuf1JWbQPg62BFjSlu8K4if
         2pOuhxRK3vXrmbQYa9XONhTETg1HU/CdNjjNGCnp0JvHvfOygI5GxslOmv/VHRXNMxAk
         InxmyO00DNx5BfUYzSHF3eULr7V2FLDxRbnQfRe2rvBi3Bw1XS2NC5l09k40wz6UK/UC
         /D7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQqqOF1TiKjnhqsAmPB1rFIjYvVwy7Fgaj57RIKi/+3JngpCp8cJTt+iPX7yJpyUK9xHnS8PZ3RDJXhY2ZIw+NxcxwCDQK26kiTCQ=
X-Gm-Message-State: AOJu0YybTkhWl7hUvJMAhd5pA+83OTYnxMW6wnPr7qdzCsnRRIzfjAe7
	694dysnwweKT80I+je5BvNBhCZOXdDfc6T8kYsKJM3BP1t77QLnS+MCAKJG+rmjuBfnZDR5UZ9g
	BpEYIZEOVYfv7ynjTdw+F3Ho9jjY=
X-Google-Smtp-Source: 
 AGHT+IFWOydMbN6BlWi7lFEJsFqVYPn/wQrhz+LemE/ooLfbb7YSNlm3inzv1ZHEE/FXcdtbKBxpbSiueYfE+CJjO98=
X-Received: by 2002:a0d:ebcb:0:b0:61a:e557:6ce1 with SMTP id
 00721157ae682-651800ecdddmr15155807b3.1.1720027408329; Wed, 03 Jul 2024
 10:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240616203231.43724-1-av2082000@gmail.com>
 <d6cd7441-53f2-4c88-a361-729e3abe81c1@marliere.net>
 <CAPMW_r+sPGF5=+=edLY81X+Cd4bMWKFJw3sDd0mzaZEM9b75BQ@mail.gmail.com>
 <f64523f0-db39-4e3a-85a6-1a3cb07e2d08@marliere.net>
In-Reply-To: <f64523f0-db39-4e3a-85a6-1a3cb07e2d08@marliere.net>
From: Amit Vadhavana <av2082000@gmail.com>
Date: Wed, 3 Jul 2024 22:53:17 +0530
Message-ID: 
 <CAPMW_rKV1BkBbrhcKNkMvhSatoHRNk58O8m8m8GHCN1Jb2V-8Q@mail.gmail.com>
Subject: Re: [PATCH v2] slimbus: Fix struct and documentation alignment in
 stream.c
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, rbmarliere@gmail.com,
 skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: av2082000@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 67IJGHWENALP6RQRVKNJA53KFMSMKXGA
X-Message-ID-Hash: 67IJGHWENALP6RQRVKNJA53KFMSMKXGA
X-Mailman-Approved-At: Tue, 09 Jul 2024 15:48:38 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/67IJGHWENALP6RQRVKNJA53KFMSMKXGA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 20 Jun 2024 at 18:00, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Hi Amit,
>
> On 19 Jun 24 23:28, Amit Vadhavana wrote:
> > Hi Ricardo,
> >
> > I have rebuilt it again, and there are no any warnings or errors.
>
> Thanks for checking, FWIW:
>
> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> BTW, I received this message plus another two empty ones. Please check
> your settings. Also, make sure not to top-post [1].
>
> Best regards,
> -       Ricardo.
>
>
> [1] https://en.wikipedia.org/wiki/Posting_style#Top-posting
>
>
>
> >
> > Thanks
> > Amit v

Hi Srinivas,

I hope you are well. I am following up on a patch I submitted on 19
Jun regarding a kernel document and Ricardo reviewed the patch.
I understand you have a busy schedule, but if you could find some time
to review the patch, I would greatly appreciate it.
Your feedback would be invaluable in helping to improve the quality of
this contribution.
If there are any changes needed or additional steps I should take,
please let me know.

Thanks
Amit V
