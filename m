Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC3C47258
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:05:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AA34DE5;
	Wed, 31 Jan 2024 14:05:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AA34DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706706326;
	bh=Bhwmz/F21q1kBgFydqSZjzH43cF3Nb4bvQpSB4Ggiro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K7dc72dP99GFNx0shODpb3maG+J1j30igUqbgdkoRXC0onGXUTG6aXZ3mIAPn7w2U
	 bntaEfiSugZ/+iY7AgYllreufnpEei5aDrUgROMN3fcmG0s9rqHKeUTU0/9f7jXCkB
	 ZYbxaa3SQ2QyT1np1yAZj86UTlUvleFHSwdz0GBs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF52AF805A1; Wed, 31 Jan 2024 14:04:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E94A7F8055B;
	Wed, 31 Jan 2024 14:04:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E888F8055C; Wed, 31 Jan 2024 14:04:50 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3674EF8020D
	for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2024 14:04:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3674EF8020D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=STuuWiXg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 10C02CE2084;
	Wed, 31 Jan 2024 13:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858AC433C7;
	Wed, 31 Jan 2024 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706706260;
	bh=Bhwmz/F21q1kBgFydqSZjzH43cF3Nb4bvQpSB4Ggiro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STuuWiXgFm0uKtFdbRCBs+QU3MEpoDCLVg2onooJaU5lUhwSQybtFHgqe0UZL3/Ru
	 qJ5lvtKnK84snuTKY+NqdwmJVQahSkVjeqnKeuNudX0Y5RfPbuZg1AhAMddXEUSi+J
	 khxQlZmkDEQQIULsANidjoL9MBOK0+rDXqdW2+zqh7vwib4NVWmjKEZUjDPLAS+U9e
	 +H6oZb5omK9mRe+gp/llSquQ3+h90Z1N7p+CA2hDmE5qJbb7N69S+zZDwQo/bLbwAx
	 8x5xaRC1b9l71P8ohg4jP3V78uOVtzAvQHxED5/0fRVu2QZVbQgVIt4bvJRiYQk/KZ
	 KX2XBZ+3fcU3Q==
Date: Wed, 31 Jan 2024 18:34:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-ID: <ZbpFTyW9UCZdCs_v@matsya>
References: <2024013025-spoiling-exact-ad20@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
Message-ID-Hash: RGAFL77WWI3DUY7VNYRSW5FOXLWGGP3E
X-Message-ID-Hash: RGAFL77WWI3DUY7VNYRSW5FOXLWGGP3E
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RGAFL77WWI3DUY7VNYRSW5FOXLWGGP3E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 30-01-24, 10:46, Greg Kroah-Hartman wrote:
> Note, this is a redone version of a very old series I wrote back in
> 2022:
> 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> but everyone has forgotten about it now, and I've reworked it, so I'm
> considering it a "new" version, and not v2.
> 
> Here's a series that adds the functionality to the driver core to hide
> entire attribute groups, in a much saner way than we have attempted in
> the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> this patch.  I'll also be taking this into my driver-core branch and
> creating a stable tag for anyone else to pull from to get it into their
> trees, as I think it will want to be in many for this development cycle.
> 
> After the driver core change, there's cleanups to the soundwire core for
> how the attribute groups are created, to remove the "manual" creation of
> them, and allow the driver core to create them correctly, as needed,
> when needed, which makes things much smaller for the soundwire code to
> manage.

The series lgtm, having the core handle these would be good. I will wait
couple of days for people to test this and give a t-b and apply.
I hope it is okay if patch1 goes thru sdw tree?

BR
-- 
~Vinod
