Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA5C17441
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672F52196E
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WEyXvWNC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QzFm9ysK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672F52196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B062166D;
	Mon, 11 Nov 2019 19:46:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B062166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573498061;
	bh=b4XF1Zdz32Nln2K/NkIy8EsK8SIiwoaPi99ANA1um3I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEyXvWNC3iq3M/41K5tKYExGlVabrDzFEEgBkp3SPiVbWo89zKY0E340fru692cM3
	 8KXVgEu0YhOt8PnIMJSH4l38CFrAhnemzpYrKU/jxIQoEIe9MUGOS7XIB/iVdhCpl/
	 jE3hUmjxtIPubUtpgR5Z6QiEbgtgP0C2YmsOWj1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11660F804FF;
	Mon, 11 Nov 2019 19:46:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AE11F802E0; Mon, 11 Nov 2019 19:46:50 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B3C8F8045D
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 19:46:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B3C8F8045D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="QzFm9ysK"
Received: by mail-qk1-x743.google.com with SMTP id m125so12064299qkd.8
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tqyA4OYIzgKUBByYmbOcv49izSd6VtL8J5SzcSN+DCk=;
 b=QzFm9ysK5JhMqFfRZ/YNP2Tf3P1gkh3wVpwb7AYtI0N1Xn5SoQFZ5zHLxSYyOrNKzP
 d1e9n+YPeOmoVa/fyismmWwfOfWpdJPFjorpDFcQfoO46ZhrQqoxlI2+UdbHVR4a51AC
 rv3XaOiYU6+zQNyzAXn4FCTLV+tXN7BQcSdQVCvBoAhH1WbT6r9HD97qCQWg2EgWGtsc
 OLzYtAMnoBDEzOLpWXPDROnJKllVMCL9ZSj6MeuNN6L7Mx6x1Ay5qSE0AaNK8nJczv8V
 XaqRw1DRJLVzh3gTyP3b9KGxoc5CQApvu3jcmwtR1N7Ox5ATN/3kc9myi7vge+DE/FI9
 cIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tqyA4OYIzgKUBByYmbOcv49izSd6VtL8J5SzcSN+DCk=;
 b=Al8H1bS+nnLAouhwwutasBCFthCM5muZsks04FM7gOHasudFB/CDimhEW2u7CtuhCc
 LlCp1rFRfuYzifPK4i15jdfYfkK4uxM8RMCHBez+A7Wt4Y1bNCNVUpB9Ned7OuBFY0HP
 813z0U5dYdhnK/g9PNBOCSEDvknjU43J/FgszY4P/pVSJoJyE4jRdtqjxjmRmuX6jzbH
 svNTYP8JVLK0LJpd4LzWX/t0ZS3zDzAR6tQkOp0PKfdqBi6r4Rnc0HdA1CW03STt6Hq4
 6FWotrG/AEMUzKxTQMVgpJFQ5zGmUTnqUAIlpL6E278NRzaR3CmhS6etTkW3lPYB1XUc
 BYzA==
X-Gm-Message-State: APjAAAXDFgc0+ba0Y98adAgqqtX9SJJcsHloaq/oLUEWtraUIU88XxXI
 /k6Y9U6s5Y67Bmfud517ymNVPooy5JzbD0TspLLtyQ==
X-Google-Smtp-Source: APXvYqzLm15GxZXJ+TYP4/Dq6rgdtuC0Rggs/MEZIt3zJ4RY8GL2fVhYpxC8bpi20dYQQGXddHQiJwYq8Z0spHuPbDM=
X-Received: by 2002:a37:8d7:: with SMTP id 206mr11432009qki.238.1573498005749; 
 Mon, 11 Nov 2019 10:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-10-cujomalainey@chromium.org>
 <b46f661a-5363-e80e-fc1e-d4d984f198ef@perex.cz>
In-Reply-To: <b46f661a-5363-e80e-fc1e-d4d984f198ef@perex.cz>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 11 Nov 2019 10:46:34 -0800
Message-ID: <CAOReqxj39iMjidAzoupiAackhU9rRr9pOZYTP7U1BG6htC66nw@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Curtis Malainey <cujomalainey@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 10/11] ucm: docs: Add SoftwareGain
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Nov 11, 2019 at 7:33 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 07. 11. 19 v 2:58 Curtis Malainey napsal(a):
> > Add software gain ucm definition.
> >
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > ---
> >   include/use-case.h | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/include/use-case.h b/include/use-case.h
> > index e84f3f8f..ee6ee5e0 100644
> > --- a/include/use-case.h
> > +++ b/include/use-case.h
> > @@ -344,6 +344,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
> >    *      - This is used on platform where reported buffer level is not accurate.
> >    *        E.g. "512", which holds 512 samples in device buffer. Note: this will
> >    *        increase latency.
> > + *   - SoftwareGain
> > + *      - Specify the software gain in 0.01dB. E.g. "20" means there will be
> > + *        0.2 dB software gain on this node.
> >    *   - DisableSoftwareVolume
> >    *      - Set to "1" to force userspace to use hardware volume controls
> >    */
> >
>
> In other words, it's the recommended software gain control? The description
> should be improved then.
>
>                                                 Jaroslav
>
Not the control/mixer, in this case it is a gain value that is
expected to be applied by the audio server (should the server parse
it)
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
