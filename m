Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459DDC7EE26
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 07:50:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 095A0827;
	Mon, 22 May 2023 09:49:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 095A0827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684741802;
	bh=xQKb2brtOcCrqzlSja0L9kWtYTI4tDxIxLi6ED4aD5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gbc6D/xWtCbh8ejXN9tmEifr1Y1TTkTdrHTNV3eXMa7XeZtNI48AU7eDm7IdIS+GK
	 cNjPqYcxctnGRpUldsc1f44Ikgz/PJg9iDdlfrZJczFaOdHCxMgEwZVP6tcSdGaxRS
	 LcVi/MjN3NCPCdYrP0JBLJOD9Fxa52EGoP1daSI4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E370EF80542; Mon, 22 May 2023 09:48:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CF4DF80542;
	Mon, 22 May 2023 09:48:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73D86F8024E; Mon, 22 May 2023 09:48:36 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C66FF80053
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 09:48:34 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 363BA1E2D;
	Mon, 22 May 2023 09:48:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 363BA1E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684741713; bh=9zMqes+CML+bl1gvKF6Yn9P9rlpGVJ+oN5VUPw+X05c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QoV/l2CzA9M4gjAkCmLlswkBjL8bhpozix8Z+GsWvluv+ZcU/z3irhC3PIEvie/xI
	 3gICv86iDqf5xsurcqod4ix08qyp7hr5mS3rho5bkkWGFkY2+EElZ2CUalG6B+qMKH
	 fjDi0jacz9/u2IxfLGB64iQpVF0PxN3Mhk4DqzLs=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 09:48:31 +0200 (CEST)
Message-ID: <956d1952-e547-f969-fa5a-663370665799@perex.cz>
Date: Mon, 22 May 2023 09:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 29/36] ALSA: seq: Automatic conversion of UMP events
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-30-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230519093114.28813-30-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2CPCGBNWFG6WAJ5WTQB4NWZBCX6F5EQK
X-Message-ID-Hash: 2CPCGBNWFG6WAJ5WTQB4NWZBCX6F5EQK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2CPCGBNWFG6WAJ5WTQB4NWZBCX6F5EQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:31, Takashi Iwai wrote:
> This patch enables the automatic conversion of UMP events from/to the
> legacy ALSA sequencer MIDI events.  Also, as UMP itself has two
> different modes (MIDI 1.0 and MIDI 2.0), yet another converters
> between them are needed, too.  Namely, we have conversions between the
> legacy and UMP like:
>    - seq legacy event -> seq UMP MIDI 1.0 event
>    - seq legacy event -> seq UMP MIDI 2.0 event
>    - seq UMP MIDI 1.0 event -> seq legacy event
>    - seq UMP MIDI 2.0 event -> seq legacy event
> 
> and the conversions between UMP MIDI 1.0 and 2.0 clients like:
>    - seq UMP MIDI 1.0 event -> seq UMP MIDI 2.0 event
>    - seq UMP MIDI 2.0 event -> seq UMP MIDI 1.0 event
> 
> The translation is per best-effort; some MIDI 2.0 specific events are
> ignored when translated to MIDI 1.0.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

