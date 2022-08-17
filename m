Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B3C25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 06:22:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E2DF1638;
	Wed, 17 Aug 2022 08:21:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E2DF1638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660717327;
	bh=khB20IPcVm4LmT/fQkPCK8rCyXeZDwKHmcQKc9vJOvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXEybzGHnUjE3H8fOKPhG+6fi7fnzB2NsrZ+G8wbIHWlvPIQT0FdyNuAMxud3X1uv
	 W5OVM8Vgo8WEMp2R51g0gRGKazQSMYvGjfqeq06kychUYMuRsSaLRoqnNXInWs2H5n
	 pAeB07s3MlEzzwfADXPSu+tYfCfnJUf0xnCFibz4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFEB3F80237;
	Wed, 17 Aug 2022 08:21:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF396F8025C; Wed, 17 Aug 2022 08:21:15 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74B68F80088
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 08:21:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74B68F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="IaNwYW13"
Received: by mail-wr1-x430.google.com with SMTP id z16so14998247wrh.12
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=khB20IPcVm4LmT/fQkPCK8rCyXeZDwKHmcQKc9vJOvk=;
 b=IaNwYW13LfZmEUQvOi0TP9bqbQWgYzh53ws3fOiElKfEwqKBUxRR4XLEfK80yBiiyA
 ysp51hzlfSr7UcQ0w6DQ0ZUAiWst6kNL4u2Ye2js2YTWE2CsPHyW8plbYzO1FhEZxpRP
 TGeP79b17eDJVAuwL6/+Kb25eDRavfo2PyUO/zGzKgz6h8suS9cEoJd2LCgHNDNk4Ss1
 mGLbxuCfOw8WnmYfuXOKAJO6tFJOBQTEgWofhWFFq6tW6wUZadSIEBJ5ce5rtG6YRQjD
 4Sm+qtG3LHh69S2x9vzpKOPhWUM4nSnef34pmgRG/LQOwM9HDGjlQ9ha9eIUx1JTCZS7
 apPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=khB20IPcVm4LmT/fQkPCK8rCyXeZDwKHmcQKc9vJOvk=;
 b=Tjx3VAUSJDvtJSNLu7QJmHBkmOB8qXWi+vDir33MCu9C12gtM6kxOZqkxr29RM41Fq
 f6YEVNJt5Be+Hc1tUgTlhZemX17rOWBdt2OgLGnP0sPwII+c1kcLs5EXA/+/8cSXunXw
 vw7OZU2raQw6EvFO/sTo9Br6+pVDGs5T61BsM3Sg2kcF53B8srzjZnWkvOuf4owZvrY6
 cMzCO5ZAKeCtVnc0v0j+rcskswNU9aOsWuSTRFCXD2oZ97pNKO35KJV9EuOw/cFH7BFg
 n7QYYLe2H3YhRSNgAXsPAU+BNF1OxwYQIrpi1CVmsIpDT65iE6Wnsb59/8qPmM+jNnUX
 OZsg==
X-Gm-Message-State: ACgBeo1FWi0V5Hfc6bNlTGskCJY7EWh37O/XqF+0/7T3pgZOrQj6fxtb
 riCyYzQq+Zzu3WcJob87wKXPEsegvPAV8RFqwg8=
X-Google-Smtp-Source: AA6agR7Ic0pRjgTQ94iWPIZ5rgSaQqAPSXO83NX28fvIglU5zlIw6TjRdEWNUKcqglFLeLKa3OGayTRPQ1C8l1jAg0U=
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id
 y14-20020a056000168e00b0022087dac3e4mr12912740wrd.559.1660717267652; Tue, 16
 Aug 2022 23:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 16 Aug 2022 23:20:56 -0700
Message-ID: <CAGoOwPT1tP-HP+0J1ddZ0Ea+67zzLzFFTeptTpNwkzxRK45b5g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Remove unnecessary FIFO reset in ISR
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, Aug 16, 2022 at 10:41 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The FIFO reset drops the words in the FIFO, which may cause
> channel swap when SAI module is running, especially when the
> DMA speed is low. So it is not good to do FIFO reset in ISR,
> then remove the operation.

I don't recall the details of adding this many years ago, but
leaving underrun/overrun errors unhandled does not sound right
to me either. Would it result in a channel swap also? Perhaps
there needs to be a reset routine that stops and restarts the
DMA as well?
