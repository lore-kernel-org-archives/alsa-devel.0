Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0605C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:02:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B3C20771
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KobJLbhx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUZSVEhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B3C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96B931660;
	Tue, 11 Aug 2020 19:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96B931660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597165345;
	bh=oWlilNWtWGXZLQbv0fWdNQMNKCMVThdP8KI4EgtLVUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KobJLbhxTzW2WJgv6EjEpsYEAQQDZ6kcnCU1fdZUoskRfv/w0fm8BoHS2P+HkpA2W
	 EUjoTaHT0rO9Z5H5v7b8y7WdjMdQwYbboCzXY2KNj3fBT/pt1PIW6hR3F3PhLCE4Uk
	 TBpQsmFMH8CFF9Di/hBfj8pdWhejUycmKMABFpIw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36DB0F8014C;
	Tue, 11 Aug 2020 19:01:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12640F8015B; Tue, 11 Aug 2020 14:16:51 +0200 (CEST)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 471E6F80118
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 14:16:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 471E6F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SUZSVEhC"
Received: by mail-oo1-xc41.google.com with SMTP id u28so1443834ooe.12
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BfaOWSVdZQ07T1WYL8SAoDKGztX/6CbsXqzUzK0St8s=;
 b=SUZSVEhCg6bsE5g5AFV3Nu7ILrIBK14FCJeQTRW4bRuMioqVg6Xp+cvlp3Yg1AIoqp
 +KJKITEVIQCC1qHMKKl6em+lfdg+/slX9FriU4yJcV/PdONBjp+w5Vg7c5lA5H/B30xo
 kbK88mNEzpr+gxCHW2krRACRsrCFrXErLis+oz+OGxiTog21ZC3h/ORMHGljsYc9qYWV
 ZeSRskj+HxmoIBBv6sNByjudCtnXj72+c/p3RBZs0DnyCBEZoD1zrdj3FaN1e60XJNeh
 zDBtXC4LSVsOIfENZwvo9yqNGeotY1MPPOUoEKYypDhOkuCUPSA4AiGeNj248+s7ZXKA
 jOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BfaOWSVdZQ07T1WYL8SAoDKGztX/6CbsXqzUzK0St8s=;
 b=iz9KdATsGe9uepxrPlFmBCrkqej8wrrhOMgCAgiW7aNwVu3wdc3QG6o6xki5tjfcbe
 MXXnlyiIbT7TnnTrB70wdJ2SahYnX9oP6l0so9qHZlqV6Mek2Q/KZfpG6c3ySuGMHCJt
 K3AuXPPbI0wZMeItI4DhrJ9PSzRYzrpTdnazqo/efte9mznj97Q9BX4a1Cr/8R2i9Dl2
 l16YuHZ7OSor3onEElRSt71PJnUu4QPDIDZyr8UpLO3gLqGWd5eDNy5iLp0c4zCl5Kaw
 IRiqylCsnU8hgpEw2l7qnFdY/O91TAVc8xYMpYYnelwd+aYyF+viPQl+jzt0y9DfXdun
 S+iw==
X-Gm-Message-State: AOAM531183RbTLQPGQNPrgsAD0A1Us2OGIcCUb0M6dxVUYoW9l9GumDZ
 bi+J/v3WEcqCUcdOpdZ1vdRdQerP2uOHziv0dx8=
X-Google-Smtp-Source: ABdhPJzSaTIBww3RVWzclOnCFAapTOONrFiRaRjDySuKQvXkeW9wMlyEhPPRLW4/2hyPS3tLM0iChxXJ4fWU8jt/XPY=
X-Received: by 2002:a4a:2c83:: with SMTP id o125mr823335ooo.84.1597148201081; 
 Tue, 11 Aug 2020 05:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook>
 <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
In-Reply-To: <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 11 Aug 2020 17:46:29 +0530
Message-ID: <CAOMdWSLef4Vy=k-Kfp8RJ++=SsMwCQTU4+hEueK_APDGvJ-PaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Aug 2020 19:01:33 +0200
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 alsa-devel@alsa-project.org, Oscar Carter <oscar.carter@gmx.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-input@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>, Romain Perier <romain.perier@gmail.com>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

Kees,

> >
>
> Here's the series re-based on top of 5.8
> https://github.com/allenpais/tasklets/tree/V3
>
> Let me know how you would want these to be reviewed.
>

  I see the first set of infrastructure patches for tasklets have
landed in Linus's tree. Good time to send out the ~200 patches?

- Allen
