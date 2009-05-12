From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Tue, 12 May 2009 14:31:41 +0300
Message-ID: <200905121431.41207.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905121350.26415.peter.ujfalusi@nokia.com>
	<20090512141937.08450516.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D1CE103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 13:33:01 +0200 (CEST)
In-Reply-To: <20090512141937.08450516.jhnikula@gmail.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 12 May 2009 14:19:37 ext Jarkko Nikula wrote:
> On Tue, 12 May 2009 13:50:26 +0300
>
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Jarkko and others: can you test this on top of the my patch?
> > How does the 'tuck' sounds after this?
>
> Do difference IMO.

Is it better or worst?
Can you try also with:

amixer sset 'HS ramp delay' '55/40/27 ms'
amixer sset 'HS ramp delay' '109/81/55 ms'
amixer sset 'HS ramp delay' '27/20/14 ms'


> I just noted that I'm able to get both
> power-up/-down pops from both channels by toggling the control
> "HeadsetL Mixer AudioL2" or "HeadsetL Mixer Voice" but only if "HeadsetL
> Mixer AudioL1" is muted. But no pop from HeaderR controls.

HeadsetR does not triggers the ramp up/down mantra.

-- =

P=E9ter
