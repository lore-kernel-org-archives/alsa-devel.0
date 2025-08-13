Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C08CA0EE0
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Aug 2025 15:45:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EECE60230;
	Wed, 13 Aug 2025 17:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EECE60230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1755099928;
	bh=DMFr7qZNG88HA+2p+BLXNrjPzdxXq4yVYSO63eN6c+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AoNauxMElgvIO8RxvOi+c/j67EzmHUUWOW6i41s7ARLJTxRFw2dW5wbwBaSXFw+6H
	 AVpVxlJV95LSCQXvr0MvhfuH1SZPT3rC8qeEQSdiDBB+7GvML2UFdPkwngGzeYY6h/
	 f+q/OnWpRUkx+lX9eBkm4MRdOd2KQj/mpzb5yCz0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A1E9F805C5; Wed, 13 Aug 2025 17:44:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6F24F805D3;
	Wed, 13 Aug 2025 17:44:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7FB7F8021D; Wed, 13 Aug 2025 17:44:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 94D51F800F3
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2025 17:44:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94D51F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=iBXbeLBq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=RlKZI+Pu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=lJ9tXTRV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tLVQQgIu
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79F5E1F456;
	Wed, 13 Aug 2025 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755099872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8Z4fiJItiCcP3TcMej2iuuTcK8fxSxhEySoeOWBwf4=;
	b=iBXbeLBqIVLpJx9g0wGZauQQd5SezuWHXrqc/tv/UwAIDx4qo+tZZYUdkjdi7/+OtQiMRs
	8VSC6zKwFvn1J7Ijk7TPUdioaEcnG+/1YCIMy/E1n7svwy1j0WJmhsaOHULQnidhN8Wc80
	j7RzO/YnxZ2rNXy/TCScjFw6KtNzaHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755099872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8Z4fiJItiCcP3TcMej2iuuTcK8fxSxhEySoeOWBwf4=;
	b=RlKZI+PufIrrmfwUkUJMMXaByVQWN3rj2uEUJd+gKi5+OscECNPwHgSZa7IIfBUojaps9r
	69xO1XRS0Zm+eGDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lJ9tXTRV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tLVQQgIu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1755099871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8Z4fiJItiCcP3TcMej2iuuTcK8fxSxhEySoeOWBwf4=;
	b=lJ9tXTRV8xX+whybyPRZc5LiiHKGEfDdjbARql6vRpBGiDm3dcr1FmJ9ev6Md0HoUlyAVK
	IVNsQzH24TPDtvZPHxzuaE9K1G6wLM1O+20P/KuGC0BoQVRx+aWc2QHlO7Ow07SWGYGgEx
	/gl/Oqy2Brp7EYsubkcyy7BEc7tj8fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755099871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8Z4fiJItiCcP3TcMej2iuuTcK8fxSxhEySoeOWBwf4=;
	b=tLVQQgIuc8xXt0VJTwH6APt++clsPB+re9KlHLqUSAtntx5lXhq9TWZ7U2gZO1yGKPG8U7
	06cAu+vKanEXcECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DAA113929;
	Wed, 13 Aug 2025 15:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EmhuDd+ynGiCBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Aug 2025 15:44:31 +0000
Date: Wed, 13 Aug 2025 17:44:30 +0200
Message-ID: <87ectfw7j5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<13916275206@139.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
In-Reply-To: <20250813100842.12224-1-baojun.xu@ti.com>
References: <20250813100842.12224-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,ti.com:email]
X-Rspamd-Queue-Id: 79F5E1F456
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: X2YRYL4WLSDKV5WFS2EPZ35GMDSW7DTU
X-Message-ID-Hash: X2YRYL4WLSDKV5WFS2EPZ35GMDSW7DTU
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X2YRYL4WLSDKV5WFS2EPZ35GMDSW7DTU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 13 Aug 2025 12:08:42 +0200,
Baojun Xu wrote:
> 
> Change the name of the kcontrol from "Gain" to "Volume".

Could you describe "why this change is needed"?


thanks,

Takashi

> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> index 92aae19cfc8f..e4bc3bc756b0 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -256,7 +256,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
>  };
>  
>  static const struct snd_kcontrol_new tas2781_snd_controls[] = {
> -	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
> +	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
>  		1, 0, 20, 0, tas2781_amp_getvol,
>  		tas2781_amp_putvol, amp_vol_tlv),
>  	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
> -- 
> 2.43.0
> 
