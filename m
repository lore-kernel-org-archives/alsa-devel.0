Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E70C77B6E
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Apr 2023 08:05:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2642F109C;
	Wed, 12 Apr 2023 10:05:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2642F109C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681286757;
	bh=/RuoXzCsarp5JJ8kUaYv2DsjCHKMXYNWz7rccNmafgs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dF57/G9mb7IXTphmcrWF03L4gSpzjLut+Cd7HB8ZXn8tXqRoWnPFSrRknu+UddKRS
	 GSBX9Xe3sVcA4WOQuQDG+GRR6GpDWLUssi5XimrtWBuw1iPiiz8gSqgLCQO2yEyMKc
	 NuwIThotB5/iaE0Kv3EzVACY4TOB2E7RBwzqpmpA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C21DF8032B;
	Wed, 12 Apr 2023 10:04:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1FAEF8032B; Wed, 12 Apr 2023 10:04:39 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2B1ECF80100
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2023 10:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B1ECF80100
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E09AB202CD
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2023 04:04:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pmVSx-EtM-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2023 10:04:31 +0200
Date: Wed, 12 Apr 2023 10:04:31 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ALSA: pcm: auto-fill buffer with silence when
 draining playback
Message-ID: <ZDZmDyOMYMD4Uu5g@ugly>
Mail-Followup-To: alsa-devel@alsa-project.org
References: <20230405201219.2197789-1-oswald.buddenhagen@gmx.de>
 <20230405201219.2197789-2-oswald.buddenhagen@gmx.de>
 <3d75c103-7e94-e6a1-7f3d-7f957c33cddc@perex.cz>
 <ZDEWyjdVE2IocpGY@ugly>
 <22f551f3-deae-1536-bd07-0b9340940ea4@perex.cz>
 <ZDVnUj2B0EkMiOlA@ugly>
 <6d6c5f3a-81bc-acf4-eb4d-229b581bbe8b@perex.cz>
 <ZDWPy9YbXWWOqaC+@ugly>
 <7b317956-deb1-0a75-0a34-f82d6a81cf90@perex.cz>
 <87ttxl7cxd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ttxl7cxd.wl-tiwai@suse.de>
Message-ID-Hash: VEGEBGJLPIAEG4MI4JKLORSZD6VYL4OX
X-Message-ID-Hash: VEGEBGJLPIAEG4MI4JKLORSZD6VYL4OX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VEGEBGJLPIAEG4MI4JKLORSZD6VYL4OX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Apr 12, 2023 at 09:54:54AM +0200, Takashi Iwai wrote:
>I'm thinking whether we need to change anything in the kernel side for
>this at all.  Can't it be changed rather in alsa-lib side instead?
>
it could, but it would be a lot uglier. user space would have to do a 
"man-in-the-middle attack" on the data, while in the kernel we can just 
slightly modify the consumer. this would be particularly obvious in the 
case of write() access.
