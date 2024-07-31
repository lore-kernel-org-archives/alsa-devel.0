Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A252EC3DA7F
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:15:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 736912D7E;
	Wed, 31 Jul 2024 16:15:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 736912D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722435328;
	bh=ogBT7l0i4QVNkp9oJgjPiFWGf4JLwRpgrdPNtDsOemw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pGK1Vz/hWrodFxyhDWbW045KGVCjBjV2Y1E741A5oCCRc96dFEYB9250o5wuqMCTt
	 QXNpzP1FjaS3fkTKCeOnxBlBveAacUr/F9Af2RqsRp0vJe5a7oxwaBCp9Bq7QgXStk
	 h4zvMJlBeXHzrSqtgiJNI849cEflxXbgQyKKSGLo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E451F805D9; Wed, 31 Jul 2024 16:14:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31A2AF805B1;
	Wed, 31 Jul 2024 16:14:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF56DF802DB; Wed, 31 Jul 2024 16:08:37 +0200 (CEST)
Received: from legeek.net (unknown
 [IPv6:2a01:e0a:d77:fcd0:ba27:ebff:fe50:cb42])
	by alsa1.perex.cz (Postfix) with ESMTP id 1113DF8007E
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 16:08:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1113DF8007E
Date: Wed, 31 Jul 2024 14:06:03 +0000
From: Sylvain BERTRAND <sylvain.bertrand@legeek.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH][LINUX][ALSA][USB AUDIO CLASS 1] wrong channel ids for
 surround
Message-ID: <ZqpEyxz+vgLLDEMI@freedom>
References: <ZqIyJD8lhd8hFhlC@freedom>
 <87h6c5zzch.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6c5zzch.wl-tiwai@suse.de>
X-MailFrom: sylvain.bertrand@legeek.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: K6C25GFR4B47PZUQKGDJGIPQVTRLJM2O
X-Message-ID-Hash: K6C25GFR4B47PZUQKGDJGIPQVTRLJM2O
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:14:16 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6C25GFR4B47PZUQKGDJGIPQVTRLJM2O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 31, 2024 at 11:26:38AM +0200, Takashi Iwai wrote:
> Could you submit a properly formatted patch (with a patch description
> and your Signed-off-by tag) to linux-sound ML
> (linux-sound@vger.kernel.org) instead?

Hi,

I tried to send that patch to the lkml, but some admins removed grey listing
and I use a domestic smtp server (with DNS SPF though), then I was blocked.

(I don't use only noscript/basic (x)html browsers, then "Big Tech" email
services are not available for me)

(I have a github account, and github is still working with noscript/basic
(x)html... as for now... then I did report an issue there)

If you have time and accept to do it, I don't mind you or somebody else doing
that on my behalf. What matters is this being fixed I guess.

best regards,

-- 
Sylvain

