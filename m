Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D17C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Dec 2021 12:05:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91CD81771;
	Wed, 29 Dec 2021 13:04:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91CD81771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640779533;
	bh=lBUVhoF4RSJMtieNdbWHPWvJeKm5wEEk5bysjAdIBcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okvFBPg+yxNr5PYWJPMs3btMHOQfQjLgUqgzT9zmX3vGghgO6+sygedFuXpk8zF6R
	 y6sG+KZ1J8SaaU/x3Z6izEBT/dJj3C4OrTJ4OaqGpRZYJZv3G5aXplWxfAaxS6wDjZ
	 PEOpBWZ+yoFMrkWI1Hizj0i/YZbVzneunbqRkwu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24CECF800F8;
	Wed, 29 Dec 2021 13:04:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 230F7F800CE; Wed, 29 Dec 2021 13:04:40 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA684F800CE
 for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2021 13:04:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA684F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UB2a42+I"
Received: by mail-ed1-x52c.google.com with SMTP id l5so50732696edj.13
 for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2021 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lBUVhoF4RSJMtieNdbWHPWvJeKm5wEEk5bysjAdIBcI=;
 b=UB2a42+IwNoOrtOr6n+5cmWFNieHfvVkBlMGxKFxS4Ya8G3GWByBvleyP2CrR45AB3
 hm/kPzn1YhkKYln+pVIO33VmHV966OvK9M4CbPsx34L1xrB5A2IukqaErk1Sf8AJfQN1
 vVnhybX4u7PGVJ2h0r/nhMj5aVUJDlb5IR/a2OXZBdQDKJs27xOzEHOm7KGpJmyo9v3m
 AqkvOIGewHfSEIV7hbFBe/SDFBWsZirg+pKr39lZGlh/tXYTKr3qjbKyUUk13+OThl/J
 RiX0akR6UQrj9LkExX5OqVgm9aFSYgmtT2FRVLBBzeubMVG79vodq4rNhxstRLHCi1PC
 oTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lBUVhoF4RSJMtieNdbWHPWvJeKm5wEEk5bysjAdIBcI=;
 b=aDkEtPQaSr40DYYQAmOEn8EJgFTYOW/Ec5cLXsSVd0SWpFsDLirtl5ni5pVUIg3GJp
 ImMLVFVMGJCStxvDX/luJCAx7gm/NvN2LmtEkozAC4uAcdbBAr2XG6tXEryxLZw/3Bop
 xz7s0PpdPxtRrbFc3ZyNmlI166XmAV8Ws+l2H4aocDbDx3wvDbd51xwE2yBB6fEWF0Tx
 F/NaHHW3talHIDZAg3+c2rmKE7suRXdYMY7KBWYH7KhGC/LTtrU2bUIWg5o203+bSs9g
 6LwzMEIEhOr/rpdjaCn8oaZYDCr4rZoP9Y1dYSQhR/PWMN/w6RiLcnh0t6yLsl03rUJs
 yLmQ==
X-Gm-Message-State: AOAM5319BCN7L1opVN4NaEgVBGGxT6NRCyw5zD4QUv8X/LZxC7wikdgT
 jpm8LQUhvNzXPuWhCDhEHdfsWl9bK4RFUvfVbg0zRzdS
X-Google-Smtp-Source: ABdhPJy4Zjo+rEcudpmRbAjJdXYXoXd+a8ZAfCOXMu823EOXDvTFe4zt4Y68rnga3qsWTTgF2cbEA0Y6oJYj5NenxnM=
X-Received: by 2002:a50:da48:: with SMTP id a8mr24854142edk.155.1640779470169; 
 Wed, 29 Dec 2021 04:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20211229114457.4101989-1-festevam@gmail.com>
 <20211229114457.4101989-2-festevam@gmail.com>
 <20211229115352.GA18506@ediswmail.ad.cirrus.com>
In-Reply-To: <20211229115352.GA18506@ediswmail.ad.cirrus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Dec 2021 09:04:19 -0300
Message-ID: <CAOMZO5DcXUR2Z6-cokwizDbAKnEs877AjbX9FEow2RFHfebnuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: cs4265: Fix the reset_gpio polarity
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Fabio Estevam <festevam@denx.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>,
 james.schulman@cirrus.com
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

Hi Charles,

On Wed, Dec 29, 2021 at 8:54 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Hmm... I might defer to Mark on this one. I totally agree your
> new code is more correct, however, I would have a slight worry
> about existing device trees not correctly specifying the GPIO. As
> in if existing systems had been specifying the GPIO correctly
> they are presumably currently broken. But I am not sure what the
> obvious solution would be, and I don't really have a good feel
> for how widely used this part is.

I could not find a single user of the cs4265 in linux-next.

The board I have does not connect a GPIO to the CS4264 reset line, so
I am not affected by it.

Cheers
