Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5C9C54E67
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:29:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50A0F2C95;
	Thu, 28 Mar 2024 14:28:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50A0F2C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711632537;
	bh=g3tbt5A5BMQBDg79luNWj/TFKk1HHVRlABZgpMrFlOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iaaLwxrvwPCYI3qPrEWB1ns5OXIrr7MOUWytsXOFYzTgk8CjGbUk4pGnFxRnqQKLV
	 L4/UCCqw0JAb/SVvCW4Fpwuyj83XcrHPpnsTyCyLBp4PaXm9f0XCJ3XFz+DFGBcv3J
	 y74+91zYzxkc7/3Mtxn6ZofVuSbNL9My+ZLr1218=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13542F805AD; Thu, 28 Mar 2024 14:28:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE9CBF805AA;
	Thu, 28 Mar 2024 14:28:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B772F80074; Thu, 28 Mar 2024 14:28:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69D08F80074
	for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2024 14:27:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69D08F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xu+H7T4S;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X3NrlaCY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xu+H7T4S;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X3NrlaCY
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 531B122108;
	Thu, 28 Mar 2024 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1711632472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=xu+H7T4Sioipv/D3TthJI14A0IFPe2Pm+ctqciosloGTkKLIzYjgBzSy97BRVtE5+easc/
	3mdVQdfCk07eCMl2ogy3aH8PSYsCAY1hfpeHoAi9YmfrJIYRzM2ZTF/CSPftFgekVHYU6h
	WzuSoSxZedpd06ayhHS8/2Nyobrv3Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=X3NrlaCYLLAy4mgaqCn56VISB4nW4Kj/f4yxBAzZU62O3fCdmPEmPC8wkkFMk3NQoZ9/Cb
	aN0w/kEmP6L3jNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1711632472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=xu+H7T4Sioipv/D3TthJI14A0IFPe2Pm+ctqciosloGTkKLIzYjgBzSy97BRVtE5+easc/
	3mdVQdfCk07eCMl2ogy3aH8PSYsCAY1hfpeHoAi9YmfrJIYRzM2ZTF/CSPftFgekVHYU6h
	WzuSoSxZedpd06ayhHS8/2Nyobrv3Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=X3NrlaCYLLAy4mgaqCn56VISB4nW4Kj/f4yxBAzZU62O3fCdmPEmPC8wkkFMk3NQoZ9/Cb
	aN0w/kEmP6L3jNBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3988F13AB3;
	Thu, 28 Mar 2024 13:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9qBrDVhwBWbVPgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Thu, 28 Mar 2024 13:27:52 +0000
Date: Thu, 28 Mar 2024 14:27:54 +0100
Message-ID: <87h6gqa3l1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Add ACPI device match tables
In-Reply-To: <20240328121355.18972-1-simont@opensource.cirrus.com>
References: <20240328121355.18972-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.83 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[61.99%];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
Message-ID-Hash: BRDFX2N4ZV6XR7KZ4WYPI6OQZ4SYIRHQ
X-Message-ID-Hash: BRDFX2N4ZV6XR7KZ4WYPI6OQZ4SYIRHQ
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BRDFX2N4ZV6XR7KZ4WYPI6OQZ4SYIRHQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 28 Mar 2024 13:13:55 +0100,
Simon Trimmer wrote:
> 
> Adding the ACPI HIDs to the match table triggers the cs35l56-hda modules
> to be loaded on boot so that Serial Multi Instantiate can add the
> devices to the bus and begin the driver init sequence.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")

Thanks, applied now.


Takashi
