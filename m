Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85251C4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Oct 2023 07:33:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67398A4A;
	Sun, 29 Oct 2023 08:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67398A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698564798;
	bh=pZmRcSyWIwdWH5XbPdgPiDBtvggS9p2WDme0Pw91+JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TXikkKFyDwI7VV1nHZoMddv4UuztxaLAqDdzLgBrBhQE7FKO1ysGphZduqrhBcrkz
	 PDuhJgA3a51A2NXSZzK0gPRAg74INGOBKyVzqE9Oe2PbCAv9qhLFZ8aIQodVeE6dWs
	 o2ElcLHUnZ/nNYBKrvRUpKyiU94HHqaJtfEoz6+c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 503CBF80537; Sun, 29 Oct 2023 08:32:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 444FBF8020D;
	Sun, 29 Oct 2023 08:31:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BED1F8020D; Sun, 29 Oct 2023 08:30:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4553F80152
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2023 08:29:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4553F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=CV0QAuEf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QIuZCeD1
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A48AE21DF6;
	Sun, 29 Oct 2023 07:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1698564583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlPQOZMqX1kXG1v1K9DZaGEbhFjfcwnCk7POMQ9PC8=;
	b=CV0QAuEf1j2xiugfpMnI4aDWwJzBj8FY0Og0pG3ijpJecIOU5LyRwoXcQK4qN8SsF30uUu
	kbdV12kSHBne8RUn3SbMCgHvBQlanU5ENfBQ6ouumFrYxegPB1E5kLRVf6/2bJRoM5avfG
	YNKfID3VgT4RmY5yuUdt5w35U+bf3Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698564583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlPQOZMqX1kXG1v1K9DZaGEbhFjfcwnCk7POMQ9PC8=;
	b=QIuZCeD1McEssTywnSEnnr6ZFiWsBwM8T/ZXjJ/x9tIV+o1m6SGqCMuFXM08OMSHOhsPG6
	bFbb0XjOSsv1VIAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D9161391D;
	Sun, 29 Oct 2023 07:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BnA1EecJPmVdYgAAMHmgww
	(envelope-from <tiwai@suse.de>); Sun, 29 Oct 2023 07:29:43 +0000
Date: Sun, 29 Oct 2023 08:29:42 +0100
Message-ID: <87il6px4wp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: mark cs35l41_verify_id() static
In-Reply-To: <20231027152515.482411-1-arnd@kernel.org>
References: <20231027152515.482411-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
Message-ID-Hash: XMQ3V3E24SODZ2EZGLSRMIR6DADPAXOI
X-Message-ID-Hash: XMQ3V3E24SODZ2EZGLSRMIR6DADPAXOI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XMQ3V3E24SODZ2EZGLSRMIR6DADPAXOI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 27 Oct 2023 17:25:09 +0200,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly introduced function is global but only called in this one
> file and has no extern prototype, so it should probably be static:
> 
> sound/pci/hda/cs35l41_hda.c:733:5: error: no previous prototype for 'cs35l41_verify_id' [-Werror=missing-prototypes]
>   733 | int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned int *reg_revid)
> 
> Fixes: 881b7bce0c25 ("ALSA: hda: cs35l41: Run boot process during resume callbacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied now.


Takashi
