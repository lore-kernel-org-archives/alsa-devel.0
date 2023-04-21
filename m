Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09439C77B71
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 15:27:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA005E8D;
	Fri, 21 Apr 2023 17:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA005E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682090829;
	bh=aimU5IHQ5KVgETZ44bydZuLTCy0kEaEfY00FbWWPmuw=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D/lJR7fKkyr51XmdoW7w+KofZrgs0tQH3JbrtRcsDv/VzC6BY3FZg/Zq10K2INMSB
	 hgR7eDVKS+s/ocAVgYAL5wToja+0NK5kpo8TaLPQCJ42LYd+z31HZMfQtBMEy1LyVU
	 b8b27Wr4CCLJ7qMic4CaljUMQDqz++n8QU9jB3cA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF454F80155;
	Fri, 21 Apr 2023 17:25:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3F51F80155; Fri, 21 Apr 2023 17:25:50 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 127C8F80053
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 17:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 127C8F80053
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 9EADD24256;
	Fri, 21 Apr 2023 11:25:46 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1ppsdu-EpK-00; Fri, 21 Apr 2023 17:25:46 +0200
Date: Fri, 21 Apr 2023 17:25:46 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/7] ALSA: emu10k1: fix snd_emu1010_fpga_read() input
 masking for rev2 cards
Message-ID: <ZEKq+mMLniMViILZ@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230421141006.1005539-1-oswald.buddenhagen@gmx.de>
 <20230421141006.1005539-3-oswald.buddenhagen@gmx.de>
 <87leilqnct.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87leilqnct.wl-tiwai@suse.de>
Message-ID-Hash: Z46XHJ46ATUX6ICRGMMYNGV2Y2EKUHCE
X-Message-ID-Hash: Z46XHJ46ATUX6ICRGMMYNGV2Y2EKUHCE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z46XHJ46ATUX6ICRGMMYNGV2Y2EKUHCE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Apr 21, 2023 at 05:14:10PM +0200, Takashi Iwai wrote:
>On Fri, 21 Apr 2023 16:10:02 +0200,
>Oswald Buddenhagen wrote:
>> 
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
>No changelog is no good news.
>Please give more information.
>
i suppose this is a difference in philosophy. i generally refrain from 
covering in the commit message what comments in the patch already 
explain. otherwise it would be just redundant, and i don't like that 
very much.

anyway, i can add some speculation what problems this could have 
theoretically caused.

regards
