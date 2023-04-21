Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66781C7618E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 15:10:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD92CE92;
	Fri, 21 Apr 2023 17:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD92CE92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682089813;
	bh=1+mrGMa+NvT0VLOY/dMsdW4MUMIm581Qu/iSDMGIL9s=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IYldapidaafSG1OZNYw+k4VnYQ0ewONDoeHTSXV9MWWAQTi/XDgS2oLHksXGW5gt6
	 Dp+71/P9YDbWEvglOxNJRZsZ0dIlaAoY9fGQxzwEITuMWk42YmYRjgB8sL3YgwCzMU
	 3vBlaQHs6on0/imM2FooLqYX0MkWL48q4tFkUE7Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C871F80155;
	Fri, 21 Apr 2023 17:08:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D11CF80155; Fri, 21 Apr 2023 17:08:55 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B4F7F800D0
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 17:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B4F7F800D0
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 3CF87240FD;
	Fri, 21 Apr 2023 11:08:51 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppsNW-ETe-00; Fri, 21 Apr 2023 17:08:50 +0200
Date: Fri, 21 Apr 2023 17:08:50 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: emu10k1: properly assert DSP init constraints
Message-ID: <ZEKnAqm5sh00Fx0j@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230421141006.1005524-1-oswald.buddenhagen@gmx.de>
 <87o7nhqnrb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87o7nhqnrb.wl-tiwai@suse.de>
Message-ID-Hash: 3SIOCKG4JSLPEJJWGZOK5FHSAMZIDR6C
X-Message-ID-Hash: 3SIOCKG4JSLPEJJWGZOK5FHSAMZIDR6C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3SIOCKG4JSLPEJJWGZOK5FHSAMZIDR6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Apr 21, 2023 at 05:05:28PM +0200, Takashi Iwai wrote:
>On Fri, 21 Apr 2023 16:10:06 +0200,
>Oswald Buddenhagen wrote:
>> 
>> If these are hit, we've already trashed kernel space. There is no
>> recovery from that.
>> 
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
>Sorry, it's a big NO-NO.  BUG_ON() shouldn't be used here at all.
>
>BUG_ON() is used for the case you inevitably must stop everything
>immediately at this point.
>
yes, this is exactly what is intended, and i hoped that the commit 
message makes it clear enough why.

regards
