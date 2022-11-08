Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BEC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Nov 2022 08:44:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B25283D;
	Tue,  8 Nov 2022 09:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B25283D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667897083;
	bh=q6qqpBqwMQgI0Wus+7X9VLIEmROhuwDUjEYSYZTBgvA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGZzK5M0QIVM4cIyx70ZpCS2LhP/aLtZlJDfT6Rd13WkfEIGT6hOrI5oEUPKr3Mde
	 H+c2r+GQXGz6WpS2dUYYfyThZtyS1ZVq5RNaGwOjzd9PYBwk83k5Jomei7gOHD9ikt
	 EnOhFyEb/itjfDot26a/oRXu66F8+xN7aCxzH20w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFDB2F8025D;
	Tue,  8 Nov 2022 09:43:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8B2CF8025D; Tue,  8 Nov 2022 09:43:28 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAA26F8016E
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2022 09:43:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAA26F8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="TWQ72G8U"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 3FA886602976;
 Tue,  8 Nov 2022 08:43:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667897001;
 bh=q6qqpBqwMQgI0Wus+7X9VLIEmROhuwDUjEYSYZTBgvA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TWQ72G8UW8iqxetw63L/N1MecpWvtaewg3Qu0IFRvW92OdzV0yvtqM8dMDudePwmr
 mceF1EJhqO0jg9FsU6PYVj7jE/4lZN3xMXCh61/VbAhkehykTneCU/FQUP8sVcoC8S
 NLlD6KHQFmWx9ZHzQQGA8e1EMsHH5+N38dN6DBXOsxdbMsJgIrZeTa3kI3yx15ChM2
 PB1dPP082Lz1Zp1dBKvbu3eotSZr5gsx4lhVfloYeeAt0VJQNOjQSvAWyaWIyj2Nfj
 K3f9EyRMZGJ1Yz8HkZgCuyIrrIypruL7ydRfvFhAegnc1BmNmdzdToNG1LlW4YImRR
 /E8F1PP9f+Jcg==
Message-ID: <4ebab444-a6b7-746a-4628-f5c0681c3b47@collabora.com>
Date: Tue, 8 Nov 2022 09:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/9] ASoC: mediatek: mt2701-wm8960: Register to module
 device table
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>
References: <20221107160437.740353-1-nfraprado@collabora.com>
 <20221107160437.740353-3-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221107160437.740353-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
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

Il 07/11/22 17:04, Nícolas F. R. A. Prado ha scritto:
> Register the compatibles for this module on the module device table so
> it can be automatically loaded when a matching device is found on the
> system.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


