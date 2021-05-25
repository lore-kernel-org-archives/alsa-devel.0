Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE43C2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 00:31:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56E16141C
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 00:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56E16141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A73611693;
	Tue, 25 May 2021 02:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A73611693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621902692;
	bh=oLP4oglLNCR+9nXwmE8IhmlcVIVSmG3eaWpMOp4bmk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2DsGTgJIgZMk4+Yhec8rSaGB7c+awsq1sEWiBHYYjciyT4KoA/xqT6uOdLFwRxzr
	 plsJOIgiOcUMwH6xZhtH670o/I42dNos9X/zM2A4ibh/msr/4/Dx1theyXshSTwMV1
	 kAg++MnWPhqasixlDqtzLcyV1VHiPDiqRULoALJ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34D84F8021D;
	Tue, 25 May 2021 02:30:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42CC5F8022B; Tue, 25 May 2021 02:30:41 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CCFBF80137
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 02:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CCFBF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="rP/2hrI1"
Received: by mail-lf1-x130.google.com with SMTP id w33so35254787lfu.7
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLP4oglLNCR+9nXwmE8IhmlcVIVSmG3eaWpMOp4bmk8=;
 b=rP/2hrI1pD+HuYaQkfSjt5L/O90JURl9WFveM0Bp/G+tbVrsVgygnir3hDkS9zFJqX
 XwL1LfEOIOxuB2aKqJEngEBuhsCz6MqBjebju6J+qBFyEqlvdRwR5atOCQXXH3Kkx2N1
 3fY2XXDpsZlfzLr4UMLuyNrxt/cNHjLd0CZdrgN1EMztuULY0zPEj5BwznG9AS3nIfd/
 Jpyu3RspjH4vFW3p5DQ/fhfYDFtsnm5XHL1ibkcu/Rny8E7jbDKOStD/nbSOvBdYKnco
 4wpIIkaIXl924s6i38dplGClI6DKYZSrxnniQcXThYcEDAsgkwfVcoYyxGdrcze3TwKm
 CB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLP4oglLNCR+9nXwmE8IhmlcVIVSmG3eaWpMOp4bmk8=;
 b=qDIIEMqbwxF7b/IwItiFu7xC2HEvrLGg36OG4XpPWZ5q3uNOA3Slxfgjv3pitMsv2A
 Q16E2IRcRsoU/m4S0vAniU4yiVdZOo5lVnF18GwGTWtpspJ0mOPjtAECivm5j7o3k76i
 JovSuWPg40XR7LmltF3lN9Ax6kABiOnpzqmfqi3ny/pCtLvo0Kj8HeAXcMVoxdWgBdb/
 QnGxDJVYTMeVs/1Pr3VSnCJpBquxuTnxbDj0Ks3GPshl+kaOgTQvXhpC0Y4Fc2vaFRn/
 IzctUBo37NWzMRYvNsx2A7feqef77z4Em3IcDpBB2+t8dHsn+/HXmLw2lR4phG2qDb78
 WUiQ==
X-Gm-Message-State: AOAM532CXuQj4L2w232EDxQAw1lhvoLeTbTHXwc8iGNgtPUnh931Pbdn
 QeknXGBL9GHbFh+VPu1AiXonlsMz9Ac0Gh2B3QzuqQ==
X-Google-Smtp-Source: ABdhPJw1HN3EJMYQmc9N6v18t6ySbunlT/243xY0jxo6mquZnjHFnii7atHe6NxbmrbfQ6HLxJ1mbqJN+Y9YvZPTUTs=
X-Received: by 2002:a05:6512:11ea:: with SMTP id
 p10mr11731891lfs.157.1621902632596; 
 Mon, 24 May 2021 17:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
 <46ac2e918c7c4a4b701d54870f167b78466ec578.1621413933.git.mchehab+huawei@kernel.org>
In-Reply-To: <46ac2e918c7c4a4b701d54870f167b78466ec578.1621413933.git.mchehab+huawei@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 May 2021 02:30:21 +0200
Message-ID: <CACRpkdYU4LQM54rht9quJvfxJ7N4KjJf27+ckNGTdLOW1LF1UQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] docs: update pin-control.rst references
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Saravana Kannan <saravanak@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Drew Fustini <drew@beagleboard.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Randy Dunlap <rdunlap@infradead.org>, patches@opensource.cirrus.com,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lee Jones <lee.jones@linaro.org>
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

On Wed, May 19, 2021 at 10:51 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset 5513b411ea5b ("Documentation: rename pinctl to pin-control")
> renamed: Documentation/driver-api/pinctl.rst
> to: Documentation/driver-api/pin-control.rst.
>
> Update the cross-references accordingly.
>
> Fixes: 5513b411ea5b ("Documentation: rename pinctl to pin-control")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
I suppose you take it through the doc tree? I can apply it if you prefer.

Yours,
Linus Walleij
