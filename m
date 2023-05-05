Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4564C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 15:53:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6B352D4B;
	Fri,  5 May 2023 17:52:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6B352D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683302019;
	bh=MZORVWbSXnY/8vSYg6bIpzxu/HmlhTz97yXYLE1C8yk=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BdGLvPB5WsGxZ9Wp3E2tcjYqd/zBOFKgiInuash6El7L2mG8MTTWo79aVBmtv3GzS
	 NMl0nUNmBKruRhU6cq42RFpeLlQHKK6Smo6U1UO4bzEplNs2FjUEOyd4gT//v6dbWC
	 I0v4kWvgNTMBQ6iILFcq4rz/uFkx6bgjbIf0xCGQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 96B54F8052D;
	Fri,  5 May 2023 17:52:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 092E2F8052D; Fri,  5 May 2023 17:52:19 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22F27F80520
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 17:52:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22F27F80520
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 09A822038E;
	Fri,  5 May 2023 11:52:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1puxj9-hUX-00; Fri, 05 May 2023 17:52:11 +0200
Date: Fri, 5 May 2023 17:52:11 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 2/7] ALSA: pcm: fix playback silence - use the actual
 new_hw_ptr for the threshold mode
Message-ID: <ZFUmK+J76OuuAUmY@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
References: <20230505103140.2285622-1-oswald.buddenhagen@gmx.de>
 <20230505103140.2285622-2-oswald.buddenhagen@gmx.de>
 <877ctmiyzy.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877ctmiyzy.wl-tiwai@suse.de>
Message-ID-Hash: GYGTOAVP6GLY2H47WSYY7MBGJENMZS6W
X-Message-ID-Hash: GYGTOAVP6GLY2H47WSYY7MBGJENMZS6W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GYGTOAVP6GLY2H47WSYY7MBGJENMZS6W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, May 05, 2023 at 05:22:57PM +0200, Takashi Iwai wrote:
>On Fri, 05 May 2023 12:31:35 +0200,
>Oswald Buddenhagen wrote:
>> Suggested-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>> Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
>Here misses your Signed-off-by tag.  Ditto for the patch 3.
>It's a legal requirement, and I can't apply patches without it.
>
i assumed reviewed-by would be a superset, but apparently it's not.
however, there is no need to add SOB to patches which i only reviewed or 
suggested. i'll adjust the patches to which i made substantial 
modifications, though.

regards
