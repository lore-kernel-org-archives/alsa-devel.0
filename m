Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE82C77B73
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 13:46:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FF8AEC3;
	Thu, 20 Apr 2023 15:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FF8AEC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681998381;
	bh=mpTgSxoTv2CjJ75t/VX3zk5VbtM0g//APLDb+zLxmds=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e2wwRnij7DeBdSkC9D4TcLIJ+BlE2uWBS039MxAq4pCA2UP80yvNreSpM76mBmCT+
	 JiUNpTHWGivOlsfTEFgx2PNCoeNLVL6SpD5DSs8EjsBltVLymyUi/dLLkFnAkE4DfE
	 EN1/sCXr8hJwmxfL6fBeXCT5CdNC4OJ5fuNXxX34=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A667F80155;
	Thu, 20 Apr 2023 15:45:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21EFEF80155; Thu, 20 Apr 2023 15:45:00 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 423D0F800AC
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 15:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 423D0F800AC
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 087CA24179;
	Thu, 20 Apr 2023 09:44:51 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppUag-iLW-00; Thu, 20 Apr 2023 15:44:50 +0200
Date: Thu, 20 Apr 2023 15:44:50 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] docs: sound: kernel-api: writing-an-alsa-driver.rst:
 add FIXMEs
Message-ID: <ZEFB0r20odpxH6pR@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230405201220.2197878-1-oswald.buddenhagen@gmx.de>
 <87sfddv7e4.wl-tiwai@suse.de>
 <ZEE0T+jx5i59oV37@ugly>
 <87wn26u32c.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wn26u32c.wl-tiwai@suse.de>
Message-ID-Hash: H5T72MNQDKJOIEM6QEHQ35P7TUAZ6UYI
X-Message-ID-Hash: H5T72MNQDKJOIEM6QEHQ35P7TUAZ6UYI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H5T72MNQDKJOIEM6QEHQ35P7TUAZ6UYI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Apr 20, 2023 at 02:54:19PM +0200, Takashi Iwai wrote:
>On Thu, 20 Apr 2023 14:47:11 +0200, Oswald Buddenhagen wrote:
>> On Thu, Apr 06, 2023 at 08:42:27AM +0200, Takashi Iwai wrote:
>> > On Wed, 05 Apr 2023 22:12:20 +0200, Oswald Buddenhagen wrote:
>> >>  The ``name`` is the name identifier string. Since ALSA 0.9.x, the
>> >>  control name is very important, because its role is classified from
>> >>  its name.
>> >> +// This is a questionable design, IMO. Why user-space heuristics when
>> >> +// the driver could set the roles/capabilities? This would avoid
>> >> +// problems like the Tone Control sliders (unlike the switch?!) being
>> >> +// misclassified as applying also to capture.
>> > 
>> > Why this has to be discussed here and now...?
>> > 
>> why not?
>
>Because it is the already defined rule, and you're complaining the
>documentation.  You are free to start a new discussion, but not it
>shouldn't be along with the documentation patch at all.
>
this is a "various questions about the documentation" patch/thread. i 
can't think of a better place to discuss/document design choices.

>> > It's the thing that was *defined* over two decades ago.
>> > 
>> that may be so, but this doesn't explain anything.
>> it's a somewhat surprising choice, and it does in fact sometimes cause
>> problems. so at least it should be thoroughly explained.
>
>Again, you're barking at a wrong place.  The whole control name ruling
>is explained in another document; there is another document covering
>control name rules.
>
there is the control-names.rst document.
if you agree, i'd actually move the entire "Control Names" section into 
it, to avoid redundancy.
but none of that explains the design choice.
two questions require an answer, imo: a) why was is done this way and b) 
do you still consider it the right choice?

regards
