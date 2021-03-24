Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB00C433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:24:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEEE61A02
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEEE61A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A23161616;
	Wed, 24 Mar 2021 19:23:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A23161616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616610244;
	bh=J9Gz+lOAWz2kcZEla+W0HEdm6Pj4xzdklVbPhN87NGE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFFzwfWm3FQUxUuQkIzGuLWhU3Ln3+652wNDcPbnoQts+KdMsSKQ/Z5wMGJ8g4mhA
	 aGHB3/JqjOGOfDshkAclvLfHLeakDTVeHb70hoS/ZZMOr81PeMhkFycYrktQRV9OSh
	 Z1mXpoEL+IL7HpxAr5GRzxyg2zM5n7pmDOSlUsXk=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3773EF80156;
	Wed, 24 Mar 2021 19:23:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 520E4F8016B; Wed, 24 Mar 2021 19:23:07 +0100 (CET)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5EF2F80104
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 19:23:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5EF2F80104
Received: by mail-il1-f170.google.com with SMTP id j11so22228085ilu.13
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 11:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+7jD9Ziw+YPY/ufj9WrL5bWKS/awbf5purcgVlFjpng=;
 b=XwvqkjxsqZ2BcFJ6mXPh/oNe5AkzxdFDJ5won/GgeXBSXne7ci+HVOWm8zpU2FxI5W
 pnPZUJliNSzYWEKavULrIOXGbuhWvUtO+V63ZuM1WTu+ZG0wWGV2LehCjobypwLimydp
 2/QUcmCOWpzvWoOnAuRP/TMqFOE+xTzDbdNwkqeyz1KuPVAuhS11Enq1hyjRO5vwU/j8
 Jf4aaRIQRYq6mUgxnvZodkrzkncc+FeE8Q9zhXC/yTidhm+7E12oNF6BqLti4mdZ1pKl
 NutgQVzyLocioQuhpheSo5S4RUQQG130Lbiye8g3BoiMmPEsXG0RLsSG1BqgtFQkns6c
 WGgQ==
X-Gm-Message-State: AOAM530tIaknxF7C1v6p3sXMllDHJtXwxIT0LPqJmnTi/MJZdVMJDUfb
 wC7YzCtss9i4LzDtV/rSOQ==
X-Google-Smtp-Source: ABdhPJwVb9jNY+tf48aCkvEKARd+56FFc2A96PY8V0WlIyLx6KzFPooDrUWIeMIWNHDl/AImI3EhAA==
X-Received: by 2002:a05:6e02:10d1:: with SMTP id
 s17mr3615039ilj.159.1616610178809; 
 Wed, 24 Mar 2021 11:22:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id k3sm1404464ioj.35.2021.03.24.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 11:22:58 -0700 (PDT)
Received: (nullmailer pid 3375422 invoked by uid 1000);
 Wed, 24 Mar 2021 18:22:56 -0000
Date: Wed, 24 Mar 2021 12:22:56 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 4/5] ASoC: dt-bindings: wsa881x: add bindings for port
 mapping
Message-ID: <20210324182256.GA3375367@robh.at.kernel.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
 <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 vkoul@kernel.org, broonie@kernel.org, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

On Mon, 15 Mar 2021 16:56:49 +0000, Srinivas Kandagatla wrote:
> WSA881x SoundWire device ports are statically assigned to master ports
> at design time. So add bindings required to specify these mappings!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wsa881x.yaml          | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
