Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88378C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27B464F11
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27B464F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41C2E16A4;
	Thu, 25 Feb 2021 12:29:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41C2E16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614252647;
	bh=h9rTv1EErYulsutc4VpD5Hy6xXNeL4UzoWw1B14Og+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X86Rng7+VEiuCDSeumB2i4L2y/MroiARxc/jqC6uL/TQhH4IswlNSRLXfMEeJnbPi
	 gopEWUSGAfiKMsYRn45a/vXGgmhuU+oCYhiIVk0LdCY9Qdq69H5zmj7c3vgogeqgLn
	 C14vlZ88DnZGbQGqpcyeR3L6qtqznj00cx5VXRDI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDC2BF804E0;
	Thu, 25 Feb 2021 12:25:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41860F8016A; Tue, 23 Feb 2021 10:31:40 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D980BF800B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 10:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D980BF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="swbR//Pf"
Received: by mail-ot1-x329.google.com with SMTP id c16so14955978otp.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DVFCa2/tt2H+LD0hRmA62OWnetDkcRuJ237RaPObmX8=;
 b=swbR//PfErd8XhgqzDSvvUK5jzVq9I8ZOx5107KVbKYg6OqJq5hU9Y7+FdR1SBeUja
 XJmX1+I6H5AglonFmbvrr81dNBwM3QnXE4EuG7TJWhIi/6FE1+8He3sEPJbO4INmoKra
 9iOMcrz+CTsosmGPpFBUPjF+flTGoUO7NFRfH/pMaTjMhY28cNzYuNdI2H+2agFc87TG
 NNcg1BKrJzAhg+GQMv7+q2S3lhDlcToJGSD5Pj4TUA/3WGlfjh98Gwmyxaz51z2EFPhd
 TSDFq9glzNWUmQSNEfoHH4rl6gUgulaH0LvJ5akCuSta4YkpTYqMt9yAEiC7zavZGd35
 C9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DVFCa2/tt2H+LD0hRmA62OWnetDkcRuJ237RaPObmX8=;
 b=g7uRH5PHe/Jlq4bLrfAVuamhtjDK0aDa8HbU8ArcK0ngJfXq9H6susS8sGGtFv2j7/
 jjJPDs4mRqcS3igkGPiIjtb/VJTyBThCuOs1eD4fKpNFZtI3WLRZMR+iA4cZLw2nwd5+
 4EjptEWJYA+o2uRtf1ejfB3eHlrfN2xpGvtbw5Be5l+RLAD8vfv93D6cmd/rk7Eo8ox3
 2aXdMY8NZFEti+RUbHpxaMoaOGcZgWo/TxbHK705yCkC6klnt36rsgwC7I9DQWLP3wuu
 VbrUGBP4gV025TCcqbpJLFsX9aB/5TOWvy1V5OwezCYklRnXxX/GLlgKE0yE/smu3i8D
 xHGA==
X-Gm-Message-State: AOAM531ziUem/yD9uBPEgXFEjWbVpVEn6ckOQIZSYHyCcvpFXg5r7Ije
 LPO41Nqn7d2k7Xg54rzcTzIVqbe3R3IrnZ4UldY=
X-Google-Smtp-Source: ABdhPJw119jqyynvn6i6tP3tXQai/RxjO4NuMQBdVlW9Zg6eOFuI0kMlNL/nUCHjxtta9WlCiGOPHrcAz/7jkLcfzHw=
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr19768599otn.290.1614072687320; 
 Tue, 23 Feb 2021 01:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <936bcf5e-2006-7643-7804-9efa318b3e2b@linuxfoundation.org>
In-Reply-To: <936bcf5e-2006-7643-7804-9efa318b3e2b@linuxfoundation.org>
From: Romain Perier <romain.perier@gmail.com>
Date: Tue, 23 Feb 2021 10:31:15 +0100
Message-ID: <CABgxDoLZKbrzghbp09kraEsk0iLzn7B0BEQWmZcdrXwmOu_MKw@mail.gmail.com>
Subject: Re: [PATCH 00/20] Manual replacement of all strlcpy in favor of
 strscpy
To: Shuah Khan <skhan@linuxfoundation.org>
X-Mailman-Approved-At: Thu, 25 Feb 2021 12:25:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, target-devel@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Mimi Zohar <zohar@linux.ibm.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 netdev <netdev@vger.kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-watchdog@vger.kernel.org, linux-s390@vger.kernel.org,
 Benjamin Block <bblock@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Steven Rostedt <rostedt@goodmis.org>, linaro-mm-sig@lists.linaro.org,
 linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
 Jiri Pirko <jiri@nvidia.com>, cgroups@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-integrity@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
 linux-nfs@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Chuck Lever <chuck.lever@oracle.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-crypto@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, Tejun Heo <tj@kernel.org>,
 Steffen Maier <maier@linux.ibm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Le lun. 22 f=C3=A9vr. 2021 =C3=A0 17:36, Shuah Khan <skhan@linuxfoundation.=
org> a
=C3=A9crit :

>
> Cool. A quick check shows me 1031 strscpy() calls with no return
> checks. All or some of these probably need to be reviewed and add
> return checks. Is this something that is in the plan to address as
> part of this work?
>
> thanks,
> -- Shuah
>

Hi,

Initially, what we planned with Kees is to firstly replace all calls with
error handling codes (like this series does),
and then replace all other simple calls (without error handling). However,
we can also start a discussion about this topic, all suggestions are
welcome.

I am not sure that it does make sense to check all returns code in all
cases (for example in arch/alpha/kernel/setup.c, there are a ton of other
examples in the kernel). But a general review (as you suggest), would make
sense.

Regards,
Romain
