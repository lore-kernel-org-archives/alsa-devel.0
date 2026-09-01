Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A915C61DD3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:08:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74CE3601AB;
	Tue,  1 Sep 2026 16:08:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74CE3601AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788271711;
	bh=9lbHYxaaUFdbyd42U/p4bqizcqzmLOiW9yG7pN6nJ1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EyvJe6REgmqtODEmpnJl/9tFiOsgYW05ixnYfV/FIOw2YDODGJX9zjvZzX4jixRTm
	 tcywNlzKzZG4wTncVFMdw8+5IgvWlkuIVJjCFnVTOnf7Y+kkfC5SoxjVoXr0f2avv9
	 nsFvG1S3vvpvYwfHCJhn0OormtJasbzjdlNKiOvA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26BBFF805F6; Tue,  1 Sep 2026 16:07:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E68F9F805FF;
	Tue,  1 Sep 2026 16:07:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66C54F804CC; Tue,  1 Sep 2026 16:07:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788271667;
	b=ipAS/T24m+lJUU3jdrioQ3lBlio7zUKSsASDyNlNqKNs19AnZ8rvKpwgnEn+pET91308
	 WGiKGivzeVCm7w5IuOiPCgZTOMU8ez7WWLFYvkMlH/fwXDwMT703O6KrDPZYOQ5xIzAgU
	 YmvVsnBGH7ovJSkFivNMU6rEgFBvXLsIg23UF50SHaTn5Ip5p5mxXlZlAdLBnT85ZGdXN
	 dwWRhm36yTTIme91oV1wa3n7emxeJIMGO6qLI07X67iuoZLVVs1a08Hr672N3+r49sVQn
	 KKUWe63yYI4C/aMTO7Oi0iU+ZvgXGNyQmNda12gxt2tkoTwVXMKG/SSQpBaC1PCyWmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788271667;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=9lbHYxaaUFdbyd42U/p4bqizcqzmLOiW9yG7pN6nJ1Q=;
	b=Oa9V6KHkEyXrqb4myOw22XHj2tRvnpTrMsvrmQAVbsixsGjZDNi+vQqVhFmnBgQDvgEb
	 SavecZ3saek0LXb7h7zDaZ+v4nClEsvmBirxY2+mOkadYuBRDjPevdP87weDFapHFv4Cr
	 dBDUlGrVZaBDpnmbpqihV2lW2KjBzAVdUP0TJRs/tDYiggFjb1PYg8WDI/5G1nYfXEXo4
	 p1pHbCT7UQF28O5TV+7wpQRipDM7p4QvXrhQ6t9tHfiVHlbJUGNWW5VwHWhc8hqTBf0Qj
	 xZK4Jo7sZndATm4zoDS/5LwLNdVIm5Sl1ue6sCEgW6bVyy8YR0rn9UeYL1tdv2GMY6Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=RipTC9CF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B3n4EX97;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yUwup2bF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kXrrKtio;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B259FF801F5
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 16:07:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B259FF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=RipTC9CF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=B3n4EX97;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yUwup2bF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kXrrKtio
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F17952275C;
	Tue,  1 Sep 2026 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788271657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsZK4jm0JzBlFSl/aTthADc9TmkYvM4civyL8fU2rLg=;
	b=RipTC9CF9VARmxgljgYeutYJH7IWx4FNFY6E6RIlwK4iqT7Q7EFMehk0kuYEe8QxGECh4V
	ETnf1O6N3PcT8r+J6+iyyOfVCN8+7AFPcu4Vh3grXuDltAAzzBseVVttJZ+piCmhbSKWfV
	IVROxwaDmMU0fYK1SNFP2tikI3msqtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788271657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsZK4jm0JzBlFSl/aTthADc9TmkYvM4civyL8fU2rLg=;
	b=B3n4EX97FGS1DEG/w4YZ3J7a+KauSuhjXP+6VkKeNURJYiu3IqcjsG3sLn/PEAP1tAtLpF
	eo2Z9129D57AzfAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788271652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsZK4jm0JzBlFSl/aTthADc9TmkYvM4civyL8fU2rLg=;
	b=yUwup2bFrsUfXCnJfiz2BtA6ADKjaEddwfPEaFMAgYCfcHwdlzkLO8ac7nSL2J4SL6F8Ry
	+RagxePtdEczgjLVS/vselz8jCbznDxnyfWGJy6CVSI+xjHw0/UIAFxniHzVFEM3pz+/04
	UBzq+x9HVy1ipaB9MtrHGwDs39MFGFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788271652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsZK4jm0JzBlFSl/aTthADc9TmkYvM4civyL8fU2rLg=;
	b=kXrrKtiojBlT1c7oWWUh38aYmJBkR1jQpWlmQEpn1poKiRSnCMs4nEcI9xOdzmPYd7WPg6
	hwTAyW/eghE+eDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4EC1369E;
	Tue,  1 Sep 2026 14:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3wXLSTclmpUXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 01 Sep 2026 14:07:32 +0000
