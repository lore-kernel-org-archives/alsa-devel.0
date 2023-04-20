Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0BFC77B73
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 16:20:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E101EC2;
	Thu, 20 Apr 2023 18:19:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E101EC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682007616;
	bh=+33sxRNf4J0WLdUfWsmmlczxxHuJRrgz+9n9g71/Kew=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dQKNxY9ntiUltbXsxoO7nS07G/gMzajnQZ1MteTqdmCWyXKg5hxK13vUPtXm41gFH
	 QXQfe0haQTKxAtXfZztQcSJHq1qWSj/k9Megwy5itSVGFr5dCukBt9Px1wDnVEzHsG
	 MtvzneuxDsZXtaWvl1iUz7Zt7JfUq2+YKv4shf0Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E72BF80149;
	Thu, 20 Apr 2023 18:19:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E010F80155; Thu, 20 Apr 2023 18:18:56 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9222CF80053
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 18:18:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9222CF80053
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 329DF24116;
	Thu, 20 Apr 2023 12:18:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppWze-lZD-00; Thu, 20 Apr 2023 18:18:46 +0200
Date: Thu, 20 Apr 2023 18:18:46 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] docs: sound: kernel-api: writing-an-alsa-driver.rst:
 add FIXMEs
Message-ID: <ZEFl5hlFL/VAIVTB@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230405201220.2197878-1-oswald.buddenhagen@gmx.de>
 <87sfddv7e4.wl-tiwai@suse.de>
 <ZEE0T+jx5i59oV37@ugly>
 <87wn26u32c.wl-tiwai@suse.de>
 <ZEFB0r20odpxH6pR@ugly>
 <87leimtyqw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87leimtyqw.wl-tiwai@suse.de>
Message-ID-Hash: CM37W324SBKOW3FUAR264UXEED5HO6GZ
X-Message-ID-Hash: CM37W324SBKOW3FUAR264UXEED5HO6GZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CM37W324SBKOW3FUAR264UXEED5HO6GZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Apr 20, 2023 at 04:27:35PM +0200, Takashi Iwai wrote:
>But why this has to be buried in the middle of a patch containing lots
>of other changes...?  Better to split out and start a new thread.
>
this "patch" doesn't contain any changes, only a bunch of questions.  
given the expected audience, i don't think that "burying" it was 
detrimental.

>IIRC, this was a result after struggles with the structured control
>implementations.  It became too complex, and the plain array with
>string representation can cover all complexity, while it still allows
>the grouping in user-space side.
>
i can see how a keyword based interface description is appealing - it 
keeps the kernel interface slim and flexible. but of course that comes 
at a steep cost in user space - i for one got completely lost and was 
unable to debug the bug described in the OP.
maybe a middle way would have been the best option?

>Again, the choice was done in a quarter century ago, and if you change
>it, you'll certainly break the whole things badly.  We must keep the
>compatibility.
>
i don't intend to actually change it. but suppose we did.

i suppose we'd have to add SNDRV_CTL_ELEM_ACCESS_{PLAYBACK,CAPTURE}.  
both could be set for unspecific and actually bidirectional controls. if 
neither is set, user space would fall back to the keyword based rules 
(and exceptions ...) - that would be backwards compatible and would 
enable a gradual migration.

regards
