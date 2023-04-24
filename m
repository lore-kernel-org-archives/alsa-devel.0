Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F04C7618E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Apr 2023 13:53:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BF37F3A;
	Mon, 24 Apr 2023 15:52:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BF37F3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682344379;
	bh=qze/yqugFdhWssMOZ8UwYDIveoJeBz/Sr2bg2NnNeiI=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uBLyyX7ty3OkP7AXt0jx9w4aRN8U4lCG6Rl5Ytmxu0pUOVw1hAX7A6AgbE/DxEfUL
	 Kb+wR+s6z/k2HmrPyZd26ARR/rJfAYUdNmAV0oyMHASeCCQj//btgYOWlp2omx+JUd
	 nuBTItjkmGdSC7cFsZL+bfRCVFU2c8kFVwlMNfEA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C3A7F800AC;
	Mon, 24 Apr 2023 15:51:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2539F8018A; Mon, 24 Apr 2023 15:51:40 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 635C2F800AC
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2023 15:51:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 635C2F800AC
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 956CE23FA3;
	Mon, 24 Apr 2023 09:51:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pqwbO-YUq-00; Mon, 24 Apr 2023 15:51:34 +0200
Date: Mon, 24 Apr 2023 15:51:34 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 7/7] ALSA: emu10k1: use more existing defines instead of
 open-coded numbers
Message-ID: <ZEaJZgCA8tjxK38O@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230422161021.1143903-1-oswald.buddenhagen@gmx.de>
 <20230422161021.1143903-8-oswald.buddenhagen@gmx.de>
 <877cu3oy88.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877cu3oy88.wl-tiwai@suse.de>
Message-ID-Hash: NW3OSNSVCCXRUSZXFSEGNZZFLQ5KD75A
X-Message-ID-Hash: NW3OSNSVCCXRUSZXFSEGNZZFLQ5KD75A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NW3OSNSVCCXRUSZXFSEGNZZFLQ5KD75A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Apr 23, 2023 at 09:26:47AM +0200, Takashi Iwai wrote:
>This patch actually broke the build due to A_I2S_CAPTURE_RATE, as
>0-day bot caught.  Any missing patch?
>
turns out it has a dependency on the "use high-level I/O functions also 
during init" patch. you applied that one meanwhile, so it's now safe to 
apply this one as well.
(i did a lot of re-ordering within the series and didn't re-test every 
commit separately each time, so it slipped through. :})

regards
