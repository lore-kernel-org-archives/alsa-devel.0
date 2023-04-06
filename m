Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF85C76196
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Apr 2023 12:36:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93987BC0;
	Thu,  6 Apr 2023 14:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93987BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680784558;
	bh=CI6kMUP4hkdr5iSxlk7AUGGQKqNGTYwhCdHhj0Kr6tI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gjZvpoSVI2Rhew1S7KSE0bA5eIf+0dUzSHujI7Pmjiq+gpjEqzBAh+y8VVj6gVLep
	 hu955zUQstQytP6k9W7c2RgADOSHFlOdKS5MlI1ekk2vdZK6S/H34tnQs6EWptbFkd
	 t7DS12+baK5RIz56430cl8uATHiUd3yp7Qtzapqw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C0B4F80246;
	Thu,  6 Apr 2023 14:34:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE5D7F80246; Thu,  6 Apr 2023 14:34:42 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4AC98F8013D
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2023 14:34:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AC98F8013D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B32D924196
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2023 08:34:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pkOp2-R5Z-00
	for <alsa-devel@alsa-project.org>; Thu, 06 Apr 2023 14:34:36 +0200
Date: Thu, 6 Apr 2023 14:34:36 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ALSA: document that struct __snd_pcm_mmap_control64
 is messed up
Message-ID: <ZC68XIBgypE9x/qA@ugly>
Mail-Followup-To: alsa-devel@alsa-project.org
References: <87h6ttv4br.wl-tiwai@suse.de>
 <20230406111545.2240797-1-oswald.buddenhagen@gmx.de>
 <87ttxttcqv.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ttxttcqv.wl-tiwai@suse.de>
Message-ID-Hash: GPWDECIRVASWQ3YRW6DWGAYQZB5AOHRC
X-Message-ID-Hash: GPWDECIRVASWQ3YRW6DWGAYQZB5AOHRC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GPWDECIRVASWQ3YRW6DWGAYQZB5AOHRC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Apr 06, 2023 at 02:29:44PM +0200, Takashi Iwai wrote:
>Care to resubmit v2 patch?
>
that *was* a v2 patch - you can git-am the mail with --scissors (at 
least if i got it right). not acceptable?
