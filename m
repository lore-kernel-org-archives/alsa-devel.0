Return-Path: <SRS0=+bKl=72=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3111DC433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 00:00:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E899206F5
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iQo08WsM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyIeBb07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E899206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 186991664;
	Sat, 13 Jun 2020 01:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 186991664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592006401;
	bh=uoDKChctYT3XkvQmjRRpy0STTekAmypzCOo0HcU+8uU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQo08WsMkbenY8to5+IRaFa0QRtYQkCyTqhuX/iVfbYbRI1qlah7gsQett2B//yHw
	 O4+YsbSw0JXo9u0vN8C7k6rtPpIEGTTuir23I66jYZzkBPPp4hJN1dGsWdALLgi3hJ
	 KTPqbn/cAEHpO7E3WAxwt2MwzTOrXi+H+U1QGpF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67D62F801F7;
	Sat, 13 Jun 2020 01:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 762E9F8021C; Sat, 13 Jun 2020 01:58:06 +0200 (CEST)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F790F80058
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2020 01:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F790F80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="pyIeBb07"
Received: by mail-oo1-xc43.google.com with SMTP id h7so2271764ooc.9
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOWpXRhAQPZLUNyvQpWGm4V2ESJc01BbPvWojl719Lc=;
 b=pyIeBb07D6klnrVJySMCOCDBMj+63aMBxanzNDWnEd3JBhf2w5ZQ7nvBLq4eyQSfaB
 ph2G+6zQGlAqIvUkvLzvnBRHzheVmGPn4G+MmjebcYL1/pMSSD9R5CJCcnUJFU9Miaw8
 7wK0BVQg3cKIdmproJ3X8dETn9W1yMH/zRn+mFPUgVCso3on/JGNKQIDq63Opgb15Hg0
 apFCQBCGNSZHvFyEqKiCDDfcojETw0QiMIBmdG9ruEUR3DgUQAPKfbWOpjVsmvpC7jpa
 TYpbVuIBYZ3cFH06zcwTWptWYg6U3HvHLgkNtLU6KNqNidYwJyosOtKzaEMUVASCDrcO
 uRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOWpXRhAQPZLUNyvQpWGm4V2ESJc01BbPvWojl719Lc=;
 b=Y11lP3j7jgWwPPA+2ENTYaSdWMgqhdoLIETUuIg39itDZjZ8LuIhGtixpjB2ea1xB0
 IxGMR8/9RSZd014z8xHAKcEZsir8JoUK5l+BNotfjmqbhM3j9gucHB2ctPKAeoXEXqL1
 b4Uq7BhAzgHdXaV/X1VyNA0YvFgOd8epg7aDeFY9HztK97odX6PvZWJ+t01moXMlMEQV
 gFRj+3jg9IAcsPLX8rpo42GuMSFMJMEZz3N/vGAihfKMkz1dHwm4iR5yNQDw8t+pCH5A
 t7yb9IHb0zAsxBitBoSiLQ7uSux2Ea/iOWwnz018mEaCcxV6OB5OCD/LEep7kabADAOo
 Smtw==
X-Gm-Message-State: AOAM530AgKqhUGEdjp9JPDrDd2PZteE7YSL3NEkLwFaKxUEn7vEinEcp
 fpjHrlfJ15Rj8EHVs0iDEvmkdw8hkh+EhPdsJzOd1Q==
X-Google-Smtp-Source: ABdhPJxX1QaScGqT8ta8x6SqAo6M+yAgHqmGZa56fHwOocpCvZA5JKmeRudDWRkQQsDu9uhaEXtmbrhNKZJiEL89R1U=
X-Received: by 2002:a4a:ddd7:: with SMTP id i23mr12822037oov.9.1592006275829; 
 Fri, 12 Jun 2020 16:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
 <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 12 Jun 2020 16:57:43 -0700
Message-ID: <CALAqxLUqPw_h-BQ1NuP3AP5VMseCSyz13dYKkwqHVjk_QqXmdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: common: set correct directions for
 dailinks
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 lkml <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Fri, Jun 12, 2020 at 5:38 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Currently both FE and BE dai-links are configured bi-directional,
> However the DSP BE dais are only single directional,
> so set the directions as supported by the BE dais.
>
> Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Yep, this resolves the recent issue for me!  Thanks so much for the quick fix!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks again!
-john
