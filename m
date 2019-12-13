Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC09C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:10:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90262077B
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ChODF2FE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ASXB/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90262077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 631011709;
	Fri, 13 Dec 2019 04:09:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 631011709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576206617;
	bh=Z+y9VSYbeaxf3gc4Q7p4n5HE3xuFdHLS+e3tWTFMaSA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChODF2FEk6avx3lrBzYdlyYe50JLCs1SK59Fova+j4//sVDHRpMx61WZKjlQMKBJe
	 JYCtx3/wPR/puFQICV75xLtBLe9qR7idvbSXo+x1Wb1McP61mW6TwC4QkBrUhXxIjp
	 Zpx5JFdMVbmLdMgqUFts34qW45J//5s1J5UqX16w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6EB8F80139;
	Fri, 13 Dec 2019 04:09:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80602F800AB; Fri, 13 Dec 2019 04:09:25 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83994F800AB
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 04:09:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83994F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="U2ASXB/p"
Received: by mail-qk1-x743.google.com with SMTP id x1so584988qkl.12
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 19:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yn6UPHNqzAqAhyMUDEs4A49nRxGs97+Efbe0+LADY9U=;
 b=U2ASXB/p0KcIpBfRXiATBa7S7YIWLrGHaOsePzh9kKsODcF39oacUwEJctKodEtMEo
 3SvCq+wAT4G+jY96OsduoDVjxgsGNCTKfNNyAHVdl6gMAtQkQnZBwYHPa2zRylD5lOSs
 LyLcvYCpx4FPneRbKVGCgrW8qqP9GTU76kFccNPFIwLjdOE//vusrNeTvjdt8P5vJBj5
 LZHzTFpvgNDDyX95SkaU1kzOuZ/wqlbvk76LXGA1Gp3YUh4uoOo5mHGpf+gFpsGGgyTV
 2weocqCGhYBvQUmCQP0V8gvxwTI/jZZlW6+R73HL9pWcBDi7ztlrHNlQQ0sSjTI1c3S0
 xrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yn6UPHNqzAqAhyMUDEs4A49nRxGs97+Efbe0+LADY9U=;
 b=m1ZLGBd+NMpCBJFBa7fMTePtobVSJkVSHPanAWpWKrEZLmVdpNNNgkeNXQX6QOqmVf
 CBD7EP72gceAQCew1Y/z9Jc5mpYEHb+UGOWqduR6+YerKVG7oEwSklzvSlW/QF8y5Xes
 XuhD4mPtcLGzGS4TU68JTEPkwib9zj5GPdBn3RSXVIC8qAOHF0IPWfRg0z3tipMF4fta
 0FYjcGJlEoGm6wvTBnceKT11IO2AjhH7ItnvkTREDrUJ719EH1hKD5yYZ9c56AxULl9v
 idThBsF9ASWZeQYZLg6oHL7pQ6pDnxBfdqyShEyt7b97NsQ1oGsDhmSjX5gQEIit0bMt
 UTPg==
X-Gm-Message-State: APjAAAVJByo3lIAo8JMhdV6v0WKLQxj2T5ECxAcQ9Lk3SiW4Ksxxij4X
 REAy64zl2A5ACTKfeI2uHIfH1/h6Fnp7LXZRKrE=
X-Google-Smtp-Source: APXvYqwfNLv8emQc8zttzX0kdkP85YXsYBGaZxqIXTh8P469k+tB2NI9ziIDYcSlhO5cwf2V8CUQtk7BEvgjlkUMNHI=
X-Received: by 2002:a37:4fd0:: with SMTP id
 d199mr11826130qkb.103.1576206560366; 
 Thu, 12 Dec 2019 19:09:20 -0800 (PST)
MIME-Version: 1.0
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
 <20191212164835.GD10451@ediswmail.ad.cirrus.com>
 <20191212165311.GK4310@sirena.org.uk>
In-Reply-To: <20191212165311.GK4310@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 13 Dec 2019 11:09:09 +0800
Message-ID: <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: kstewart@linuxfoundation.org, guennadi.liakhovetski@linux.intel.com,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, gregkh@linuxfoundation.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 patches@opensource.cirrus.com, tglx@linutronix.de, allison@lohutok.net
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: fix lambda value
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

Hi

On Fri, Dec 13, 2019 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 04:48:35PM +0000, Charles Keepax wrote:
> > On Wed, Dec 11, 2019 at 07:57:22PM +0800, Shengjiu Wang wrote:
> > > According to user manual, it is required that FLL_LAMBDA > 0
> > > in all cases (Integer and Franctional modes).
>
> > How well tested is this change, and is it addressing an issue you
> > have observed? I agree this does better fit the datasheet just a
> > little nervous as its an older part that has seen a lot of usage.
>
> I've got a feeling that requirement might've been added in later
> versions of the datasheet...

We encounter an issue that when Integer mode, the lambda=theta=0,
the output sound is slower than expected. After change lambda=1
the issue is gone.

Best regards
Wang Shengjiu
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
