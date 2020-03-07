Return-Path: <SRS0=bYd2=4Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BCC10F00
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:36:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CABE20663
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N70Ui6F1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb8heO4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CABE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA8F3950;
	Sat,  7 Mar 2020 05:35:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA8F3950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583555770;
	bh=M4RqAVMIUZtw6jW6L9b/NNM3dIE5gpEkYjJUh43SPhc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N70Ui6F15vypN26hUSijX6TfP9JANPNVSSflnTWVcd7XcDvSz47OpvFb5ODeezqap
	 V8Pv9IUTevsLjN3wXbDursnu1N5Hza4yf3mMdn8/tUhmIhjdOuAfikif8iBaLDnDEy
	 FvkIfjMAGjDIHcF4+1ADjIdMld3tAcFuQYcjbL9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E245F80245;
	Sat,  7 Mar 2020 05:35:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D61DCF8025F; Sat,  7 Mar 2020 05:35:02 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7EBEF80130
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2020 05:34:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7EBEF80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lb8heO4i"
Received: by mail-io1-xd32.google.com with SMTP id h131so3450312iof.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2020 20:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mp2jKw3BR2/WUzUo3CX2KZa7SdT2B/WVfjE292+5pEI=;
 b=lb8heO4iCDu+zizq2CvdiCrjf4BSmmo1thSm6Za9ZRv4r3LVD5Mln4eKVjDwxjrfe8
 uJk8TtyjYroAF9us66tdpoMGn8D5n8LkoDwouxxDX5lHRWrx7vW4qNWhOH5Zwx2GsPMO
 pZH9+AjkDP01SGaTrLNQPksuHl6AX5KNVhS2foiZdj9RJkGGvmV531ZltsvKkverGeQm
 SI7MZz0HLRAOPOc1uFVE2XoTXMZaSfE3Fo3OkkTUrDJFU4Sx2uFp8szs9RUkRCEZiZWN
 IysPV8JJD/IN/wLxHwkCraFi9TLLIUL0ackfjSQBDksvJeoW2u4uOarThvL373h+kXqn
 yAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mp2jKw3BR2/WUzUo3CX2KZa7SdT2B/WVfjE292+5pEI=;
 b=inr2e83X8IGamoHsRhbJqAMNYlRXPGdz3LEawBwHZ8a/HIz7y+Hfzz354JXXSNwRCe
 wB2tayGS5hugSQMXHJCLRUgzWbKBwgdmPbHAy7hnWuPoPhvHTVMW8pkRitqp4AcpnTN6
 lgwoxDnqVMHGl6US+2cSWUorgoUOSdNTXxSSqu2k1+JRjF+6KmWsUxAnA4nU1A02T/1J
 maOIGo3hJgSHsSc85KUE68V6qO6aYYKdccxb85EOoHEApo+8m6C9f9m8METCVG9lt5XD
 5dUfVzWK75zINZPoGaASfgHeKSkMOtZdoarTo4cebWHZ0bKjxEuzXh/zSuTLtNb87RhC
 iUJQ==
X-Gm-Message-State: ANhLgQ1gC79AXbkY2Tbv1rSpNsPZUNgwh7qAyIDc9c2BdiPO6bJnL5MU
 FZe0PKh3faPRUQs7v2O0jvwzlx7rH9vODowTz6Q=
X-Google-Smtp-Source: ADFU+vsxBha5M/TbNCB9bmijOCNnIjSxAlWyRoQMc6D4z1rjraYeKi4ttG6/EI6xRupI0/uQh0K4sTU0D6CGmDIt1jY=
X-Received: by 2002:a5d:9658:: with SMTP id d24mr5620931ios.173.1583555696206; 
 Fri, 06 Mar 2020 20:34:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:4c0f:0:0:0:0:0 with HTTP;
 Fri, 6 Mar 2020 20:34:55 -0800 (PST)
In-Reply-To: <CAOzgRdZZQLKYOQDxvySaum5CTD8Se=UVac=ha9R=+vF_md+4Xg@mail.gmail.com>
References: <20200106131159.476744-1-hdegoede@redhat.com>
 <9f6ffcbe-10fe-91fa-3998-029c2837a39d@perex.cz>
 <CAOzgRdZZQLKYOQDxvySaum5CTD8Se=UVac=ha9R=+vF_md+4Xg@mail.gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Sat, 7 Mar 2020 12:34:55 +0800
Message-ID: <CAOzgRdbmwdc7Um=7HAZ+ksUvn0e8Ex1i3hgVrbH8SeLZzwyU3g@mail.gmail.com>
Subject: Re: sudo alsaucm -c bytcht-cx2072x set _enadev Speaker
To: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

HP Pavillon X2 10-n105nf, a user report "alsaucm: error failed to set
_enadev=Speaker: No such file or directory"

on my ezpad es8316, alsaucm -c bytcht-es8316 set _verb HiFi set
_enadev Speaker, "set _enadev=Speaker: No such file or directory",
only can _enadev MonoSpeaker.

2020-03-07 12:25 GMT+08:00, youling 257 <youling257@gmail.com>:
> sudo alsaucm -c bytcht-cx2072x set _enadev Speaker
>
>        alsaucm: error failed to set _enadev=Speaker: No such file or
> directory
>
