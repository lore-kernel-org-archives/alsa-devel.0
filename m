Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52837C00140
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Aug 2022 17:13:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FA3D166C;
	Thu, 18 Aug 2022 19:12:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FA3D166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660842806;
	bh=elFcerguZJvThKuRUTXfjw/sbs8p/ceFFUN0BlqItMw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OBuFie78sG5RDE+wY2PTV7GXOGT4s7ilX6Q/AO+DuAOLvmE0Vbc4bRxGEJsIUvoOV
	 MwDKxI6hCSP0cpaWnj7ewYGlLDdfDiJClJHNCjXbdiVAyovAh3VxNkrBzduDdLgi3l
	 D5PgzHXJ1lgf5msMJhlRuAIN2Mps/IJH27BteAmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0B3EF8013D;
	Thu, 18 Aug 2022 19:12:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4ED0F800E9; Thu, 18 Aug 2022 19:12:34 +0200 (CEST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99488F800E9
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2022 19:12:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99488F800E9
Received: by mail-io1-f52.google.com with SMTP id 10so1577320iou.2
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2022 10:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=h34ROyt3to7gmxXibwOAJi1qMJdptGraIUSFnGPhnVM=;
 b=hOWl/BSgrxjCj7RgTwru2uJ9LzPPUNzJnu4z9VxjUPJfvC/WCSgJvA5owJ7G/e35QS
 TwSueOPpfc39RJsgVO13HiHwAkk3/F0ROhDgmkbr1o6tool+HWgAWH11l9AqsxIZhJUL
 Pi69F/KSHwBkFFes7RtKX6xwNz8CAJO15Fkux7PHSoI7oqVQ61Ep1jEjzhkQ1X43yWkU
 XnzLFZoOIXrGU27x8Jlz2SteZ5+I9hOkUk+ZFyZ7erkiOY6fHKdCHp/dSGbYTMYdUEin
 x+89F/9lGVT5sLIvDVAf7QmSVJN0nYvU5IokPT71d4zkrXc6+NjYEZSxH/BBK7TZ+I1b
 0G6A==
X-Gm-Message-State: ACgBeo0EWKGuIcnH7oT7scENQzVsHPg/ZzX5t3c5hPR1oroHYu2rQZDe
 VAS9tTvw7a3//Ok7WjyG/g==
X-Google-Smtp-Source: AA6agR7HpaHm2KfXfJ2bjNl3Qk5UqRcAJECbGGNoRdZjq7jAod5+DycpivnxU6scCe+lJbgjt/6Zsw==
X-Received: by 2002:a05:6638:d93:b0:341:5cab:4d9 with SMTP id
 l19-20020a0566380d9300b003415cab04d9mr1792636jaj.146.1660842746366; 
 Thu, 18 Aug 2022 10:12:26 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a056638216d00b003427e69f2b8sm780925jak.144.2022.08.18.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Aug 2022 10:12:25 -0700 (PDT)
Received: (nullmailer pid 2046290 invoked by uid 1000);
 Thu, 18 Aug 2022 17:12:22 -0000
Date: Thu, 18 Aug 2022 11:12:22 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: codecs: wsa-macro: add support for sm8450 and
 sc8280xp
Message-ID: <20220818171222.GG1978870-robh@kernel.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org
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

On Thu, Aug 18, 2022 at 02:46:15PM +0100, Srinivas Kandagatla wrote:
> Add compatible for sm8450 and sc8280xp.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 27da6c6c3c5a..f82c297ea3ab 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2561,6 +2561,8 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>  static const struct of_device_id wsa_macro_dt_match[] = {
>  	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>  	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
> +	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
> +	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },

Looks like these are backwards compatible with the existing versions, 
why not reflect that in the binding?

Rob
