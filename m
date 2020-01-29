Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D947C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:14:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23B4205F4
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GrwhC8dp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Y2wNzZ6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23B4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33E821612;
	Wed, 29 Jan 2020 20:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33E821612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580325255;
	bh=j8GpjRPidIj+ALo8AfcWEdnAYTAQmyo1qrDoPVbHTpM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GrwhC8dpVRBtYrGD1+JM6RVD6hCT0UH2FG3XLM3J1g/9xfEOiqStgy/7D74D1bi5Q
	 Y0HRj9i/0aTWHTN+x782Pj7Z5q4TTMORGtDmFg/+qSFGADbYjoV/jsd9c2NYytvIKh
	 1ARnPXgzOSWQ66J3OSlhOSILNBFPwm5BUnzXZD8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2593F80082;
	Wed, 29 Jan 2020 20:13:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85178F8021E; Wed, 29 Jan 2020 20:13:22 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BCE9F80082
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 20:13:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BCE9F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="Y2wNzZ6P"
Received: by mail-io1-xd2f.google.com with SMTP id s24so1005521iog.5
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kBYSo7RSmIy52ZEO4wR0V5VSwoqDH0h2sA+/sDwkt3U=;
 b=Y2wNzZ6PkjvTXjmr3WnhUwTB47lCXr6ZKC1EbyG+d5y34qh6gs96yEcmtovhLvxNXZ
 bNiljXAkjD02fEuWz1zGBOPpLN4zsS1KPDuE/pYmXmRsWqpU+j7BiAAQLydzw4S4g0cl
 azhIYh4VcrJDiyPbWh0vCh/t0OztDWTu9+Ik2omCTXjtun3YQFem2m9WzZ5hSwPIstQs
 WNgg9B5gGvv9FcA+R++PE8db/bJdrJoSLEU3xCpT68JnO/qB4+JSlKR9DuxhEAKXah98
 v9wUTJ124E+Z42IPrO1G9glIw9c6b76WX0p/syvejoreH1sFwPyJX0RF+TI92pMVt7Fm
 YlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kBYSo7RSmIy52ZEO4wR0V5VSwoqDH0h2sA+/sDwkt3U=;
 b=hZitHoKwaHYO3baVTmG/zB8RzZQe6zhRWW7uZru8a6ISDVqI2r1brkReUUhp5iOt9N
 SDt6cgNf7+mkAHIki3+Y05zJ84e+SDjai6njACr8xqGZ7vr14ko/AkxZrtzkofEkXsF9
 pfEJUbINZfdVJ2MEwrh0U8j8o5GP2UhiakSh8AzxYLAXTvjS1kfajIY1Z0g8N5cxoBtr
 Kgc2E570swImUneK7TKZu+qJUxtrr/ao50nfFgSTgB2lSS2WBm+CCL+4/pCpc6v0E/Wg
 Wl6jDBl+dIYN/3UGyP9qQ0Gtl9HcP4Rkb/sBZDRcZQzm6+ccP/+I37X30hayN9EyagAF
 21oA==
X-Gm-Message-State: APjAAAWURI/PgvPfj7AACjTdeuBSYkaWB4MKe1ozYTuxUbiqRP676R6d
 WOaH3Ays9bbnhLPamAM5wASLa/OsvrYQ1S6P82X0UA==
X-Google-Smtp-Source: APXvYqxnDVR7NWMAt4pXL+wEHe6IL331cCIyh3fVXTT67KYAZUzA0pgBjOtHD15a4A7xMQUb+Lzygz8m3QSLlAQ11m8=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr581802jak.10.1580325195886;
 Wed, 29 Jan 2020 11:13:15 -0800 (PST)
MIME-Version: 1.0
References: <CAFQqKeUnT=QHkBWp3ZDeuBtYCS=f7FLa0+eS9sRo8reK0N6YWg@mail.gmail.com>
 <20200129185947.GA478824@kroah.com>
In-Reply-To: <20200129185947.GA478824@kroah.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Wed, 29 Jan 2020 11:13:05 -0800
Message-ID: <CAFQqKeXOGOHpqWCmUskw4r5z1kKQG-_1zuKpaXb6gBozWWG+0g@mail.gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [alsa-devel] Question about the correct license to use with
	debugfs in SOF
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

On Wed, Jan 29, 2020 at 11:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 29, 2020 at 09:04:06AM -0800, Sridharan, Ranjani wrote:
> > Hi Greg,
> >
> > Can I please bother you with you quick question about the right license
> to
> > use for the
> > debug.c file in the SOF directory?
>
> What is "SOF"?
>
Its Sound Open Firmware in the sound/soc/sof dir

>
> > Currently, it is dual licensed with GPLv2.0 and BSD. But Pierre brought
> up
> > a concern about this conflicting with all the exports in the file being
> > GPLv2.0. Should this be fixed to change the license to GPLv2.0 only?
> > Appreciate your help in this regard.
>
> Why ask a developer a legal question, don't you all have a whole huge
> legal department who knows all of this type of thing really really well?
>
> Would you ask a programmer a medical question?
>
> That being said, think about trying to justify the existance of a BSD
> licensed file trying to access gpl-only symbols, why in the world would
> this even be a question?  Why have it dual licensed at all when I was
> told that Intel was NOT going to do this anymore for any kernel code?
>
Thanks for your patience and clarification.
We discovered the discrepancy while vetting the licenses in the files
again. Something we should be a bit more careful about moving forward.
Sorry for the trouble!

Ranjani
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
