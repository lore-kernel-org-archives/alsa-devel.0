Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F5C77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 09:13:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F1D4E74;
	Fri, 21 Apr 2023 11:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F1D4E74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682068403;
	bh=Qwt1TCpcI1FTF1sSeARR+lskNtBbhAjtBeQpWoeyD/I=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ch19hb7ueDPvGngH7mOeSe6l3bYufmwpKiVH34/Emr1xNVR6ZnqkG1F7r4WjW93D3
	 CnWhS9IBZIBERCZw1XD8aCYnrX4Sii/E+Qk8dxvrMTzQPCfbCQzahwiSFKwdGF9G7u
	 gL92YZPgbGwZnkpZ6OE86cjYMxdZAhJjX/ao7i54=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C7DAF80155;
	Fri, 21 Apr 2023 11:12:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F1BFF80155; Fri, 21 Apr 2023 11:12:02 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 02245F800F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 11:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02245F800F8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id A1222241D0;
	Fri, 21 Apr 2023 05:11:55 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppmo7-w8T-00; Fri, 21 Apr 2023 11:11:55 +0200
Date: Fri, 21 Apr 2023 11:11:55 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] docs: sound: kernel-api: writing-an-alsa-driver.rst:
 add FIXMEs
Message-ID: <ZEJTW13Vm6PK7VIq@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230405201220.2197878-1-oswald.buddenhagen@gmx.de>
 <87sfddv7e4.wl-tiwai@suse.de>
 <ZEE0T+jx5i59oV37@ugly>
 <87wn26u32c.wl-tiwai@suse.de>
 <ZEFB0r20odpxH6pR@ugly>
 <87leimtyqw.wl-tiwai@suse.de>
 <ZEFl5hlFL/VAIVTB@ugly>
 <87leilsjgk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87leilsjgk.wl-tiwai@suse.de>
Message-ID-Hash: ONUDN5SQVUKIGBBDGIZMFOTFIMKXD6AH
X-Message-ID-Hash: ONUDN5SQVUKIGBBDGIZMFOTFIMKXD6AH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ONUDN5SQVUKIGBBDGIZMFOTFIMKXD6AH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Apr 21, 2023 at 10:55:23AM +0200, Takashi Iwai wrote:
>> i suppose we'd have to add SNDRV_CTL_ELEM_ACCESS_{PLAYBACK,CAPTURE}.
>> both could be set for unspecific and actually bidirectional
>> controls. if neither is set, user space would fall back to the keyword
>> based rules (and exceptions ...) - that would be backwards compatible
>> and would enable a gradual migration.
>
>The backward compatibility isn't really easy as you wrote, I'm
>afraid.  If you run an old user-space stuff on the new kernel, you
>must not fill that new information bit but translate it to the string
>suffix instead; and that has to be done inside the kernel
>automagically.
>
right, i didn't mention it, but i imagined the strings to remain the 
same, both for backwards compat, and because they serve a "label" 
function regardless of semantic interpretation. of course that would 
make them partially redundant with the newly added bits, but that 
doesn't seem too bad to me.

anyway, i think i have enough background info now to write a nice 
paragraph for the docu.

thanks!
