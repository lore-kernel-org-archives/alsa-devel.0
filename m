Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F722C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:34:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4EC86024A;
	Wed,  5 Aug 2026 15:33:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4EC86024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785936845;
	bh=5qwwTPLAjifjucq09daVXZoN5WEB7gNKHa2R9gMjFMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Cx/3FKboUwrXsxg5QK5CEJlLYMdE+ONqDls4tTg7Afvfl02rKRSctt06wS6yICHvP
	 lhLjdLorey9RqkrAGCbyptEqHn9swBbN+V9jnWZZizp2KJ+qTuKpBKyA6LjAdBXDZI
	 8MCk7+iVRzc+M5i1ihRXc8McvNIqg13hvhD3yRHE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99745F805F8; Wed,  5 Aug 2026 15:33:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70DAFF805FE;
	Wed,  5 Aug 2026 15:33:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8875F8027B; Wed,  5 Aug 2026 15:33:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785936801;
	b=iIvzsmKFfPQrAbpb4LVZA+Lbq4znOGrqUM8iqig7YnvvE1MEy2xl8ebBTk5XWCwM2jI5
	 L52oCW9M5AIAysFQrhnG70ygGPFv+v18ngEQyJdnX0uJa8mwr9FHjy/8C6bEmLij1uiio
	 1XkFh0K7LpRlsljNmpQh1J9Blh31LUyIkuTUR3KodJt1T8iptg3VyQ/p+BXVN7tWOA7Hy
	 6pzDjCGYvENLJsvmGyllo/u85Wz3A0Vit8GahXukProxv2/t8xqosmt2/rTvhCiCBNI+z
	 nzb7f+tBCvRHm4UYC1iIIYca3Sval/Rybg6r3UmqVGKu49up0duyG6IhYmKy6O2KSMw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785936801;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=5qwwTPLAjifjucq09daVXZoN5WEB7gNKHa2R9gMjFMc=;
	b=ryAFKFeCMpRJXjPdDrX+Rv9UodbcPZuMtb8ERpiQZIV+JbY3vv4IR3REcQQemdZRxoZP
	 F2/vkDGQ15sKq7ZnRx+Dkmu/PbTVDPs1QeCkAm+O0N9EKgIwwfehC27UYsZe3gZFCZYmp
	 1HUuD3hi2U/EPoki/Be3DpKKD7mENOuvfSqgy2vVtFIRPwuNycnAZTTAEipvg3giajgPT
	 iFVj/Mf+mLBwZaqyTSx89QQ/WH3zdfO6VBcxiyqCTBDpRjfkS/MDY7HjxR6gpcYknEUx2
	 4KHFJxDIdfCo1obG+nvF7Ncgw39BkgmLnifkRgGBNDsuPEZ1YboqD89g/fRwwl9ytew==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="dfRwHl/z";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dozMO8tb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=jLEeuNJO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SnrQG1cZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AA0BF80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 15:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AA0BF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dfRwHl/z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dozMO8tb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jLEeuNJO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SnrQG1cZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E5FD3DF3;
	Wed,  5 Aug 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785936795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE+q35ApNjZKO4rqBMkHgJw8FcFNWwsiENwfNPKpXik=;
	b=dfRwHl/zvBze8z7P2MjRJ4Gdnl3xqfdY1vlAPwXjoF6gvwQcPiliUNDgH7Lm3bI5bvHVVx
	1PqCkBdgIXjSnRLui93xhZzXyCGRg/ZsHAfkHXfD/91Oyy2rJsW5gHUpZ/CFw/6Xf/Ni6y
	mvs3G4SZTJhgPqqtK7C5F6Ldf9HAVxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785936795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE+q35ApNjZKO4rqBMkHgJw8FcFNWwsiENwfNPKpXik=;
	b=dozMO8tbjjqNhlvs0nJMpzteLTF0AnBFYgGygi0DebWlkJP6RPZxXwBQT2FDYLw3minMlS
	U58paLlTYboduWDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jLEeuNJO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SnrQG1cZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785936791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE+q35ApNjZKO4rqBMkHgJw8FcFNWwsiENwfNPKpXik=;
	b=jLEeuNJOlLY1VJQqCoVg63NofmaOm6osWa8/hskz+x5gdMuThQL46pO8do3dNiDkDUll/U
	NUVHZ5EPr7hEplIK7pOSENV4Tnol8is2QjaUpvAUIV1kgZqFMJEPO/wDhHtzI1zDmQcmpr
	tegj2F/5R0e1hKS07LTj0Rky30EtdP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785936791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE+q35ApNjZKO4rqBMkHgJw8FcFNWwsiENwfNPKpXik=;
	b=SnrQG1cZjvu28SbvgLwnEObBzOiy+Ke5vUoqjEORfXud3jKpnd+Se7Nansz3fUQkCIP0lX
	1VyI/w4knx9MebCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B153779C2;
	Wed,  5 Aug 2026 13:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/gYCZc7c2rENAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 13:33:11 +0000
