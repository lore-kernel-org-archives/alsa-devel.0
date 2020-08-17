Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F253C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:33:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9106320758
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IHJW3vdC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tNKStXXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9106320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25EBA166D;
	Mon, 17 Aug 2020 09:32:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25EBA166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597649608;
	bh=coRFPJbKc7ywpJ/3lZow7TORgJ25yZLIlsHXIN7jxzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IHJW3vdCXWfAY5fC6xCi0uhRQ98XRyWT/biD09ZQVBO7uyyr4dXSdJ0dbOekMcsDJ
	 jOSkPhU735jq2b8izn/jJh4l46gh2pmAjNxQgRk2yhdB0GkwOC03DpMxMYpitV5pj8
	 3xXRbQcSw4dUSqMzkNzgf62lAyVnxjw6YXm4H77U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF105F80216;
	Mon, 17 Aug 2020 09:32:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECCCBF800F0; Mon, 17 Aug 2020 09:32:35 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D69FBF800F0
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 09:32:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D69FBF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="tNKStXXB"
Received: by mail-io1-xd43.google.com with SMTP id g19so16657496ioh.8
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=coRFPJbKc7ywpJ/3lZow7TORgJ25yZLIlsHXIN7jxzI=;
 b=tNKStXXBprrwJHyJVh8NMGU+XD/0G/4WKH47mbhpwKE5Z6rUlmgshyAEzqbJncPpcU
 rcC87eSlhXpk+Z2a5TSf8ZcQXN8a5uCph2e7RrhB7fIE4V83bm7yahnQ+xyeUVvrUyM4
 lykuFoQpx6RtkQKUW664Zfrx9e63X4S5cxa2kRaMjc4MNWWTPc5c9qOBg7tW+qCx0PNI
 IUkErl6rHI/4UhdfAst2zcAWE4GiNkjw+V40iQLu44pN5lNZQIZ7Atzk9qYEMmkEwl2b
 y9OiDJtGUpzZM6gjZyfua6XC2nvhby0JbCsJx8qg1u/l9qnWHZmPZ5+fjbgsz9E1LTuC
 lgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=coRFPJbKc7ywpJ/3lZow7TORgJ25yZLIlsHXIN7jxzI=;
 b=jt965Y42BRfbQnrjN3vjDqBh7mDvpoymfP8s/AIUfB/8hW/MDkB7/d3ktBo0c4wOjt
 fncdriduUQ6NQH8WOpnL4zEwE4O6TcdlIAxAaiSpv0VhqerS2Fje54B9tU28jdWUEEB0
 lbsQuHj9q+6SS0mbrY3jIwYqZILVD+b3ffd9gDQoMDgG7onC6Ft3CAd7xildutoHXAg7
 6V3+mlou0yCakiMZo6WrUztrX9wzUrLDQ+y1xkDoEtHRBQLrj2cJ0p7ZOuHZmIy4byI0
 vUIQuoQ5rt3B6dAWz2yAKMUAs5qP8cLGejtzEoE8sBrCmVP9H38wfO/+ITSn+Ej1beBa
 HubQ==
X-Gm-Message-State: AOAM5331TZs07N5LHATlx38ruOOX/VAgEQzBg1tz8T3GgxoDiTV2XQ4z
 AlJVCvpssGM7QKuElWVzQKSgk2MgmPZX0TGNcM4vEQ==
X-Google-Smtp-Source: ABdhPJyiQfEySyRQED1xZDsTrTIji8ZHp7mV/pCtyczHBll+qmrXXvVx94yMgeUGA+HSb+ucUVNCLkMo9+g8Mg+yu04=
X-Received: by 2002:a5d:8cce:: with SMTP id k14mr11326563iot.13.1597649547058; 
 Mon, 17 Aug 2020 00:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-2-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597644455-8216-2-git-send-email-jiaxin.yu@mediatek.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 17 Aug 2020 15:32:15 +0800
Message-ID: <CA+Px+wVFKNLYhYpchR-zmNkxaj2_fVYM_xUt7w73pp+KcNkR3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: mediatek: mt6359: add codec driver
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>, howie.huang@mediatek.com,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 shane.chien@mediatek.com, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, eason.yen@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, bicycle.tsai@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 17, 2020 at 2:08 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> Add the mt6359 codec driver.
>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM, thanks.
