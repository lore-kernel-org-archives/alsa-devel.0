Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEEFEB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 09:54:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 594EE1EF;
	Wed, 21 Jun 2023 11:53:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 594EE1EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687341256;
	bh=HjDAudkKipQLczGA3Z+Xcf4LUnUH5z5iQaIO41AWYto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KJihcys4lClsktKH49YFyS5xnNQxXR4vW/ObxNbkGzQZtCdy+iiGrhdTofUG8FZtq
	 5gPsAgTpq3EDKYQamTpgSOiv8fp2r8B27ODpKTW3ZcaKMo4J6xLQ2gyiqVYWEMnAPr
	 drh+ZrozOwLq+0p6xhPg3IMY/QreQ/o9Gzw1cbFg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68B88F80093; Wed, 21 Jun 2023 11:53:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C275FF80141;
	Wed, 21 Jun 2023 11:53:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52BF3F80141; Wed, 21 Jun 2023 11:52:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08D8FF80124
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 11:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08D8FF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=e4nqUfiW
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown
 [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FB486606F73;
	Wed, 21 Jun 2023 10:52:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687341170;
	bh=HjDAudkKipQLczGA3Z+Xcf4LUnUH5z5iQaIO41AWYto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4nqUfiWPdOPILSnlwY/fnUauQ1CgUSbBk904O3wxRq8jufIdx8Se0MUH8zg2LTa6
	 F07saruQacith8Q7T55AI+b2nspXoX4g5eiOtdk4qrDdC74qOcbephNt7p/2ryX5ci
	 Cfu5P9NI2QgrEEyVHqPZzrz85w5mjlqirx3nGX3iv1QWwizOKwo6LV08oTaWT6+JfS
	 3jwuzOq7ILskZxpSV6FUQ7JgX7lPuOdjkAQck2+rRDKqhjHH3e2xAdWRVb2IcdY+NN
	 PhbzBizMVGXgFDHl+evY1+z4mECWBOFGqWcr+qyAW74O7oHu+3yxRxc7G2kvZTEM6R
	 gQZSyraCMBQfQ==
Message-ID: <d26ea42b-5749-bf08-997b-4a3b6062aed4@collabora.com>
Date: Wed, 21 Jun 2023 11:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] kselftest/alsa: pcm-test: Move stream duration and
 margin to variables
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>
Cc: kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
 Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-2-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230620220839.2215057-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MFJITQVAX6QOZHV6QIIR27ZWVUZ6LWPE
X-Message-ID-Hash: MFJITQVAX6QOZHV6QIIR27ZWVUZ6LWPE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MFJITQVAX6QOZHV6QIIR27ZWVUZ6LWPE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 21/06/23 00:08, Nícolas F. R. A. Prado ha scritto:
> The duration to stream for and time margin to consider the stream failed
> are currently hardcoded values. Move them to variables so they can be
> reused and more easily changed.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

