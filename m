Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2C606A31B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Ce2z+hN9;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XeH28d03;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wvUMSiIf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XeH28d03;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wvUMSiIf
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BDC3601F8;
	Wed,  4 Nov 2026 08:26:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BDC3601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793777213;
	bh=JkhYhFVAK7M/DxNrpqcN5qqqo+0SXWUsy3sszgOqiDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ce2z+hN9sHj1YIGtft/JUbzfv+80H4cnWA36xA5aMqbIfjkhopm+Dlp/7Z0HreKG2
	 X/LNTUqkSx7yEiI7V+Tdrl8k9IzIAwlAnU/9aJSjbuBClHi8QWrZ8+x6UidqmWh4tj
	 f16OoF1Sg2xSQcY8yomKfs5NoVmeQVmiXzvwULP0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 445A9F80600; Wed,  4 Nov 2026 08:26:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C45ECF805FF;
	Wed,  4 Nov 2026 08:26:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69044F805AA; Wed,  4 Nov 2026 08:26:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793777173;
	b=ixnnI383bUfGm5PSr7qnCbAu2Gi75rt/Mr48E7hTN8TiSEJbiASKvF5iqF6J8LdANVOw
	 miKUibCAfnktCUUlvihvrbE21p6aylRaEyfbwetsWeLUpg7Vp9iPjaN1sTUOUAebM5KYl
	 1VfcPsNeJXWqAZjDOSCI3kvsKd7/8TWBPc+AJzRmXEDLQLEEh3tEtMXGGvtm7+NKHIi72
	 WjIRm5Supq2HoYWaO52h5ekdoNwYaY4WTqg82BBvTQA6eExsJ0MIgeiU8oE3eETfqCtsq
	 Wxdm5W+HCb3Al9wdK0ttbvMnh+wAwXz1S2Qrs3SA/gIHMDiVbKgV9qDHpUvZTzPYIKQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793777173;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=JkhYhFVAK7M/DxNrpqcN5qqqo+0SXWUsy3sszgOqiDI=;
	b=nw1eTXsyqWUEIKu+x6Gkm4Er0jT4KvHBjmeL5uEUV33HqXKNYMWmZqWs8LDXSVkdiqeB
	 TFdtbqwqTQCLrqaiJ2Re0QFlXYeQ/yd8+j+c7WFeehN21fJucNHkJJDKDx2xo5AfOGBJb
	 eYEHSd3Se73A6QAJTmuiMA/nl6xbO0toEbkrX2UvMxGkLiMf0Unffauov1+jlimVPrTd+
	 KZd0By/oc5hNZwZZon/sdrlAtDc7KqAWJeYvPw0TB+3NtYUB8jdS0GqKBmJZnI4JC5sf1
	 NlRX0pJCsF2gxE2WQFEvBcHJVvlRu9QGy4qZps0bcrFyiw60vFRwA6sxKnS+bs8FqUA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XeH28d03;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wvUMSiIf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XeH28d03;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wvUMSiIf;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D879BF8055B
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 08:26:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D879BF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=XeH28d03;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wvUMSiIf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=XeH28d03;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wvUMSiIf
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A5181F79F;
	Wed,  4 Nov 2026 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793777171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SA7Bf9auILChUao5hZdgNKE7dHcrzEqtGGCcyfajDU0=;
	b=XeH28d03aO9jBGFzpSN/p5tdxG2hXReWJoXHiD5TpnCi0iubl2gT9iW2jhYUTDC+w3RhDX
	0ZMR1kGxpJNiSLlTa5bG9PmLYeh/1JNg2ZvK1ne5zw5Cc1yYKUbxj218TgiMhKO5C5sfUv
	TGt8SPtdFYKVq2drxXOCsXlXqH/3lA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793777171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SA7Bf9auILChUao5hZdgNKE7dHcrzEqtGGCcyfajDU0=;
	b=wvUMSiIfHhIOTcG/45u8kAWosopcVphhHLFnjbqBm0+nqaaZkZIUHmDycRMIxdhMo+is7F
	g0tQsjCPS2tpGOCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XeH28d03;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wvUMSiIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793777171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SA7Bf9auILChUao5hZdgNKE7dHcrzEqtGGCcyfajDU0=;
	b=XeH28d03aO9jBGFzpSN/p5tdxG2hXReWJoXHiD5TpnCi0iubl2gT9iW2jhYUTDC+w3RhDX
	0ZMR1kGxpJNiSLlTa5bG9PmLYeh/1JNg2ZvK1ne5zw5Cc1yYKUbxj218TgiMhKO5C5sfUv
	TGt8SPtdFYKVq2drxXOCsXlXqH/3lA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793777171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SA7Bf9auILChUao5hZdgNKE7dHcrzEqtGGCcyfajDU0=;
	b=wvUMSiIfHhIOTcG/45u8kAWosopcVphhHLFnjbqBm0+nqaaZkZIUHmDycRMIxdhMo+is7F
	g0tQsjCPS2tpGOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D45E134A5;
	Wed,  4 Nov 2026 07:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wzxFGxLe6mp+NwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:26:10 +0000
Date: Wed, 04 Nov 2026 08:26:10 +0100
Message-ID: <87o6c5ukfh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cristiano Souza <cristianocps@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: usb-audio: Skip broken playback feature unit on
 XiiSound chips
In-Reply-To: 
 <CANiPN4m_+iwVio0LvXeJrq5SdLi3-paL45XMs0yjuZu4KotmEw@mail.gmail.com>
References: 
 <CANiPN4m_+iwVio0LvXeJrq5SdLi3-paL45XMs0yjuZu4KotmEw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0A5181F79F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
Message-ID-Hash: HPUU7HJRCT7FHEKNKNQXST53VZK4CWIU
X-Message-ID-Hash: HPUU7HJRCT7FHEKNKNQXST53VZK4CWIU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HPUU7HJRCT7FHEKNKNQXST53VZK4CWIU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 03 Nov 2026 04:33:35 +0100,
Cristiano Souza wrote:
> 
> Weltrend XiiSound-based devices (040b:0897, e.g. Redragon H878
> wireless headset) expose a UAC1 playback feature unit whose volume
> and mute controls are unusable in practice: the reported per-channel
> dB range is only 0..+0.39dB, yet setting any volume below the
> maximum mutes one or even both channels, and the mapping between
> logical and physical channels is unreliable.  Any attempt by
> userspace to drive the hardware volume therefore results in muted
> or one-sided audio.
> 
> Skip the playback feature unit entirely so that userspace falls back
> to software volume, and pin the unit's master and per-channel volumes
> to the reported maximum with mutes cleared when the mixer is created,
> so the signal path always stays fully open.  The capture path
> (microphone feature unit) is not affected and keeps working.
> 
> Tested with a Redragon H878 wireless headset on PipeWire/PulseAudio:
> stereo output works on both channels at any volume, software volume
> applies smoothly, and mute/unmute works.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Cristiano Souza <cristianocps@gmail.com>

The patch looks inapplicable likely because your mailer broke the tabs
and spaces.  Also, the submission for a kernel patch should go to
linux-sound@vger.kernel.org, not alsa-devel ML.
Please fix your mailer setup and/or try submission via git send-email.

But, before that, about the code change: I wonder whether you can
achieve it more simply by defining a usbmix_name_map in mixer_maps.c?
It can be used to skip unsupported units, too.


thanks,

Takashi
