Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77338C77B71
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 15:17:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C8ABE92;
	Fri, 21 Apr 2023 17:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C8ABE92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682090246;
	bh=txF4cbJJG4hGcv3iTlTceiTwcNzrxIkkLcnZlLEI86k=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vloRVnbJtrS1FDvdjvbBTuLC8WABKQ7CpNsX6u0jmXA1HMl7lbrJJpvadYXCYSpnS
	 Qok8aZvznMGkDTmo2GAab2fCB9iG8fklr8JU+pKnQe8ebsQg3EzP2BU6kTBUhE/u/k
	 Wu4fR4YBTUNSGvzB0mKSsIVz5OmV+XHGBCQy2/CM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B466F8019B;
	Fri, 21 Apr 2023 17:16:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A0B3F8019B; Fri, 21 Apr 2023 17:16:08 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 90FDFF80053
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 17:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90FDFF80053
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 4F2BF240FD
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 11:16:04 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppsUW-EiN-00
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 17:16:04 +0200
Date: Fri, 21 Apr 2023 17:16:04 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/7] ALSA: emu10k1: drop redundant
 snd_emu10k1_efx_playback_hw_free()
Message-ID: <ZEKotHwG1CjoSDek@ugly>
Mail-Followup-To: alsa-devel@alsa-project.org
References: <20230421141006.1005452-1-oswald.buddenhagen@gmx.de>
 <87r0sdqo5n.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87r0sdqo5n.wl-tiwai@suse.de>
Message-ID-Hash: RKFXIX26GRKHUERG3S7TWRC67RSVVWH5
X-Message-ID-Hash: RKFXIX26GRKHUERG3S7TWRC67RSVVWH5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKFXIX26GRKHUERG3S7TWRC67RSVVWH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Apr 21, 2023 at 04:56:52PM +0200, Takashi Iwai wrote:
>Also, when you submit this size of patch series, please make a cover
>letter and explain what the series are intended.
>
i've actually pondered that and concluded that it would be kinda 
pointless, because the theme "cleanups" is rather obvious.

for the other series it would be "fpga access fixes & cleanups", which 
also seemed obvious enough.

anyway, i'll lower the "threshold of noteworthiness" for the future.

regards
