Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428E4C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jul 2022 03:00:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E36C6100;
	Mon, 11 Jul 2022 04:59:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E36C6100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657508447;
	bh=1tAfhN/vmGMqN3Vslimj5cD27VtEZ0xOlM4tb4oB7Mo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AhqH1arUdRGvMprspCewJhq2T195YJ3yHX5schXBeS/X3ArSH15b+O0VS06BpF4yT
	 tz0F/o9e38sRQPhlqWjeCHnf0VE3M0jg57zhb8ZVBYnv7M8fejRH3FDxz04+tMIz6C
	 ef4odNgsQ+pR8ra7yMO3WbJdnAn4IYbGsvSKq+0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5559DF80155;
	Mon, 11 Jul 2022 04:59:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DA16F80163; Mon, 11 Jul 2022 04:59:55 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69A7AF80152
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2022 04:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69A7AF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YV0saGWc"
Received: by mail-pl1-x636.google.com with SMTP id r1so3329815plo.10
 for <alsa-devel@alsa-project.org>; Sun, 10 Jul 2022 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2WqbsqnJBgBtP7DjnnhraykI1JIFLr/Z5s9tS9xDIA8=;
 b=YV0saGWc86Dr0nLb97pd2N+sjGpt7P84y62z7L/fx7FhOr67Aidp66vasyVaFWstou
 1sf5hspntxeheOTlauMVYz9fUaAO9R8te5hc8OdqcPv3U2+OrYkNFbwjlUVchNpjv5jz
 PYtziagU5jSqpiRvryMD0DoW8T8r7Afv47ZpJsFhwgag8WdRsdac8shwhzTnVXPD/gu2
 q61/IokaBBQV4swk7VAEuIkWydju5kDpcS+nUpd9xdKCsOAGF4rHgoS6rmcRQO+My9aZ
 eAy2A5YNTSA7s8DsBWi6jezZe2CxYOXp3sCWRvF7qG/qGUzvHtzLeOk74HeHcLVWDRKQ
 CM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2WqbsqnJBgBtP7DjnnhraykI1JIFLr/Z5s9tS9xDIA8=;
 b=FXyTVVWTiPOSB1ugTiCNI3wOojwhld5nfK/mDvEzaC7BTfweyaCs+5bMFCYuwBOwiv
 UJgx4Aot00isZ1Wj+/eaVDbsoPcqPRZK1TH6q7p+PXBRuzqmT/qXq0A+KCnUiykNxKep
 lHK5XMDBIiTP3+8v+cMj0nm4V/5tqoAWLN7GVKET/7I+kf+Zt+6mulLP+2CbksuRjsju
 UO4UXPK28NYosghy/YUntp1/0pW66CL7hdfDHXuJbyUnPwNIjS9o0hduTpbFnMBxTZ7V
 9izliwIcx7CSm+NBHq0FyUDi4h63fsQ806eBtQIQ/4GmwPOv3zb//d6TulWSx9WrAKHX
 RfRw==
X-Gm-Message-State: AJIora9cHMfEc4YCfXGx/pMEzZRFIgGgMGJjoL1PEtIkRgCMpnKRJfpO
 LMATKVwQM4YevZ6kGMjYTMw=
X-Google-Smtp-Source: AGRyM1vFxY03KrBrNYv9cLq5Q8Vjt9qgJF235uzEVGiyWYj2Cxe7tws80vt3Ka3OCRoCfBVcZOglBw==
X-Received: by 2002:a17:902:da82:b0:16a:7ca5:36c0 with SMTP id
 j2-20020a170902da8200b0016a7ca536c0mr16226830plx.27.1657508389812; 
 Sun, 10 Jul 2022 19:59:49 -0700 (PDT)
Received: from localhost.localdomain ([116.232.54.164])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a17090a3f8600b001efd4dbcf13sm5744087pjc.39.2022.07.10.19.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jul 2022 19:59:49 -0700 (PDT)
From: Zhu Ning <zhuning0077@gmail.com>
To: vijendar.mukunda@amd.com
Subject: Re: [PATCH 3/3] ASoC: amd: fix for variable set but not used warning
Date: Mon, 11 Jul 2022 10:59:33 +0800
Message-Id: <20220711025933.3445-1-zhuning0077@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d2828d36-275e-60d7-782e-2bff265bae0b@amd.com>
References: <d2828d36-275e-60d7-782e-2bff265bae0b@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, lkp@intel.com,
 Basavaraj.Hiregoudar@amd.com, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 christophe.jaillet@wanadoo.fr, amadeuszx.slawinski@linux.intel.com,
 zhuning@everest-semi.com
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

This code is ok. The machine driver should still function well without gpio.

if (IS_ERR(gpio_pa)) {
        gpiod_put(gpio_pa);
        put_device(codec_dev);
        return dev_err_probe(card->dev, PTR_ERR(gpio_pa),
                                            "could not get pa-enable GPIO\n");

}

You donnot need to handle null gpio_pa gpio.

if (!(IS_ERR_OR_NULL(gpio_pa))) 
	gpiod_set_value_cansleep(gpio_pa, true);
