From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/10] ASoC: twl6040: Rename pga_event to
	out_drv_event
Date: Tue, 27 Sep 2011 09:17:29 +0300
Message-ID: <2328247.bSzubebQHV@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-2-git-send-email-peter.ujfalusi@ti.com>
	<20110926211956.GA2872@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E66A22434B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 08:17:21 +0200 (CEST)
Received: by bkbzu5 with SMTP id zu5so9105945bkb.35
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 23:17:19 -0700 (PDT)
In-Reply-To: <20110926211956.GA2872@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 26 September 2011 22:19:57 Mark Brown wrote:
> On Mon, Sep 26, 2011 at 04:26:24PM +0300, Peter Ujfalusi wrote:
> > This event handler is used with the OUT_DRV widgets.
> > The name pga_event was misleading.
> =

> Applied, though
> =

> > index d5c4bb4..b63ee24 100644
> > --- a/sound/soc/codecs/twl6040.c
> > +++ b/sound/soc/codecs/twl6040.c
> > @@ -72,7 +72,6 @@ struct twl6040_output {
> > =

> >  	u16 right_step;
> >  	unsigned int step_delay;
> >  	u16 ramp;
> > =

> > -	u16 mute;
> > =

> >  	struct completion ramp_done;
> >  =

> >  };
> =

> This appears to be a random unrelated change.

Argh, this supposed to be a separate commit, it got squashed accidentally, =

sorry.

--
P=E9ter
