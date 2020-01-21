Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F2C32771
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:34:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3732024125
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XEuwYWG+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nostatic-org.20150623.gappssmtp.com header.i=@nostatic-org.20150623.gappssmtp.com header.b="GOnC9Kfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3732024125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nostatic.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 866A3166F;
	Tue, 21 Jan 2020 02:33:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 866A3166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579570467;
	bh=usUQ1epGUS1JdekPnmPP89RHoZ1a+8Aa2+0EEHmRLmQ=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XEuwYWG+YB08rMWDo9dOlyhZFY9yEs59BwDmIYWgQBEKqrPNq9CCcmUlSCI1evfuW
	 LphgKe3cTPsuSMRlAaTJGRU3DBwBp/HjYakWvVg8AB5Qjwa2sTlkX7sqc/X3pVrAEg
	 fCNGkzPW7stSe7Zj+dsBRLDE7i5rDhoQwTm8Lha0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2710F800C6;
	Tue, 21 Jan 2020 02:33:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7367CF8020C; Tue, 21 Jan 2020 02:33:34 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 771DDF800C6
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 02:33:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 771DDF800C6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nostatic-org.20150623.gappssmtp.com
 header.i=@nostatic-org.20150623.gappssmtp.com header.b="GOnC9Kfp"
Received: by mail-il1-x12d.google.com with SMTP id s15so1083984iln.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2020 17:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nostatic-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=gvytIQMvIvkRtqL1bYRSzTxuYNu2uqMNRWqgWY6TPWk=;
 b=GOnC9KfpKXk5hpaLMtUK6GGPkpt7BmfQ2VPip5QmV1LaokB1rFqB3L41NvbPfWErzy
 6Tca0xIdPx11bAaUNe4WUb+UnvMtbfYptvxkogYLUW68K+e+emHBKTsYr5Tg6zYzkCne
 ZIWTu12ovAyWlhlcZv1mteFl6D/b85lvjdD9m4gObQnKYEfwVU0DPhkw3VkwYwvHLiBj
 3dRCsEQuUr/fG/S4hESkgUVj7uFmzEL6SyyWgJnb49rpdfbvUVsOqfxAoDGbVle7z+Xw
 F3tB8H2HfYQMrK4JZv3SfeItX4RNIoWikDs+PS+46jmexZIHuK6nUT5d0TP0LKqFh4qX
 p+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gvytIQMvIvkRtqL1bYRSzTxuYNu2uqMNRWqgWY6TPWk=;
 b=fIEbpkyjETVaD+ytosrud/LoprFtb0QKTHyVYn+RQ13PYya6XZdcjn8fJ/NV5n2e3a
 1PiSUnjlS455QEZI6EAENWZenQFJAhwd6RV02tDWPmXi556S0wwPbNUDvT28S54Fo5M+
 gXKIoHvjhvQyrJPGIu0WZ0TXx3GqDEvVPnPDi6l7ozte+4k4p733KZGYRZKt/ngl6V7J
 g/p/8YbLl5L8opKQ9m+Z/aRsn6QO2lMmKZayB6ChDwEk6BOj5nAU8ANzr2qrxpoudjxe
 au91OWs0Xrfu6A7qLdQocGOmKlz43e1KNgTUNkYi3onQGFkFfS+Nmpez3pcATuKkDWXn
 TCSA==
X-Gm-Message-State: APjAAAWxpXaDiq7ZpOxzQdR9D8X6TiEVeb/ppZ9PlR4f/UC/XcvtXsZy
 r8/E3ET/FEbAunTMoxlCzJhF76Mr8IBtbyrHhkWbX9nbQeA=
X-Google-Smtp-Source: APXvYqxVdU7O3JWWSaMyQVXblzMhmv4fihqKTAujgmRzs9etrF8svkCvy60qMOS5/hHHiuUaj3GrAZmFZKwArp99cI4=
X-Received: by 2002:a92:48c2:: with SMTP id j63mr1597087ilg.153.1579570405922; 
 Mon, 20 Jan 2020 17:33:25 -0800 (PST)
MIME-Version: 1.0
From: Mike Oliphant <oliphant@nostatic.org>
Date: Mon, 20 Jan 2020 17:33:15 -0800
Message-ID: <CAHXb3bfkxhPQxVXO4MyqYuotdR2guT-WyZGzKTVePEtqp-fBjg@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: Re: [alsa-devel] BOSS GT-1 USB audio and implicit
	feedback&In-Reply-To=<a3588f5f-b9b2-b622-7f9e-b9d472d88907@jensverwiebe.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Jens - actually, I think we have pretty much the same issue. I get no
playback when forcing an implicit feedback endpoint, or when letting the
Roland quirk handle it automatically. If I disable implicit feedback, it
works but I get pops/clicks.

Coincidentally, I just came across this post of yours on the Line6 forums
about manually tweaking the sample rate:

https://line6.com/support/topic/4426-line-6-with-linux/?tab=comments#comment-240302


I gave it a try today, and by forcing a sample rate of 44105 instead of
44100 I now have largely clean playback! I get the odd dropout, but it is
much less frequent (on the order of once every few minutes instead of
several times a second).

This is obviously an non-ideal workaround for the problem. Playback should
be synchronized to the capture stream, but this doesn't seem to be getting
configured correctly for our devices. Why, I'm not sure - I'm gradually
gaining a better understanding of the USB audio kernel code, but I'm not
there yet.

Mike
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