Date: Tue, 01 Sep 2026 16:07:32 +0200
Message-ID: <878q5lcbff.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Isma=EFl?= Bahloul <i.bahloul01@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v2 1/4] ALSA: usb: add RME Babyface Pro FS driver
 (proprietary mode) =?ISO-2022-JP?B?GyRCIT0bKEI=?= core + PCM
In-Reply-To: <20260901090635.9208-2-i.bahloul01@gmail.com>
References: <20260901090635.9208-1-i.bahloul01@gmail.com>
	<20260901090635.9208-2-i.bahloul01@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,intel.com:email]
Message-ID-Hash: A2X7FEHBPLFXK2AHQBIJGWHI5V6UM4ZV
X-Message-ID-Hash: A2X7FEHBPLFXK2AHQBIJGWHI5V6UM4ZV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A2X7FEHBPLFXK2AHQBIJGWHI5V6UM4ZV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 01 Sep 2026 11:06:32 +0200,
Ismaïl Bahloul wrote:
> 
> Add the core RME Babyface Pro FS driver (proprietary mode, VID
> 0x2a39 PID 0x3fc0): USB vendor-request protocol + cold init,
> interrupt-URB PCM streaming on interface 5, mixer-state persistence
> across re-probes/resume, and the card lifecycle (probe/disconnect/PM/
> module entry).
> 
> The control surface (mixer, front panel, DSP EQ) is stubbed here so
> the module links; the follow-up patches in this series implement each
> part.
> 
> Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
> Assisted-by: DeepSeek V4 Flash
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609010710.w6NVelt4-lkp@intel.com/

You don't have to put Reported-by / Closes tags here.

And, above all, please try to give some "big picture" of the design of
the driver.  It's not clear what the stream_work does and how the
stream numbers are managed and how they influence on what.


> diff --git a/sound/usb/babyfacepro/Makefile b/sound/usb/babyfacepro/Makefile
> new file mode 100644
> index 000000000..40badfd14
> --- /dev/null
> +++ b/sound/usb/babyfacepro/Makefile
> @@ -0,0 +1,2 @@
> +snd-usb-babyface-pro-y := babyfacepro.o babyfacepro-ctl.o
> +obj-$(CONFIG_SND_USB_BABYFACE_PRO) += snd-usb-babyface-pro.o
> diff --git a/sound/usb/babyfacepro/babyfacepro-ctl.c b/sound/usb/babyfacepro/babyfacepro-ctl.c

SPDX tag is missing in Makefile?


> --- /dev/null
> +++ b/sound/usb/babyfacepro/babyfacepro-ctl.c
(snip)
> +/* Crosspoint-map output order vs the master-map order — HARDWARE-
> + * VERIFIED 2026-08-24: the block that feeds the Phones is the FIRST
> + * crosspoint block (0x34), while the Phones master is the SECOND
> + * (0x03E2/0x0006).  The crosspoint map lists the Phones first (the
> + * monitor output); the master map lists AN1/2 first.  Control index =
> + * the canonical order (AN1/2=0, PH3/4=1, ...) so the crosspoint and
> + * master controls line up; this table maps to the register block.
> + */

