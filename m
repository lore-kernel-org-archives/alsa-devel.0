Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD991C54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:16:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8EA20714
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hMDMCkrK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ2Mu2kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8EA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC73D1679;
	Sat, 25 Apr 2020 20:15:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC73D1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587838570;
	bh=Zfp5Onx0Nx3Qntcg022CjQlnGd/UDCDiCI9EG053aKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hMDMCkrKc7EDEEXviugYHMFaEq947zA1jbQ8b1kSYNED+Tcys5ARfBfV8TmAyMlp3
	 8M6W1rwBsBNuqHoEWCuWSS7EJbqe0HZFmFEqYolqHQyMMHuOsePQ8KUpIG+mkqQy0D
	 pjYe8MzC0cVkd3s7DEmKwL1El53+3Z5k1ZxVvGOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BA89F80159;
	Sat, 25 Apr 2020 20:15:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29316F801EC; Sat, 25 Apr 2020 20:15:18 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 201D2F80116
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 20:15:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 201D2F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QZ2Mu2kn"
Received: by mail-lj1-f193.google.com with SMTP id n6so13262333ljg.12
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zfp5Onx0Nx3Qntcg022CjQlnGd/UDCDiCI9EG053aKA=;
 b=QZ2Mu2knMaH9Q2yJHEjGYeeYBK61t8dAzRLBCZrcEvH8VQ1JHJ22La++a6HLWfIxy/
 dpXZcqvSfNklUnac+BGrBjdpsCBsTRd4NsytdNfvP0Pn3ayXSbAEAOVN0Y7HsU64SOWM
 Dp7l1WoxIx9oZWwHjYBxMwummBQ/2MM4o7RkcTBpnBvSrFz3gX4eQeBmheAm8I1jeV2Y
 EBtH+L/8yQ1EZn/vftHDIr8/Gi075D+OiNFMg++X6fEKvSVtO13X6fWDKxO6pGVGrwLN
 iLQ5rlsMB4QzWuaFm9yVHGFQ476g+lvg92BnX5Uisy+JWX8oBoB6vAsLtCbm4sp703i2
 i7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zfp5Onx0Nx3Qntcg022CjQlnGd/UDCDiCI9EG053aKA=;
 b=dk+QJQ0sgKfEfa3/q3pVnnFdQa6N+sxu34nmlBE9utjBQCdWcWbdQprFQtFybiRo8n
 mlNDaxelKKrR4EBasp9AtgeTNBH/bqtuWcVPD249eSGIZ2sxK2RGbLxglkyxzXaKEiy3
 /D6YdST5geqrDWxlLIVAbkwkCzfUfMJH/eElUmWgGrkFH1rJwUynKSLwrdzr3USDeVug
 I+GWnfPOODzv+HNqGBqJzaM8b8Ld3cj4RqNLqzT5gv99fk9kI4knZx60SpFahFHfk9zY
 v6txg4qX8vxEQk2Clu5JEG38xQlnGTvaLdmjuS1sC8ztxZxtfR+6YaaLUSA1QsUlc7o4
 L5sw==
X-Gm-Message-State: AGi0PubSDEXwVCB/VXYgKE7f8mDRfUccLFjOAjbv68JR4powo5kgVf8d
 DTdCjWRq0dSgm/dco40gPYgfJfF2etqTyuh1KDA=
X-Google-Smtp-Source: APiQypJKKonm4LYq08uK635o51516Yi7zpc7rdMUNvjVaJgMuF0zg5LYsawLU8gBBxAhpxUDKPtv/aBXJypbMhFSCqM=
X-Received: by 2002:a2e:8083:: with SMTP id i3mr9423787ljg.175.1587838209302; 
 Sat, 25 Apr 2020 11:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200424022449.14972-1-alexander@tsoy.me>
 <CAOPXC2kF-k9xH8KhP_s+RmebgTdZW7avn9uedMRAooOB5WhzCA@mail.gmail.com>
 <6eb7b878b82659f7e9b9859186dfe40320402438.camel@tsoy.me>
 <CAOPXC2nXJBp_qhOZwQALbB5ZQh4O-jPMVojCGUG-9tNH7-dQ3A@mail.gmail.com>
In-Reply-To: <CAOPXC2nXJBp_qhOZwQALbB5ZQh4O-jPMVojCGUG-9tNH7-dQ3A@mail.gmail.com>
From: Gregor Pintar <grpintar@gmail.com>
Date: Sat, 25 Apr 2020 20:09:58 +0200
Message-ID: <CAOPXC2ntasO-LfaozFGPi1Ux3vxF_oL1nSnQCwXTgpM6D1OM+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Improve frames size computation
To: Alexander Tsoy <alexander@tsoy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Roope Salmi <rpsalmi@gmail.com>
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

On Sat, Apr 25, 2020 at 6:50 PM Gregor Pintar <grpintar@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 6:44 PM Alexander Tsoy <alexander@tsoy.me> wrote:
> >
> > =D0=92 =D0=9F=D1=82, 24/04/2020 =D0=B2 17:02 +0200, Gregor Pintar =D0=
=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Fri, Apr 24, 2020 at 4:24 AM Alexander Tsoy <alexander@tsoy.me>
> > > wrote:
> > > > This patch fixes this issue by implementing a different algorithm
> > > > for
> > > > frame size computation. It is based on accumulating of the
> > > > remainders
> > > > from division fs/fps and it doesn't accumulate errors over time.
> > > > This
> > > > new method is enabled for synchronous and adaptive playback
> > > > endpoints.
> > > >
> > >
> > > Hm, I still sometimes get click usually in about first 2 seconds,
> > > but it is hard to reproduce.
> >
> > I wonder if it's because the driver doesn't honor wLockDelay. Anyway,
> > the second patch can be reverted if there are still issues with 2nd gen
> > Scarletts.
> >
>
> I just got click with async. I better stop testing before I get click
> with 48kHz.
> Could this wLockDelay affect async too?
>
> Does anybody else still get clicks? I would totally think I'm mad, if
> I would not
> record them. Maybe it is something else.
>
> I guess I will just switch back to 48kHz and try not too think about it.

Guess what 48kHz sync and async clicks too.
It could be related to running capture at the same time.
It seems fine with 44.1kHz so far with input muted.

Sorry for all this spam.
