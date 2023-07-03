Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24713C001B0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jul 2023 12:08:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F40C97F1;
	Mon,  3 Jul 2023 14:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F40C97F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688386121;
	bh=5s084Wm3myEdvBasrFfOD1EPvksZbpy3BnPoV3MzglE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VUEoGH1tjG9RXG68TdTAwTOVIA8SJivPbf/8jRP/dmPRm6bbe9aWlFgx7VZGAgXaU
	 1eW2P9IxPKdRuBLz0Tjq9DO5YdhI8hC3DIKtRWAZuQw4GWnFgivDTNEg0/B4Tj5fCm
	 +ZQN7f1zQlfK+h0LFtYxnPq6u5/YONIoDTUdpyXM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E72D7F80125; Mon,  3 Jul 2023 14:07:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 654EFF80125;
	Mon,  3 Jul 2023 14:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF5C5F80125; Mon,  3 Jul 2023 14:07:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2DA27F80093
	for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2023 14:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DA27F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=MSnaBW3t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=TZv7uZB7
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95C3C1FDE6;
	Mon,  3 Jul 2023 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1688386031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xjo1FzDRtH38qpOa18b49WUf8o6xwwrYzgUyVPfI1Ug=;
	b=MSnaBW3tWbGFZz0kcWdaRRAiONNZgHvwQojeS7yZpiQGkqQMfUnzxPT5byVWm+RlHlGYNG
	27LJ6jwAnZdCubsGtE+nv2QAgfOFyOjTouOKkc3jLboxCMi7lJ8aiv54w0vwuQZnwbDdk5
	IGosnrq/0XU+lucTojpkNCDMmEhlUDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688386031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xjo1FzDRtH38qpOa18b49WUf8o6xwwrYzgUyVPfI1Ug=;
	b=TZv7uZB7blqPoGJ1mqJ4gqnOKCajEF/BrJ41pDEkVx0xgIHod0Q3IaQZlHnu2OVPxP+N/2
	uglZjjj8g9VBXOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AAB513276;
	Mon,  3 Jul 2023 12:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0ml3Ae+5omT4agAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 03 Jul 2023 12:07:11 +0000
Date: Mon, 03 Jul 2023 14:07:10 +0200
Message-ID: <87h6ql5hch.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	hverkuil@xs4all.nl,
	Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
In-Reply-To: 
 <CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
	<1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
	<ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
	<CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MDVDNKDI2ACJGHHK6NVM646EWD3ARTQ4
X-Message-ID-Hash: MDVDNKDI2ACJGHHK6NVM646EWD3ARTQ4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MDVDNKDI2ACJGHHK6NVM646EWD3ARTQ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 03 Jul 2023 11:54:22 +0200,
Shengjiu Wang wrote:
> 
> 
> Hi Sakari
> 
> On Fri, Jun 30, 2023 at 6:05 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
> 
>     Hi Shengjiu,
>    
>     On Thu, Jun 29, 2023 at 09:37:48AM +0800, Shengjiu Wang wrote:
>     > Audio signal processing has the requirement for memory to
>     > memory similar as Video.
>     >
>     > This patch is to add this support in v4l2 framework, defined
>     > new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
>     > V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
>     > for audio case usage.
>    
>     Why are you proposing to add this to V4L2 framework instead of doing this
>     within ALSA?
>    
>     Also cc Hans and Jacopo.
> 
> There is no such memory to memory interface defined in ALSA.  Seems
> ALSA is not designed for M2M cases.

There is no restriction to implement memory-to-memory capture in ALSA
framework.  It'd be a matter of the setup of PCM capture source, and
you can create a corresponding kcontrol element to switch the mode or
assign a dedicated PCM substream, for example.  It's just that there
was little demand for that.

I'm not much against adding the audio capture feature to V4L2,
though, if it really makes sense.  But creating a crafted /dev/audio*
doesn't look like a great idea to me, at least.


thanks,

Takashi
