Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B85C77B61
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Apr 2023 10:17:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B38B0EF2;
	Thu, 13 Apr 2023 12:16:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B38B0EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681381048;
	bh=Y1PjrsSZLYTQAoVQJywSjot9b0rillQuGr78mgT7FTI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pzdAHH8iWInjWJ02AfJ9hlMod3XLH76S1mruLXksZEY2LJx7TaAhhfsTwy1ATo9PH
	 AActPH2nuab2BeVg//XmmNbsoNm+LF+NrC7NQn+f/2BpQxBOkgIR2OJIjUbMN8rmGC
	 TOxz1ZA14LdnyIGdyWKhYzbtcrt1Ktt7fKamvMgA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E0A8F8032B;
	Thu, 13 Apr 2023 12:16:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79F8FF8032B; Thu, 13 Apr 2023 12:16:11 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99FB0F8023A
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2023 12:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99FB0F8023A
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 023BC240CF
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2023 06:16:05 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pmtzo-bjc-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2023 12:16:04 +0200
Date: Thu, 13 Apr 2023 12:16:04 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ALSA: pcm: auto-fill buffer with silence when
 draining playback
Message-ID: <ZDfWZG+VASX/Xo/j@ugly>
Mail-Followup-To: ALSA development <alsa-devel@alsa-project.org>
References: <22f551f3-deae-1536-bd07-0b9340940ea4@perex.cz>
 <ZDVnUj2B0EkMiOlA@ugly>
 <6d6c5f3a-81bc-acf4-eb4d-229b581bbe8b@perex.cz>
 <ZDWPy9YbXWWOqaC+@ugly>
 <7b317956-deb1-0a75-0a34-f82d6a81cf90@perex.cz>
 <87ttxl7cxd.wl-tiwai@suse.de>
 <ZDZmDyOMYMD4Uu5g@ugly>
 <87wn2ho06z.wl-tiwai@suse.de>
 <54c16616-dee7-b50f-d612-82eef906d1df@perex.cz>
 <871qkoxrrl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <871qkoxrrl.wl-tiwai@suse.de>
Message-ID-Hash: ESWTZUB4QT4AUH2KG4FBQ7FAR7DPRCFL
X-Message-ID-Hash: ESWTZUB4QT4AUH2KG4FBQ7FAR7DPRCFL
X-MailFrom: ossi@kde.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ESWTZUB4QT4AUH2KG4FBQ7FAR7DPRCFL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Apr 13, 2023 at 07:42:06AM +0200, Takashi Iwai wrote:
>On Wed, 12 Apr 2023 21:59:28 +0200,
>Jaroslav Kysela wrote:
>> This looks like a sane proposal, but some drivers does not require 
>> the
>> silencing at all, so we can probably skip this step for them (new
>> SNDRV_PCM_INFO_PERFECT_DRAIN flag?).
>
>Sure, we should apply it only conditionally.
>
i don't think the extra complexity is justified. with my improved 
proposal, we're talking about a cost of filling two periods per draining 
op, which aren't exactly super-frequent.

>Also, we may skip the
>workaround for applications accessing directly via mmap as default.
>
no, because one may easily miss that more than one period is required.  
also, i think that forgetting it entirely is an easy mistake to make, 
even if it's harder with mmap than with write.

regards
