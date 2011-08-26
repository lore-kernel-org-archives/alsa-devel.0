From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Fri, 26 Aug 2011 11:01:25 +0300
Message-ID: <1564550.J9hpTzF6jo@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<20110820070113.GB5011@opensource.wolfsonmicro.com>
	<1841405.uncpCjWKsY@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 371502468A
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 10:01:26 +0200 (CEST)
In-Reply-To: <1841405.uncpCjWKsY@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Lopez Cruz, Misael" <misael.lopez@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tuesday 23 August 2011 09:52:03 Ujfalusi, Peter wrote:
> > I do think it'd be helpful to split this code out as a separate patch
> > as it's the controversial bit...
> =

> It is not that easy.
> There's no incremental way from the old driver to the new one.
> What I can try however is to write an intermediate driver, which does not
> have the delayed sequencing. I know that this is a bit problematic, and it
> is not going to work as good as the driver in this series, but probably it
> will give the needed separation of the sequencing part.
> This going to take some time, since I need to - kind of - write a new
> driver, which is in half way between the two versions ;)

I have looked at the possibility of separating the controversial part from =
the =

rest of the change, but it does not look feasible.
I would need to write a driver to fill the gap (well a hack driver for the =

time of one commit), and even in that way the patch which adds the =

'controversial' bit is going to contain quite a bit of code, since I need t=
o =

rework other parts of the driver.
I think the improved commit message contains enough information on the chan=
ge.

Thanks,
P=E9ter
