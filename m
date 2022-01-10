Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E20C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jan 2022 10:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B24217EB;
	Mon, 10 Jan 2022 11:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B24217EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641810239;
	bh=bBmul8kGqlETn2EomdH9OXK3+/Ll5s9Tm50vV3Ybeco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nod0AQlT5vl4jpYqEYFrUIVMkrLfDVkRLflNydtJLYGYt6xg+5WTjQ0yoZHEM67lo
	 CKEXhQUdzc/iQfDl40Y3n5O+qWhCNu5PruD52tTEPSMu1exNoJpZXNi0evFn8MkWAP
	 vwUBptRDtb9BCB6W46euYMFAiXO3952zLl4epwi8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3556AF80125;
	Mon, 10 Jan 2022 11:23:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1CC8F8012E; Mon, 10 Jan 2022 11:23:07 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64BE4F80054
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 11:23:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64BE4F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bZfdedTa"
Received: by mail-ed1-x531.google.com with SMTP id u25so51591474edf.1
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M0nrXkjvT8Y2JTsBxE15ySAcNK2QPiRrQi7yxt+5z/k=;
 b=bZfdedTaBlISxsnA+HjOnZ2STTnliWILpWqzvyQ6qQWMHBDbqJEEzOrRd7Z209N+wV
 Pt7u7gf1aCvV8qAsRsq66SlB7ZDSM81mOI0eXQscqDfQv76/Retg+8ieV2cdXTVCUNjb
 g4vH1O+eIUoj+skY/jI67sxujc+a9xhj6NpSqTtbfLNAVq+qdFEeEDKW3F6/f4alCMU8
 8L29OhGE3C74CBXs0JFnCg3y8HxUbE/DzEziHguagP7ZjFEC8l2IaEP/MmuLunKjutas
 4ep7CN06F9nNM9u7F+wgRgi2rt+tZT+31rYGvYIdT1lKg5Mp1aohyE5cQW58dtnP3Qos
 qAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M0nrXkjvT8Y2JTsBxE15ySAcNK2QPiRrQi7yxt+5z/k=;
 b=fjgU/wwboEUOILFFPRshNQdEs6pwZ2cCCuOl03tr+iUpbCZZtj0hcY7uTgyp3grKCo
 Ucmp4JbOmW7oD6rXUOTeITNF1YVclwl97oizvNOu6hXm4iuaDxz3tSEGvMOlaX0ZgO9r
 2qUPyQPTjDcngK4MmOrg3gnWnXBWhksdsA/r+vw3qVgwbaNUYZ1S9VTVb4gwQRCx2caT
 ecxkd9zmxAeNwKRWym8q9vIx8y1YRJHAfo/BbX2tmvy+JGaWmnRCi5bharkwA+s7hkyH
 8V8ozWAc3w/dRTRpFo14fVum0JXj9P3P+0JkzsM8CAso2g63CiBN0FGtAuReKDRBTt8M
 IVjQ==
X-Gm-Message-State: AOAM531V+JHMeFNBqeZR193JmlPZDXXDbYsmUjxaVhrozIHWsbDy6E2F
 2yoRn6+X6SUePTO4QNNstlhhtCfYzf2aHWqHsVk=
X-Google-Smtp-Source: ABdhPJwECqRHbXYE3+1gJLeWik7SnLbktBiu0AZzxvMVObvaegtHQCjFwf0DmV1UNgLl9J6yU9U5sFqr0U6pNjyMLGM=
X-Received: by 2002:a17:907:97cd:: with SMTP id
 js13mr57649438ejc.497.1641810179272; 
 Mon, 10 Jan 2022 02:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20220108140756.3985487-1-trix@redhat.com>
 <CAHp75VfbSmgeyi=8q1_he7mpGrNxYAOewKYWD=h8BSuxz2XWOw@mail.gmail.com>
 <0c0926d9-9b72-1519-7e22-e90ffc229940@redhat.com>
In-Reply-To: <0c0926d9-9b72-1519-7e22-e90ffc229940@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jan 2022 12:21:11 +0200
Message-ID: <CAHp75VdJOzYR0HsZ2LWn-iAMwcM3s0NNDKQdXZZudcEB9RwE9A@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: fix double free in cs35l41_hda_probe()
To: Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tanureal@opensource.cirrus.com" <tanureal@opensource.cirrus.com>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "nathan@kernel.org" <nathan@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jan 10, 2022 at 2:37 AM Tom Rix <trix@redhat.com> wrote:
> On 1/9/22 2:33 PM, Andy Shevchenko wrote:
> On Saturday, January 8, 2022, <trix@redhat.com> wrote:

...

>> +       if (unlikely(ret)) {
>
> This is double weird. First of all, wtf unlikely is here? Second, I commented on the patch that does something with this driver and pointed out to the return 0 in some cases. This one seems a band aid.
>
> Unlikely to have an error.

We don't use likely() and unlikely() here and there, you need to
provide a very good justification of its use.

For the record, I forwarded you my review against the code where you
can find much more issues with it that are subject to fix / amend.

-- 
With Best Regards,
Andy Shevchenko