Avoid non-ASCII letters as much as possible.
LLM tends to put the too fancy letters and comment styles, e.g....

> +const u8 bf_xpoint_block[6] = { 1, 0, 2, 3, 4, 5 };
> +
> +/* ── control-surface stubs ──────────────────────────────────────

.... like the above.  Avoid the unneeded separator like this.

> --- /dev/null
> +++ b/sound/usb/babyfacepro/babyfacepro.c
(snip)
> +int bf_vendor_write(struct snd_usb_babyface *chip, u8 req, u16 val, u16 idx)
> +{
> +	return usb_control_msg_send(chip->dev, 0, req,
> +				    USB_DIR_OUT | USB_TYPE_VENDOR |
> +				    USB_RECIP_DEVICE,
> +				    val, idx, NULL, 0, 1000, GFP_KERNEL);
> +}
> +
> +int bf_vendor_read(struct snd_usb_babyface *chip, u8 req, u16 idx, u8 *buf)
> +{
> +	return usb_control_msg_recv(chip->dev, 0, req,
> +				    USB_DIR_IN | USB_TYPE_VENDOR |
> +				    USB_RECIP_DEVICE,
> +				    0, idx, buf, 4, 1000, GFP_KERNEL);
> +}

Avoid magic 1000.  It's a timeout for 1000ms, so define it.

> +/* The 0x16 cold-init clear covers only 0x00-0x3D — the "cross"
> + * registers of a block (L-reg odd / R-reg even of the stereo
> + * sources) survive from the previous session and would sum L+R into
> + * BOTH channels of the output (mono).  Zero them explicitly: 10 odd
> + * L-registers (5,7,…23) + 10 even R-registers (4,6,…22).
> + */
> +int bf_crosspoint_clear_cross(struct snd_usb_babyface *chip,
> +			      unsigned int blk)
> +{
> +	int ret, k;
> +	u16 flag;
> +
> +	for (k = 5; k < 24; k += 2) {

Those L and R registers should be defined properly, instead of
hard-coded magic numbers in the loop condition.

> +		flag = bf_flag_cycle[chip->flag_cnt];
> +		chip->flag_cnt = (chip->flag_cnt + 1) & 3;
> +		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000,
> +				      (BF_REG_CROSS_BASE_L +
> +				       BF_REG_CROSS_STRIDE * blk + k) | flag);

This seems to be a quite often seen pattern.  Maybe it should be
better in a helper, e.g. bf_vendor_write_cycle()?

int bf_vendor_write_cycle(struct snd_usb_babyface *chip, u8 req, u16 val, u16 idx)
{
	u16 flag;

	flag = bf_flag_cycle[chip->flag_cnt];
	chip->flag_cnt = (chip->flag_cnt + 1) & 3;
	return bf_vendor_write(chip, req, val, idx);
}

> +/* ── mixer-state persistence across interface re-probes ────────
> + * A userspace client can claim the proprietary interface via usbfs
> + * (USBDEVFS_DISCONNECT_CLAIM — seen with PipeWire grabbing the
> + * device when a stream targets the sink, and with the TuxMix
> + * user-space daemon's libusb).  That detaches us and the card
> + * disappears for the duration; on release the interface re-probes.
> + * The device keeps its registers across the detach, but our cold
> + * init clears them — so save the mixer state at disconnect and
> + * restore it at the next probe.
> + */

Hmm, this could be done by alsactl restore, in general, too?

Though, the state save/restore could be used for the runtime PM, too,
so it can be useful.  But it's something to be considered later.

> +/* ── stream (interrupt URBs, caiaq-style) ──────────────── */
> +
> +static bool babyface_capture_copy(struct snd_usb_babyface *chip,
> +				  struct snd_pcm_substream *subs,
> +				  const u8 *data, unsigned int frames)
> +{
> +	struct snd_pcm_runtime *rt = subs->runtime;
> +	unsigned int buf_frames = rt->buffer_size;
> +	unsigned int words = chip->frame_bytes / 4;
> +	unsigned int chans = rt->channels;
> +	unsigned int pos, f, i;
> +	unsigned long new_period;
> +	bool crossed = false;
> +	u8 *dst;
> +
> +	spin_lock(&chip->lock);
> +	pos = chip->hw_ptr[SNDRV_PCM_STREAM_CAPTURE] % buf_frames;
> +	for (f = 0; f < frames; f++) {
> +		const __le32 *w = (const __le32 *)(data + f * chip->frame_bytes);
> +
> +		dst = rt->dma_area + frames_to_bytes(rt, pos);
> +		for (i = 0; i < chans; i++) {
> +			/* Channel map: app ch0-3 = device words 0-3 (AN1-4);
> +			 * app ch4-9 = words 6-11 (ADAT/SPDIF); app ch10/11 =
> +			 * words 12/13 = a FIXED-GAIN playback tap (observed
> +			 * 2026-08-25: the playback echoes there at ~−27 dB,
> +			 * independent of the output masters — NOT the output
> +			 * bus; the ADAT/SPDIF range is words 6-11 only).  The
> +			 * device words 4/5 are a fixed marker, not audio —
> +			 * skipped.  At 96/192 kHz the frame has fewer words;
> +			 * missing ones read as zero.
> +			 */
> +			static const u8 map[12] = { 0, 1, 2, 3, 6, 7, 8, 9,
> +						   10, 11, 12, 13 };
> +			u8 wi = i < 12 ? map[i] : 0xff;
> +			s32 s = 0;
> +
> +			if (wi < words) {
> +				/* 24-bit sample in bytes 1-3; arithmetic shift
> +				 * sign-extends from bit 23.  S24_LE container.
> +				 */
> +				s = (s32)le32_to_cpu(w[wi]) >> 8;
> +			}
> +			put_unaligned_le32((u32)s, dst + i * 4);

Why do you have to convert to S24_LE at all?
You can use S32_LE with msbits.  That's a far more standard format,
and even easier for user-space.
That is, just copy the data as-is.

> +static bool babyface_playback_copy(struct snd_usb_babyface *chip,
> +				   struct snd_pcm_substream *subs,
> +				   u8 *data, unsigned int frames)
> +{
> +	struct snd_pcm_runtime *rt = subs->runtime;
> +	unsigned int buf_frames = rt->buffer_size;
> +	unsigned int words = chip->frame_bytes / 4;
> +	unsigned int chans = rt->channels;
> +	unsigned int pos, f, i;
> +	unsigned long new_period;
> +	bool crossed = false;
> +	const u8 *src;
> +
> +	spin_lock(&chip->lock);
> +	/* Clamp to what the app has actually written: the in-flight URBs
> +	 * (nurbs × frames_per_urb) can exceed the app ring, and without
> +	 * this the driver advances hw_ptr past appl_ptr — the ALSA core
> +	 * then flags a spurious XRUN on the next app interaction even
> +	 * though the app refills on schedule (seen at period 16-128 /
> +	 * 96-192 kHz with nurbs=16).  The device just repeats the last
> +	 * frames (stale audio) instead of corrupting the stream state.
> +	 * NB: subtract the unbounded counters directly — modulo arithmetic
> +	 * is ambiguous at exact buffer multiples (appl=512, hw=0 → both
> +	 * wrap to 0).
> +	 */
> +	{
> +		snd_pcm_sframes_t data =
> +			(snd_pcm_sframes_t)(rt->control->appl_ptr -
> +					    chip->hw_ptr[SNDRV_PCM_STREAM_PLAYBACK]);
> +		if (data < 0)
> +			data = 0;
> +		if (data > (snd_pcm_sframes_t)buf_frames)
> +			data = (snd_pcm_sframes_t)buf_frames;
> +		if ((unsigned int)data < frames)
> +			frames = (unsigned int)data;
> +	}

Hmm, this sounds weird.  We can tolerate the XRUN check, but this
doesn't look good.

I stop at this point for now.


thanks,

Takashi
