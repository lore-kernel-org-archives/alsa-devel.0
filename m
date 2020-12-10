Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E51C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:26:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9B52310D
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B52310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3FD51666;
	Thu, 10 Dec 2020 18:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3FD51666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607621163;
	bh=2FGqJeLFDHDRCLV1yGnwqYZlvtln1+KN7xtfUqUo7ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEtqZjt8Nds9nFY+A4ZzGTOfpjHtf/TzLGqSf4BNRTtfPUNRCsIv7Yzj5nHMBf0aM
	 t7sPNfBqtHhnbXtGoAYGWuxQRTHkvlnzUYr0PxHI0fapUGSr8ytdgkDoo+T+c3s3Z1
	 jMhoufxuhxedBnbzI6mXbEAvRFRmWn0uO3SMh1IY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61FD6F800EF;
	Thu, 10 Dec 2020 18:25:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10A87F800E1; Thu, 10 Dec 2020 18:25:09 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98B64F800EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 18:24:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98B64F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TOG920h1"
Received: by mail-ot1-x341.google.com with SMTP id b18so5608958ots.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IFQckzUxker7hD4gEVPk8FIb33ZU0VYEtCHChGBdgHo=;
 b=TOG920h10dQaSs1Q198SciJA7oznw7oR34uKYF5py3DQuEjyYTON9+z1HjOnjjjlvx
 JXrgnkCecWzR+8rvOo/d6rjtWTapmCrFezHhoy5XAK4fAWCx+fbc1ww+ua29g7QLGuGE
 KK5Zm3uIJiZrSF0Qx606sq+DZUECSFH1Bk+hBJ4dC+s8BuQm/z40aDRibum/3JtzT0Un
 sAlIIFRX39vUFtEeYkO+Pxy3Dk5vBzVh0Ibx6JOtD+u448UzRrzKusHOz87Ppeq7P4Fb
 sgp+H+hLlFfleb51uqa7uE07Rl6UVe8smo5VvvAfD/yo+6CptPnfM8Hg6SXxOtAoxd7N
 6aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IFQckzUxker7hD4gEVPk8FIb33ZU0VYEtCHChGBdgHo=;
 b=eM2XgMeqTJunemEx9s9ZxAePHRlIyumAMDXrN1asZDnOsH6RX/WEbhIBIyQeKvMiHQ
 v8+oxZorNfNtPrXpaJEwBO911LKR6oxX3QXZsxp0MrQwVvsTY69afIcY3WxHumTRWdHO
 fFTqm4tdDhsVCpB5XG4kFUywIIp0yA4rOxX4tL0sujUuQ9f3+mOehrtjmrqG/xNgCatG
 IJExhh9mrOZDxWceDWj1ZOn3BQ7sn4Rwmt7wP49OqDUbB/f7gqfLYyrnPgyoHQFVq+b1
 6M2veoaRrMkp6XtY+FHcjfROrvh6l+Yq2FIjKceer/0LI+LiJmHNI9rvjRVPE+bCzSPg
 exhQ==
X-Gm-Message-State: AOAM531MM+EC2u9Ut4sTuYOzwzuF+DfeSDbUFPXEOH6qOaVqbHLCGL9B
 KFa0PYS0GXwwTodhUKepDE/jCj4PGb3aVQwubsU=
X-Google-Smtp-Source: ABdhPJxOMhMACKGCkVgQUS9xHAEg0wochoEtFLfmyVRzXWlQkk1BKLm6ABpG4Wh5IMW+NWtCuDnAA9jEuaSihXQOe50=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr6900148ote.132.1607621095196; 
 Thu, 10 Dec 2020 09:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20201208195223.424753-1-conmanx360@gmail.com>
 <20201208195223.424753-3-conmanx360@gmail.com>
 <CAM8Agx3ttO_RDgjQAxLYpVMVRhz+xgmg80f4iefXZNVrGcd0-g@mail.gmail.com>
 <s5hczzhr2xy.wl-tiwai@suse.de>
In-Reply-To: <s5hczzhr2xy.wl-tiwai@suse.de>
From: Connor McAdams <conmanx360@gmail.com>
Date: Thu, 10 Dec 2020 12:24:44 -0500
Message-ID: <CAM8Agx1+FiaqoR7jG5uD-XQkwzu2YiVOZTAEy8JuKLjC3XCU6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 stable@kernel.org
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

Will do. Sorry about that.

On Thu, Dec 10, 2020 at 12:22 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 10 Dec 2020 18:16:00 +0100,
> Connor McAdams wrote:
> >
> > Woops, sent previous email on the first version of this patch.
> >
> > This patch is a mistake. Not sure why I did this.
>
> OK, then could you resubmit v3?  Now I reverted the v2 patches.
>
>
> Takashi
