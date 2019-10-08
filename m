Return-Path: <SRS0=gTnd=YB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF12C4360C
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:31:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9458720673
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ubeWEcdl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdBf8oOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9458720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27631166B;
	Tue,  8 Oct 2019 15:30:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27631166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570541482;
	bh=9/zaq3OyDs9QynI9z2dpV4Gv+a87XNN6jxtFah7meTs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ubeWEcdle3Dc6ZRyTwytlV4r97E1c8tbMODK8YvlhPtUr65uiHQ10SR4CPivsxPy7
	 /BjMdqmeQpMOCbKZYYOmbqsH7t7+cG/X7N9t0Th7GBlt8W6o3AC0MnBsG8wXLqoqJh
	 LlBYGtihTf4HsAt56lLpOwfgZFOH6LU5D9FxoHfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 980A7F800BF;
	Tue,  8 Oct 2019 15:30:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BB05F8038F; Tue,  8 Oct 2019 15:30:29 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2B3EF800BF
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2019 15:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2B3EF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VdBf8oOe"
Received: by mail-wr1-x429.google.com with SMTP id r5so19358537wrm.12
 for <alsa-devel@alsa-project.org>; Tue, 08 Oct 2019 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lF1ENjDc7NOoUQXgV6aVu9kc443TEhXbF15hOeLH97g=;
 b=VdBf8oOexOt3xjfB3oECFftWp2HTYmWp79e6V9+Rq/hPjUr9eRQWCHUieHFfHJTMxj
 yKmj/9RHuy4PYkIfaDBx6lAARiFZIYdOgQL+XttH+6gRV+vTarni43s+25gmcYNUEY56
 ZBscXAbUhlKzB3/e5Dn+XJ+cTEe+YKYtIJcRhOOEKMz0sDW+R44oC/AJCaNgOsfmX89x
 4tNNbrMa721xWEUV2aG2CdkHAcQ+56fDywok1aUP+iAFIeUqJxMIngd3z8cw7dtfj4gT
 ncwvRRvBqU5uYvIravGAR7KYIcO8AwP/Hhj5+a9voa42iPoHtqv/5vNjU0Nm8DY6fG0P
 VtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lF1ENjDc7NOoUQXgV6aVu9kc443TEhXbF15hOeLH97g=;
 b=QbPxiO5HypZNU6QEbprQ7GinZ1TH249TM6Ch9RZ0y/z9CX5pY2s0U2NJFXhcXhA1J4
 EShrtKaUSAcsg0tCBc9sNlMqw9ni6IZdqom5KaWcd4Cz5qQltxpqvxzB/sx+ro5zer3d
 H76+s6lFpRUF4qiaXm5iiTGgsql5fzUAneS+wDXQ3/l8NZCT0VO6uTXOnbwn+BpyF5EV
 z/8EKIAArZhfebRKUnAFWEvqjp+4sYBtCaGzfukB6hsMMX58vwmS77idvpQ4oeQkGABi
 gSj53iqi4FWWTDSnHnJT7/M+KVpfPk0xJFrKL7z14YtkjF2tx3xUS+EkG1Z9Y+qgEIZi
 0hdQ==
X-Gm-Message-State: APjAAAX4YhYkRint1AtUOWrQczEgFWiFhdD9o1uRVCRGwQMRnadVZNz7
 Tt6n4/ULrZ8EtXE1TVlORPZvhLY/dVIdW2fGnJ6IQVFC
X-Google-Smtp-Source: APXvYqzOYxYXCwDPQN5UE9l/U4r2dPmzrtpTmvECwBwbagme+6jPK64sTDN8BEqfMKl0WL3jdzcYQMkDPTyMek4MmCo=
X-Received: by 2002:a5d:630d:: with SMTP id i13mr5863518wru.230.1570541425439; 
 Tue, 08 Oct 2019 06:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEnQRZDhhZHOyqC8QSmgy+CY5eYSktPUiL6tVF9z_5ACegCsQw@mail.gmail.com>
In-Reply-To: <CAEnQRZDhhZHOyqC8QSmgy+CY5eYSktPUiL6tVF9z_5ACegCsQw@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 8 Oct 2019 16:30:13 +0300
Message-ID: <CAEnQRZABxV+s3bF1yRr2TF0EJhZ-u+ZXxuvvz5so8AfyHVm8wA@mail.gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Counting links in simple-card
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

Also, I wonder how can i use simple-card to create just a backend link
CPU-dummy + Codec :).

Is this supported?

thanks,
Daniel.

On Tue, Oct 8, 2019 at 4:03 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Hi Morimoto-san,
>
> In simple-card.c simple_get_dais_count function there is this comment:
>
>      * ex1)
>      * CPU0 --- Codec0
>      * CPU1 --- Codec1
>      * CPU2 -----/
>      * CPU3 --- Codec2
>      *
>      *    => 5 links = 2xCPU-Codec + 2xCPU-dummy + 1xdummy-Codec
>      *    => 7 DAIs  = 4xCPU + 3xCodec
>      *    => 1 ccnf  = 1xdummy-Codec
>
>
> So, I don't understand exactly how did you get the formula for links. AFAICT
> there should be 3 x CPU-Codec + 1 x CPU-dummy.
>
> thanks,
> Daniel.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
