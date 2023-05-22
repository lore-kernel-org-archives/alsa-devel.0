Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695BC77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 06:37:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5328B825;
	Mon, 22 May 2023 08:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5328B825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684737444;
	bh=tvZxA/tJdJJ9WoJwHmkvZvukKP3rUheDQtC6T4I6Wgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UkRz5Q2J7kWNhvHxowTU24aYscrKo/ZzjiaWCTwiPA8fkdVp4++vNhq5hlqcs9Ha9
	 pMdiiIENxbvL6TrPEm+xw33SKFfPz492cNymEJgF7xoMVbDQdqA4LIeT/c0N/vl88U
	 dbEGVks4Y3XEC6Su6LH0RQZHDWwt+Of6PCGeP7Cs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D704BF80549; Mon, 22 May 2023 08:36:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23A52F8024E;
	Mon, 22 May 2023 08:36:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E72EAF8024E; Mon, 22 May 2023 08:36:21 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1DB6F80086
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 08:36:19 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EC6871E35;
	Mon, 22 May 2023 08:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EC6871E35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684737379; bh=H5B3vntJ303EK1IzBk7UMw45d6D+BN6rZPkxhG0nucA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Byue3Ly8uN8gpke3DvK7LD5M4iIBocepC0sEsFqFIwgjTTL07XK+o4HrFTjJGFE1o
	 1VNlosqSiBo7v0nE1chODrogdSYvn53Cb7WwVsUFGLJkY5q3PjQPal2PKSescj6vsG
	 zLfYzwuKKdvEzXXTmoDtv9bitvg36UfUOCzuqtPo=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 08:36:16 +0200 (CEST)
Message-ID: <13f9ddd3-6720-3c77-8bd9-7b21c1fb2d22@perex.cz>
Date: Mon, 22 May 2023 08:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 04/36] ALSA: rawmidi: Skip UMP devices at
 SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-5-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-5-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NCLKIBMEPVCH7POTSLTARORP5NI23YMH
X-Message-ID-Hash: NCLKIBMEPVCH7POTSLTARORP5NI23YMH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NCLKIBMEPVCH7POTSLTARORP5NI23YMH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:30, Takashi Iwai wrote:
> Applications may look for rawmidi devices with the ioctl
> SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE.  Returning a UMP device from this
> ioctl may confuse the existing applications that support only the
> legacy rawmidi.
> 
> This patch changes the code to skip the UMP devices from the lookup
> for avoiding the confusion, and introduces a new ioctl to look for the
> UMP devices instead.

Missing bump of the control API protocol version ?

Otherwise:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

