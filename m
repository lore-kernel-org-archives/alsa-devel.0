Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB4CC44501
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:52:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AD6C601F6;
	Wed, 15 Jul 2026 16:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AD6C601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784127165;
	bh=lMZewwveleRMMmeDifVBH2enKOpJQHeyT+4HoGX2/Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=USg9XXQyNuEeG8CjIQ37JVVSWgkVHNbNlSGJA6f7CwcJPbAP8vrkst+26OqXln2Cx
	 RcipwUUzETQR0cbNU7JqDBYjv5WTn9sqE0FOlc+LvaRwe62vnzMJsUYf++htoeRwan
	 06ssAQvtu66d7GdsYCoSu60ZnD4ABX1BlJCoCnBk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1870F805FF; Wed, 15 Jul 2026 16:52:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E974F805F0;
	Wed, 15 Jul 2026 16:52:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B45F7F8057F; Wed, 15 Jul 2026 16:52:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784127121;
	b=JCB93OQqwy08e0N63F1AUDDwOETX4kkTgBrqOWUtJ9I040/qNiacpQm4w54usLQuJIza
	 WGGFDcaCwZDTdklWR8lQSJsvGFA5gWQ8alwjFWsc5N8TTLmJffuCqFTkcCPUAH6kRR9di
	 IFoXCOZaLzoeWu6v3S6RHJfibpEgPpeMdmTJv/rYQJfyKTYswyrgBWFMeOItCI12i4LpE
	 CmsnfzYKDypYeSbwgLn32n6CcMcsctGPw4Pc2S8sgq/v+O+kVQmps0F/I+Sweao/ETpiY
	 9cZEu09vW1vQX3CWpcQu2Jaic1TQ027Lb9F8q7RZ7IP6lJmQs8DLeREfLMJNqiIA3Bw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784127121;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=lMZewwveleRMMmeDifVBH2enKOpJQHeyT+4HoGX2/Yo=;
	b=LbyUu1Kj6nLI3qWOy9bjkxh6XhluXKvbIOs5Y57SEwq98YW6GB5XFmeypKTTk/8+/TSe
	 FbEsdwChND+XR8ha9YFCyV9EHcSLj0BiQWPw48u2+HkLSs/wltcKzGj8FTPuMgJnUHm2j
	 ULLxqTrl8WB9W0gkinZSPqTanHzWXtHutv3vkAlOHkndjzUnHwhVeKA2rxqlTHPRwP1Sm
	 tPXtn5W4IR4OJzu3jPs/wZobJTO8P8tfxKUedm/ND2OGAOMsW3obHITUm6N/MlChT0w+A
	 zKkzIZcnrMVq+m14UZMtbmDR4xpzQVoy5IfW9X44Df0eb++qQWOxd1CDvMZxY27/D3w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xWTDFANO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jfI6OlqM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xWTDFANO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jfI6OlqM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48E80F800B5
	for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2026 16:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48E80F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xWTDFANO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jfI6OlqM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xWTDFANO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jfI6OlqM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC883E2A;
	Wed, 15 Jul 2026 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784127119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPUo0iJlK2XehVHswpj14nUnaGvvy9s1U1L+9nCAvgY=;
	b=xWTDFANOcIlNgzpdwe9gM5HQs1iP6hVact5QHZmqDVNqJjHzvahcJaY2j4Fcjh9lzSbqTr
	dCT+vQQU791ZccJK0CjveNCW0fnw4KxgIM56emkXNDf9o5WJTgXeTecDhuTfc3Puyi8sH5
	Pw/rtx2hrqO7IsIr+q6SFtDYGO+4M74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784127119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPUo0iJlK2XehVHswpj14nUnaGvvy9s1U1L+9nCAvgY=;
	b=jfI6OlqMOMQEykSqvQyZO08fl4MucOB3UxlPO/Vn5eFxn/Fu/BbG7iiLlDkR8bnPBX7xuB
	MHWsWm0MEQryjVAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xWTDFANO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jfI6OlqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1784127119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPUo0iJlK2XehVHswpj14nUnaGvvy9s1U1L+9nCAvgY=;
	b=xWTDFANOcIlNgzpdwe9gM5HQs1iP6hVact5QHZmqDVNqJjHzvahcJaY2j4Fcjh9lzSbqTr
	dCT+vQQU791ZccJK0CjveNCW0fnw4KxgIM56emkXNDf9o5WJTgXeTecDhuTfc3Puyi8sH5
	Pw/rtx2hrqO7IsIr+q6SFtDYGO+4M74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784127119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPUo0iJlK2XehVHswpj14nUnaGvvy9s1U1L+9nCAvgY=;
	b=jfI6OlqMOMQEykSqvQyZO08fl4MucOB3UxlPO/Vn5eFxn/Fu/BbG7iiLlDkR8bnPBX7xuB
	MHWsWm0MEQryjVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDCB0779AD;
	Wed, 15 Jul 2026 14:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rxHQOI6eV2r+ZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 Jul 2026 14:51:58 +0000
