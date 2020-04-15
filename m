Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC64C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:51:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8D02078B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bqgmt+8I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV4xqBrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8D02078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C55C486E;
	Wed, 15 Apr 2020 16:51:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C55C486E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586962313;
	bh=uVrTU6SslrMUuy6SwA6ixkxrAdrOOQCriM+zWijEpt8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bqgmt+8ICPeL+PAlj014VpvBC+ikbuzmeRAzriy7OZ4khThg0tCC965liZU0bih6w
	 dmq4oH1ehfEyL7ALyKT5BNcj22AgqUSXyNcQv4C5NCECHrs3YIiGtIXBv2rxZSOx6I
	 NXvoREvnhLiVvTquHvbhGs5EFLdwMn6Mcdoq1jPI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F9EAF80229;
	Wed, 15 Apr 2020 16:51:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F60EF80245; Wed, 15 Apr 2020 16:51:00 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 506B6F80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 16:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 506B6F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RV4xqBrQ"
Received: by mail-il1-x129.google.com with SMTP id i2so3511899ils.12
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uVrTU6SslrMUuy6SwA6ixkxrAdrOOQCriM+zWijEpt8=;
 b=RV4xqBrQwNTi1A2J974AYYX6but+tspdvQVWP+nY63IMi4SI9YQmdMV+NwwDqmJAY4
 8mRqrdk+Jmp3LNZ8h5GB/uA4J5xQN4pw45N2IhOxtW9MzSqvapzwYqMhllcLzLEfJ9pU
 6YlyBPh4vLcF9Qqr/po12mW2XydVVjWfJJkNc0DLlq6iApaZ7PBNG/nANYp5Gs6aB+NF
 vyHHbe0wBWhVwjw4DKf15UdWL2EEga4a1tW/6wO6dRk1CJ8h01utBKDcKhCd+bhPVuUt
 OpD8D8xnLEn73NiiIe1r8fk6osGd+sSoiTS2YiS2hLC4FAiau7mWz3CYhverhUWqP2g+
 9pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uVrTU6SslrMUuy6SwA6ixkxrAdrOOQCriM+zWijEpt8=;
 b=T9D4uriSeYNVPKvMdFxjGS2bLdn6I/khXKf4jKaqj2KKZD12tDKXjRGtvm/SfHQE34
 aO0KQ+/oFs9sneQqX9+IQge9sszXxUkdNLwDK4WUiuQNSL2PACjevgCRekSypDxoGZrW
 5HVL5ZUpd2GP6d3+O7uHWQC3RoUsPeHD8NaB4c9e+QuvUhk+ipGvyRI8GB35IBi37nj+
 1+eSr7bkXpAyzWXc47HBtTjHw9uBY954pbg8kDw+ArqwO6nzVUCNwrUQOCt7Wvwm7FD2
 i9H+MunKWlASH5r35HJzTdiBZm5lTVd+gM1YIyLgm1qvUVf3KahRM1tdhNVaPfXFSFt7
 uclQ==
X-Gm-Message-State: AGi0PuYgB8whnMcKBxgiMRjjvwFvesbjqi97ODykX7QK6XSz2zs5ErIm
 9RibE3eF+C9wdne8cDrimPtZwcWPkb0Eww3doZQ=
X-Google-Smtp-Source: APiQypIUPMddpYFh04ggXfanY6G54QmifpbgFJE5WXIoapZNntbmCSk5+VqgDe/Rg7jlTNzmeuRh5gIIeNdHHLqhaxc=
X-Received: by 2002:a92:c98c:: with SMTP id y12mr6034591iln.263.1586962249759; 
 Wed, 15 Apr 2020 07:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Wed, 15 Apr 2020 07:50:49
 -0700 (PDT)
In-Reply-To: <21488b92-601f-9acf-09fd-4537c8eb9b1a@redhat.com>
References: <20200413145957.22459-1-youling257@gmail.com>
 <ae69c1b0-b347-4366-4bb0-383aed69c4b1@redhat.com>
 <d6146d62-a20a-f6a0-64f0-65cea7253948@perex.cz>
 <CAOzgRdbgOykctcteVMLJqqyeXwww2ekzUrbzLbu0jtCoU_5Xgg@mail.gmail.com>
 <2c1d70d1-6a77-9d06-96df-86c602c1e2e8@redhat.com>
 <CAOzgRdYsy3MZCO4NvuBL_-SDpSyiLrnc5oesfMhqHdeg+zAhgA@mail.gmail.com>
 <21488b92-601f-9acf-09fd-4537c8eb9b1a@redhat.com>
From: youling 257 <youling257@gmail.com>
Date: Wed, 15 Apr 2020 22:50:49 +0800
Message-ID: <CAOzgRda2vkNzibgwMzcHFWBryVddn9WyjmpVu7swVa+JzecpwA@mail.gmail.com>
Subject: Re: [PATCH] bytcht-es8316: fix Speaker or Headphone no sound if
 enable Mic or Headset
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org
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

2020-04-15 16:45 GMT+08:00, Hans de Goede <hdegoede@redhat.com>:
> Hi,
>
> On 4/15/20 10:18 AM, youling 257 wrote:
>> 2020-04-15 16:04 GMT+08:00, Hans de Goede <hdegoede@redhat.com>:
>>> Hi,
>>>
>>> On 4/15/20 8:26 AM, youling 257 wrote:
>>>> boot enter ubuntu no sound at all if EnableSeq.conf disable all output=
.
>>>> =E2=80=9C The PA should activate HiFi verb only once.=E2=80=9D i don't=
 think so.
>>>
>>> Which version of pulseaudio does the Ubuntu you are using have?
>> pulseaudio (1:13.99.1-1ubuntu2) packages.ubuntu.com/focal/pulseaudio
>
> Ah yes then you are likely hitting the bug I was talking about.
>
> Can you please file a bug against Ubuntu for this?

open a bug, https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/18729=
70

> Here is the original Fedora bug for this:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1818883
>
> And here are the patches fixing it:
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/276=
/
>
> Regards,
>
> Hans
>
>
