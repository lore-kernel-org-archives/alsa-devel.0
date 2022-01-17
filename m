Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DCFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 08:42:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C070174F;
	Mon, 17 Jan 2022 09:41:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C070174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642408931;
	bh=KEtz6kFsKMKYyb1SwMtrFy+rBZOHcM+2Fn7uK+T+Yh0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Degd7XA0wk0L5HK3otHNz5+aX02wP2cMWyiKjhbt7uLsX83LRk7nEuwvyr7E6jIIF
	 T+YIdPTwZlDwr5CnwJvcndsxzFIprCJdnm9KLhs4e3OLOXpK4bWeZ5FWwrKDeuZV87
	 NwI3ZT2Fz5EqVlNIRcOUENIBzOgb7gV8hEMGbufw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FDF3F80100;
	Mon, 17 Jan 2022 09:41:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 409C9F80249; Mon, 17 Jan 2022 09:41:17 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9CA4F80100
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 09:41:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9CA4F80100
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1n9NZP-0006T4-TT; Mon, 17 Jan 2022 09:40:55 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Brian Norris <briannorris@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to
 SPDIF output
Date: Mon, 17 Jan 2022 09:40:54 +0100
Message-ID: <3970568.xje1Q9F24u@diego>
In-Reply-To: <CAGXv+5H0-dM28YQj_orS1_14NLcJve8VtO6oLcBiRpJFjaf5KA@mail.gmail.com>
References: <20220114230209.4091727-1-briannorris@chromium.org>
 <20220114150129.v2.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
 <CAGXv+5H0-dM28YQj_orS1_14NLcJve8VtO6oLcBiRpJFjaf5KA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Lin Huang <hl@rock-chips.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
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

Am Montag, 17. Januar 2022, 08:44:37 CET schrieb Chen-Yu Tsai:
> On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Commit b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> > switched the platform to SPDIF, but we didn't fix up the device tree.
> >
> > Drop the pinctrl settings, because the 'spdif_bus' pins are either:
> >  * unused (on kevin, bob), so the settings is ~harmless
> >  * used by a different function (on scarlet), which causes probe
> >    failures (!!)
> 
> I suppose that means the default pinctrl should be dropped? Or maybe this
> use case is the outlier. Up to Heiko?

Interesting question. Right now it looks like Gru is the only one using spdif
in that way, so I'd think dropping the pinctrl here is the "saner" option
at this time ;-)

I guess we can reevaluate if this becomes more widespread

> > Fixes: b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 




