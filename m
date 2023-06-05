Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F86C77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 07:19:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9118B825;
	Mon,  5 Jun 2023 09:18:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9118B825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685949565;
	bh=QAHcC+rrI5/b9EwKcubvDaiuGyz0clUDKhXKauXuckg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X9dTaxohoqGciQuZlx47MzBdUCjuD0AQeNXKSiwVL3X44VaYUawcaoP0fC+9uw4+e
	 B6Nl4RFNVCFGd4qjz03NnVIiUQgARljvZ2Fy4JKQ8vs/YkWqeLGAuuXR/hE68OVyj5
	 QDk1shGxSo073X475DpFlZ+YjC8QScLVcQqR9/TY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD50CF80290; Mon,  5 Jun 2023 09:18:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C46FF80254;
	Mon,  5 Jun 2023 09:18:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5902FF800ED; Mon,  5 Jun 2023 09:16:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03C81F800ED
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 09:16:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03C81F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hbrZ7RHt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Pw4S27pJ
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADBEC21B1F;
	Mon,  5 Jun 2023 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1685949364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvobikAyYLd5tNbqhgR0HiS99+mLLI7sqkpLdjdt9Xg=;
	b=hbrZ7RHtTFh3lFSwfJewIoVWFCNd9Px6YYoyfhk7e/uh9RWcNA/giRTxp9+hQPPd75w85v
	1DPwh8BysAYVNAay9JCa0zpKgcM443KdZ6Ok/xg8jqV4a1Pn8+srPcKITlOGnMatARggA1
	9anQs9brs8F5xPY83o5oIRM3YboqzXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685949364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvobikAyYLd5tNbqhgR0HiS99+mLLI7sqkpLdjdt9Xg=;
	b=Pw4S27pJNwrpqHa1bM5XY4yVGTEztYBGKUXEq/wFpQjP9Sjzr+7hb0QVLaTIe330wmNr0Y
	zUSYVvThQZsLx6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CABD139C7;
	Mon,  5 Jun 2023 07:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GzdUHbSLfWRcZgAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 05 Jun 2023 07:16:04 +0000
Date: Mon, 05 Jun 2023 09:16:04 +0200
Message-ID: <871qiqjs5n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/1] selftests: alsa: pcm-test: Fix compiler warnings
 about the format
In-Reply-To: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
References: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YBFG2F64H6GPXTCRMY4NAPI22KBFFVTW
X-Message-ID-Hash: YBFG2F64H6GPXTCRMY4NAPI22KBFFVTW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YBFG2F64H6GPXTCRMY4NAPI22KBFFVTW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 24 May 2023 21:15:29 +0200,
Mirsad Goran Todorovac wrote:
> 
> GCC 11.3.0 issues warnings in this module about wrong sizes of format
> specifiers:
> 
> pcm-test.c: In function ¡test_pcm_time¢:
> pcm-test.c:384:68: warning: format ¡%ld¢ expects argument of type ¡long int¢, but argument 5 \
> 				has type ¡unsigned int¢ [-Wformat=]
>   384 |                 snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
> pcm-test.c:455:53: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 4 has \
> 				type ¡long int¢ [-Wformat=]
>   455 |                                          "expected %d, wrote %li", rate, frames);
> pcm-test.c:462:53: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 4 has \
> 				type ¡long int¢ [-Wformat=]
>   462 |                                          "expected %d, wrote %li", rate, frames);
> pcm-test.c:467:53: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 4 has \
> 				type ¡long int¢ [-Wformat=]
>   467 |                                          "expected %d, wrote %li", rate, frames);
> 
> Simple fix according to compiler's suggestion removed the warnings.
> 
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Applied now.  Thanks.


Takashi
