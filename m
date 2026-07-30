Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB51C55164
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:46:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 183DB601FA;
	Thu, 30 Jul 2026 17:46:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 183DB601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785426375;
	bh=Et43kXlpTi0V4RYFyaCaiQyyXXSeHxG+2Ex+/2O/ZJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=duEFVSgbHAsa4YYXCtK/6hwy/c9/ZW6OWrziB166S+Uen+wopVpcV6/r6LGi6pNP7
	 RNgtxAPxHx1J0Bjd3bBMwtKcjrLzMg/lg0HwoGoQutnkmqWcNtVNVQHbYMRG9xOQMj
	 HpcEdfRw1tAXmFLZtYa8YjnMqG2l7VMqkjd3X4m0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEF8DF805F8; Thu, 30 Jul 2026 17:45:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74CE0F805FD;
	Thu, 30 Jul 2026 17:45:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A7D5F80496; Thu, 30 Jul 2026 17:45:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785426330;
	b=n4UozilWw7AZXTM3aIgGuZBRL76UqpxJKEkKoSSNe3Ckz3qHk0+b3208HyfLndjT2WTn
	 K3AjiMiEJrj3aZu45o2RIVnnxQfljeyBbnqXhKMjwPjLEuVwtP4mnZJfDDtxbnCaw1PfB
	 /wi+TaI/lGMZ5sYga6tKNhcDKdlONaWhYLNnrxT5zc4n0gnUKj29dErgr+p4CtM4vTP8S
	 r4vUuzKtNOLRzBDIlWs54qUcCqsl7f5jRV9FDIO2svA651DXSSfTb32HBfJ2q93+VIxWE
	 ov5AY9ivp0vy4tWMHFe3tqyMiczGtz62AQAzVC+Q1r1/e9w4Sw71O+CdP7N0ldMfp0Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785426330;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=Et43kXlpTi0V4RYFyaCaiQyyXXSeHxG+2Ex+/2O/ZJc=;
	b=ZP444OHplR2VaUqHkCc/stahB2VjUl6Ys9ZOp4L16+eJruIC4uhZCNZSuvglYqQOUrw0
	 q6qBl6m4+CpTfRDaiaRgNiOMsZV7zSa20nMfCxQuD4LmKNUSlcgqAMNS8taSf+mo1mh1L
	 Y3BsRBmb1A63hgu/QrDhxjlRLj2yB+Pezk1UhgfeuTO5dAc7LzPKYybVHdJBMP6IgsOcV
	 G3O0ZBrr1pNxsjzkxWfGSnPS6IKGPUs5KSPSaSGpslkxyDylrveJNdbkUDskKzwcp0Ea6
	 Bg+Z1YOI99JexyPVgZqqlRW4Lyxh3nz2wpV2+PUYWWFQIxiedCUp4IDpJTiqM/RzfqA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hH67haPU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=eV2CXhBA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=C9Bj9FAW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hrUGQd6x;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4876F8014C
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 17:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4876F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hH67haPU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=eV2CXhBA;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=C9Bj9FAW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hrUGQd6x
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B59123E69;
	Thu, 30 Jul 2026 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785426324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRvIjuEd9o4Sz2C1/MjDfEkVbN2Z/MUarxT5PU337xg=;
	b=hH67haPUKijYpiBlyFI69/OlgSemmz076fmDADXhe2ED0gaeICbOwnPnk3axqrB+Pbb3Dg
	PrQnldMJxi11B+Y4w8FbCqZ2Y7upxpiWZl1XQbbQuxUNo6MsmgioXDthBQqKY0wv8T4f4y
	M3pMysBAC/AQcr2f0gZidIG4dgyvfEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785426324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRvIjuEd9o4Sz2C1/MjDfEkVbN2Z/MUarxT5PU337xg=;
	b=eV2CXhBA3ZdyXp5saupTXmMsW8SZZLf78rLyOnjZTN/EKp1A2NNtJ+gXFRkMtLE2RW0pC2
	JiqtMJ16IFS6sqDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785426320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRvIjuEd9o4Sz2C1/MjDfEkVbN2Z/MUarxT5PU337xg=;
	b=C9Bj9FAWSwaiHT71RPoG6sIRs5VVJiIRpJk8KeTNAg0IMqcrCwcYEYi9/a7O57KUzY6TtZ
	QBHkfzoF3rsVljNUoMAkPFu4YKNl1Pz9XYQZNnSTBCldcrGZ3Km8H/RJmXY6LO8wheg1Z7
	WcrPFVmfUGQ4RdFzcMKPkTenvcZHyK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785426320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRvIjuEd9o4Sz2C1/MjDfEkVbN2Z/MUarxT5PU337xg=;
	b=hrUGQd6xuiXIYEpePfT92aoucdChwbNqmwfs0HA12V/y3V+Gk3h1qLK8dDRjQnuGBSDdIa
	H9ifEnEFTZ1/oYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77AFB779CC;
	Thu, 30 Jul 2026 15:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id klgBHJBxa2rRawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jul 2026 15:45:20 +0000
