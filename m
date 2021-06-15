Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BEC48BDF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 07:02:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E92D61417
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 07:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E92D61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B8FC1678;
	Tue, 15 Jun 2021 09:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B8FC1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623740522;
	bh=9R6yJGe9iXR+QKQYp3ed6kj3FohafuSvjRzw5BTEgL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V3C/27kF740t5kf587HH/iqTROKv3EFVXSsQBFcIQzwb/h1I2He/pOQG31e46rYBx
	 Tnn80meTHKGbcPsTuCBKKuTzXH2DEStBGBN94OUNhbACMTeMas2NwprfjoLgcwXUpI
	 AgVDqYeekOKz/S4vaKFwjfzP/2TrVv96nPkPqUU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9FA3F8016D;
	Tue, 15 Jun 2021 09:01:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 574ABF80171; Tue, 15 Jun 2021 09:01:10 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7155F80113
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 09:01:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7155F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="umkC6wBa"
Received: by mail-lf1-x12d.google.com with SMTP id m21so25156646lfg.13
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9R6yJGe9iXR+QKQYp3ed6kj3FohafuSvjRzw5BTEgL8=;
 b=umkC6wBaORmGymofAod7RGVV1/CFa3gkF1CQn9wzc5EdLRiFhVCfpGj4KyX7JTVjvx
 uuhHrzT0515t+Yvglmxuz/XKjq2Xfggw8B78fd/15+Me4cfqluoK9kRKk7G+jVYTbctV
 OWOWHqY/XBcg7EcN2XnFoYNHquUWFVVyjhy8mklTV3vIqFFheMmfQ0aVQMir+C/7eUx1
 K9np5llFqzLB3Npo13I8KgtbuLAIbRImfo2gaktQujf5aU5kZryi4p5r35tKRSLMYype
 Y2nCX8mu+3XxjtZzDZFtpNfRDjwldRgdSW18jXGwCN8rx6oPpq//Nlfq5ndG9WJykeVY
 jSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9R6yJGe9iXR+QKQYp3ed6kj3FohafuSvjRzw5BTEgL8=;
 b=eAO514ghKNHQEds2LRiI5C3NeLncHeXkHBPRj8ktWXAARBP6MW9KDL2MzoVzijwDBU
 Si0DP5W+cv90c/gxY9q7vxoB4G/naPAZaApI6VYHRw+Qomy1rv/HvYXTpMzLTymAUHUk
 /5ly4ASRmF4yprY4qHhPJ8VTJD4TbeNCcHd/JRhiQna+h4DfMsp5QV38gmDxk36MVvs5
 eIaeUwh+ZEby6pAiL5OkHoXhBErHx9FiKMq5s58JzVZJyhgiY7lvyceWO7j7Q9TVWjiN
 sHc+9ZqMzdNWxU7O2UCs4JlIfWB8uVUgJfLkX9hmcBthRrFzBakK63sb6XeZWo0/N1sK
 iOwA==
X-Gm-Message-State: AOAM533XfN5/rXFzgMdUi9iZkbNlL49BJpVPqKxuQgF76LiB1kju80+V
 Owp481jtWMzitGz4xkCPlrguAJrXYV9Z3joQdUk=
X-Google-Smtp-Source: ABdhPJytbmpBc/v6/ujKDjf3vh3FQsf5IDAR1hAnC4zwXLCCxyHZEhLaHGrG2m9yRzgcGvIdYRh4TaR09Z8B2Z0GQfM=
X-Received: by 2002:ac2:5ecc:: with SMTP id d12mr15247436lfq.539.1623740456413; 
 Tue, 15 Jun 2021 00:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+haTa8FJep+mokae4O7Gy9zzq2dbPk28fuEH5FO24uTzw@mail.gmail.com>
 <26698.1623455194@turing-police>
 <CAHhAz+goVhacpDPc-OaVuG151TS8QKYdsqdnK9UcAx+Hc07zSg@mail.gmail.com>
 <27987.1623737660@turing-police>
In-Reply-To: <27987.1623737660@turing-police>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 15 Jun 2021 12:30:45 +0530
Message-ID: <CAHhAz+iOFda+T3=ri2o8UhNR1L1KVdKJUYABS8djijqvhsn3JQ@mail.gmail.com>
Subject: Re: USB sound card issues
To: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-usb@vger.kernel.org,
 linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
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

On Tue, Jun 15, 2021 at 11:44 AM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Sat, 12 Jun 2021 16:45:00 +0530, Muni Sekhar said:
>
> > > And if it's configurable for multiple formats, was it set for the cor=
rect one?
> > Is there a way to verify was it set for the correct one or not?
>
> arecord -v gives what it thinks the setup is.
>
> > > Does the record die immediately, or hang for a few seconds and timeou=
t?
> > What is the difference between these two ways?
>
> An immediate failure is usually related to a "Can't do it" situation wher=
e the
> USB interaction to configure the device has failed, while a timeout usual=
ly
> indicates that the configuration at least *claimed* to succeed, but is fa=
iling
> to properly transfer valid data.
>
> > For my hardware, I noticed that it hangs for a few seconds and gives EI=
O (arecord:
> > pcm_read:2032: read error: Input/output error).
>
> Given that the usbmon output ran to several megabytes, that's tending to
> point at "the card was returning lots of packets, but they weren't actual=
ly the
> format/data that arecord was expecting.
So, is it a USB card issue?



--=20
Thanks,
Sekhar
