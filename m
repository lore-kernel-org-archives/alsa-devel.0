Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E31DEE4996
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Aug 2023 15:09:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABE3274C;
	Tue, 22 Aug 2023 17:08:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABE3274C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692716953;
	bh=QhcdenjTr+dMugMO1zI2OuwG4FXqFH0hQaj4KR8w5Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Q1OCFcRZOGzBfxTU9UB+9bL4MBtrXP7lo96HEO0CqnRVYl4s9t37hkgVRM+GKf9GT
	 NGCSa4SPGdUlQcuuiUYa6GesvzTZoeLcSn/5/I7aeWaW3ey7pFPceDvTm72A+TbJMB
	 DfKAxe4XLSMuNGbgXKo/uXK4De97cg0QUjv+tFQA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B93F3F8025F; Tue, 22 Aug 2023 17:07:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44A26F804DA;
	Tue, 22 Aug 2023 17:07:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14AACF80158; Tue, 22 Aug 2023 17:07:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9BDBAF800D1
	for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2023 17:07:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BDBAF800D1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=uB3RxRup;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UfV4wESY
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED23F1F85D;
	Tue, 22 Aug 2023 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692716866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8uBMMnViOQDnjhHWXY2ri1Yju+o1RCmXoIVHmAXIe8=;
	b=uB3RxRupz6OdtrOuQCl7b59L9sssZ+XX1QdhvVwEa70VNlLUxyI+CVWwmz7yfSugwCQfae
	jmq7rZa+YaNVivD4Gdc1uFd61zZzBwEAlTeSXatxSCWq/UPiSfLBrO0ni/FYs6FQvR4syR
	jgQAVClvyPUChFY59ysE6ttgZjke9II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692716866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8uBMMnViOQDnjhHWXY2ri1Yju+o1RCmXoIVHmAXIe8=;
	b=UfV4wESYhXH9LJzvWx+yG4dbbZjhS6RqYb6EIKSrL005nlLmTtl8FVrb541vvDp4qpJsbT
	txi86KAESkpJfxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B24FA132B9;
	Tue, 22 Aug 2023 15:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0vrtKULP5GTPNQAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 22 Aug 2023 15:07:46 +0000
Date: Tue, 22 Aug 2023 17:07:46 +0200
Message-ID: <87bkezdsjh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	broonie@kernel.org,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com
Subject: Re: [RFC PATCH 01/17] ALSA: pcm: Introduce MSBITS subformat interface
In-Reply-To: <43b25b8b-3e28-bd91-a29a-846a5aa7579e@perex.cz>
References: <20230811164853.1797547-1-cezary.rojewski@intel.com>
	<20230811164853.1797547-2-cezary.rojewski@intel.com>
	<43b25b8b-3e28-bd91-a29a-846a5aa7579e@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: NTAKYUBL255GRX5W7VLSIX6GSTGXNXUB
X-Message-ID-Hash: NTAKYUBL255GRX5W7VLSIX6GSTGXNXUB
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NTAKYUBL255GRX5W7VLSIX6GSTGXNXUB/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 22 Aug 2023 17:03:02 +0200,
Jaroslav Kysela wrote:
> 
> On 11. 08. 23 18:48, Cezary Rojewski wrote:
> 
> > +#define SNDRV_PCM_SUBFMTBIT_MSBITS_32	_SNDRV_PCM_SUBFMTBIT(MSBITS_32)
> 
> What was reason to add 32/32 format ? Subformat STD + msbits == 32
> should already handle the maximal resolution. Until we do not have 64
> bit formats, it seems like an useless extension.

My understanding is to distinguish the cases "we do fully support
32bit" and "we don't care".  But, the end effect is same for both,
user-space would handle 32bit in both cases, so this difference won't
help much, indeed.


thanks,

Takashi
