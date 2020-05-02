Return-Path: <SRS0=kfZ2=6Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89242C3A5A9
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 21:46:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108A22084D
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BfAZSdYx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duKx9r7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108A22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56219169E;
	Sat,  2 May 2020 23:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56219169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588456011;
	bh=ljnvTXpT2GvpktujqX5bCDicTyede+95jcYmgGx5qEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BfAZSdYx/ZzT5Fqqv8fq/ijZ4U7kFC/LgZHtEj/NRgTJmQ5DqEPNB9/J13WFf4uIj
	 ouJzCUOZkRlURClip394s0bqZjAhMOJ/zRY2ltGV7LBfR/2iOrNYt2El+MAL0dmYyU
	 A4E4mVtEUxsQwemnY+kgHBGKFKYjRs8LlwznvAzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B969DF801EB;
	Sat,  2 May 2020 23:46:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BD56F801F7; Sat,  2 May 2020 23:45:57 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CFFFF80087
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 23:45:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CFFFF80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="duKx9r7f"
Received: by mail-qk1-x742.google.com with SMTP id k81so10095137qke.5
 for <alsa-devel@alsa-project.org>; Sat, 02 May 2020 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bX94DfQt1bV1P2YZB/N6Fk9j80RMwAHUWH/2nPEPXCU=;
 b=duKx9r7fwvG40664Z5QBj0CHyTmrEegm9PwE6Kel4jwKMf92j/Tuxs0l/Zq2yV7XHE
 JCoKU+9LHlEyKua+RFEOHysV5KbBw4SAWO4vfbkG+wMgjTZCOvNbxMIAdyyPA5aJmTYf
 OhUsmtRcP+H8cJakP2abIu+BKOdM6AHJjC60l5Swde1RLNmEGhxWXHkUZE0n8AfnSnfi
 xk6KnwSmOFiWEHKvvy2vjBEdOfZYaQVxe6Xorqnacd+ocXV/CKc5MpNEXBkT2k7D3hXz
 /6cjUAawY046PnPS6Hfs8eD1tXI9t3YWRe5ulsllPaWaK6Xf5njqHgdK7rseVHkt/+rO
 zWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bX94DfQt1bV1P2YZB/N6Fk9j80RMwAHUWH/2nPEPXCU=;
 b=TDlmvWgnhnvemrsKhmRbaYjE2+kcP1EJI/TkwKlLVO1m+OBzD4SfLF9pWW4l9DFwVG
 19/Vv9qyHyY8RzXLA4cEqR+YxLiIfJK4z4kHjkxH/0Mh7M0RhUQWS5jzfl/XsINAPlsq
 SgRbX4ujmy0yXQtyDfV6asgl234H37AiNG03cm/1sRni4gR2PZMf4+TcSHigkG1DOOz8
 TnZT/epjinc9GySPfBlHbolYhrAV69HMMs1wD4CGOR9rUnJQtW1ikKQqXamyN+LOBl2c
 x4LP8Z/3KDBK5Bxlp6xVtczqkcf3SNSfAyI2EqwZpomleJoEarC/DeVZJwTPMGsnGhX1
 ryPA==
X-Gm-Message-State: AGi0PubABGZPyKiIPEKSDnEG5NDuaXKOXQ1fvwvrBV9NGNG7ScjJCbMb
 6Uoxm9YmjrMSRVFvGalA940fjJXu5yyLPGE+ybI=
X-Google-Smtp-Source: APiQypKFp6uLo3VPXXCORVmpDhKDAs3RqjYUX+zAVi/8eQ5Z7m215a42eKq/eaDp/zxiyo/aHrIlBOYD0Ygeh0+6NWo=
X-Received: by 2002:a37:d0f:: with SMTP id 15mr8420764qkn.276.1588455948750;
 Sat, 02 May 2020 14:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200502193120.79115-1-anarsoul@gmail.com>
 <s5hmu6qgjry.wl-tiwai@suse.de>
In-Reply-To: <s5hmu6qgjry.wl-tiwai@suse.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 2 May 2020 14:45:22 -0700
Message-ID: <CA+E=qVdwb==MfdbWS2oSCDN=eKd0dhJ5a6iEpwMPZcFCWr3Rvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ALSA: line6: hwdep: add support for poll and
 non-blocking read
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Allison Randal <allison@lohutok.net>
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

On Sat, May 2, 2020 at 1:32 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 02 May 2020 21:31:18 +0200,
> Vasily Khoruzhick wrote:
> >
> > This series adds support for polling and non-blocking read for hwdep
> > interface. This allows apps to listen to HW events without using busy
> > loop.
> >
> > Example of app that uses hwdep interface for POD HD500 can be found
> > here: https://github.com/anarsoul/line6_hwdep_test
> >
> > Vasily Khoruzhick (2):
> >   ALSA: line6: hwdep: add support for O_NONBLOCK opening mode
> >   ALSA: line6: Add poll callback for hwdep
>
> Looks like a nice extension.  Applied both patches now to for-next
> branch.

Thanks for such a prompt response!

>
> thanks,
>
> Takashi
