Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC57606A335
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=lmJwS7ve;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rcm2ckr+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wevwQUU4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zbAvDukf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GMkhdXk2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F82660206;
	Mon,  2 Nov 2026 14:51:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F82660206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627514;
	bh=dYhizhFGVUkJcOyZmWTXDlOzL1jaPZKyXm2TEQ3dizY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lmJwS7veI6oU9RSQRuQyM2hU8MvAPXY9TBVICwE50TXr+mUcVz7VzigZkgkhd2DMt
	 6T4dBldYZISL0hKVul2mTSLd+wT6Yzjywvo2V+wqEaiMRN9K8sfD88iBldSHcytwjl
	 szNWw3mCsJlzr+VmX/0LtWgAmeRSPD9Z8BZxHtGY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DAEAF8061F; Mon,  2 Nov 2026 14:51:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F126DF8061C;
	Mon,  2 Nov 2026 14:51:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64A27F80272; Mon,  2 Nov 2026 14:41:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2827AF80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 14:41:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2827AF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=rcm2ckr+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wevwQUU4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=zbAvDukf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=GMkhdXk2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32C25222C2;
	Sat, 31 Oct 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793462594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZHI04ep+aMDqueIcXREJ9i7SmmuioT62o5wFPf6KsQ=;
	b=rcm2ckr+s4E6/4YVSccPkJ4zjpwQx7CG90xfLNgZOmt3lLOqUHCS12bvDSuzZtbUidlYIl
	vRD/Tji61zfFuNFhsI11G6DJaq0Db4l9qCeV+tnD+ubrjZrvVQSFMc6dwk10ClMva1SWgU
	u59Fa/vtPmx4gMs4U2OFvjobtMjdkj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZHI04ep+aMDqueIcXREJ9i7SmmuioT62o5wFPf6KsQ=;
	b=wevwQUU4DfFHIekVy0AmPcnGb7zL0W2erY/enU6xokRGh2VWhCi6oLj5kvRH9RJJ327jiZ
	zhcAkeRsbYJn57CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zbAvDukf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GMkhdXk2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793462593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZHI04ep+aMDqueIcXREJ9i7SmmuioT62o5wFPf6KsQ=;
	b=zbAvDukfCin4QwW41WeBTSYYJM7dROZYLcYQGr4agSeVfK1o4VIg8L/9btrVVXAiIVuqgl
	fU3TRX7WoaWfX2kJKVDKa3rkHHP6kA6bQQ6VWPf217AWSpig5Kdkg6nTRFs+jIk4Zibt+h
	rvoVK+Em2HZzpnQEsTS7MPtqk9zNf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZHI04ep+aMDqueIcXREJ9i7SmmuioT62o5wFPf6KsQ=;
	b=GMkhdXk2Vq8DLnFcamlPbZAK1OT/lmcJVGZi7E+jW/xUI4Y83+AZE6bNmNGEOo/hnwV0xy
	u0zZ4bminm2cobCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE94813432;
	Sat, 31 Oct 2026 16:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HfP0LEAR5mrnLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:03:12 +0000
Date: Sat, 31 Oct 2026 17:03:12 +0100
Message-ID: <87wlqxrh6n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Panpan Ren <renpanpan@kylinos.cn>
Cc: takashi.iwai@suse.de,
	perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix card name for CVT Touch Device
 (1ff7:0f33)
In-Reply-To: <20261027090913.37647-1-renpanpan@kylinos.cn>
References: <20261027090913.37647-1-renpanpan@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kylinos.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 32C25222C2
Message-ID-Hash: BTRPYU72QJEDBDBLO32TOTAHDLSJSHZA
X-Message-ID-Hash: BTRPYU72QJEDBDBLO32TOTAHDLSJSHZA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BTRPYU72QJEDBDBLO32TOTAHDLSJSHZA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 27 Oct 2026 10:09:13 +0100,
Panpan Ren wrote:
> 
> From: renpanpan <renpanpan@kylinos.cn>
> 
> The CVT Touch Device (1ff7:0f33) is a USB composite device (HID + UAC
> audio). Its iProduct string "Touch Device" is generic and does not
> identify the audio function. Windows names the audio function
> "MAXHUB Speaker" from the UAC OUTPUT_TERMINAL iTerminal descriptor.
> 
> Add a quirk entry to override the card shortname to "MAXHUB Speaker"
> with QUIRK_NO_INTERFACE to preserve normal stream and mixer creation.
> 
> Signed-off-by: renpanpan <renpanpan@kylinos.cn>

Applied now.  Thanks.


Takashi
