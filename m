Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E1C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:48:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4472073A
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hQw+HpJu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RUDwy5R2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4472073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68F6C16A2;
	Tue, 21 Jul 2020 13:47:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68F6C16A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595332087;
	bh=IRq8ucCfmuFJvcTFkc3tS7Wj/uLZA8Spf3C0id9cxrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hQw+HpJufDYzSXBUF7mpSXHUp307iAHdKyDMatZQKc39Ttrk6IDHdkhUkkc5zXv4s
	 bgljyxdNkavG3RCnIBOQrFFu0h4Sxdtz/grfDCakj+HZZHfEl3kqBRAyVcHquZf6PX
	 1UDZTVc61jmFTtpae3UlcZvfTaB4lApO52550O1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE8ECF80212;
	Tue, 21 Jul 2020 13:47:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9132EF8024A; Tue, 21 Jul 2020 13:47:15 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A5C5F800CE
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 13:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A5C5F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="RUDwy5R2"
Received: by mail-io1-xd43.google.com with SMTP id z6so3514405iow.6
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IRq8ucCfmuFJvcTFkc3tS7Wj/uLZA8Spf3C0id9cxrY=;
 b=RUDwy5R2+a5FcDCg5Cq7hkluN+M5R+bUbQi2wWTIXT/XzGtTdqGuKd7TkRNE6aS+yC
 ibSbJ3fOYtsswQJmU0k2GbpqFSf3yFp1m2wLGDdPA7oJ8dukiXKrxBgj47D/ozvGCFKf
 3ZXxHx1KYIAq8f4yp97OhZkSp9qfyD6cQ335kfeomWXnQnVTi9RLMhpSE6LhVm3PHbbY
 lcc/Bws6wFqAfy8n4vYBWy4QGR+N7XKXprisTQJ5XllRn8f7TjZgR3ZN8gAW167n16rF
 Ukai0FGxz8zAeBmXroqOjqeUfcxhGiTOxRZjW11MMB5kQlBa5CQ9g/C5UK0tc0A1a7W7
 Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IRq8ucCfmuFJvcTFkc3tS7Wj/uLZA8Spf3C0id9cxrY=;
 b=BrhexOMRNs8P4r0n1m8vTxKdeeQRMss+RXNOnPlSb5Mkj2tnEpNvemG4N6zmyPqY4N
 IV/aZ0oCQXUxMqgervPcds1FEbAM1W3Tf56U4sQwnqHRQA4DHbOBRgwh0IjJO5C91TVJ
 DWrZ8dfmjqBDXaNxEvteeddSpRevAnzkeHmCBjq/jylHuyEvvwWBPOFd9uWspeSYFw1s
 duIBaJ9xKKtpD+YbgW7y9xlr0st+G1m80tBlwbfQ60/Stk04gNJlFGMcIYBiTcjBTQIx
 FSoEhVBBvl68E14C7ZsmGraQsQhCnTSb212NVHBsv3r9SaT/+hwjt4ygR5M8qDlZ+wJv
 9Rfw==
X-Gm-Message-State: AOAM530Rcn+4UaYjM3Z+lJdWRqF4DC13Yq10XhbYwtl4/s+XGY1T5pRl
 AcEo+/L8HkU/3muoowDsQS7onR7lcqKNQSzIFk3RDg==
X-Google-Smtp-Source: ABdhPJye8qmq76v2qG18buCf5XgXAaN7ZfKIQ217WAXoEp+aVmjEUDMteAbXQB+XN1Y95WqgmvGJC/9JsLyBwYAuZUM=
X-Received: by 2002:a05:6638:11c1:: with SMTP id
 g1mr31491011jas.34.1595332027045; 
 Tue, 21 Jul 2020 04:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
 <CA+Px+wU1S1EqtW-yZH9z9aCF3ggSriBqy73SRYy8q61x0GkdQQ@mail.gmail.com>
 <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
In-Reply-To: <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 21 Jul 2020 19:46:56 +0800
Message-ID: <CA+Px+wUhAHAx-qmAEWy_8Jy40NDTAHH-TNYtPtMfwocMHQ=AbA@mail.gmail.com>
Subject: Re: Speaker pops with max98357a on rk3399-gru-kevin since v5.7
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>
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

On Tue, Jul 21, 2020 at 6:40 AM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> On 17/07/2020 05:27, Tzung-Bi Shih wrote:
> > I am not convinced the pop comes from 128f825aeab7.
>
> Maybe some pre-existing defect in rk3399_gru_sound got exposed by
> 128f825aeab7 or the machine driver needs some changes to complement
> that commit?

Hi, I got a rk3399-gru-kevin and can reproduce the issue.

Could you take a try on the proposed patch here
https://patchwork.kernel.org/patch/11675533/ to see if it fixes?
