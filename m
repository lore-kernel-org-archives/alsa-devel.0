Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE33C04AA9
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Sep 2023 15:47:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 334B4823;
	Wed, 20 Sep 2023 17:46:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 334B4823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695224845;
	bh=n35pt4I8RCP5QS6Z3/Tdg4gxlvE6ZhXpSoyCS5V1gfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gZLLt44LIBHZjDYMvWMjEUu66jy8kCRYmb+wP0j67V0Slb/6zQWL0mFndk1dE5i1L
	 /6NPAHemlQRilhnLJToh8xWFDWVQYo0X5tKZ8lfjKvIrfHpauIDONRJlcCdc97UBRG
	 BDMuUPebU9dci3G6KnnCJ9mC7uPDkIiweJWfsk78=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBE68F80558; Wed, 20 Sep 2023 17:45:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A81BF8025A;
	Wed, 20 Sep 2023 17:45:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C61D4F8025A; Wed, 20 Sep 2023 17:45:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D285CF800AA
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 17:45:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D285CF800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TJ9SSn8v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wLwpOj8V
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BB5122043;
	Wed, 20 Sep 2023 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1695224749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jT8POAt+6a+cyjo2/WeyeI4/wNaD3Ch0j26LYY819mk=;
	b=TJ9SSn8vujr8m77E4OuabEEKVgvsPZDNotcQSXeftPSM9+XgXq0XTWd6oQUp26cx2HUc8K
	VJK4gMUdxTrWHLzPwBMEEwSslWYZ7CsrZfOIWwHHk09U5j9EEURc6GgfyTVh638C4fFcG+
	jsagTn2vTcWKB1CYPEmtmSGzdJL+U1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695224749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jT8POAt+6a+cyjo2/WeyeI4/wNaD3Ch0j26LYY819mk=;
	b=wLwpOj8Vb+JFA5RHup2roNKkyLwOl9ooc22go3ym3s8PWDgXJPS8CkMnjaf5ZhZKVQksIq
	RB6cwzuoAZMF4+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4441D132C7;
	Wed, 20 Sep 2023 15:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id txK3D60TC2WNTwAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 20 Sep 2023 15:45:49 +0000
Date: Wed, 20 Sep 2023 17:45:48 +0200
Message-ID: <87fs38voer.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	tiwai@suse.com,
	llvm@lists.linux.dev,
	alsa-devel@alsa-project.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of
 COUNT_ARGS()
In-Reply-To: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: X6VLOQGNKKD4PMRFPY7JR2Y2RDGBCH2I
X-Message-ID-Hash: X6VLOQGNKKD4PMRFPY7JR2Y2RDGBCH2I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X6VLOQGNKKD4PMRFPY7JR2Y2RDGBCH2I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 20 Sep 2023 17:38:19 +0200,
Andy Shevchenko wrote:
> 
> Replace custom and non-portable implementation of COUNT_ARGS().
> 
> Fixes: e64b674bc9d7 ("software node: implement reference properties")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 1684fca930f7..55c2692ffa8c 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -10,6 +10,7 @@
>  #ifndef _LINUX_PROPERTY_H_
>  #define _LINUX_PROPERTY_H_
>  
> +#include <linux/args.h>
>  #include <linux/bits.h>
>  #include <linux/fwnode.h>
>  #include <linux/stddef.h>
> @@ -314,7 +315,7 @@ struct software_node_ref_args {
>  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
>  (const struct software_node_ref_args) {				\
>  	.node = _ref_,						\
> -	.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
> +	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }
>  

Reviewed-by: Takashi Iwai <tiwai@suse.de>

NR_FWNODE_REFERENCE_ARGS is 8, so the COUNT_ARGS() macro should
suffice.


thanks,

Takashi
