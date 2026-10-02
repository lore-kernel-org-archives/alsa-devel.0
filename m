Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5194CA5FDD
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:50:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5FFB60298;
	Fri,  2 Oct 2026 14:49:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5FFB60298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790945409;
	bh=7rkj/N5W7RxAR11H4P1QL0a/+vajefjuvp1Tn1wlWC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HcA0bltimAsutwFBSfoC+JnV7XccSVa+5fUwBrpGq4ziTIRF3evO4PnjM3vSfbo0c
	 8Dq7ijDSUkcD3+U5jHa/mvvPJruiVzx/myqofn0m23s5j6eml26/fjanBzuu478xQ9
	 jCFo3Vc4+HbPwlhNPfxL40HQNpQUWh2s/Dyg0oaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BCB6F80603; Fri,  2 Oct 2026 14:49:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2F75F80602;
	Fri,  2 Oct 2026 14:49:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9CBAF805BA; Fri,  2 Oct 2026 14:49:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790945363;
	b=OT3TkETcd9IPfMpotMOB1rGPDWAaA1IV6KthRlAV/Q8EPWVLDrpEWCfb3po+m8it5lCa
	 xuCvCm8aTUnnksc47QV6JGg6CvYgDpOP5D8I6kydPl2CfNTHdjQ2rfVjVCbS+rWdIaimD
	 UagJb8Cub3uUcwPqs3/1+Y5SbmWsKtr540lUKe8lkkWqDtyviXTp6wJzs4sRsdyTWSxZN
	 5Sqy4fm2SvAd4tD3XX/EOBHEyXjin9i9NtzANReWBTXPL/2umzLSGN1CFwqbp+dLx2mX1
	 KTAD6uRBdQmgx7g5KcQHzD+LIfKWMUFXnNTYB8Ms+jwBul/4rLJM2j1u8IX1rj5sQlg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790945363;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=7rkj/N5W7RxAR11H4P1QL0a/+vajefjuvp1Tn1wlWC8=;
	b=rDGMpr3L+Erbd5SsV5KNKVGjgmVkus0Q26rql1UtmgM0DClP7MZ6HsH5kytLc0iPOcsU
	 ShheBTY+NVhFignbtWTTWnKE+dJrv0r/xDPaWH6hQIhMUTnBnc+brXlstJA7Zsgn+A83I
	 SqnuLHepNlpFMnFfWpFmVjTpVk6xMaoT58Plh0fIfy8hJEbLiflXY/a4dEsNp2A/RNAI9
	 wrkvi97NEKZO2vqlSj8bnlfw4zqARiH3P1A1ccJC1AQr9ayghEpr5QjkgpGRqZ3r0skjz
	 sISjrJ+PFtnRKN733dAFCpLjSaRgRTeZoDT3IeGSz6FmxFWejGiCAROcIjDabyebxYQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="sD5t/l11";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="72Oi/D0O";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=isrNTkTM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=C20wx8Bo;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EAC2F800B0
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EAC2F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=sD5t/l11;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=72Oi/D0O;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=isrNTkTM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=C20wx8Bo
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38A4421DC4;
	Fri,  2 Oct 2026 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790945357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XQ9gUQ+z15h7NUiFz5FiKJXgezx4EjAHkmJFYvhEQQ=;
	b=sD5t/l11Cu0hK06MNiAQ7UEFwlbXXOu8t9pmL2RL4b7pNq1um+l7ZqW0BkJFmwSpEkK766
	j9UlqPO2nMLBvrPrsqVsYZDc/pPKltHi6xJxWAnYx04AleBo1zLONw+PuAv2RBJgRGnSxc
	F8lXkM5F+l8Qbobm4qfoo7vma5uU200=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XQ9gUQ+z15h7NUiFz5FiKJXgezx4EjAHkmJFYvhEQQ=;
	b=72Oi/D0OJ5DH9YCH+1iOP5VG3ACWcVKvt3aFm1TiHNosKpI2SBNczWef/cUMzPxeRj1PHQ
	w2B4qxH8mzWJocBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=isrNTkTM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C20wx8Bo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790945353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XQ9gUQ+z15h7NUiFz5FiKJXgezx4EjAHkmJFYvhEQQ=;
	b=isrNTkTMT1lr/gcArz3i72PhPPur2JELK4x3osbJvWMPf7DJlKbsMe8YDvC+cyCW04FogD
	R3YexsDXgn9FOXjo7vmjnarpNiP1owBZTewONISxU9U+UAUmMEDjKrIvmhLtyt8dCm8OQa
	kg5IIzmOGcUdd4YPRy/nJNHDCUzO8KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XQ9gUQ+z15h7NUiFz5FiKJXgezx4EjAHkmJFYvhEQQ=;
	b=C20wx8BoAQZFJOeTBg32Tq7lFpNgYz3pK40dqMUFUfxBgQgjwJaepfjoW6x7Cngp0l1Umm
	4EiQGsWfXdQimICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E878A13C73;
	Fri,  2 Oct 2026 12:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tSvnL0iov2qLVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Oct 2026 12:49:12 +0000
Date: Fri, 02 Oct 2026 14:49:12 +0200
Message-ID: <87tsn4z2rb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc5
In-Reply-To: <ac1f5abe5b1f49157574990efcd4eaf2@kernel.org>
References: <ac1f5abe5b1f49157574990efcd4eaf2@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38A4421DC4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: 6XCZ7HAIY3R3SXAVM4WGBHN7HUNFTJZ2
X-Message-ID-Hash: 6XCZ7HAIY3R3SXAVM4WGBHN7HUNFTJZ2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6XCZ7HAIY3R3SXAVM4WGBHN7HUNFTJZ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 02 Oct 2026 14:35:32 +0200,
Mark Brown wrote:
> 
> The following changes since commit 93f51579e7df248780214094418f205253383cc5:
> 
>   Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc5
> 
> for you to fetch changes up to cad16d850e3759dd82cd869f739b56e9844a1fee:
> 
>   spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260 (2026-10-01 16:38:05 +0100)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> A bigger collection of fixes than usual due to your vacation but nothing
> hugely remarkable here, just fairly standard quirks and driver specific
> bugfixes.

This one looks better :)

Pulled now.  Thanks!


Takashi
