Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEDC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 21:05:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C12206F1
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g4+Tffcp";
	dkim=pass (1024-bit key) header.d=precisionplanting.com header.i=@precisionplanting.com header.b="cH+9DWoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C12206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=precisionplanting.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91F781614;
	Thu, 14 May 2020 23:04:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91F781614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589490319;
	bh=BBl7mAO3Pg9nhObel5OkJGJoyLD1Cdz0WqMWo06eHEk=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g4+TffcpsmnMgFnoEr4n+KjCockATFYb3RPHvkk3nKbsKfuWnvKg1j5upW56dbVcV
	 66Rrh4pth27AX0cCG2ZKR5E5PYRYcIV+h27vSTi91gSafy/5CAuvAGqwg9MW9S3RbD
	 7QoOdM7TRTCWy1knDjkXA1CjqJRizqXDzuU7Jv80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F349FF8014C;
	Thu, 14 May 2020 23:04:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82BC6F80158; Thu, 14 May 2020 23:04:26 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFCDBF800E3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 23:04:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFCDBF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=precisionplanting.com
 header.i=@precisionplanting.com header.b="cH+9DWoj"
Received: by mail-lf1-x12f.google.com with SMTP id s9so4904lfp.1
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precisionplanting.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=87niJSe35kyR1W1HlAu/bbOhU+mzgfg9hHuJdiktwOM=;
 b=cH+9DWojphll7ZnMDZDmkdfwc+trHhmTE8koxtmVsM59mX57QHUZV+Lp8YOgUuCq1M
 Rgmwu/holobqw8x1mshE/jqxIDt4XXAdwESOo+yKP4aiZE/FwaUXV72kgPM4+Edm6kOX
 9KE/aJi9XgBz0iA1fBd+5ho57N9sxXcldBfnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=87niJSe35kyR1W1HlAu/bbOhU+mzgfg9hHuJdiktwOM=;
 b=mEc4ySGclWHeie9K5nPcy2US8Zou6ChpFtl0hAkQfMgEAmBDgpu80Egma4VmGGcDcf
 WdNt+EUFUZAkEuzjzpqVBXedO3ILZCMFmMVes/Gmf8VmInyZ37tvYP1CE/eqIqrY/iRB
 VFJ5v5Wc2oJS0AT1nRHavxLgX6YeO/dYs2aPi2LPKHKYITHzsAIEEQ25Oaj5g+QYJJgo
 mpJwlN1go1S+R/Ifgy+0Q7SJcAKrwI0uOjX1/o4HBoUGhvG4cyvAryYd6t3yEBlJeyNW
 KKnnWTZtAlqCpFy1CZKfp5A2sLqUA6WxNC7vQPQRc4Ftjp3/Vm/pG3Ib0JV1VQHP+QCA
 a1Qg==
X-Gm-Message-State: AOAM530eiyyXOoJvUHiWhmN2bIRJyn9gCWhP8MrVMhkvg/17gTjwFC1l
 TbUmPNMdKD+l34fxxMzgaUog6s57yx1V4bLTSc+1+Eyqt4U=
X-Google-Smtp-Source: ABdhPJx5LTDG86R1v4xFq9SKakXMe/tOtMPYVIvABy6cfgyLVYasTvfw0LWGkpnVKEmHZeDI7bObMi0ILxvwfR/2ujI=
X-Received: by 2002:ac2:569c:: with SMTP id 28mr56119lfr.176.1589490260398;
 Thu, 14 May 2020 14:04:20 -0700 (PDT)
MIME-Version: 1.0
From: Dexter Travis <dexter.travis@precisionplanting.com>
Date: Thu, 14 May 2020 16:04:09 -0500
Message-ID: <CAOyfbRXsKi-7bvnRNhoR6Vu7ET1oM5CJ6tEKwcDchy48ExpFvQ@mail.gmail.com>
Subject: core: snd_card_disconnect/snd_card_free: hang when card unregistered
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

In my system during certain power events the power rail for the
TLV320AIC3120 goes away and may come back.

To accommodate this I have added a call to snd_soc_unregister_card as
soon as I notice via GPIO that this power has been removed.  I then
call snd_soc_register_card to re-install the sound card after power is
restored.

If no sound is playing when the asynchronous power removal occurs this
works fine.

If a sound is playing one of two things will occur.  In the first case
the sound driver comes back and sound is restored when power is
restored. In the second case my deferred work function which calls the
snd_soc_unregister_card function gets hung and does not return.

I have traced the difference to the wait_for_completion call in
snd_card_free.  if snd_card_disconnect adds files to shutdown_files
list then wait_for_completion will hang forever.

Any suggestions on how to further debug this?

How to force the immediate unregister of the card even if a sound is playing?

Thank you,

Dexter Travis
