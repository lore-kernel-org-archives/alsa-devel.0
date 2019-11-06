Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F72C5DF60
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 01:22:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E042245C
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 01:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O51s9oGx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OVrQ/QCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E042245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73D3A1706;
	Wed,  6 Nov 2019 02:21:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73D3A1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573003369;
	bh=XxVJFF5v4fXMH9vH4GSB39vF9uHBDvEwaFLoLC9G8p4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O51s9oGxBG6cilCsPSsXwbAwoXCVhi7XOK4fHc3nuQavtX6bSlC4+PihsBCHUJC/c
	 1nWmQyJVhuDe0Tdv7X/cWspxSwFIMqxiX7TRrqC7glm+efayod4TrDU8eoUAjBHSJ8
	 g0h6MU5vjKl+lt7AiORs3zPH26sH2mWO+lDiygAo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37A06F80446;
	Wed,  6 Nov 2019 02:17:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C027F8049B; Wed,  6 Nov 2019 02:17:54 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9412BF80271
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 02:17:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9412BF80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="OVrQ/QCy"
Received: by mail-qt1-x844.google.com with SMTP id o3so31895187qtj.8
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 17:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gCrtO7fiX85h+LuXrkDpZD21wwFT/XaHDQqRI/R2+Ho=;
 b=OVrQ/QCyD0M9cGPKEQ8mTXD5P325NCq3cLzFsVwCwCSz6CcnaJpO8Cc1W8cTzzd/rO
 ncC4HbBEWOhMlU6FFQiTKbmQS1b1wihttWWll2gk4q5FRejT2onxEYB0Q9Zf7XgAY5Ln
 rAJf96zthGUHtGp3VurKUUxnpOMeoLCQ17N4DDIzsw/CV6b/SLgdHDutPYp6+6sxMe5c
 3oSlcFAFJpetZ27K5qazD7E2woBuQSDXF8Il1O6jKBkzRddouh6ALKB1GQRL5ZPojt8r
 IQ90zYU88lIWdAiznvCxMyIj1AFwg+HqPWdOKfAFdN5WgMKzTJoze5zufHPyGZpYqzFQ
 h5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gCrtO7fiX85h+LuXrkDpZD21wwFT/XaHDQqRI/R2+Ho=;
 b=Uru0tx8iM/P45vZh9MYEyD8noTJ9MaCraiGJM9YJ4SKC5Q9mn6YirGU2OJv8ajqadS
 jQMhdS69Qmlgk0H88XuPGgbOunZ9wnVODMwjeysuQMfC1iFK+WaT3BYFe79wWrMAAXFO
 6k5MnYuLc0Jp5SzOCP6mGJpHQCjlVfQzQscHR/aAvDblIO+XqROMyt1deQbvEmHoDSms
 PSM84Wr3F0ozr/kKEeANcwYCyz0GfIIG5wz8+6CmuytCaGXl3tx/AdwtTPa9dI4jOF8k
 6zTw1EdaOUQ4clr66NL7+2bT5RMvLqIB/RfmNuA77qiSaYGMOkY3O0g6/ZJ8jfF1l6rX
 CjUA==
X-Gm-Message-State: APjAAAUArAFSHKcLt3By6XG2LE34b7LKT7ZTVKWLWSvEYMGrBfXhcJxo
 Mu47wh63sDE/9mxJ8W4PKAJmRCucuZzwuDAjugGUhQ==
X-Google-Smtp-Source: APXvYqwUSVXsJ4XpmEmFSD7lMFpKOY103CRdn8mGZMzHWFM2kB+w3KTc2o7pQtNslFgB98piqi/AkOx65UNRaty0zRQ=
X-Received: by 2002:ac8:289d:: with SMTP id i29mr164998qti.24.1573003069006;
 Tue, 05 Nov 2019 17:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20191106011335.223061-1-cujomalainey@chromium.org>
 <20191106011335.223061-2-cujomalainey@chromium.org>
In-Reply-To: <20191106011335.223061-2-cujomalainey@chromium.org>
From: Curtis Malainey <cujomalainey@google.com>
Date: Tue, 5 Nov 2019 17:17:37 -0800
Message-ID: <CAOReqxjToRK9eoDj4GGKsp7s1jKcyW=rQvymFuEJK0CQny6TKQ@mail.gmail.com>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [PATCH v3 01/11] ASoC: rt5677: Load firmware via
 SPI using delayed work
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

On Tue, Nov 5, 2019 at 5:13 PM Curtis Malainey
<cujomalainey@chromium.org> wrote:
> the codec is set back to normal mode.
>
> The kcontrol 'DSP VAD Switch' is automatically enabled/disabled
> when the hotwording PCM stream is opened/closed.
>
> Change-Id: I9db4a2d125e83c13a969e31fec904fd52ff500c2
Gah, that commit hook always gets me. If everything is good Mark will
you remove that change-id for me or would you want me to resend the
series? Sorry for that.
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---

>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
