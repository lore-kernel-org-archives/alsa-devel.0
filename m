Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57786C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 07:52:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3578D204;
	Mon, 26 Sep 2022 09:51:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3578D204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664178755;
	bh=jRzEPtnKifOeywmOYhARVPJ3VQMiGaHReABwgtSyS54=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ak4jfw5KbQVC7xaDk7nAGSXQUa7rS33VG5fFVjbHCsT4l6GAgjwXo/+9i6aCeoBaZ
	 irWo8XbwlE+gKIGuggpt1AABPOnkOMyCi2ot2bqkEAjTT/lmX+kY+uIB7RWcWZO2Jn
	 7wzkQRTQ2kyFw1otTIr03lvOm2d64XglQYJzBIp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B742F80254;
	Mon, 26 Sep 2022 09:51:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4EB6F8027D; Mon, 26 Sep 2022 09:51:42 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FB9EF80134
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 09:51:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB9EF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Kl/ik9OP"
Received: by mail-lf1-x12f.google.com with SMTP id s6so9501889lfo.7
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=jvYvVWLSf4e8Yu944Qnf0DCzJLFbXHx/b6AjfcFyxfg=;
 b=Kl/ik9OP6N486uc3ipCE3PqQ2EnzmmRRIVsetjtVaSwuqxB3KcKxDYZsaVrrG7tocC
 p+YmpNpCtt5hO0WTBfYSh1rZnOfK6argETuht+HyCDwGBgNWRaUSsG4l6hKH65HeDC5a
 nITqMcklR5qVn/doCUCknHlKwh33wJqe5GXSC8FWxRVvRSEp2+oNSIAnGT1rlBEzRk/4
 UdFj0X6Q6yMcqqXYm33FWhVlyaVURGpQATLNZqvHxPl2Avi0GkFfnhQuw5zmJ+jdR0bT
 exzHy5eigO7oKeJ9ZdAVaOkVRuoyvDU6hlkJB6o1c5ivwpdMSO6USsUm7eT4om/W9VL+
 FGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=jvYvVWLSf4e8Yu944Qnf0DCzJLFbXHx/b6AjfcFyxfg=;
 b=pRFpWreEKZdccO676BxFJcqbmWE5rpuEzaG1/lEtf9/hzt/OF/Sb1E4oekThDpKC/G
 xJtXu+cnIIlMH9V9NkNKFXcZeBsXSrpGYQyZevk+Eky91FAswjuCglGusagkVV16EMb/
 +VcgvH6yXV8Arp+LmL9PPQQ38zdyfYtFhuonaGidHbmN0t4ACZYtUEAei5b8uoAVAB3t
 jfn5o/ptGDIfawBD+YAbn5CB0A3ApwhY+vyI6OsSrUBsQBX7oP7xPBiZMuUtdMlDnzeS
 L2kXv68o6kVCo4nhAgG4GWTnO2E020SBxfMVTvb0Fuaw6UDF02+ZsFEGbraudiyB4vfd
 1PwQ==
X-Gm-Message-State: ACrzQf2N63SyaAPEjt9Ebv+Nc26Vcqe0wKpoofgc8+KjuvH5rIG5TQsA
 kS6mR27yExgmJvXoMdB5ehlLMg==
X-Google-Smtp-Source: AMsMyM72gQh9BlSdHlb/fUZ1pBNnUC1vPovZqUS1FS9beAE/yju5eVqdX25l69BydVEZuU/PbcPKwA==
X-Received: by 2002:a05:6512:1188:b0:499:6fbf:d751 with SMTP id
 g8-20020a056512118800b004996fbfd751mr8550642lfr.51.1664178698030; 
 Mon, 26 Sep 2022 00:51:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 i30-20020a198c5e000000b00485caa0f5dfsm2461378lfj.44.2022.09.26.00.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Sep 2022 00:51:37 -0700 (PDT)
Message-ID: <aca7f1c2-488e-28b7-2ea5-ead507aa535c@linaro.org>
Date: Mon, 26 Sep 2022 09:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] ASoC: codecs: wcd934x: Fix Kconfig dependency
Content-Language: en-US
To: Ren Zhijie <renzhijie2@huawei.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
 james.schulman@cirrus.com, cy_huang@richtek.com, flatmax@flatmax.com,
 pierre-louis.bossart@linux.intel.com, lukas.bulwahn@gmail.com,
 srinivas.kandagatla@linaro.org
References: <20220926074042.13297-1-renzhijie2@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926074042.13297-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On 26/09/2022 09:40, Ren Zhijie wrote:
> If CONFIG_REGMAP_SLIMBUS is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
> will be failed, like this:
> 
> sound/soc/codecs/wcd934x.o: In function `wcd934x_codec_probe':
> wcd934x.c:(.text+0x3310): undefined reference to `__regmap_init_slimbus'
> make: *** [vmlinux] Error 1
> 
> Add select REGMAP_SLIMBUS to config SND_SOC_WCD934X.
> 
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

