Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F248C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Dec 2021 13:13:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F141D1776;
	Wed, 29 Dec 2021 14:12:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F141D1776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640783596;
	bh=Li6Y2pjEiWtIaCCKT0RKZ8AhJkZt0uYTefmhlTdOqWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hL29YDEufCxVJVYUJKNjZnDcmn85eTfycB92TelKu+ZVv5O+GjCx9BHlTvmE7pFQW
	 XUmcqdnfNVU+AIcPpowEabKqqFwJ2qNS13vxQhMtulH2r59i/NZZehCFDCTeCsacZf
	 l//p9F8ZV3qHklKiVoUOMmP0CkMxnoyNXni2MoGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 969F1F800F8;
	Wed, 29 Dec 2021 14:12:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3998DF801EC; Wed, 29 Dec 2021 14:12:19 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2164F800D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2021 14:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2164F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gn9xH95N"
Received: by mail-ed1-x52f.google.com with SMTP id q14so78412770edi.3
 for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2021 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q9D0TUu04h97ds6FxSx7MgmJz+wEu67upxcwcKSNcxU=;
 b=gn9xH95NrntqFTGuw7wKbYwOZEwMizGJHYCdp8M3kMhsJXQE1zmEXxLLfY/WXL5aYu
 XJ1lcL1Pw9q2eog2yH5AAPSkNDSkVbYgXhivkHOBOZ9UFDUzn9Xxex1BdcWYwzt4CheD
 EywzEnaMzDUr53NCsBeLwIZ7rtAZUnu6O4F4omQfHeUT8DAP+yfphrMmYpNJZVnl6+ab
 d6USM9iKUKv9I/EczqqlUIKIevFq+jJHuE0dm0ReWeJ/OgkkEvjPlsBQREc0ewbNKgcV
 /b+PbSnrJwdVY0INH2cJ6LiYnmUvObwgSVI4+IgzO2t3V1HMJWbWDuaGjSEgpRXf4wM0
 90sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q9D0TUu04h97ds6FxSx7MgmJz+wEu67upxcwcKSNcxU=;
 b=6xT1s6MpaeGeLOOHNSaPPGfJhJbRiBuHmaHDvAGqS+jXgqbtUMyre1UijW7gSPIy9X
 a75EZ79lL8mOVyrzHT6O+uP1OfMcCJWLkS7Sph9mTZ7FgbzZeCy3Qd26ILxFxLMazq6p
 sOkiZWgpCtj5FmuLgB6nSoQKf0bAgfzE9EqBO490AOoAwWqz62MKman0ZkjdLYWpv45l
 25ohWWO47Sm0vSUCixuPRO7KLQXqTnejUMOWwFdwUjdbzAmTsjh1Cz3lq+OVChEbG0nV
 W0MKgf8ACgTOMkFMvwOtT4iREsxUv5RojQqjoQad39nRDFvEiAAzfjyXtbMjgSRR2jCH
 l6sA==
X-Gm-Message-State: AOAM5333imLDHGd1heSfC5VRyvdOByNBRRaaZNWzKGAXqzGOR7qxBVga
 mqTw8b7edvY7t4guLCqEOZ0+mnpc+pboMtrlwDDg3t93
X-Google-Smtp-Source: ABdhPJwYS8pDY10zm5mmLWAcCnXb9owByzjq4mj6ZXaO2xlWeGKHEV4Rl4xWFOvewKhTZhltIp/rQVv6N4XqUKQBSTI=
X-Received: by 2002:a17:907:765a:: with SMTP id
 kj26mr20547986ejc.652.1640783528979; 
 Wed, 29 Dec 2021 05:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20211229114457.4101989-1-festevam@gmail.com>
 <20211229114457.4101989-2-festevam@gmail.com>
 <20211229115352.GA18506@ediswmail.ad.cirrus.com>
 <CAOMZO5DcXUR2Z6-cokwizDbAKnEs877AjbX9FEow2RFHfebnuw@mail.gmail.com>
 <YcxX3XFWO9jQWlLJ@sirena.org.uk>
In-Reply-To: <YcxX3XFWO9jQWlLJ@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Dec 2021 10:11:57 -0300
Message-ID: <CAOMZO5ANC34SoxB9YeiLQo8FsjYana9uXiogtktJZ_ghx9JiQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: cs4265: Fix the reset_gpio polarity
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@denx.de>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, james.schulman@cirrus.com
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

Hi Mark,

On Wed, Dec 29, 2021 at 9:43 AM Mark Brown <broonie@kernel.org> wrote:

> There might be more out of tree users of course - there's no requirement
> for people to upstream their DTs.  Probably better to play it safe.

If someone correctly describes the gpio_reset as active-low, then the
driver will not work.

If there is any out-of-tree user of the gpio_reset property, they are
passing the incorrect polarity in the device tree
and things are working by pure luck. (wrong polarity in dts + wrong
polarity handling in the driver = working state)

Ok, if this can't be fixed, then let's drop patches 2 and 3, which is
unfortunate.
