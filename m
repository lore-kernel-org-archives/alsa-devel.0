Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951FBC77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 06:43:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62011827;
	Mon, 22 May 2023 08:42:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62011827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684737811;
	bh=QFamjhl0bSzOW4IYcsfDpxvrxXdIudr8UIqjBynodiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OdOLjAcQRmTCpyutEIvAdO9BdncZV2o1IiVHQz/tMG+VL1sMv3e+kMHDMaom1nPUT
	 oQCYJv3rS282PnfVC0vu81XvOur3oguGfWxuQxWDDVQpEuML6/neW+9k1rDmxZk71c
	 lxXnYlnRjktNVxRtNYy+/Kz6M/461cd694cT+edU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1268F80249; Mon, 22 May 2023 08:42:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FF85F80086;
	Mon, 22 May 2023 08:42:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20533F8024E; Mon, 22 May 2023 08:42:03 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C796F8016A
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 08:42:01 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 13DAE1E2D;
	Mon, 22 May 2023 08:42:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 13DAE1E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684737720; bh=3TDF/w5/PalWqytNQYjVdSwlKM0RnVbFbw+iOnEgYqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rGWDwR089yKmjXz8Qf6K3osG5pJ28oeaUeGkBVgVYwvNdZEq82je7KXya+LJBBccR
	 Yd0V4lofKh2wHxcWwJbSS4GlkS71OwdU7YBGjySGaloCD6JRnRUNwZgg1dBMgyhfk2
	 /I7QMwqn4leSbbyTf6pJ/K1D55UB2M0GPtqLup0s=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 08:41:57 +0200 (CEST)
Message-ID: <449358ff-ed1a-6ba3-4bd3-e31ae6ae9e3b@perex.cz>
Date: Mon, 22 May 2023 08:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/36] ALSA: usb-audio: Define USB MIDI 2.0 specs
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-8-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-8-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: EN6VQYMHKFAMFBZFJ4XMJ3WHHAWICETH
X-Message-ID-Hash: EN6VQYMHKFAMFBZFJ4XMJ3WHHAWICETH
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EN6VQYMHKFAMFBZFJ4XMJ3WHHAWICETH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:30, Takashi Iwai wrote:
> Define new structs and constants from USB MIDI 2.0 specification,
> to be used in the upcoming MIDI 2.0 support in USB-audio driver.
> 
> A new class-specific endpoint descriptor and group terminal block
> descriptors are defined.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

