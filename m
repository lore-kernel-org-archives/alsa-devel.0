Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D8C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:14:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BFE615E5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61BFE615E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B65C16ED;
	Thu, 30 Sep 2021 17:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B65C16ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014845;
	bh=kIAzW9JkxwXtEru2Lm+pNthqiMY9hZCRIDpCsNLKdb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7l7f0p/oMi5wFZcexKcilXMcTPAkdurNRNSzHg2BxID6tUwa3wHRk4LH4d9A8zqk
	 4uURQ/KTxCuWmSN9UepaInVaKND4AauJ24w5N6UUBDBXgCu+ZAAfwp9EHhG54cXEU5
	 1+hjrQwSt1+uRW5chKgek0shWthSF6g8nSwLqtbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94B34F804FD;
	Thu, 30 Sep 2021 17:11:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C108F804AD; Thu, 30 Sep 2021 04:12:00 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 059E2F80113
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 04:11:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 059E2F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FzewjiS6"
Received: by mail-pg1-x52c.google.com with SMTP id 75so4691126pga.3
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WAhFYzhi7R9BAOIMEpfr/15bIdrl06z+qo1p9o7c8X4=;
 b=FzewjiS6mRR53vjZ35rJlkIC2oQZI1YwZA+poT3aW4C/zdu7jpZ2YQ7VkhdkKZY2Gh
 zlaocKfl37o0hLgz1kpt/KT0CSOcb8ZmQ0EpbpcThbdjDrzaTX5uhKLgARBkRkGIeCLq
 x3lYrLf3k7eAjMHSvDNLWmhYeO1B4Tva13nkSx5tWlwoW3D9nXeIjBbf1Ab9su40KLPp
 lQFJ88/COZIVgdSYPfIGj/IIL8mqz5JbcGqPzW848/yVR/EERrCsU0n8fJ6to1OSbyoS
 vfppdH97hbUYS89PmfS+3rGcnzk04jMl4u247R1DEoEKoBk1H7dgs/lSzuly7o1BGFvd
 dhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WAhFYzhi7R9BAOIMEpfr/15bIdrl06z+qo1p9o7c8X4=;
 b=YNN6GH6Gv9e/3mOBmKA7R2copLcrA/ZfFXAs0MS+53jnEjJbqVov1/YgODJOM07yn6
 tH7VjdFGkUGO7q9dbExDqLzp0GmB7OKg2XN+a3pfl7YPvcDTvyTmOTW/7keU7U0F1R9G
 ZXTltyvJnMtAHyrQzYqjwPgc3j7ktxu/dGdl06pYcM/BWCcc94c815R9ZhjV8wwYJSwF
 1vHFo6+lemsBGEBLuu9ZljisVvCqJ6F8UOpOK8IHXwWxDH0cZMVgTiaDkbQKrXOtcgdv
 SoSn0saeaLxa0otj2f+mX4j3LEQpLMTWM7va1ks4OFWc5h6UNzYSgmr7oLyTlbRLag78
 UqoA==
X-Gm-Message-State: AOAM532nyaTEgBBSECnAjxIp18ylg8krHRl8n579mc0CApFlb055KQgP
 hZKuMTpzHCYjKVrzoDwxnDYeOvyhjrCXpF1QXjE=
X-Google-Smtp-Source: ABdhPJwkPMLTWwt0y+WPy/RTJS0pDCU+b2+IVPI3c+urm67am3A0suXSKZtX5H+1HsUGGunOLkjC0YQljVjceBaHJoQ=
X-Received: by 2002:a62:dd84:0:b0:44b:b54a:c2a5 with SMTP id
 w126-20020a62dd84000000b0044bb54ac2a5mr3000934pff.11.1632967904055; Wed, 29
 Sep 2021 19:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
In-Reply-To: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
From: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
Date: Wed, 29 Sep 2021 22:11:33 -0400
Message-ID: <CAFSeFg8UJtt1mUSE+ue8kjh5y=yR68g4SuwAcDrRGNXHHMsi=Q@mail.gmail.com>
Subject: Re: ALSA kernel projects - for academic purposes
To: Muni Sekhar <munisekharrms@gmail.com>
X-Mailman-Approved-At: Thu, 30 Sep 2021 17:11:01 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
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

On Fri, Sep 24, 2021 at 10:05 AM Muni Sekhar <munisekharrms@gmail.com>
wrote:

> Hi all,
>
>
> What small projects would you suggest to a novice with the ALSA
> kernel. The aim is to develop a familiarity with the ALSA kernel
> source code, and also to submit it for academic purposes.
>
>
> --
> Thanks,
> Sekhar
>


1. Read the documentation for the Linux Sound Subsystem :
https://www.kernel.org/doc/html/latest/sound/index.html
2. Then try to understand the the ALSA Driver API
3. In your kernel source tree under the sound folder/directory you will
find lot's of useful source code.

If you open the /sound/x86/intel_hdmi_audio.h file at the very top you will
see what is below:

// SPDX-License-Identifier: GPL-2.0-only
/*
 *   intel_hdmi_audio.c - Intel HDMI audio driver
 *
 *  Copyright (C) 2016 Intel Corp
 *  Authors: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
 * Ramesh Babu K V <ramesh.babu@intel.com>
 * Vaibhav Agarwal <vaibhav.agarwal@intel.com>
 * Jerome Anand <jerome.anand@intel.com>
 *
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * ALSA driver for Intel HDMI audio
 */

All the authors you will notice are from intel and seem to be all south
asian :-))) pure coincidence ? I somehow
do not think so.

Muni in my experience what I have learnt  over the years is there will be
times when you ask a question and
you will get very negative or straight-up demoralising and demotivating
toxic remarks and comments. My advice
to you is this:

Have a deaf ear to the obstacles and negative comments, rather use them as
motivation to achieve your goals.

*Lesson to take away:*

   1. Alas! We can=E2=80=99t have a deaf ear to the negative comments that =
we
   receive so abundantly from people all around us.
   I mean even those who don=E2=80=99t usually give advice, would try to st=
op you
   from doing something you so eagerly wanted to do,
   even when they themselves don=E2=80=99t know anything about it. But we c=
an,
   however, avoid them or use them as a motivation
   to prove them wrong. Yep, use their words to prove them wrong!

Good luck - Aruna
