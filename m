Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3CBE95A91
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Oct 2023 08:53:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AD2F823;
	Mon,  9 Oct 2023 10:52:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AD2F823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696841627;
	bh=UY+qgo19DN9smM4tqXBzZgl8bnhNBRKEjaxnMvjZtpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XIQF5mJDn099ryvztNY2f5i+bf1FKW5KHTrR1tD5woCxaBuQz43kosoPzoW5IMG7G
	 iXzQmCXLz5wrPON6U5aGm4IOt3RyBMXB5CSxkSy+khiPLpkweUEncTSuh6CGOz0Wd+
	 kmNM4KKHZAiG5bcLfgYXaieVQ9dLfhgX99+rTnX0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD40AF805A8; Mon,  9 Oct 2023 10:51:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A3BCF80589;
	Mon,  9 Oct 2023 10:51:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55DDCF80536; Mon,  9 Oct 2023 10:51:35 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4226F80130
	for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2023 10:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4226F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=jYdMYMkO
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F2FA660708F;
	Mon,  9 Oct 2023 09:51:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1696841492;
	bh=UY+qgo19DN9smM4tqXBzZgl8bnhNBRKEjaxnMvjZtpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jYdMYMkOIpjeICvEe1jn7aDn3VoCBm0LIn6BRupMI+SriDgip+uUGPWy4gFFwIKBg
	 1tIMw4vChvJnGQIpqatgs8c0b/qTUnFJdhugdSGxoD7Ba1VZDlg8WfK3Mol2vd1CuY
	 CF4TFb2552NXR1FGjPAPIlfcj14v//a6LE+gr/fsS5slZlB9SBoeTpq40xElLK4LvG
	 N7MY8r7uvOB5knB0nqyrRihBb7Q2CgCtAecq3vAejSx9ykrzHFI2tg972C8RfK1HGp
	 JRZSua1pQ41tO7/a9WVAkpGa7XYECoafr8a086tNxp580s0jv9S7hKg8bQxN4Lx4T0
	 lir5OYOu8L1Ow==
Message-ID: <3c226979-3a26-ca11-e6a9-984e278d9cb9@collabora.com>
Date: Mon, 9 Oct 2023 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6/8] ASoC: mt8173-rt5650: Drop unused includes
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 alsa-devel@alsa-project.org
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
 <20231006-descriptors-asoc-mediatek-v1-6-07fe79f337f5@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-6-07fe79f337f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: UWYMQ3CA6GUNZ7AV4H4H7CB6DDEPUJPN
X-Message-ID-Hash: UWYMQ3CA6GUNZ7AV4H4H7CB6DDEPUJPN
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UWYMQ3CA6GUNZ7AV4H4H7CB6DDEPUJPN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 06/10/23 15:46, Linus Walleij ha scritto:
> This driver includes the legacy GPIO header <linux/gpio.h> and
> <linux/of_gpio.h> but does not use any symbols from either of
> them so drop the includes.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

