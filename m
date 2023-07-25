Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51600C001DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 06:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2625EAF;
	Tue, 25 Jul 2023 08:57:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2625EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690268312;
	bh=ZOWvNA0RUEm4A2QLxn+Mk8r05tkv6yHwarXm4mOtvyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BqrzLtgCecVK5/OgBT+bW8kgeFveE/ILZ3eZ4eMQPUsigr0Y6Ps7DRiWygW89tM8U
	 tw+bqTfHxHIenEL+ckW3/PEHljD9XAFUcid55qHM4M6CEJnYWd94kdltrvXK6f6RCk
	 zgYxhOqUByoOvi/Jf7q6a2vOpfPpGAysqu95dcVg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CC69F80163; Tue, 25 Jul 2023 08:57:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49021F800C7;
	Tue, 25 Jul 2023 08:57:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB8A4F8019B; Tue, 25 Jul 2023 08:57:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7CBE5F800C7
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 08:57:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CBE5F800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=0zxnnVkq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jGs9ToYV
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16A77218A2;
	Tue, 25 Jul 2023 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1690268255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Oi3czKnpvE6a+3o5E+2OD3NX8ZHwPHEeEjkU+816sI=;
	b=0zxnnVkqjhYogR+gSX8ALAzMUJOePN8qiWPDDTsnTWm/yobi1+3EfgQcJPR/00OSQE3cns
	lovd+FP4k4hD5UunNTWUeUimHGaaPPsjm2QqNe1ITsTrY8NCMTzqcg/pXDEM0WEBjABovF
	hvsNvTBNDqkuhFP0aVEMpfGAfGZ65dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690268255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Oi3czKnpvE6a+3o5E+2OD3NX8ZHwPHEeEjkU+816sI=;
	b=jGs9ToYVVp0Pnq39eX42g+FlWEbZnjh5urcI3qMPD09lMmi+Ywi9lpeBohzDI/SDbw6+Ym
	zyLzL4gbUmK1P5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8278713487;
	Tue, 25 Jul 2023 06:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7VDhHl5yv2R1BgAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:57:34 +0000
Date: Tue, 25 Jul 2023 08:57:34 +0200
Message-ID: <87cz0gv5pd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <agross@kernel.org>,
	<andersson@kernel.org>,
	<robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>,
	<catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mathias.nyman@intel.com>,
	<gregkh@linuxfoundation.org>,
	<lgirdwood@gmail.com>,
	<broonie@kernel.org>,
	<perex@perex.cz>,
	<tiwai@suse.com>,
	<srinivas.kandagatla@linaro.org>,
	<bgoswami@quicinc.com>,
	<Thinh.Nguyen@synopsys.com>,
	<linux-arm-msm@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-usb@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<quic_jackp@quicinc.com>,
	<pierre-louis.bossart@linux.intel.com>,
	<oneukum@suse.com>,
	<albertccwang@google.com>,
	<o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4 19/32] sound: usb: card: Check for support for
 requested audio format
In-Reply-To: <20230725023416.11205-20-quic_wcheng@quicinc.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
	<20230725023416.11205-20-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: 3HBGTKPYKQEWDN2MYESZNDX4V6GQXXXE
X-Message-ID-Hash: 3HBGTKPYKQEWDN2MYESZNDX4V6GQXXXE
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3HBGTKPYKQEWDN2MYESZNDX4V6GQXXXE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 25 Jul 2023 04:34:03 +0200,
Wesley Cheng wrote:
> 
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support for when playback is
> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 28 ++++++++++++++++++++++++++++
>  sound/usb/card.h |  8 ++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index a3fad66a3337..365f6d978608 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -142,6 +142,34 @@ int snd_usb_unregister_platform_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>  
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{

Please add a comment what this function does.


> +	struct snd_usb_audio *chip = usb_chip[card_idx];

Is the dereference safe without locking?
If the call is supposed to be allowed only in a safe situation, it
should be mentioned in the function description.


thanks,

Takashi
