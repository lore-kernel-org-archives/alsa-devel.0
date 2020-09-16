Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73808C43461
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:53:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839DF22209
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EAHKPdb1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNTpNjlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839DF22209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C215711C;
	Wed, 16 Sep 2020 13:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C215711C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600257185;
	bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EAHKPdb1iXEMRSzOrKwKrVYxyn/kZta7WQMcrlzBsr5GEAIQJE7ltpQu2tiadhfZJ
	 Wj2WPxnRRyyRHAGVWxztKVil9xJxPUu8CMc0EKWz0SM8QtsRpsHP0ack+kVBpFs+9H
	 LdrEGRr5QbcKhwqeU7sl3fsqWxvxpLkOm1Ce5ygg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4331BF80150;
	Wed, 16 Sep 2020 13:52:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9890F8015A; Wed, 16 Sep 2020 13:52:12 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0C7AF800F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 13:52:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0C7AF800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rNTpNjlo"
Received: by mail-lj1-x242.google.com with SMTP id u21so5646546ljl.6
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
 b=rNTpNjloivgL4IIauQWwsnW3KxFixBc/ITJAbmTyYNUMIyMEtpg9ZBa48r6s6fWkYd
 /NfUhyCTCCGtfo4ijiup9gAKreg7Bs7UIPUy0PiJqYyXqvz79OMc2HMYFSibNNsuytD+
 1GRo7G6lEiQwDX+QJ7aWDh8rHqBvf6EyxvLp2yy5T9ENaAZDZzpf4RqYI4x/oCagOemc
 Ja0kUPbj7gs0YCQEf5nPzBV1F46VmAvwn5sEw7qX0W9GCZMqTz8aSq5ygPvz1N+shfms
 3aJJ+nYGGWY+EnxEmJ+aeLDed6RubyY6R3r4JDiejlYeeNMii+nbcxI3mM0jyTSPfW6v
 C8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
 b=WTpgY4eHbZgERVNvYfrdst8a+71mq091hwGyoCO+vM5meyxl9Lj1Zsd5jdwqWJ+JP0
 f7VQPzIXFidpFtgKL5KMV5jzSOLYtksA07tksADEPSMgitBXD1sjPW73wYuP+i6FgwUY
 v58sXm2uwZLjxzszDkAH8v5/ocgqbIG8xLrkQXX9WPvkcXhdsR6VbQ+/KseT9k1Zubqv
 k8VJPah0EX3/wL6DKmDOHaFp6Ih4VzW0dmMfKUI3Bc2ZvxQsDi7bvuZrhOsGOO/Ycpi5
 ueVIu02pSAEQ8Gq8Yf7VARMagI4w3G9BT22WWkQDZlysK/07ivaPNQYmMLaZ/xgESEso
 j7zw==
X-Gm-Message-State: AOAM531R0DwkJzSWrTeMNHKtaxSN7wT5rzixaJPPtZI6pplfPrIo+mLJ
 1gf6KqkxCsyc9pNWJLlvOU1g23Mpsi4zryfJ25w=
X-Google-Smtp-Source: ABdhPJzc002ZLUmgbuaE62WjRqkY0WfMHJ0a+m0maYHyQ6/Z/CBGbgoyR3VB9GpneRsAU37REZo3nFwFnQ/HWmLHjIE=
X-Received: by 2002:a2e:1444:: with SMTP id 4mr7758634lju.218.1600257125682;
 Wed, 16 Sep 2020 04:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
In-Reply-To: <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Sep 2020 08:51:54 -0300
Message-ID: <CAOMZO5CEViX6E8sNo0LROk3Y92_BCezHDpfBqMaQK_J4kT24yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: update the register list
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Sep 16, 2020 at 8:47 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Knob kmg

Please ignore. It seems my cellphone wanted to write something.
