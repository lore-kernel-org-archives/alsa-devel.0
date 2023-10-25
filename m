Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13838C25B48
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 16:22:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C16CDF1;
	Thu, 26 Oct 2023 18:21:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C16CDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698337326;
	bh=elhQOYwu2l+jJ6X0MVOvAna4YshvhckaGeb2HazU7mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NNxAi5P9NUvWo/nrYKmauk5MA6/m0oka+hHmJkfwze/ZE1yS/qSfamXkadog72grM
	 o8MZY4tvDp5FK0g9fsfImKNa+2jup0VmbcvXG4GtlJdnpSDAq4X9/dtoJVgwYi4hNy
	 04ZNYt7KKO0iDVT75UnAkiBKcEbFxhyQGVhM0sG0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B992F805B5; Thu, 26 Oct 2023 18:20:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CAACF805B1;
	Thu, 26 Oct 2023 18:20:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 644DBF80165; Wed, 25 Oct 2023 15:49:54 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE670F8012B
	for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2023 15:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE670F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=UqbG0+mv
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id E4EFAB82F42;
	Wed, 25 Oct 2023 13:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C40DC433C7;
	Wed, 25 Oct 2023 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698241789;
	bh=elhQOYwu2l+jJ6X0MVOvAna4YshvhckaGeb2HazU7mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqbG0+mvXmGygYchXB5n7zM++Q31Hox8T/aWYLq0+iQIrJAz6I/ByqnbO0eRYhlxy
	 WSxgkklYyqio37TvBkzZdO46iKOU4tvT6EEBpqfEOugeY3qMc/HONV4+no71XZefuE
	 tZTI+h66kPETq6jUAK20JO2Acawq75tRZ4v09JWY=
Date: Wed, 25 Oct 2023 09:49:48 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>,
	ALSA development <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ALSA: change mailing list to linux-sound on
 vger
Message-ID: <20231025-unique-dingo-of-proficiency-fa998c@meerkat>
References: <20231020071247.973909-1-perex@perex.cz>
 <87wmvdwkxm.wl-tiwai@suse.de>
 <87wmvax1is.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmvax1is.wl-tiwai@suse.de>
X-MailFrom: konstantin@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 52BNXFN4MUU4D4XUWJEMGVA2CIX3MPP4
X-Message-ID-Hash: 52BNXFN4MUU4D4XUWJEMGVA2CIX3MPP4
X-Mailman-Approved-At: Thu, 26 Oct 2023 16:20:26 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Oct 25, 2023 at 03:41:31PM +0200, Takashi Iwai wrote:
> ... and I tested posting patches to linux-sound ML:
>   https://lore.kernel.org/linux-sound/20231025132314.5878-1-tiwai@suse.de
> 
> I thought those are forwarded to alsa-devel, but apparently they
> aren't.

In case there was confusion, I meant that the patches sent to that list will
be automatically fed to the alsa-devel patchwork, which they were:

https://patchwork.kernel.org/project/alsa-devel/list/?series=796434

> So we all devs need to subscribe this ML now?

Until we can do search-based pseudo-lists in the near future, that is indeed
what I would recommend. There is almost no other traffic on that list, so this
will not impact your inboxes in any meaningful way.

-K
