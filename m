Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F9C27C76
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Jan 2023 17:42:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E733868;
	Sat, 28 Jan 2023 18:41:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E733868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674927746;
	bh=UsFqkHpq+zecSpbileA8oE88rqAqGP2pVfXbVmj47MI=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RZWQ8kYFuJRaba3LhjQmXIqZxr9jsNV1pZG9JVOTETQEwwbZiZISy3owbYDc1qNfO
	 lIqtwkwwnutTSG/mtihTcavZItjAkfoNmSPrZt1g+NhUe4IgC3AKPd8kHfkSw9QL2A
	 xTHw476+e2rMzIKyWnLjEMPtS8Y3PoJtwtl+AxM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A2E2F8025D;
	Sat, 28 Jan 2023 18:41:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E035F8027D; Sat, 28 Jan 2023 18:41:34 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D339F8007C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2023 18:41:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D339F8007C
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=L0lEN66n
Received: by mail-pj1-x102a.google.com with SMTP id
 b24-20020a17090a551800b0022beefa7a23so11633134pji.5
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2023 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UsFqkHpq+zecSpbileA8oE88rqAqGP2pVfXbVmj47MI=;
 b=L0lEN66nLcsX0ghB6goBIntsba9sN7PcE6bVsX8ySLBl+BTHGRTq/G8B6WBORTZd6u
 QpRKoxp5+i6akpcFjzK2ozQ7uT1mvJfm2pj9NIyqGZyOU1/JICy3371dSy0F7VEEFGQb
 1mzVZ+hDE+u7xApSKYzyaNS0IX4NidUm7LCXdKwQCz6J+izOvZPCgV4zBCKj5PSvFbaj
 ulv47WxfAQYIo1MtAl6JBMfhz5KMJJKIL6em1ktwODZjbBn0V6OFS9B9yW+OCc1bNqxD
 obbktN3BLzYa/z8JlgPVZv+wIqcWBMQm+Vi9gf2fTD6cf5MttxmUrh9RfvUMVqFShXvw
 GaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UsFqkHpq+zecSpbileA8oE88rqAqGP2pVfXbVmj47MI=;
 b=uijRbg+8h7UJeyQOilEdZAF6c06sMPJmCzBio9pn4oqyMl2b5V7rrjxwvRhSFC+/gV
 X0emSLYjLePnoBRTFwy8sbXIhH5UxzEDDnh8Nh0+e5t8iL0c0JD25U/tNcA1UPlZiwN1
 anz6+r5+0KsFb4u1bQjlmrSyohHUtxm/GjyMny2IlVxB9IwKp1JNsnKimjq8Kb0r4ry7
 MdshYJ2IWwp3czgw7cpvxzrICk+AZSOx/SNKLp/hsduyXfwXJ98nKL2OpvXcCkBkb5rC
 BElGQHOh6aD4wrlLj0ruWDaM3wB0kjNlEg1LtUWzCTVOyf903n4xK11XcDI8C4rl899+
 sUgQ==
X-Gm-Message-State: AFqh2kpi3nrQCujkvlCrHVzRkRq2K09IgIbtp1O15VQm5wYaydG1qWVp
 vDMovtlVGX2Xv6wJ1YVhieC0LDnBDMhF8COTzJ4=
X-Google-Smtp-Source: AMrXdXvG34XZO6eEJVvN5aHCgWL4ph6DjbkuCqQRHM0QoQwGRZFixeab9z7mufGs9srhIPdEp+/zj5Lq4CAL4PyhNTA=
X-Received: by 2002:a17:90a:8404:b0:228:d64f:ddbe with SMTP id
 j4-20020a17090a840400b00228d64fddbemr6866466pjn.40.1674927686993; Sat, 28 Jan
 2023 09:41:26 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5CVCm5bpVThYW7V379PyTfyVQLBrN03cUfOxLRyBXp0gw@mail.gmail.com>
 <CAEnQRZAUx0Xg_3J161VG=m9oCQFNBT3aFHwExFbWWOTK6xsSTA@mail.gmail.com>
 <CAOMZO5DECuV17T+1u9WKXdZfGqQ84kMCm2Yt+b0cuOuFFUiBLw@mail.gmail.com>
In-Reply-To: <CAOMZO5DECuV17T+1u9WKXdZfGqQ84kMCm2Yt+b0cuOuFFUiBLw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 28 Jan 2023 14:41:14 -0300
Message-ID: <CAOMZO5DPLdt2BqPVrwd9+TCYnJAGQowKqL=7g6i_-Fr7qktDPw@mail.gmail.com>
Subject: Re: i.MX8MN: SAI: First playback failure, second succeeds
To: Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Daniel,

On Wed, Jan 25, 2023 at 11:51 PM Fabio Estevam <festevam@gmail.com> wrote:

> They also match in the working and non-working cases.
>
> I have also tried applying your patch:
> https://lore.kernel.org/lkml/20190308173904.27298-1-daniel.baluta@nxp.com/
>
> but it did not help.

It is working now. The error was caused by an out-of-tree patch to handle MCLK.

Without such a patch, it works well.

Thanks