Date: Wed, 15 Jul 2026 16:51:58 +0200
Message-ID: <87mrvswbjl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v5 2/2] ALSA: control: add ioctl to retrieve full card
 components
In-Reply-To: <20260706141457.51736-2-mstrozek@opensource.cirrus.com>
References: <20260706141457.51736-1-mstrozek@opensource.cirrus.com>
	<20260706141457.51736-2-mstrozek@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2CC883E2A
Message-ID-Hash: RMXL24LDWRVRMUFHKB4CTLV2MZW5KCJX
X-Message-ID-Hash: RMXL24LDWRVRMUFHKB4CTLV2MZW5KCJX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RMXL24LDWRVRMUFHKB4CTLV2MZW5KCJX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Jul 2026 16:14:57 +0200,
Maciej Strozek wrote:
> 
> The fixed-size components field in SNDRV_CTL_IOCTL_CARD_INFO can be too
> small on systems with many audio devices.
> 
> Keep the existing struct snd_ctl_card_info ABI intact and add a new
> ioctl SNDRV_CTL_IOCTL_CARD_BYTES that carries a variable-length payload
> selected by a type discriminator. The first defined type
> SND_CTL_CARD_BTYPE_COMPONENTS returns the full components string. The
> ioctl is designed to be reused for other variable-length card payloads
> in the future.
> 
> The user-space caller may set data_allocated == 0 (or data == NULL) to
> query the required length; otherwise the kernel copies the payload into
> the user buffer and writes back the actual length in data_len.
> 
> When the legacy components field in struct snd_ctl_card_info is
> truncated, '>' is written just before the NUL terminator to signal to
> user-space that the full string is available via the new ioctl.
> 
> card->components is now dynamically allocated and grown in 32 byte
> increments via krealloc(), capped at 512 bytes.
> 
> Link: https://github.com/alsa-project/alsa-lib/pull/494
> Suggested-by: Jaroslav Kysela <perex@perex.cz>
> Suggested-by: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
> Changes for v5:
>  - use __u64 and u64_to_user_ptr() instead of 32bit compat layer
>  - handle a NULL card->components
> Changes for v4:
>  - replaced snd_ctl_card_components with snd_ctl_card_bytes for possible
>    future extensions
>  - support query mode (data_allocated == 0 or data == NULL)
>  - added compat 32-bit
>  - renamed card->components_ptr / components_ptr_alloc_size to
>    card->components / components_alloc_size
> Changes for v3:
>  - change components field to a dynamic array resizable in 32 byte
>    increments
>  - removed SNDRV_CTL_COMPONENTS_LEN define
>  - sanity check if 'components' requests more than 512 bytes
>  - added a commit to clean up trailing whitespaces
>  - alsa-utils link no longer needed
> Changes for v2:
>  - do not modify existing card->components field
>  - add a new ioctl and struct to keep the full components string
>  - handle the split/trim in snd_ctl_card_info()
> ---
>  include/sound/core.h        |  4 +--
>  include/uapi/sound/asound.h | 22 ++++++++++++-
>  sound/core/control.c        | 62 ++++++++++++++++++++++++++++++++++++-
>  sound/core/control_compat.c |  1 +
>  sound/core/init.c           | 34 +++++++++++++++++---
>  5 files changed, 114 insertions(+), 9 deletions(-)
> 
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 404785b7d885..2ca24ac7e37f 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -108,8 +108,8 @@ struct snd_card {
>  	char longname[80];		/* name of this soundcard */
>  	char irq_descr[32];		/* Interrupt description */
>  	char mixername[80];		/* mixer name */
> -	char components[128];		/* card components delimited with
> -								space */
> +	char *components;		/* card components, space-delimited */
> +	unsigned int components_alloc_size;	/* current allocation size of components */
>  	struct module *module;		/* top-level module */
>  
>  	void *private_data;		/* private data for soundcard */
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index d3ce75ba938a..500599213f93 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -1058,7 +1058,7 @@ struct snd_timer_tread {
>   *                                                                          *
>   ****************************************************************************/
>  
> -#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
> +#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
>  
>  struct snd_ctl_card_info {
>  	int card;			/* card number */
> @@ -1072,6 +1072,25 @@ struct snd_ctl_card_info {
>  	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
>  };
>  
> +/*
> + * Card components can exceed the fixed 128 bytes in snd_ctl_card_info.
> + * Use SNDRV_CTL_IOCTL_CARD_BYTES with type SND_CTL_CARD_BTYPE_COMPONENTS
> + * to retrieve the full string.
> + */
> +
> +/* Type values for struct snd_ctl_card_bytes::type */
> +enum {
> +	SND_CTL_CARD_BTYPE_COMPONENTS	= 1,	/* full card components string */
> +};
> +
> +struct snd_ctl_card_bytes {
> +	__u32 type;				/* SND_CTL_CARD_BTYPE_* */
> +	__u32 data_allocated;	/* size of @data buffer in bytes */
> +	__u32 data_len;			/* in/out: actual data length in bytes */
> +	__u32 reserved;			/* explicit pad */
> +	__u64 data;				/* user buffer (pointer stored as __u64) */
> +};
> +
>  typedef int __bitwise snd_ctl_elem_type_t;
>  #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
>  #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
> @@ -1198,6 +1217,7 @@ struct snd_ctl_tlv {
>  
>  #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
>  #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
> +#define SNDRV_CTL_IOCTL_CARD_BYTES	_IOWR('U', 0x02, struct snd_ctl_card_bytes)
>  #define SNDRV_CTL_IOCTL_ELEM_LIST	_IOWR('U', 0x10, struct snd_ctl_elem_list)
>  #define SNDRV_CTL_IOCTL_ELEM_INFO	_IOWR('U', 0x11, struct snd_ctl_elem_info)
>  #define SNDRV_CTL_IOCTL_ELEM_READ	_IOWR('U', 0x12, struct snd_ctl_elem_value)
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 7a8dc506221e..5e9f68c96f4b 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -876,23 +876,81 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
>  {
>  	struct snd_ctl_card_info *info __free(kfree) =
>  		kzalloc(sizeof(*info), GFP_KERNEL);
> +	ssize_t n;
>  
>  	if (! info)
>  		return -ENOMEM;
> +
> +	static_assert(sizeof(info->components) >= 2);
> +
>  	scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
> +		const char *components = card->components;
> +
> +		if (!components)
> +			components = "";
> +
>  		info->card = card->number;
>  		strscpy(info->id, card->id, sizeof(info->id));
>  		strscpy(info->driver, card->driver, sizeof(info->driver));
>  		strscpy(info->name, card->shortname, sizeof(info->name));
>  		strscpy(info->longname, card->longname, sizeof(info->longname));
>  		strscpy(info->mixername, card->mixername, sizeof(info->mixername));
> -		strscpy(info->components, card->components, sizeof(info->components));
> +		n = strscpy(info->components, components, sizeof(info->components));
> +		if (n < 0) // mark the truncation with '>' before NULL terminator
> +			info->components[sizeof(info->components) - 2] = '>';
>  	}
>  	if (copy_to_user(arg, info, sizeof(struct snd_ctl_card_info)))
>  		return -EFAULT;
>  	return 0;
>  }
>  
> +static int snd_ctl_card_bytes(struct snd_card *card,
> +			      struct snd_ctl_card_bytes *info,
> +			      unsigned int __user *data_len_out)
> +{
> +	unsigned int data_len;
> +
> +	switch (info->type) {
> +	case SND_CTL_CARD_BTYPE_COMPONENTS:
> +		scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
> +			const char *components = card->components;
> +
> +			if (!components)
> +				components = "";
> +
> +			data_len = strlen(components) + 1;
> +
> +			if (!info->data || info->data_allocated == 0)
> +				break;
> +
> +			if (info->data_allocated < data_len)
> +				return -ENOMEM;
> +
> +			if (copy_to_user(u64_to_user_ptr(info->data), components, data_len))
> +				return -EFAULT;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (put_user(data_len, data_len_out))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int snd_ctl_card_bytes_user(struct snd_card *card,
> +				   struct snd_ctl_card_bytes __user *_info)
> +{
> +	struct snd_ctl_card_bytes info;
> +
> +	if (copy_from_user(&info, _info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return snd_ctl_card_bytes(card, &info, &_info->data_len);
> +}
> +
>  static int snd_ctl_elem_list(struct snd_card *card,
>  			     struct snd_ctl_elem_list *list)
>  {
> @@ -1990,6 +2048,8 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  		return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
>  	case SNDRV_CTL_IOCTL_CARD_INFO:
>  		return snd_ctl_card_info(card, ctl, cmd, argp);
> +	case SNDRV_CTL_IOCTL_CARD_BYTES:
> +		return snd_ctl_card_bytes_user(card, argp);
>  	case SNDRV_CTL_IOCTL_ELEM_LIST:
>  		return snd_ctl_elem_list_user(card, argp);
>  	case SNDRV_CTL_IOCTL_ELEM_INFO:
> diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
> index 4ad571087ff5..f14d9f5e94be 100644
> --- a/sound/core/control_compat.c
> +++ b/sound/core/control_compat.c
> @@ -446,6 +446,7 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
>  	switch (cmd) {
>  	case SNDRV_CTL_IOCTL_PVERSION:
>  	case SNDRV_CTL_IOCTL_CARD_INFO:
> +	case SNDRV_CTL_IOCTL_CARD_BYTES:
>  	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
>  	case SNDRV_CTL_IOCTL_POWER:
>  	case SNDRV_CTL_IOCTL_POWER_STATE:
> diff --git a/sound/core/init.c b/sound/core/init.c
> index 1ff340ee6884..15a8209469c7 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -590,6 +590,9 @@ static int snd_card_do_free(struct snd_card *card)
>  		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
>  #endif
>  	snd_device_free_all(card);
> +	kfree(card->components);
> +	card->components = NULL;
> +	card->components_alloc_size = 0;
>  	if (card->private_free)
>  		card->private_free(card);
>  #ifdef CONFIG_SND_CTL_DEBUG
> @@ -1036,16 +1039,37 @@ int snd_component_add(struct snd_card *card, const char *component)
>  {
>  	char *ptr;
>  	int len = strlen(component);
> +	unsigned int cur_len, need_len;
>  
> -	ptr = strstr(card->components, component);
> -	if (ptr != NULL) {
> -		if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
> -			return 1;
> +	if (card->components) {
> +		ptr = strstr(card->components, component);
> +		if (ptr) {
> +			if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
> +				return 1;
> +		}
> +		cur_len = strlen(card->components) + 1;
> +	} else {
> +		cur_len = 0;
>  	}
> -	if (strlen(card->components) + 1 + len + 1 > sizeof(card->components)) {
> +
> +	need_len = cur_len + len + 1;
> +	if (need_len > 512) {
>  		snd_BUG();
>  		return -ENOMEM;
>  	}
> +
> +	if (need_len > card->components_alloc_size) {
> +		unsigned int new_alloc = roundup(need_len, 32);
> +
> +		ptr = krealloc(card->components, new_alloc, GFP_KERNEL);
> +		if (!ptr)
> +			return -ENOMEM;
> +		if (!card->components)
> +			ptr[0] = '\0';
> +		card->components = ptr;
> +		card->components_alloc_size = new_alloc;
> +	}
> +
>  	if (card->components[0] != '\0')
>  		strcat(card->components, " ");
>  	strcat(card->components, component);

I believe we need to protect snd_component_add() against the racy
ioctl?  Otherwise the existing guard in your patch makes no sense.


thanks,

Takashi

