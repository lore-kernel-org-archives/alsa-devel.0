Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9887CA5FAC
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:31:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C3B76026A;
	Wed, 30 Sep 2026 14:31:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C3B76026A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790771485;
	bh=umMdtdGHmNyN3QUyqFsFG/sSNcroWHL4MqclGkoUPcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qE/m66jM4UVWwEpmzvmWNeJ66mhGQfU0UQ/Ddt96M2a5z2+wGFPORexGXb72yvEge
	 kdDkPXwVItGDEzk1RxG0/E6c1vZTVbpq2VmvaHPodKr/YCiKYwQtd0Ll1KJdVWjxqY
	 Eb3i/YwhuFP4BTs5fJCjA30TgSk1iowcHPYErgyc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FC8BF80601; Wed, 30 Sep 2026 14:30:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1ADEF80601;
	Wed, 30 Sep 2026 14:30:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8E17F80542; Wed, 30 Sep 2026 14:30:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790771442;
	b=Z49ZwGSyFHN373QpT29xnpVImxPLtn8YtoJLOba2IB2ZR1gkArw3aWbMJce3E+GRmd3A
	 osIhdo3ncmQfclCFiKfzdEQ2L0L5IrI3qIULdB581LEdCnVhi92JgfHD+JtnAl9rPpcoL
	 ueM6veskk0njbiL/Yj2amkJOF9367IXoMhwwTfGb8sPbxqayLtS/77PzqdRl7ycTqUo4q
	 jsMKIIdBsSzOIAE8siPAlY1nWKw4/iQ3kePeCCjBzyafbIpWVSiQ9l1v8iJOjk6idnR3L
	 5BNq+sTloZNkemV/dpBnwFZgknhvxDXzR0XzyEWUq/bfJXz/zVcyGkUFyHKQjbuvgkg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790771442;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=umMdtdGHmNyN3QUyqFsFG/sSNcroWHL4MqclGkoUPcw=;
	b=S/XY7DgHBApOE6KCICG+NGjn+WTWuNcUR8zrrTskRLEQRyzX851COwchJJWq9gWdeZao
	 InIRbtxnyADSa9GppikSuchdXUewK56elgNrrri16gGR4XnJPIzTpJ1EbDxJaRtX2zCgH
	 NMr2C4WjCkJ578LvdxOKbZXJ4Ds3KcrIESx/MHE+D6NE0BGw4VNbcO503J2ZXGw9EKaqn
	 3LbsuqaAYpLeYtK6+nL5vvLLvf/efXR+NTT6Uq8Fo1EnTLY0R+fmvTcO9eCTtovUuTpsQ
	 R4oVqchIXs8YLmpmXX5EdKRT6nvxPqzGkynzaQnr2f2b+OoKCBjVlWkG7HPdAaHvprQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=DtXE4IrT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Cja5hqS+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=dwCmq0xB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Jkl8R7lg;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B54DCF800D0
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 14:30:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B54DCF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=DtXE4IrT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Cja5hqS+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=dwCmq0xB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Jkl8R7lg
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8493A1F8D6;
	Wed, 30 Sep 2026 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790771436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdXUot0qtKaOs8crNAWjCWwwHQBoIPvaskpFXhLmheQ=;
	b=DtXE4IrThRusTGqzHYItRgTUOFQ6JLJAbDlZwf6BOcw9OIRdTZgdGUB4iUiZ+zBFTKlQSx
	H6jJDl9Z52lel80Dqx73nRGa0KPjsQex27WXB8fbMI9CYsmLkiaTFpDNFHwVggycb+1dNR
	m1yf0rmXF3oSU8hR2sr5jj54gX/3F+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790771436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdXUot0qtKaOs8crNAWjCWwwHQBoIPvaskpFXhLmheQ=;
	b=Cja5hqS+fduO6epvq2vv5jzR381iZeyuiWS9mOhOZsRu5shGARqx3MC4SAJxATu3zjKzP+
	XNCRDrXR87w6VQBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790771432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdXUot0qtKaOs8crNAWjCWwwHQBoIPvaskpFXhLmheQ=;
	b=dwCmq0xB4Ir212FFx3TbmuGmnU9LnETlRDV5FCoEVuWxC4wxDP9W1I38XqQl0jZO+4N20f
	CHSTmyFvlmO3Ft/lMgCS5nngoH/9+vZ4wC3Fxw4+IXFy7EF9u+oyKN3PDKMdX/8bRwRTR9
	gkzwvJ+ePkkZG5x2E219loTqoo0cfYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790771432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdXUot0qtKaOs8crNAWjCWwwHQBoIPvaskpFXhLmheQ=;
	b=Jkl8R7lgjtwA5UI/kHyV0tH9FQVU2iNm2hsnkgNk5NMMro0uvr37k8P5MnEQjVpaWLVoD4
	5BybyRO/v2+7BrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 372BC136AD;
	Wed, 30 Sep 2026 12:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h4KIA+gAvWrPdwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Sep 2026 12:30:32 +0000
Date: Wed, 30 Sep 2026 14:30:31 +0200
Message-ID: <87y0ci53bs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ren Panpan <rppxj178543@163.com>
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	renpanpan <renpanpan@kylinos.cn>
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 14-dv1001TU
In-Reply-To: <20260930065504.24151-1-rppxj178543@163.com>
References: <20260930065504.24151-1-rppxj178543@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: UTQNJUCXFQFCRKXMNE7RLL7WB2FJUJ3Q
X-Message-ID-Hash: UTQNJUCXFQFCRKXMNE7RLL7WB2FJUJ3Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTQNJUCXFQFCRKXMNE7RLL7WB2FJUJ3Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 30 Sep 2026 08:55:04 +0200,
Ren Panpan wrote:
> 
> From: renpanpan <renpanpan@kylinos.cn>
> 
> The HP Pavilion 14-dv1001TU (subsystem ID 103c:8987) uses a Realtek
> ALC287 codec. The mute LED on this machine is controlled by GPIO bit
> 0x10, which was verified via hda-verb, but the subsystem ID is missing
> from the quirk table. As a result, the ALC287_FIXUP_HP_GPIO_LED fixup
> that drives GPIO 0x10 is never applied and the mute LED stays off even
> though the associated LED class device toggles correctly.
> 
> Add the missing SND_PCI_QUIRK entry to map this subsystem ID to
> ALC287_FIXUP_HP_GPIO_LED so the mute LED works as expected.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221810
> Signed-off-by: renpanpan <renpanpan@kylinos.cn>

Applied now.  Thanks.


Takashi
