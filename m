Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26B2C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:35:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE5636026B;
	Thu, 20 Aug 2026 15:35:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE5636026B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787232948;
	bh=uW02AMtwc3SLb4gtwcGjHVonRpndro+M5G0OMZp2DTY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AITlaxe6LdMQO+jcrVbF4C7CZH9h8qzIQkAQC1VEP+7UN4TizCULvJ+oFXER+aO10
	 AXZBdSO9Ihht9m/pT4RFRB4iDg8o9HiHEfJJmDrCQGL2IVQGkYrfBqODGKNVhGTQNl
	 XnXcMud7kfhykZQk2u+6bBssZ/jwEo3i/Hy420xw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81BBDF805F0; Thu, 20 Aug 2026 15:35:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4470FF805FF;
	Thu, 20 Aug 2026 15:35:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BAEFAF8053D; Thu, 20 Aug 2026 15:35:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787232905;
	b=mF5v6Yvr4PqkS1veXwWOShgl5YLCdh9sxSyJEP69LP6V5bxPJa5veKfXhYycXfbLnvYc
	 iDgtkXeXmq6P98tumhuzy5zv0+poHLR9ao+NsHdtVZofO1RBdftV0dgX0SOKwb7tShuaB
	 T/QWrIPLs9xk4sqlKpAdtZM6iJ+fLxrofJ5hZmaWfsfBuiz7MD0Rt/xmc/7GoK1k9sZM/
	 urX1c4aIIT7LizdCX3KsbqigD3kNekNh0vGYTYgOjBkcpuvpC5fd8ikRLNjRHjMzx2HGt
	 Z4U7XEZstpgz9CNlETCJX2mLQrTAzSY5JKoK3W4yhs8lYcgO6IcXOFkFC8zTWn29cwg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787232905;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=uW02AMtwc3SLb4gtwcGjHVonRpndro+M5G0OMZp2DTY=;
	b=j2cRrj6/1gu84lNzsPMms7NflSu/xx6yxV8TmG2tR/SbBiQTI38WpyPXbye9Xb8O0D2K
	 PZD5KLPTBCmwl8NCKW9MRohmug5aHLLQPbzChx5uel3/wEspfN/YkkoDFnW1asJNZqduY
	 qcWp8vJuSx5pcL/FybSbB0wLaTzBzIgDtQVCTcdTXSgBVlEw6AoJzRn8auQGqIyXkMoKN
	 9huPzQYbvp4SElJ18w6VWUsb0hAxBGK5x2l1DNhpqiXAADsuLX6jZTzZtX85v2BwhOZSW
	 iVyn6BG28RIGX4DkjJCmi8D9zJKtzfYnrtFD1CN6yPkW4QwW3olxz4fp+OYfsl0LEXg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lf1GHGRo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vs5eZ787;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=D5V4xhrm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=BzCuGK79;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D894F80153
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 15:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D894F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lf1GHGRo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vs5eZ787;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=D5V4xhrm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=BzCuGK79
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E4053EFA;
	Thu, 20 Aug 2026 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787232899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=btRg2++bWGReS9+ODbff9nmgGTZ9x9SGBBhhwvN/hKE=;
	b=lf1GHGRo2wljvK90vG4i7Me0dlh4RmdF4gZIol8g0AJt8jXG1Istkk+x5l4bxR/snPbU5k
	0p0n8XEZcpLcNceXHXIG6BpKtLlQTeiDHoogYRAnltuPYbz6gNDdYPeTgMTr7wnLIp0FV/
	C3u55ffT7CebBBkudzqGnnC54AwrhCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787232899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=btRg2++bWGReS9+ODbff9nmgGTZ9x9SGBBhhwvN/hKE=;
	b=vs5eZ7873bys3X0YBcUhfhPraJj3Pq+aS7E1YkMDZAEoZ0H6B1zdqcCmTZse/2Q1N4aTSM
	ULWcyKbhyq9ESMAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D5V4xhrm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BzCuGK79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787232895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=btRg2++bWGReS9+ODbff9nmgGTZ9x9SGBBhhwvN/hKE=;
	b=D5V4xhrm7Am1IDDjM/muf0RI+B31VyKcTDroD1YzTUB/Gwkew5WzvpoEdcNXPiMDrWH+KT
	ucwRDF5/uqMnFeG6dmhB8mN4Up3YEWsOBBkXe+9z+C9xt4cyKaftY9ncdcbNnCrS9stMZE
	/b1DkABjoBPgaXuP7iVHWa/4G5G2bdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787232895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=btRg2++bWGReS9+ODbff9nmgGTZ9x9SGBBhhwvN/hKE=;
	b=BzCuGK79A6AYpgWhmXQGJF6mRmybz1YsQr2un4Jkfj4n1ijVmvzJaTV0JVN1j3f45J+0OL
	+ywGzv5/QdGZfuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5F627A8;
	Thu, 20 Aug 2026 13:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4quaGH8Ch2oIOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Aug 2026 13:34:55 +0000
Date: Thu, 20 Aug 2026 15:34:55 +0200
Message-ID: <871pbsnce8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: Linux-audio BoF at Linux Plumbers Conference?
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8E4053EFA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: RBHAFTX2HBJ5VO57EQQLJECE3RNFFPHN
X-Message-ID-Hash: RBHAFTX2HBJ5VO57EQQLJECE3RNFFPHN
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RBHAFTX2HBJ5VO57EQQLJECE3RNFFPHN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

a few people including Mark and me have talked about holding a small
meeting for the Linux audio stuff (finally again!) during the next
Linux Plumbers Conference (on Oct 5-7 at Prague).

Has anyone already planned to attend there and is interested to join?
If we have enough people, we can try an official BoF session.
Otherwise, we can just have an unofficial session at lunch time or
such, too.  Just let us know.


Thanks!

Takashi
