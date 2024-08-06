Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E673C3DA64
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:42:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4057A3404;
	Tue,  6 Aug 2024 14:42:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4057A3404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722948130;
	bh=Q5ZNqxDbR4EwDeeBN89lQiVRPFwV9vl6BCMgkOcCKMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qhiooJa0NFKGgDs2zsdPv6aCT5fKGEPn+PakocVxHHIvVuUgHQxkzsL09nVTMqkdX
	 9hhOf0aH0ps1BbYyHHeobdXZ+2Y9b4JCthjq5M9DzvjbmVHaUDytO1+MXvwmRuDjop
	 JqPqpOP2K6Kzh/kxVby8Qm81EADFGkhXT0tzP5Ys=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77FB4F805B3; Tue,  6 Aug 2024 14:41:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2645DF805B4;
	Tue,  6 Aug 2024 14:41:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8E2BF802DB; Tue,  6 Aug 2024 14:36:07 +0200 (CEST)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7A6FF80236
	for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2024 14:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7A6FF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=4m0tszts;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=wotMqU59
Date: Tue, 6 Aug 2024 14:36:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722947761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxRFPMssv0TbntD/eFDfQJABume4sd1MP+ymuPVXIMs=;
	b=4m0tsztsBPr+9mmrcnWxq/lZkoO8odl8CGs6qI25Z1zRNYgQoKXKr4ZaByl6dBrVhFzByu
	kzA5HK8d9DMIOtsKiVlrdcZO/8QWXdrbbKjYqqjOsCLbqdNa4KaD0fVY+45JiomSwJkueT
	z9cNVR8YYFIPCX1QATrLaeyWFJ920wDF1X1U4QwsyNd4TId6eOQmDrskXmTeAmvKoNmWid
	TY0AUs52gyd4bOmrCTMoq51FigtT2MDE9a8lE3nvlgfC/jvuMrcjP90VKpB1FGP4EiPciB
	N3LbMvHa0DE1NrFVpp5vB2n9BHncTWQsw7Vj5ajqlMt7L/jfM8dkyCyNtgwDEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722947761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxRFPMssv0TbntD/eFDfQJABume4sd1MP+ymuPVXIMs=;
	b=wotMqU59S88oaztq3MncD0BL4YuXzvYzxYh4qAO3DGWbQurB/e6HrSu55TBnCKXPBZA7aM
	OlapAP5nRhxhSTDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-ID: <20240806123600.uI5LeCdp@linutronix.de>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240806102707.3825703-1-jbrunet@baylibre.com>
Message-ID-Hash: 66BYAAW6MQQLN2DJWNP2275TEYWLAQOQ
X-Message-ID-Hash: 66BYAAW6MQQLN2DJWNP2275TEYWLAQOQ
X-MailFrom: bigeasy@linutronix.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66BYAAW6MQQLN2DJWNP2275TEYWLAQOQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2024-08-06 12:27:03 [+0200], Jerome Brunet wrote:
> With PREEMPT_RT enabled, spinlocks become preemptible.
With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.

> This is usually not a problem with spinlocks used in IRQ context since
> IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
> of a threaded irq handler won't be threaded and this causes scheduling
> problems if spinlocks are used in the upper half, like with regmap when
> '.fast_io' is set.

=E2=80=A6 However, if IRQF_ONESHOT is set, the primary handler won't be
force-threaded and runs always in hardirq context. This is a problem
because spinlock_t requires a preemptible context on PREEMPT_RT.=20

> In this particular instance, it is actually better to do everything in
> the bottom half and it solves the problem with PREEMPT_RT.

      threaded handler

The term "bottom half" is usually used with softirq. The IRQ part has a
primary handler and a threaded handler.

> Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-av=
krasnov@salutedevices.com
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check pe=
riods")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  sound/soc/meson/axg-fifo.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 7e6090af720b..d0d05fa44d66 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -251,8 +244,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *compo=
nent,
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
> -				   axg_fifo_pcm_irq_block_thread,
> +	/* Use the bottom half of a threaded irq with non-atomic links */

This requests only a threaded handler. There is no "bottom half of a
threaded IRQ".

> +	ret =3D request_threaded_irq(fifo->irq, NULL,
> +				   axg_fifo_pcm_irq_block,
>  				   IRQF_ONESHOT, dev_name(dev), ss);
>  	if (ret)
>  		return ret;

Sebastian
