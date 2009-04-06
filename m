From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Mon, 6 Apr 2009 15:37:58 +0300
Message-ID: <200904061537.59067.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090406122232.GA8585@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E0C0A2437E
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:38:02 +0200 (CEST)
In-Reply-To: <20090406122232.GA8585@rakim.wolfsonmicro.main>
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
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Monday 06 April 2009 15:22:33 ext Mark Brown wrote:
> On Mon, Apr 06, 2009 at 03:19:27PM +0300, Peter Ujfalusi wrote:
> > Add SND_SOC_DAIFMT_DSP_A support for omap-mcbsp.
> > The configuration for DSP_A and DSP_B is the same.
>
> That doesn't sound right - the two formats do differ on the wire.  In
> mode B the MSB of data is transmitted along with the LRC pulse while in
> mode A it is transmitted after the trailing edge of the LRC pulse.

That is why I have asked previously about these... I'm still a bit confused=
, =

but at the end (I think) the configuration in omap-mcbsp is right for the =

twl4030:
regs->srgr2	|=3D FPER(wlen * channels - 1);
regs->srgr1	|=3D FWID(wlen * channels - 2);
and
/* 0-bit data delay */
regs->rcr2      |=3D RDATDLY(0);
regs->xcr2      |=3D XDATDLY(0);

I'll revisit this.

Thanks,
P=E9ter