Date: Wed, 05 Aug 2026 15:33:10 +0200
Message-ID: <87o6fgg0a1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?1cW9qA==?= <soldierjazz2013@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org
Subject: Re: [BUG REPORT] sound/usb: Fix Use-After-Free in snd-usb-audio
 error_timer during device disconnect
In-Reply-To: 
 <CAEoG+NTPOoKfbJMvcnfsM2f-3GUrpcw5_LSnpXvAPWUZZJg7mA@mail.gmail.com>
References: 
 <CAEoG+NRpPip1Eymi1ZSgG7FdYH2UkRneat2GJRWXL_M38xfD9w@mail.gmail.com>
	<8733wshq3t.wl-tiwai@suse.de>
	<CAEoG+NTPOoKfbJMvcnfsM2f-3GUrpcw5_LSnpXvAPWUZZJg7mA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E5FD3DF3
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: 6SEXPKG4OYJWGHYYOTRE4PCDD6QMTGXM
X-Message-ID-Hash: 6SEXPKG4OYJWGHYYOTRE4PCDD6QMTGXM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6SEXPKG4OYJWGHYYOTRE4PCDD6QMTGXM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 05 Aug 2026 11:36:19 +0200,
张建 wrote:
> 
> Hi Takashi,
> 
> We can only test the Linux driver on other processors (non-Qualcomm
> processors), and no problems occur under these conditions. Therefore, we
> suspect it's related to the callback value sent to the URB when a USB device
> is disconnected on a Qualcomm CPU.

Basically the upstream focuses only on the upstream code base, so the
bug reproducibility with the latest upstream kernel is mandatory.
Since there have been already many fixes for similar issues, it's hard
to tell without testing with the latest code.

Let us know if you can trigger the issue with the upstream kernel,
then we can take a deeper look at it.


thanks,

Takashi

