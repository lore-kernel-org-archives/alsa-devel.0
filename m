Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F73C6FD18
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Apr 2023 12:07:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F142FEC4;
	Sat, 22 Apr 2023 14:06:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F142FEC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682165257;
	bh=yv/uqEucy43eXb2KbXuSl5BY4D7P4ndSvUjN+qytDM8=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RlAfkhxnXDnUYMoRrMPwgpfmvEvavq+v/CF6A2Ca21n2i8xj4wOI+SOXG7cqRuFT3
	 lab0SeRyGSV/2qOYb9g/jdS2OvyCuJkJ+0P4rxIo4Wd+xUeGbDsDdB2sTYUlbD4SuJ
	 NhyMv1TPMfDMI5WLNCZXCZd+TuzU3Gpiz9v9zv04=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 666DBF80155;
	Sat, 22 Apr 2023 14:06:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28E28F80155; Sat, 22 Apr 2023 14:04:51 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 15693F80053
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2023 14:04:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15693F80053
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 5E26723F58;
	Sat, 22 Apr 2023 08:04:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqBym-Pjp-00; Sat, 22 Apr 2023 14:04:36 +0200
Date: Sat, 22 Apr 2023 14:04:36 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: emu10k1: fix error codes
Message-ID: <ZEPNVE1MbRtkakRw@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230421172623.1017222-1-oswald.buddenhagen@gmx.de>
 <87y1mkpdf3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y1mkpdf3.wl-tiwai@suse.de>
Message-ID-Hash: AMHKNZLPZ2DOZPFERAZ5Z2LHVL7EUDJM
X-Message-ID-Hash: AMHKNZLPZ2DOZPFERAZ5Z2LHVL7EUDJM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AMHKNZLPZ2DOZPFERAZ5Z2LHVL7EUDJM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, Apr 22, 2023 at 09:46:24AM +0200, Takashi Iwai wrote:
>On Fri, 21 Apr 2023 19:26:23 +0200, Oswald Buddenhagen wrote:
>> One might argue that this potentially breaks user space, but a) this 
>> is
>> just one driver among many, so it seems unlikely that someone would
>> expect (only) the broken codes and b) it seems unlikely that someone
>> would check these syscalls for particular errors at all, rather than
>> just logging them (this might be debatable for the voice allocator
>> calls).
>
>I find this is too risky for really little win.
>
yes, the gain is relatively low. it merely means applications displaying 
somewhat less confusing error messages.

>The error code is
>returned to user space in quite many cases; e.g. the voice allocator
>is called from PCM hw_params, too, and that's most of user-space
>programs do actually check.  It could be a surprise if it's changed
>without much reason, may trigger unexpected behavior changes.
>
of course. hypothetically.
but these aren't error codes around which specific error recovery would 
exist.
codes that actually _have_ error recovery built around them tend to be 
already correct, because people actually tried using them and noticed 
mistakes in time.

>Of course, if the error code must be corrected, we can fix it.
>But I don't see it in this patch description.
>
i can provide a rationale for each of the changes, even though i think 
that the patch context speaks for itself - the theme is always "return 
an error code whose description better reflects the situation being 
reported".
but none of that would change the fact that it would break code that was 
specifically designed to rely on this driver's bogus behavior. i just 
don't think such code exists, because that wouldn't make any sense.
so i don't know what your criteria for "must be corrected" are.

regards
