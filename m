Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA9CD98F2
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:09:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C41B601F1;
	Fri, 19 Jun 2026 15:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C41B601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781874557;
	bh=FZPyrhDIKHtZnqWESVoiWoI3FIueJBpbIWsR3B2EWZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ML7FwutPfXLq9fjvkZTmdhzJGmpN04EbkELBcKEarODwMqoII4maYH6jykEFSGWV/
	 95rJldcAdZBbr4IvBiSWz/3rVJtdNtkF42y/IMLdyp8VEQeUr5yjT1UIYAbYx4d4SF
	 beUEkCTUYNL2a939qr5ZChw4RjGg+l1SY7oX7x1Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 331CCF805FC; Fri, 19 Jun 2026 15:08:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCD68F805F3;
	Fri, 19 Jun 2026 15:08:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72AB8F80423; Fri, 19 Jun 2026 15:08:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781874513;
	b=HACn8nJx+ytQ2g9sLgMP9KtbK1Javb+sfgSALKWyONDhBBjPjR1xjhba9+WI2sqNJ5dl
	 XKtPQDzT6Y1A5qjFJSN6lUxkvHZxyJCOx66y4VAQxoWXVDcBJfG+A6LAsO0EOONtlf1D2
	 Pn2uuct+ACpUR9HG2eypdk2kuwtVM/80IZ7Z36Bqg0ri25CjeDRy8coakQ2nf5x/sR9C7
	 31+tFRkPQ4EF41zY9rO3D3NNK0jaM/l7TRkGNrKp4JRb+H6CckiQK0Wfg2TU3CDjkRiAP
	 2ZC4vQtK0RvnWhbZX2o5lqAAH6PV21kTaF0O5EsVLz1AQUU+n9cRo8sisedjzuHiV1g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781874513;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=FZPyrhDIKHtZnqWESVoiWoI3FIueJBpbIWsR3B2EWZ4=;
	b=E2oiiVwmceKdQVJbKhuf+0cPkhy/L0hCTBb25s1CogUgpOk7pyoBkOsdm8zzNY6nwzIt
	 rJy57KxytF+UZO8vi5H+OH13jEXvq+BEdXnG2SBpFcmgCdXGxhYJkpj02Xw1A44aJAJVe
	 0LgJwCdhMQH7vpol8QTwiMFh/Kt6o985mdGkZuvbrEWdlrA0QXSnv+r5X30WZ/VSkBt+x
	 Cb+RKpu3ejYv+3ie2D2l8cxWEDMfOKyVOXoHWwr97YAPoJvtuLFDPDKi2ByFuUc+PTnnn
	 ft21sh2wjK8cwEczWUA4TjfOoNI2ann64ZWecLJao3ZOB1Dgq1WP6IrRgL4dkaHE6gg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CWxG03f+;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 932C6F8003C
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2026 15:08:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 932C6F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CWxG03f+
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so1400548f8f.3
        for <alsa-devel@alsa-project.org>;
 Fri, 19 Jun 2026 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874512; x=1782479312;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kZhsgkJerSVKBfdIsaLkYedynvx7vkcSWkFfn2/TgwA=;
        b=CWxG03f+nNoPikIB+LQIJhxo1ed+bLp5AxUal0VDdJ1Ui3C1RYZ+ON2qezvqLktdma
         XBQivY47Ib3hIA4VXS82OSwhBXgF1pp1WJ2G+Hyrx+D3DpTTwpdA1vRswWgMX5UPXYfg
         q0dDQkZ62W4oo2yROSBbeYrD/ba2HMhhUjfhQYB7RmUBFMP26FLrXRqOK/9SGAVrWlWL
         jCBFtnP96NVswUa3Z5Wwv/ThkdOZY5dSBFfwAvVndxFXKlXUo0yg0V4EMFo2YpgyUTN8
         DHeb+JFh+SbYAzmc+JFebk+XXv9EWwuewx2Qcmxv2MJxwKaiEWqThmgsCKZJu2OEjIsq
         9dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874512; x=1782479312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZhsgkJerSVKBfdIsaLkYedynvx7vkcSWkFfn2/TgwA=;
        b=owDGnMZ+/66HGwDg3GvLEiKt6Jxq+nrcc0ik8ERgCwwXpdbARRWMZUhoVYi3hNu/YC
         Y1LAtBSyE3bOvnK3Vj5UF2chiX55CcvLQgf+ipUKdCZSsepvlm4IdTUXC69WqaFWTRk1
         bFLtuEcxKQycaRnzzFMppEXLQAUqEwxpy0ftHw1tZost2ktn3+gr8nb2i/zwdTQO+T6g
         mgrh99SjLtt72JLmpLJUyAtH+qdC0htHTyUOifqse+LkEKIGXq2cjRBytMP8KeV5YQdu
         0MNFKj+4OHUQwvFRbV+nVrzwXtsSBO+fenSNCtIHUTiWMO9U+d3r6hOYtqqVmItZuhn1
         vrLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X3bGaA4DgAlHTbG8dyU6JeQacRyi8Tt0MifDtvVwssBgZ8M7zN/0EJv8ABpy+k2e/8ZyjHi8HZTNf@alsa-project.org
