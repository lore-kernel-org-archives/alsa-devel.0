Return-Path: <SRS0=Of65=ZI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49790C432C3
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Nov 2019 13:40:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B4320700
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Nov 2019 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qJLfZ6Pb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="mzBd4wef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B4320700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AC6E168A;
	Sat, 16 Nov 2019 14:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AC6E168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573911637;
	bh=riaYIjTz+x5Pj69i5OQsInmn2ZSHs4KYnWJfOY1v8UI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qJLfZ6Pb4slQ4/izAwdHD7k4KmmocOer15q/74HEIA3ywm9Gto+fqJXXirzmMz/3E
	 +6g1esl04QE8X3vfzwl4vx/x2D7prqWzvN7APV5Czouu0bBlNtB6IJzCNj5o6ZtZIt
	 dmJOrGKG65RIP6wS8Dq9KBiZaRVotyayk06ZgfI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6CFAF800FE;
	Sat, 16 Nov 2019 14:39:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0F09F80101; Sat, 16 Nov 2019 14:39:44 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42638F80082
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2019 14:39:41 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 46349A0042;
 Sat, 16 Nov 2019 14:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 46349A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573911581; bh=K1k70lbegR5gXXlkJOxDqXylUUOS3xdfXqfWypp1O78=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mzBd4wef/dRV1GUCA0VQTDb2dVelKJFjVParUHoFY1BHVsgW9uz+6jwlAZo0JjBhz
 wq93W0NrwvX59pLChCyQSJ2TvaoQyEddp5zpXYUKAgdSRsmuXMGVaEgqS82YLMvB1u
 sbTMobPpIO9HXFUqYlKtQxuyvr8kH+qW2hfOFfBU=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 16 Nov 2019 14:39:38 +0100 (CET)
To: Lars Wendler <polynomial-c@gentoo.org>, alsa-devel@alsa-project.org
References: <20191116142440.2b4e8e12@abudhabi.paradoxon.rec>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <48906630-65c7-c0de-6b93-322153cc0968@perex.cz>
Date: Sat, 16 Nov 2019 14:39:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191116142440.2b4e8e12@abudhabi.paradoxon.rec>
Content-Language: en-US
Cc: alsa-bugs@gentoo.org
Subject: Re: [alsa-devel] compression format of alsa-ucm-conf and
 alsa-topology-conf tarballs
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

Dne 16. 11. 19 v 14:25 Lars Wendler napsal(a):
> Hello lists,
> 
> some shell output says more than any explanation:
> 
> 
> lars@abudhabi:~/temp/alsa> wget -q
> https://www.alsa-project.org/files/pub/lib/alsa-topology-conf-1.2.1.tar.bz2
> lars@abudhabi:~/temp/alsa> wget -q
> https://www.alsa-project.org/files/pub/lib/alsa-ucm-conf-1.2.1.tar.bz2
> lars@abudhabi:~/temp/alsa> tar -xjf alsa-topology-conf-1.2.1.tar.bz2
> bzip2: (stdin) is not a bzip2 file.
> tar: Child returned status 2 tar: Error is not recoverable: exiting now
> lars@abudhabi:~/temp/alsa(2)> tar -xjf alsa-ucm-conf-1.2.1.tar.bz2
> bzip2: (stdin) is not a bzip2 file.
> tar: Child returned status 2
> tar: Error is not recoverable: exiting now
> lars@abudhabi:~/temp/alsa(2)> file alsa-topology-conf-1.2.1.tar.bz2
> alsa-topology-conf-1.2.1.tar.bz2: XZ compressed data
> lars@abudhabi:~/temp/alsa> file alsa-ucm-conf-1.2.1.tar.bz2
> alsa-ucm-conf-1.2.1.tar.bz2: XZ compressed data
> lars@abudhabi:~/temp/alsa>
> 
> Please rename the tarballs if possible.

Oops, it was a mistake. The tar balls are repacked. Thanks for your notice.

				Jaroslav


> 
> Please CC me on replies. I'm not subscribed.
> 
> Kind regards
> Lars
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