Date: Thu, 30 Jul 2026 17:45:20 +0200
Message-ID: <87tspg1nxr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Padhia Luo <lcj20010426@gmail.com>
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speaker mute LED on Lenovo
 ThinkBook 14 G8+ IPH
In-Reply-To: <20260730071453.19636-1-lcj20010426@gmail.com>
References: <20260730071453.19636-1-lcj20010426@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: YL452BOAZ2MNQZQY7CUFCW53TROVDBHZ
X-Message-ID-Hash: YL452BOAZ2MNQZQY7CUFCW53TROVDBHZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YL452BOAZ2MNQZQY7CUFCW53TROVDBHZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 30 Jul 2026 09:14:53 +0200,
Padhia Luo wrote:
> 
> On the ThinkBook 14 G8+ IPH (SSID 17aa:393e, ALC287) the F1 speaker mute
> LED never lights up, while the F4 mic mute LED works.
> 
> Both LEDs are platform LEDs registered by lenovo-wmi-hotkey-utilities and
> default to the audio-mute / audio-micmute triggers, so the speaker LED only
> follows a control carrying SNDRV_CTL_ELEM_ACCESS_SPK_LED. No control on
> this machine has that flag set, so snd_ctl_led never attaches anything and
> /sys/class/sound/ctl-led/speaker/card0/list stays empty. The mic LED is
> unaffected because MIC_LED is set from the SOF topology on the DMIC
> control, which does not go through the codec fixups at all.
> 
> The pin configuration of this machine matches the ThinkPad pin quirk that
> selects ALC285_FIXUP_THINKPAD_HEADSET_JACK - pin_config_match() masks out
> the sequence/association nibbles, so 0x14=0x90170120 still matches the
> 0x90170110 in the table. That fixup chains into ALC269_FIXUP_THINKPAD_ACPI,
> but hda_fixup_thinkpad_acpi() returns early because is_thinkpad() is false:
> a ThinkBook exposes neither LEN0068/LEN0268 nor IBM0068. Therefore
> snd_hda_gen_add_mute_led_cdev() is never called and spec->vmaster_mute_led
> stays 0.
> 
> The vendor fallback SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo XPAD",
> ALC269_FIXUP_LENOVO_XPAD_ACPI) would have handled this correctly - the
> machine does expose LHK2019 and VPC2004, so is_ideapad() is true - but it
> never runs: the pin quirk has already set codec->fixup_id, and
> snd_hda_pick_fixup() returns immediately in that case.
> 
> Add an SSID quirk selecting a fixup that keeps everything the machine
> currently gets (headset jack handling plus the X1 Gen7 DAC routing) and
> additionally runs the ideapad ACPI setup. It chains into
> ALC287_FIXUP_LENOVO_YOGA_PRO7, which already combines
> alc285_fixup_thinkpad_x1_gen7 with ALC269_FIXUP_LENOVO_XPAD_ACPI, so the
> resulting chain differs from the current one only by the added ideapad step
> and cannot regress the analog output or the headset jack.
> 
> Tested on 7.1.5 on the affected machine: the speaker LED group is now
> populated at probe time without any userspace help, and the F1 LED
> follows the mute state.  Compared against a boot with the previous fixup
> selection, the mixer control list (names and numids) and the registered
> jack input devices are identical.
> 
> Note that the underlying mismatch is not specific to this SSID. Any Lenovo
> non-ThinkPad whose pins collide with a ThinkPad pin quirk loses its mute
> LED the same way. Letting hda_fixup_thinkpad_acpi() fall back to the
> ideapad check would cover the whole class at once, but that touches a
> helper shared with every ThinkPad, so this patch only fixes the machine
> that was actually tested.
> 
> Signed-off-by: Padhia Luo <lcj20010426@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