X-Gm-Message-State: AOJu0Yz+F/qSCIN26mNmAx4/d52uE5nDk4vsvI96rCqalrzw3W+91Waz
	MY/rBS6CVkPWV+KVOjlYSWrnYEckYFf5tvbAsVQNaWd2uNoJX3OrGvcs
X-Gm-Gg: AfdE7ck24pU2SLP+icVoVo2aZKpIcAr+PJISNuTZE9S4kpURsiFC82C8yTy3RGvTG/t
	eqSKR+iJj7F707M2n5YhfQRW+Cq2OX0A8BYD5cOEB9jKgD7hn5dO+jvj189upROEC/kmZgzktTG
	TaTGTSae59WKJ6Zkb6R4RjQwxlWKV0gP6T0QATtOfpbH9cfyZ48ujYp++rEyhDmqqnHeAz+/AlY
	pAVgvkEfdvS5BBc3Fx/3ieM1mt5G/IGACmaQyuygNNVfsxJ3hHEUBW54XGs5aZc1nSOkabzanQi
	5Jh+NJZRnrjHF57xUVDWHyED/VjnVaMBF/mvWKlhi0xk/YhOZNNjEdPaJnAbFsVL4ompUbkXl2k
	I+ioACbPh49gGyzO/+tkNwA4Eu/6D8YHJmNuvzgpf5qRCA+yQJz8MFsdBsBADDwXnLKGvdjVXwp
	4jy5Lpa+91qnfRRXkLGZI51wL31vH01ucPRcrAS5R7aWiB+roBdFu742sJ5kfqVdMcQdlMHCtF3
	/D2x2k=
X-Received: by 2002:a05:6000:481b:b0:45e:eaed:afd2 with SMTP id
 ffacd0b85a97d-465041d5b0amr6899357f8f.0.1781874511611;
        Fri, 19 Jun 2026 06:08:31 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a33csm7291097f8f.17.2026.06.19.06.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:08:30 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <f092d0a0-3188-4fd0-8228-2b715c642a08@gmail.com>
Date: Fri, 19 Jun 2026 14:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: acp: Fix linker error with SDCA quirks
To: Syed Saba Kareem <syed.sabakareem@amd.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Mario Limonciello
 <mario.limonciello@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Hasun Park <hasunpark@gmail.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260619124343.1683484-1-syed.sabakareem@amd.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260619124343.1683484-1-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ZJFVKPGTKKM4S42E4EWGI37RPPVYMKC3
X-Message-ID-Hash: ZJFVKPGTKKM4S42E4EWGI37RPPVYMKC3
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZJFVKPGTKKM4S42E4EWGI37RPPVYMKC3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Syed,

On 6/19/26 13:43, Syed Saba Kareem wrote:

>  config SND_SOC_ACPI_AMD_SDCA_QUIRKS
> -	tristate
> -	depends on ACPI
> +	bool "AMD ACPI SDCA quirks"
> +	depends on SND_SOC_ACPI_AMD_MATCH
>  	depends on SND_SOC_SDCA
> +        depends on SND_SOC_ACPI_AMD_MATCH = m || SND_SOC_SDCA = y
> +	default y
> +	help
> +	  Enable SDCA quirk support for AMD ACPI match tables.
> +	  This is compiled into the snd-soc-acpi-amd-match module.

This Kconfig file uses tabs instead of spaces. Most of your Kconfig
additions are formatted correctly, but one line uses spaces.

- Julian Braha
