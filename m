Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5235FC2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:36:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF6120873
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BiSLz3t/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UZ6fDAw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF6120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 291651614;
	Fri, 14 Feb 2020 08:35:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 291651614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581665790;
	bh=ygaEFxwec3H5mWAumwoa9WKXKdPyzhEy7mbgwNie2bo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BiSLz3t/XUNfzICjg7DmjGdJvPI7GRG9ptki37ieMcpamZAobzykqcdTS03yIq8cA
	 bE10avl/ycedT1zgVSmNrsrTCLcdo7vOey/v3d7eC6pyXxjKFFwN77AZreC0nLksEy
	 lm+IDAKr45nWrVk9R05kSHIj26V1+71HzalUQ/WI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97DC1F80138;
	Fri, 14 Feb 2020 08:35:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E28BF80138; Fri, 14 Feb 2020 08:35:37 +0100 (CET)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEC7EF80138
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 08:35:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEC7EF80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="UZ6fDAw4"
Received: by mail-il1-x144.google.com with SMTP id i7so7288341ilr.7
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I1eG2NiwnMHcD+8ZEBk/TQZkr1ocwevoK5Q1stsGPh0=;
 b=UZ6fDAw4oN8KlRZPMnBhJd0Ev8dZAqA7G1U4REXYuJiWgp0PEusoKpzvbadHqnAz/M
 KuGdLZbhYZ1znnKIXK1Dvcdh+8gFSkQq1PS3X2WfvZ/h91VHULyySwO0TTPA/H4LgRxR
 KiY61A4PCh63xBcYTtdEEow9lR9sIb0KkJ1E4V7ei5bxq4/XqhxVv1ZftYgq8/Zgb/rt
 ZH/X8w3p0MKGOrspJqJm4+U+8EBBU7ghgaJkhkORbSfzHDTqMxihRLzWwt2y4YrjlvDk
 l9myA1r5rLq84wDBjMMRPmYwWrpLwKsCG5Udq8zQeW1I5ivieU3AxYA805kVSpDOu3S/
 Yfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I1eG2NiwnMHcD+8ZEBk/TQZkr1ocwevoK5Q1stsGPh0=;
 b=GpMD1DANAaZTAZRjssaN8AzuYFGbbE0Ms2xoORISW5nZqNrsMjX2FSzoPrtkQsMjiU
 9j/6zFa7Vpmsr77CpM5RC+2Nqt8eSCYReloEKfQuq2f1vc+kZZAYI+AmeES08Ernluxq
 c2C/x7vuC8dWYm4zdGf6hwZN0iFDeQUh5YNre6x96KEL/7wCIlZl4T+k3AEccSGQCCan
 7ZEn16ZZ+bY/37S0gq9VmWzl/CdI2R0cAqZBXhR8118m2tcKNN/T5gTlavEm1P+TQWlk
 DK6zxwZwsag7jfByXGzEdyYfs7vwbPsOzWNj6QGdPy5dNpsrIwH8lsNkW2ptzRtgm+yV
 BmzA==
X-Gm-Message-State: APjAAAVhztH3Uk/jzBJ3D7EeWGhko2+nbwIRf9w1LU0hfPE0ld/0xbiU
 d7QHWig7JfiCQHzYDjnnuKftgqPm3lQktzxhLEy5hw==
X-Google-Smtp-Source: APXvYqzd5x9vUof79ss9P8ZSwc9sQuJX+BQLK7R4MtTtWZfQ+G1G0z3XtZitNmw0tqejxBn+XcigB+3jeNXBx5X/tnM=
X-Received: by 2002:a92:9c52:: with SMTP id h79mr1618052ili.213.1581665726341; 
 Thu, 13 Feb 2020 23:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20200213153226.I477092c2f104fd589133436c3ae4590e6fc6323b@changeid>
 <1581664042.20487.4.camel@mtksdaap41>
In-Reply-To: <1581664042.20487.4.camel@mtksdaap41>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 14 Feb 2020 15:35:15 +0800
Message-ID: <CA+Px+wW0BWz0-8L_UXJ-OYbwG6W9vmCWRr7kevpk0yokp+NKKg@mail.gmail.com>
To: CK Hu <ck.hu@mediatek.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, p.zabel@pengutronix.de,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Dylan Reid <dgreid@google.com>, linux-arm-kernel@lists.infradead.org,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] drm/mediatek: fix race condition for HDMI
	jack status reporting
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

On Fri, Feb 14, 2020 at 3:07 PM CK Hu <ck.hu@mediatek.com> wrote:
> I think sound driver could be removed for some reason, and fn should be
> set to NULL before sound driver removed. In this case, codec_dev != NULL
> and fn == NULL.

No..if you see sound/soc/codecs/hdmi-codec.c, plugged_cb is statically
allocated.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
