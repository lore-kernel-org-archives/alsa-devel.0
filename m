Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04C8C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Nov 2021 01:09:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2BF318E1;
	Fri, 26 Nov 2021 02:08:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2BF318E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637888978;
	bh=5xbh4X4pCsv3FSndus2wpPYw9GjF0D+jnSTbXmCIct0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IN7L/rysEsuptTYoIbe1wiK4ulpCg+szPZHUvji3+ixBWMGXx2W30eEFu/FTIMBWz
	 Ih2FZDuG2RNtIty85QezXbHcWldSNVUVstcy7wMFjEsp01xtkx5Ys2fJwibx3PZ+Tz
	 fjvNF5v+QUu06muhT6a6ZTpJKczyjUTo5BU9BeQI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C1D0F80430;
	Fri, 26 Nov 2021 02:08:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A6B2F8049E; Fri, 26 Nov 2021 02:08:44 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95A05F80302
 for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2021 02:08:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95A05F80302
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HK1690AT"
Received: by mail-lj1-x231.google.com with SMTP id k23so15611730lje.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 17:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UGO6rN17miNJTMO6kEKzbLFRfLfEsZ5XOCr8ahzcsGE=;
 b=HK1690ATF2nVNKaPt4pcQ/SDRvwvKGIyUie/R+Ts0aO0XKAnxrlKyp4NTqDOxuYs4M
 9L4pDu9CaYXbl8S1JvKp7yAT/Zbu/BECeB9F4k/8i1ftew3HsHmb93PTSP6+uMXwIX1z
 UoZWxjOytY6YLF6cfmuc7jfVmVFuLSr8hQ4xoZDuhYBZ+0OUvDczc/6ERD8GYlBz6v1Q
 +QlX0NKojruA72vchivpj5Ws2QKiXfwTl1z0/cJJCNIXLWYdtbIOgw2UdT7/9+VxiANA
 G/DaPjjWEH3WVuEHymvrWcWs2ifI4mdK2KU6DZQSt5svH3wpVQr3DcODzIrWlXzYt9JE
 AL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UGO6rN17miNJTMO6kEKzbLFRfLfEsZ5XOCr8ahzcsGE=;
 b=WvUbdHg9h5FJfq2XLPfutPPlNLds2JIQ5+vm1kJBsbodZ2Kn9Fp+xhRZJRj4I5oVS1
 5G1DtrcuJf5E/0cPW7j5PGPyoTQpA+YaW0s4zPOMVUE/6NpScxFKVrT20HBHeMTGVjE5
 8e6kkFwFLhlY4Hnb+QmqIgTOB0kO1knRQPfPjKeNJCUqGtBB+jHQ/TrQlOPlGcjoOoNL
 s6GMMKufCSd2l368xTW5Hbbdw341PmJHtFWkmMXP7F7h78qynXbM4b1pX0znHQf6AEaz
 6QxcG8/89w0XtqRlXDSaFHulk/yWuMpug9wXSZ/EDtKzA0lCJbSrTOpPDvr0pz7Fa5ZO
 AD6w==
X-Gm-Message-State: AOAM530TuspcMcL0Xe7rx1UjH4jy+C8pDUrXD6dWkc43UubPo4iGHJqa
 Betg3kX2otR90yIFDjwEX2o=
X-Google-Smtp-Source: ABdhPJw5u/B8ZH1YuKd4akVumwownmSG11mUWnxsExAZ8MTck+K+I3tFpmYsTmIOkMfN8rDKfnoapQ==
X-Received: by 2002:a2e:e09:: with SMTP id 9mr20584527ljo.172.1637888906336;
 Thu, 25 Nov 2021 17:08:26 -0800 (PST)
Received: from [192.168.2.145] (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
 by smtp.googlemail.com with ESMTPSA id z4sm372582ljj.26.2021.11.25.17.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Nov 2021 17:08:25 -0800 (PST)
Subject: Re: [PATCH v1 02/20] ASoC: dt-bindings: tegra20-i2s: Convert to schema
To: Rob Herring <robh@kernel.org>
References: <20211124220057.15763-1-digetx@gmail.com>
 <20211124220057.15763-3-digetx@gmail.com>
 <1637875562.276093.2858310.nullmailer@robh.at.kernel.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d12b0e75-4605-b65a-2f87-a4c4d363fc90@gmail.com>
Date: Fri, 26 Nov 2021 04:08:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637875562.276093.2858310.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Agneli <poczt@protonmail.ch>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
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

26.11.2021 00:26, Rob Herring пишет:
> On Thu, 25 Nov 2021 01:00:39 +0300, Dmitry Osipenko wrote:
>> Convert NVIDIA Tegra20 I2S binding to schema.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/sound/nvidia,tegra20-i2s.txt     | 30 --------
>>  .../bindings/sound/nvidia,tegra20-i2s.yaml    | 71 +++++++++++++++++++
>>  2 files changed, 71 insertions(+), 30 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.example.dt.yaml: i2s@70002800: 'clock-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1559387
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Indeed, I missed to re-check the I2S binding after last minute changes.
That's compelling reason to make v2.

Then I'll also remove the now-unnecessary assigned-clocks property from
the S/PDIF binding.
