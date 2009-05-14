From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 11:09:08 +0300
Message-ID: <200905141109.09084.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905140827.11625.peter.ujfalusi@nokia.com>
	<20090514090808.14c0dfda.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 24CF924520
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 10:09:16 +0200 (CEST)
In-Reply-To: <20090514090808.14c0dfda.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 09:08:08 ext Jarkko Nikula wrote:
> My two cents: Would it be possible to implement 'fake' PGA or amplifier
> into TWL outputs which only controls the power state of mixer and mux?

With the 'fake PGA' on the headsetL:
Startup has a click, going standby is quite smooth.
The sequences with the twl4030 codec (soc-damp.c routings are reverted to b=
e =

the original) are for
Startup:
dac -> HS ramp up (HS enable, fake PGA) -> PGA

Standby:
HS ramp down (HS disable, fake PGA) -> PGA -> dac

If the order of the startup can be somehow altered to be:
dac -> PGA -> HS ramp up (HS enable, fake PGA)

Than it would be good.

-- =

P=E9ter
