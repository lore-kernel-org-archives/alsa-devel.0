Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4270DC7618E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Apr 2023 10:34:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E01FF28;
	Mon, 24 Apr 2023 12:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E01FF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682332470;
	bh=I+AArAY1YcEyPrvgN7assWYGYocSeYaZq0COT2cIpEI=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BaemJR2AsQF0ct2MIRlTZd4jYtBplEM796JD+KFV19m5ays1yt657ZhIgjEOo0oaZ
	 8d9axiMZ5YFNVWmTY1uezItdOxb0jkMWIyako7xODIiH33BxZ/m17C8WjMAJIFp+Ro
	 qv7frRjGaMyVCu9rQ8nhxnT6zhjwdAMxRsosR7qk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5F26F8018A;
	Mon, 24 Apr 2023 12:33:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9728F8018A; Mon, 24 Apr 2023 12:33:08 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9EFCF80104
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2023 12:33:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9EFCF80104
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B9E4523E69;
	Mon, 24 Apr 2023 06:32:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqtVC-MLH-00; Mon, 24 Apr 2023 12:32:58 +0200
Date: Mon, 24 Apr 2023 12:32:58 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: emu10k1: fix multi-channel playback device class
Message-ID: <ZEZa2oQV20IgqNvR@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230422161021.1143989-1-oswald.buddenhagen@gmx.de>
 <874jp7oy2k.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <874jp7oy2k.wl-tiwai@suse.de>
Message-ID-Hash: JKYQETHXQ6NA7JFQPK2JOE7F77JKGINC
X-Message-ID-Hash: JKYQETHXQ6NA7JFQPK2JOE7F77JKGINC
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JKYQETHXQ6NA7JFQPK2JOE7F77JKGINC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Apr 23, 2023 at 09:30:11AM +0200, Takashi Iwai wrote:
>On Sat, 22 Apr 2023 18:10:21 +0200,
>Oswald Buddenhagen wrote:
>> 
>> It's multi, not mono/stereo.
>> 
>> AFAICT, this doesn't do anything in the kernel.
>
>... but those values are read by user-space.
>
>> Also, I think the subclass is meaningless for devices with just one
>> stream, but whatever.
>
>Again, the value is read by user-space.
>
i assumed that much.
but these are another thing that appears to have exactly zero useful 
documentation.

>So changing both have clear influence on the user-space program, and
>unless you have to change this for fixing a real bug (and there is no
>other way), this is too risky.  IOW, too late to change, we have to
>accept those values.
>
there aren't any precedents for use of SNDRV_PCM_CLASS_MULTI and 
SNDRV_PCM_SUBCLASS_MULTI_MIX in the kernel tree.
there don't appear to be relevant hits outside the kernel, either.
it's conceivable that some code would check for the *_GENERIC enums, but 
i didn't find such code.
so i'd postulate that these enums are effectively dead, and both the 
risk and the gain of this change are about zero.
i suggest to initiate a formal deprecation procedure for the MULTI enum 
values, however that's supposed to look like.

regards