> 
> Thanks!
> 
> Takashi Iwai <tiwai@suse.de> 于2026年8月5日周三 17:30写道：
> 
>     On Wed, 05 Aug 2026 11:19:54 +0200,
>     张建 wrote:
>     >
>     >
>     > Hi Takashi and Linux USB/ALSA maintainers,
>     >
>     > We identified a reproducible Use-After-Free (UAF) kernel panic in sound/
>     usb/
>     > midi.c during USB MIDI device hot-unplug under active URB transfers.
>     >
>     > The issue was reproduced on Qualcomm platforms (Snapdragon 8 Gen 3 Linux
>     > 6.1.145 / Android 14, Snapdragon 8 Elite Linux 6.6.77 / Android16 etc.).
>     The
>     > crash consistently hits __run_timers (timer softirq) dereferencing
>     poison
>     > pointer.
>     >
>     > Crash Trace
>     >
>     > [  169.493907] I[ 1: surfaceflinger: 1794] Internal error: Oops - CFI:
>     00000000f2008234 [#1] PREEMPT SMP
>     > [  169.493941] I[ 1: surfaceflinger: 1794] sec,qc-rst_exinfo
>     soc:samsung,qcom-rst_exinfo: fault handler : unknown
>     > [  169.495442] I[ 1: surfaceflinger: 1794] CPU: 1 PID: 1794 Comm:
>     surfaceflinger Tainted: G S      WC O      
>     6.1.145-android14-11-3254743-abS9280ZCS6DZF2 #1
>     > [  169.495447] I[ 1: surfaceflinger: 1794] Hardware name: Samsung E3Q
>     PROJECT (board-id,09) (DT)
>     > [  169.495455] I[ 1: surfaceflinger: 1794] pstate: 02400005 (nzcv daif
>     +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
>     > [  169.495464] I[ 1: surfaceflinger: 1794] pc : call_timer_fn+0x44/0x26c
>     > [  169.495471] I[ 1: surfaceflinger: 1794] lr : __run_timers+0x1b8/0x30c
>     > [  169.495475] I[ 1: surfaceflinger: 1794] sp : ffffffc00800be40
>     > [  169.495480] I[ 1: surfaceflinger: 1794] x29: ffffffc00800be40 x28:
>     dead000000000122 x27: 0000000000000000
>     > [  169.495490] I[ 1: surfaceflinger: 1794] x26: ffffffc00800be90 x25:
>     0000000000000001 x24: ffffff8a713312b0
>     > [  169.495501] I[ 1: surfaceflinger: 1794] x23: ffffffc00a427000 x22:
>     ffffff8868a70000 x21: ffffff804c485c40
>     > [  169.495511] I[ 1: surfaceflinger: 1794] x20: ffffff804c485c58 x19:
>     0000000000000100 x18: 0000000000000000
>     > [  169.495522] I[ 1: surfaceflinger: 1794] x17: 0000000091b4a83a x16:
>     0000000000000000 x15: 0000000000000000
>     > [  169.495532] I[ 1: surfaceflinger: 1794] x14: ffffff804c485c40 x13:
>     000000000000000d x12: 0000000000000028
>     > [  169.495542] I[ 1: surfaceflinger: 1794] x11: ffffffc00800be98 x10:
>     ffffff8a71331240 x9 : 0000000100000100
>     > [  169.495553] I[ 1: surfaceflinger: 1794] x8 : 0000000100000100 x7 :
>     0000002776497736 x6 : 0000002776497736
>     > [  169.495563] I[ 1: surfaceflinger: 1794] x5 : 0000002776497736 x4 :
>     0000000000000001 x3 : 00000000000009c4
>     > [  169.495573] I[ 1: surfaceflinger: 1794] x2 : 00000000ffff808d x1 :
>     ffffff804c485c58 x0 : ffffff804c485c40
>     > [  169.495584] I[ 1: surfaceflinger: 1794] Call trace:
>     > [  169.495591] I[ 1: surfaceflinger: 1794]  call_timer_fn+0x44/0x26c
>     > [  169.495598] I[ 1: surfaceflinger: 1794]  __run_timers+0x1b8/0x30c
>     > [  169.495605] I[ 1: surfaceflinger: 1794]  run_timer_softirq+0x24/0x4c
>     > [  169.495614] I[ 1: surfaceflinger: 1794]  handle_softirqs+0x120/0x3e0
>     > [  169.495621] I[ 1: surfaceflinger: 1794]  __do_softirq+0x14/0x20
>     > [  169.495628] I[ 1: surfaceflinger: 1794]  ____do_softirq+0x10/0x20
>     > [  169.495635] I[ 1: surfaceflinger: 1794]  call_on_irq_stack+0x3c/0x74
>     > [  169.495641] I[ 1: surfaceflinger: 1794]  do_softirq_own_stack+0x1c/
>     0x2c
>     > [  169.495648] I[ 1: surfaceflinger: 1794]  __irq_exit_rcu+0x54/0xb4
>     > [  169.495655] I[ 1: surfaceflinger: 1794]  irq_exit_rcu+0x10/0x1c
>     > [  169.495665] I[ 1: surfaceflinger: 1794]  el0_interrupt+0x54/0x174
>     > [  169.495671] I[ 1: surfaceflinger: 1794] 
>     __el0_irq_handler_common+0x18/0x28
>     > [  169.495677] I[ 1: surfaceflinger: 1794]  el0t_64_irq_handler+0x10/
>     0x1c
>     > [  169.495683] I[ 1: surfaceflinger: 1794]  el0t_64_irq+0x1a4/0x1a8
>     > [  169.495690] I[ 1: surfaceflinger: 1794] Code: 72950751 72b23691
>     6b11021f 54000040 (d4304680)
>     > [  169.495696] I[ 1: surfaceflinger: 1794] ---[ end trace
>     0000000000000000 ]---
>     >
>     > Root Cause & Race Condition
>     >
>     > There is a sequence defect in snd_usbmidi_disconnect() combined with the
>     URB
>     > completion handler:
>     >
>     >  1. In snd_usbmidi_disconnect(), del_timer_sync(&umidi->error_timer) is
>     >     invoked BEFORE killing in-flight IN URBs via usb_kill_urb().
>     >   
>     >  2. Prior to usb_kill_urb() finishing, an in-flight IN URB completes
>     with an
>     >     unconventional error status (e.g., -EPIPE) when USB disconnect.
>     >   
>     >  3. snd_usbmidi_in_urb_complete() calls snd_usbmidi_urb_error(urb). When
>     >     receiving non-disconnect error codes (This error code is outside the
>     scope
>     >     of the error codes handled by snd_usbmidi_urb_error.), it invokes
>     >     mod_timer(&ep->umidi->error_timer, ...) without checking umidi->
>     >     disconnected.
>     >   
>     >  4. This re-arms error_timer AFTER del_timer_sync() has already
>     executed.
>     >   
>     >  5. snd_usbmidi_disconnect() completes and frees struct snd_usb_midi in
>     >     snd_usbmidi_free.
>     >   
>     >  6. Later when error_timer fires on deallocated memory, leading to a UAF
>     panic
>     >     in __run_timers.
>     >   
>     > Please let us know your thoughts on this issue.
>    
>     Could you verify the issue with the very latest Linus tree, too?
> 
>     thanks,
>    
>     Takashi
> 
