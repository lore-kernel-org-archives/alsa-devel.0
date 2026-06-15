Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4C7CD98C5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:32:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66465601C7;
	Mon, 15 Jun 2026 09:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66465601C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781508766;
	bh=faH40j0IkWOAv9+IWFO/9sCAAauQpXwzASwukbDY4F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MQDQbn9m3cChiCbQz/mImIDrwEqtcOJHN/nMjiGQK/EwY6bUWaSd0/qYzvz+TBnG4
	 bc1DNZe7xrGwxSlIFDRREo8IZI5vYkXAr0HVJdyvSzU7sql4NdxpfOK+BibFE2+BJU
	 tan4gx+eZpgsgRNOoJCYTu7jZLZynn+/qj1YRCzY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46FE9F805FE; Mon, 15 Jun 2026 09:32:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 707C0F80600;
	Mon, 15 Jun 2026 09:32:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB053F8047D; Mon, 15 Jun 2026 09:31:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781508710;
	b=eH4CvwcOBnOM1JvFCcCoAcaLpUvPVKesMYisYtJI221vPYKW1Porn5RqqFADzDySHGWS
	 R4FsWCw7UsQMq73W8H4mVIU369QqZLU9We9XbnBr+OWVPlP63LtpQmD8gjeUVC+PTdVcO
	 ffvRUrU8stxM4bpY//2YoD20c1ShvP2C7mBKTwvl0LQv3HHmviO1v6q5DlSSn1hxpGfkY
	 Oqx3iJbfcHXN4eTDz316QmtpVOn+iwJyuVA4yLhUUpMVwDabx+7NS3aFx8cWRTRuzPEvQ
	 J+fdiZpBzh4svDAfIJtC8+1u1wB3mvVugHbVI/R+R9ds+uCp1Z71hkHSydZGYJVAG9Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781508710;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=faH40j0IkWOAv9+IWFO/9sCAAauQpXwzASwukbDY4F0=;
	b=mumvSIukDggdzYje8cYmUX/yQBIvcSdxBNy+RVc5icpotAQ4LGYt0kNeKIEgVLAr8IFG
	 5ir5A3kf7uuAKBJhpoDf8/5QfZItCZ6EZUwc0matGYW+tUBYWdfO+HsnicgFed13LHPXa
	 JMRUD1nWCIyUoF/06WGhK3WQcrgfl+AzFMYumY7hj7xh31tjKiPCpVufzaMfOhybKvyoT
	 HSqtxy7aZ+Darr1QSq0qwGg8ogpAwDoWATyPr9kPpjS+hrx8zpQUEBd04BFMv0/dfktHA
	 hTWlGr2lGNW5jOiWYJwasPgqRhEnoS+qydQ0jHbBD/Q45aamq8TxFCnvcS8IAxZ2O6w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nXRxFpXh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z4XhEnTf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nXRxFpXh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z4XhEnTf;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60A8FF800D0
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 09:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60A8FF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nXRxFpXh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z4XhEnTf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=nXRxFpXh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Z4XhEnTf
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5B375AD2;
	Mon, 15 Jun 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781508708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgMav6iO2ZIKjcIF47QRdQL7Zy1dU4Bi9B+OPFN38Sk=;
	b=nXRxFpXhg5j0FQ4lTz8KCZ1oYYooHfDKwhFfUlqHjtxWQDFiL2ycwNPmw+AcmV595yo0vd
	tvlFl93ak+u6uu8M3Pohw5VCSao8GKxUbNRushBlQtW5EGRP1d8elMbYSFdJ/QK6M4uvU1
	rAwkuCg6m/XUPxyFSKHuas5Fs9i7f4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781508708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgMav6iO2ZIKjcIF47QRdQL7Zy1dU4Bi9B+OPFN38Sk=;
	b=Z4XhEnTfinZpQjmA2/rolk83zwde1HFJriJThnuNtIheKorS4nf//JZeysv6C1+8/kgyug
	MxAR0lmqG7R4StDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1781508708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgMav6iO2ZIKjcIF47QRdQL7Zy1dU4Bi9B+OPFN38Sk=;
	b=nXRxFpXhg5j0FQ4lTz8KCZ1oYYooHfDKwhFfUlqHjtxWQDFiL2ycwNPmw+AcmV595yo0vd
	tvlFl93ak+u6uu8M3Pohw5VCSao8GKxUbNRushBlQtW5EGRP1d8elMbYSFdJ/QK6M4uvU1
	rAwkuCg6m/XUPxyFSKHuas5Fs9i7f4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781508708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgMav6iO2ZIKjcIF47QRdQL7Zy1dU4Bi9B+OPFN38Sk=;
	b=Z4XhEnTfinZpQjmA2/rolk83zwde1HFJriJThnuNtIheKorS4nf//JZeysv6C1+8/kgyug
	MxAR0lmqG7R4StDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E342779A9;
	Mon, 15 Jun 2026 07:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PCgGWSqL2qtSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Jun 2026 07:31:48 +0000
