Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3859FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 01:47:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1558122582
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 01:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1558122582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D4F317D3;
	Mon, 28 Dec 2020 02:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D4F317D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609120062;
	bh=tF342TNHudEtS7Qv9jGgqW66Nx8Vjdru1HdbRRzpHas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMUg1cZw7SZpA7eWddCPU7515CPEpGZyn3Gokp9di1HU+XK9FHM4dXs/xQmlZa3jz
	 dvSUZ5f0ufG7CoRr0Jre0zJRaZejv0qxvjWwDptScdg8Ny5CMzDBeyNYO1eAxiRI3s
	 UBN63Ahqz2uZygcUsFOOJoWtC8xFu/TP73DmEiKg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4828F80240;
	Mon, 28 Dec 2020 02:46:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BFDCF80245; Mon, 28 Dec 2020 02:46:20 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EE49F80169
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 02:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EE49F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="r0tucrOt"
Received: by mail-lf1-x12b.google.com with SMTP id m25so20764800lfc.11
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 17:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tF342TNHudEtS7Qv9jGgqW66Nx8Vjdru1HdbRRzpHas=;
 b=r0tucrOtUYBBuiFWW/lAoXUKB5KLvpg3ApwBlRaIXbRm1EPgxg+OSg4PeynhX/8U6f
 SEhqS1kUxIiWB1pmy6UzTRvZby3FxLm/DNywhETpivZV/1OeH+RLra5IyPlIGmhbbY9E
 Fl3w2W6PYD9kOo0bak2kIj1KHuZDfZHTMPKew2Z9ZrG6L/G4lLll6YFIzFw/j6N8iemh
 ecxHeXcaHqP9TFgJutV0AUFAJiUML5QUkLS/saRCO5rZin98Fj3h8acU4KJGmUniu2GS
 O4OTYv0kpmqKoCn7Qy/YZ7v4e7OhAFLcMnnFpOsNl0IXmZ26YclAbON2OpKwco/Hwtvr
 dE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tF342TNHudEtS7Qv9jGgqW66Nx8Vjdru1HdbRRzpHas=;
 b=d7xHGktL0LzWi+Uyv6/AwEvVgSxzW0ytfPrkmjT/gxeOruoHYC5PaMvBI5rRH89OC+
 x6gvByVpqf8dPHJWOPgX8ybUwnWleu21Rhgn3vkyz+c8yLRDTBaGO1iujpEgync0lG9N
 bR0bLmBUzr40dCHojs1r/SWRDXSzpc+QnMHF3kVIXq67EDt5eASr3RNtJBdPEg/uGmdC
 LYzpj0HcmfqEiJtTJMAjXaQn440bL8WL4Bko0KhIJ0BiRfJ7NKy6NMlyic54K+Kckq6J
 D2cHuB1ZK8aIQGVsRAwF7wSVTbfhCP7RvQB01i47eD0r+fnECMqVlTxyQwDXvz4Zgtw3
 7eZQ==
X-Gm-Message-State: AOAM531HnONpRFSV3n/OGj8zsS/ex/2SUTNpNZXJy5uq1BxFAsK+ONZB
 cL+dTcqBs0pSnkVKf/tKWnLvFe4jIu/xgFh2WBE=
X-Google-Smtp-Source: ABdhPJyNXqaxSjoGRNxM/2MPReS7QbaP2ozMkbwHT4690iE7VDjKnb/VWol4or5nKjN1BXRs0id79vRYLX+9O1QcClY=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr22021319ljz.74.1609119971324; 
 Sun, 27 Dec 2020 17:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20201226213547.175071-1-alexhenrie24@gmail.com>
 <20201226213547.175071-5-alexhenrie24@gmail.com>
 <s5hzh1zejsr.wl-tiwai@suse.de>
In-Reply-To: <s5hzh1zejsr.wl-tiwai@suse.de>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Sun, 27 Dec 2020 18:45:59 -0700
Message-ID: <CAMMLpeQUPj8KJhonZ-b6rK_6acYyGfwKss81aDXNfbfh=QfDAQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] confmisc: fix memory leak in snd_func_concat
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Dec 27, 2020 at 1:26 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> I guess this would lead to the double-free at the error path after
> realloc() that already freed res before the goto line.
> Care to fix it and resubmit this one?

Thank you for catching that! I just sent a v2 of this patch.

-Alex
