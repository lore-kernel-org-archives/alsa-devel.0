Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4883C2BB85
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:01:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42859206A2
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LB00Kw94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNuMkIEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42859206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E9A86E;
	Tue, 14 Apr 2020 21:00:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E9A86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586890898;
	bh=vku39TN+p8W1cXG35tH9xBj8XE2RMoUOgq+LnuxWOGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LB00Kw94v5pPtuLsYUfX2OFNMNLzFmr4sg21fbSs1QZ1VsbDrn05sHhhOMlpIJuz5
	 pyXxIlPvCm+HMCsFK6tLSpkNWN7/+UQKc+jkFhw8zHGtt0AkoqN4nHJMQC+f/OgLoS
	 Yhy2mr4T/5/C0TN/pp78PI6cyLNuww8ySvoyD0LA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D571AF80126;
	Tue, 14 Apr 2020 21:00:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08812F8013D; Tue, 14 Apr 2020 21:00:46 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DED5F800F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 21:00:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DED5F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rNuMkIEs"
Received: by mail-lf1-x142.google.com with SMTP id w145so659082lff.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vku39TN+p8W1cXG35tH9xBj8XE2RMoUOgq+LnuxWOGc=;
 b=rNuMkIEsC4qajqgUvs5Frlpje0uAD8GkEIHjosF8sq4n2OnrChikeB3fsuKOG/rJ4c
 Nrh91u1nEqfMxgdrdcAWV5KajTRPvwtWqmE8bJzF64ae2pQ+K1BhO26kpsDVnzADehle
 1CC5HospidLMjwvkQtWJSIz549zH7abBvoN6b5IhUhprAO/jxWY21CPTVoE6i6aAt9gS
 weVY1qSTM5VyQ4VZ8erSp44DI0ua/5QaKEwP9drIaN0jD14Di3Mm2EKs9f5z7+E85uqg
 y4GwqN9XehWXO68+Apz4MHkes+pyxB4zi4sDjCimCBCiluKdBUdoWL2w4WJPQULWrqci
 w4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vku39TN+p8W1cXG35tH9xBj8XE2RMoUOgq+LnuxWOGc=;
 b=ou05y49JRefjcHxD5BSdIgGEG8D3KJC7dvYjRyzzP+gzKT9LwlKgVhDwbB+24n2y7n
 gO5ktP3TVv0B4coDfcVNPrvyLLHLNwhPC+Ba8D1HaXKuzuRl5LCHku3886T/DPmFuYeI
 dhkmJuxUPjeGPscfxgsTgEhWffSlwlyk3pW4b1+PFxqZRctqmmPlNICgJHo9Jf5Y54HE
 KtWHpkj9ZdFU8ZNjQPiJZPMHTedpDUAFK3w6xpFR2Y8oRQdoudxUISyWyiLEZhsstw+P
 IfLJ9d/6R07K/oyqFP9A+E4cH7pZEyqBF21kdcafp9UMXh62MbPV3EFOnsCLIY9Xj0Il
 G0+g==
X-Gm-Message-State: AGi0PuYdGzltC+6jSMGz1/tU0StjEiz06PPFwli34UFgR+dtdlXr8ddr
 ujocBTzGhynI94VCUJXbsEF07N3uuiRvb3VHtQo=
X-Google-Smtp-Source: APiQypJghBXx+OqXpdcaUnjKNCywSLM1ufuFhoEC2HYC+rFBDg+uV3fLp3aPSO0JR3plIeP29EYSKJaWLGUDK93YN3g=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr701931lfo.69.1586890841018;
 Tue, 14 Apr 2020 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414181140.145825-1-sebastian.reichel@collabora.com>
In-Reply-To: <20200414181140.145825-1-sebastian.reichel@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 14 Apr 2020 16:01:10 -0300
Message-ID: <CAOMZO5C5CVz=2gUm70ewt=etpW8yUp+OLQ7qKWOt-_+OCPRmuQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG power-on handling
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Sebastian,

On Tue, Apr 14, 2020 at 3:11 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> As mentioned slightly out of patch context in the code, there
> is no reset routine for the chip. On boards where the chip is
> supplied by a fixed regulator, it might not even be resetted
> during (e.g. watchdog) reboot and can be in any state.
>
> If the device is probed with VAG enabled, the driver's probe
> routine will generate a loud pop sound when ANA_POWER is
> being programmed. Avoid this by properly disabling just the
> VAG bit and waiting the required power down time.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Fabio Estevam <festivem@gmail.com>
