Return-Path: <SRS0=OsOn=2J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42AEC43603
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C6924689
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aQ4Sxo7A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E8XzAMNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C6924689
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B974A85D;
	Thu, 19 Dec 2019 20:10:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B974A85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576782665;
	bh=IjKQIdqO7By1A+sZkJOPMuv93NBBlmt7mwdnbJloJIU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQ4Sxo7Aj/wwsGAuvOZJSSePWU0NmJlx1HYjiEdt1nbWfeCVpyiRB6eRJJKSk+L41
	 ur8xRDIs6ouBZQilBVedCAgmqoiZcLW/bRqoDGDWMoZm8ioETaG0D0g5++31Qo3+FP
	 b2MyKGfnIokYdmQfKhhhcDO5arM11cahPQHkMF7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01442F80218;
	Thu, 19 Dec 2019 20:10:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8926F80234; Thu, 19 Dec 2019 20:10:12 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1173FF80059
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 20:10:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1173FF80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="E8XzAMNo"
Received: by mail-io1-xd42.google.com with SMTP id x1so6878462iop.7
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RLXEKTt9yEf0dS7FBsvoK+eMImXUCxfrPqLMAO9QATs=;
 b=E8XzAMNoVeW0DU7fJhM1FDGqLMqj8C6hEzMHFT6W9TtRJ2SZu2++9sYgljwaSI0dDP
 QYNnPyABt4KpI9Ahxs/oyHLg5fdUUJzmj+BpOFwlGUNPpx7a8yDzjxT0zgoaAD/MzLN0
 XEuWF78LTaCzVZcPLwQLKf8sFDhRXW9cGgxXFWZ48OgfGpFLbrcE831zu1PhzjK/WPO7
 5Elf0YT55AqHBRvNx+kgZo0mLv7ieO1NDq+TP+tZQL4ZNh8DlAkD+sZ/DlMvrYKNkQu2
 oqalKHIyqGnZoYArq5/Xe708ZbfoQ7UfwHlGwvW/ckMR8fvRnESHn0Imtc1OdRNQvI+Y
 KgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RLXEKTt9yEf0dS7FBsvoK+eMImXUCxfrPqLMAO9QATs=;
 b=LEVGPZLLapyiWLG/x9dvipyp9pLj8ReD7pENrd1/t3ilWyLbEuguE/wa+SStJeD+XV
 B5B9EEPE6QH04oXA+QNYDa8duLi2hRqPxb8z+DjdpiCXilEMRhd+W6moM7B76701nXH2
 iQ7MG5OK0AZ5tbtxlrbnboGTQT02sPfX2I40IrVYLNMjwZSxZucdlexvG8F9lD7rEMaV
 Davzg+m1qG9/voNi2Pq7+S2YqTSAMT/j+yn6oGGVLQ8WvekwlR1p8fPblucoWLZ+wyDN
 jXzegINGBbCqwVOcmltk4sXFH9FDOALmDY9RjEKPX0qgiZBRhdaou5NxDzZthC8t/eWb
 lipw==
X-Gm-Message-State: APjAAAV3otzNWTuvn7TTKzvWTi5dupSymUDUrex73bkw1TDr8fWZcXOJ
 PoCJQA8OUTCCSs7mMvXEMaPEarQMnLFvBI33Lzr+Jw==
X-Google-Smtp-Source: APXvYqwRu+W3KlMY+hM8RqnAY7dw1bjYCV2YH+/T3oSJyWBx2ywlwUOmNv2acfnrn6NikuzNi9wjSV2Qts00UoLx+TE=
X-Received: by 2002:a6b:ec08:: with SMTP id c8mr7031791ioh.257.1576782607206; 
 Thu, 19 Dec 2019 11:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20191219125140.47689-1-broonie@kernel.org>
In-Reply-To: <20191219125140.47689-1-broonie@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 20 Dec 2019 03:09:55 +0800
Message-ID: <CA+Px+wVo2Z2nwZ6zJoNsrejCWoybvAU9L4y2rqqGmx3t0LF6fw@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090: Remove empty suspend
	function
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

On Thu, Dec 19, 2019 at 8:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> The suspend function is empty so can be removed.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
