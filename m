Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085BC2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:43:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3F6218AC
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oFJ2XBgs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy8DZBWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3F6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED6F21682;
	Thu, 13 Feb 2020 14:42:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED6F21682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581601415;
	bh=fFdWUrpCwv+XidQvZ09xi+8O3WCmvKnniiwY5GMhFtI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oFJ2XBgs+SFPmt0OU2us2nJzXdZdHjyvZf8gDsh36uyrKekzl6hnHeldDDHnWzs+P
	 50LX6egipsApNNE10LqFxEB3BbHJt4IcrOpOnMQsg2zRrrcqeFnG7g9Pk7lFk94Dg6
	 PkwSJ1hJN+eKj1+hAVQnDZYRCvTzh8+cYFqxxTdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C6C5F800F0;
	Thu, 13 Feb 2020 14:42:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55F38F80145; Thu, 13 Feb 2020 14:42:42 +0100 (CET)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46737F800F0
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 14:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46737F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Uy8DZBWT"
Received: by mail-il1-x144.google.com with SMTP id g12so5005161ild.2
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 05:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wYqO+icpSij8aiOwPZBSTkzoUsPfO7QyFrHiJiHWNpw=;
 b=Uy8DZBWThuEkhMkpYU6QmCgoyPRDKtxVVO/uBHS/Xsx4dThFPssBWpdSixjzdKVnhi
 j63mKxLxt1hbyvqEBYnlpwAIAUvgGYZi2WXbr4/rPAdeBYJMPcrKuYJoMTjQFnstZEUA
 kfjeI5OeB5cxReEJJ0wvaI6QaUc89Ulrs/Uogmn+7e6MCWB1k8UHZtq6YkUJxH6OCmF9
 Be1xex9KSHuC9w+69LOYPX6Z35kbHg0yCb2sYRRQnzlIoGfC+e4tyxmqvk6g6lFtLoFr
 dUP/xOjZk6jAW0xQi/XJyS7i3xLgj+uPWDBj+rs0Jdes8I+i5mHFbj6IHyL53XyC6ye1
 JlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wYqO+icpSij8aiOwPZBSTkzoUsPfO7QyFrHiJiHWNpw=;
 b=BZFhz2ixB3gb8hPZS0072oQ4u133RvWnlGLukM31seMDOr8mv3Cm7jiGG4TYRvProA
 ETKpQCb9JCG5+g+YspZjZmEyNnvk0gVMrezA8xRh9RRDmkOzT4h5osqMQYyZhFhrNrmj
 baliwyrwjPWTGgTQyJyyqHZeIPDxOgo/6pLJSas0lcnpMwpNstajXCEKk/UoOirF6rkl
 oKrhvxP9moxxwNJEpLbjWNLnXcua0yVVuRGGTAvKXamq14P4U9GxkdSYtk9VLE1c3BK6
 P2hKlcxsA1I5/vaOYIKYTbObUYqC21nTs8ClNLpTyhCluCnoh8OLi0tVwGJFMZY+Da/Y
 ZWmg==
X-Gm-Message-State: APjAAAUTREUc36Ju0J3fjEfxjD7VO17OZAR0wbQ7JEedJ5/90f6ka69b
 /Xq/qwzm33yXwy5Ux14FHuayv673DnxkjCozw3nHkg==
X-Google-Smtp-Source: APXvYqzXcdGTItpMF5ZnZk9U2FZCTCkS+INTtNXDL5BbMA/l9Xm8BqezDABjPqysGmvJK8/Y9Huh3GJilfOZNl/IcjY=
X-Received: by 2002:a05:6e02:152:: with SMTP id
 j18mr16101714ilr.235.1581601357084; 
 Thu, 13 Feb 2020 05:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20200213032728.199462-1-tzungbi@google.com>
 <20200213112003.2.I1d568b0c99742c6e755d051aadfd52e4be3cc0a5@changeid>
 <20200213122448.GD4333@sirena.org.uk>
In-Reply-To: <20200213122448.GD4333@sirena.org.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 13 Feb 2020 21:42:25 +0800
Message-ID: <CA+Px+wUCaLYrYR_Ff6tJGWaE+w=Nk=4JFJYu8zfT_MXZ2YR+UQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [RESEND PATCH 2/4] ASoC: mediatek: mt8183-da7219:
 pull TDM GPIO pins down when probed
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

On Thu, Feb 13, 2020 at 8:24 PM Mark Brown <broonie@kernel.org> wrote:
> we might want to have some general pinctrl integration

I have no idea what it could be so far.  But I am willing to help if
you have some draft ideas.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
