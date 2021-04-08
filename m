Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2BC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 08:41:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A95A610E8
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 08:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A95A610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F10C166F;
	Thu,  8 Apr 2021 10:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F10C166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617871287;
	bh=Duj3ApL3SsQ8R277YrY9HIhmP0ZVx8tfk3GLIRpNOW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9wXWqQzh98C7868l4MArYfluc+8q/CRZeO3vPwNlGvD+UYgKV2rGxMlkZEOJnKIP
	 V3dufs2cFkDTn/P0ipltAMGXf4ntN1oazR/FEIEBo7PplMeSgcTqspn1oK7btkYtfI
	 EJAy+6F+5L6LJBwzf7ThrBILLkYGu2EagkMVUSfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1499EF800BD;
	Thu,  8 Apr 2021 10:40:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CAF4F8020B; Thu,  8 Apr 2021 10:40:34 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA554F800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 10:40:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA554F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="seQonEKI"
Received: by mail-ej1-x631.google.com with SMTP id n2so1631115ejy.7
 for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2021 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Qtakub78mwKHzdQl1xppJZsYsTKa3NqWZ87Updiy3I=;
 b=seQonEKI3MyDJhu2U1MjF/acw77Gs/OARuUveuOIPa6UoS9yndUrDCPPsBV1Osm+Sl
 MGBQYwX8aFF+U8zgTyb+rot412H2CMzhpIHitFtEGMylKCOMH51rAJqs24uSmFw0ux7O
 uf81aPFJDX0quloBQJHCUxlF2ABNEQW+1vHp9OVzcxpRArywtDBVtFIocSMux57kn8v7
 eM6XFfWScc9wk0DQbJp9VKlhxk5gWeO4IJ0Xqjq4lWsLTBC61JjbSxqVewVXdxCg9ArF
 FMGsy4WmChenUCUA+pwK3LXv1YSV346poBB3XhgYCZfGguNpsQEptD+OIwEE/xu2eFkC
 6YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Qtakub78mwKHzdQl1xppJZsYsTKa3NqWZ87Updiy3I=;
 b=fLoHyI6oPQgeZm0aNHhdCyiaGZxxwIGcTvUkctP8vU+zOBsRtMbW24eoWsfCLMjTJD
 xCsLr3xAa8U5J2VneZSkAsT0KvGo/WbskvEuvwJIPrU2tKvegALL8Fw/uxZbHsQaqf0/
 s72aAZo8uR5vjZQZpmLJFu223STNk8IxPr/B7l058u32kzMRfmqv5NLF7RAY5IWg/Buj
 F1IebBLUOb8/iQarQf69LFIBL/EZvkdVhCxU/IaF4Gmmo1F007/6SPpU+DWnti2qS0SP
 4ASpUIfoqJhTsRGuTs073SGTySWw2Kbrzs8spTw1NAGMG8dUgrmzpFkpDb5H2sXVY8TL
 qsNA==
X-Gm-Message-State: AOAM531RoVfWB9At+iAl7l6wjqVeArJ17zTSnkbxUEswyFH2/UYbMTYc
 1tB/u51gQsPep6OM3n/Y7i1G3ZW4XhphESHi9Ko=
X-Google-Smtp-Source: ABdhPJwFRj7bv0JPeS3FoPghpEIdsbwEhANxCFweXcjW2Jwe3G4D2qkLEIkuMLeEPm5jh+7a72INoBAdFsIXEvanRGc=
X-Received: by 2002:a17:906:34cc:: with SMTP id
 h12mr8779371ejb.301.1617871224622; 
 Thu, 08 Apr 2021 01:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXb3begced9GYCQ4a6qLOK2PrQR9gHeSvb3HAG29DVpZ+vwiQ@mail.gmail.com>
 <CAEsQvcu5freEXMFwBRH0aQsT9=ngvOY_SkA6dmfs_YVvMYYuJw@mail.gmail.com>
 <CAHXb3bddyVMXrZHxmtz5AM4j7TRwWSbZcLM94JjcbOMfrd4+2g@mail.gmail.com>
 <CAEsQvcs+-O_eGW928eLdbde9EhWiD3qxjCuv2iW477DZDprkBw@mail.gmail.com>
 <CAHXb3beRycUteezmWRqO0u3kZnV8TbCNAqfO3ksjVoJ6WSrdBw@mail.gmail.com>
 <CAEsQvcuBYnY_k1Rd8US5qrDKcJas62Q5kA4P0NSEJODBCcZMuw@mail.gmail.com>
 <CAHXb3bfD_YivP3r4wOeb8bcXmAU+_+eeZwudW6f1pxfYtpnq1g@mail.gmail.com>
 <CAEsQvcsCJUi8eP_t8MGUKf0zSf7Zmqiof8b0fmk-XhZtUScbmg@mail.gmail.com>
 <CAEsQvcspNZFS4gbS=dQ1enkshVnG+-=xvoc8kskmoweTQjQhRw@mail.gmail.com>
 <CAOsVg8raD8enyWELM4w17dZCe=1Vy2s+7RLszVko4aRLmj7jDA@mail.gmail.com>
 <CAEsQvcsz2Na9epF24urfqt5ZxFUU6efCj9hzV6x-a1mY_dfrUA@mail.gmail.com>
In-Reply-To: <CAEsQvcsz2Na9epF24urfqt5ZxFUU6efCj9hzV6x-a1mY_dfrUA@mail.gmail.com>
From: Lucas <jaffa225man@gmail.com>
Date: Thu, 8 Apr 2021 03:40:13 -0500
Message-ID: <CAOsVg8rzoGowneAfNjN83kDy_gPFnzpHHOuCBg7xkmcxDR9FKw@mail.gmail.com>
Subject: Re: Implicit feedback on BOSS GT-1, the saga continues...
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Mike Oliphant <oliphant@nostatic.org>
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

Yes it is a wonderful feeling!

I plan to revert these changes tomorrow to test something else better, but
will be happy to keep trying any suggestions, especially if they can be
made to be more independent.

Thanks, Geraldo, you just taught me something I didn't know about lsusb,
but it'll still probably be a stretch for me to learn enough about
endpoints to feel comfortable talking about them.