Date: Mon, 15 Jun 2026 09:31:48 +0200
Message-ID: <87mrwwmf8b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ripeer <ripeeerr@gmail.com>
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz
Subject: Re: [PATCH RFC] ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT
In-Reply-To: 
 <CANj20GgeB2y7jUrj43g1vP2_+u7awtecZCig0MxoJBJBM5=3ow@mail.gmail.com>
References: 
 <CANj20GgeB2y7jUrj43g1vP2_+u7awtecZCig0MxoJBJBM5=3ow@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: 5B4FSD42GEHZOOZ5OA2TZMZQ6IWZK7CM
X-Message-ID-Hash: 5B4FSD42GEHZOOZ5OA2TZMZQ6IWZK7CM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5B4FSD42GEHZOOZ5OA2TZMZQ6IWZK7CM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 13 Jun 2026 18:46:07 +0200,
Ripeer wrote:
> 
> 
> From: ripeeerr@gmail.com
> 
> ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT
> 
> The Lenovo Xiaoxin 14 GT (Chinese market model, AMD Ryzen AI 9 365)
> produces constant electrical hissing and crackling noise from both
> internal speakers and 3.5mm headphone jack during audio playback.
> Audio works correctly on Windows. The noise is louder than the audio
> itself and is present on all tested distributions (Arch Linux, Fedora 44,
> kernels 6.12 and 7.0-zen).
> 
> The PCI SSID 17aa:3912 is not present in the quirk list. Additionally,
> in some configurations the BIOS reports the SSID as 17aa:0000, causing
> the kernel to apply no fixup at all:
> 
>   snd_hda_codec_alc269 hdaudioC1D0: ALC287: picked fixup for PCI SSID
> 17aa:0000
> 
> Codec info (/proc/asound/card1/codec#0):
>   Codec: Realtek ALC287
>   Vendor Id: 0x10ec0287
>   Subsystem Id: 0x17aa3912
>   Revision Id: 0x100002
> 
> Audio devices:
>   c2:00.1 AMD/ATI Radeon HD Audio [1002:1640]
>   c2:00.5 AMD Audio Coprocessor [1022:15e2]
>   c2:00.6 AMD Ryzen HD Audio Controller [1022:15e3]
> 
> GPIO state (all zeros, amplifier appears uninitialized):
>   IO[0-4]: enable=0, dir=0, data=0
> 
> The proposed fixup ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN is chosen
> by analogy with neighboring Lenovo 14" AMD models (17aa:3911, 17aa:390d)
> that use the same fixup. However, this has NOT been verified by testing
> a compiled kernel — I do not currently have a working Linux installation
> on this machine. Guidance from maintainers on the correct fixup is
> very welcome.
> 
> Signed-off-by: ripeeerr@gmail.com
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/
> alc269.c
> index dcbc66984..0d8f157c9 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7774,6 +7774,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>   SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10",
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>   SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10",
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
> + SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT",
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>   SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
>   SND_PCI_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10",
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),

The code change looks OK, but the patch file isn't in an applicable
form -- likely your mailer broke the spaces and tabs.  At best, try to
submit via git-send-email.

Also, your Signed-off-by line should be properly formatted; it must be
with both your (real) name and mail address, as it's a legal
requirement.

Last but not least, please submit to linux-sound@vger.kernel.org for
the kernel patches.  alsa-devel ML is for user-space stuff.

So, please resubmit with the corrections of the above.


thanks,

Takashi
