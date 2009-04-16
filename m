From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for DSP
	mode
Date: Thu, 16 Apr 2009 12:43:00 +0300
Message-ID: <200904161243.01010.peter.ujfalusi@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
	<20090416093121.GB16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 46804103936
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:43:29 +0200 (CEST)
In-Reply-To: <20090416093121.GB16318@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 April 2009 12:31:21 ext Mark Brown wrote:
> On Thu, Apr 16, 2009 at 12:07:50PM +0300, Jarkko Nikula wrote:
> > I did a little bit of hacking and testing with this to see are can this
> > even be a fix on top of my DSP_B fix for 2.6.30 but looks like there is
>
> Hrm.  I'd merged your DSP_B fix for 2.6.31 not 2.6.30 since it seemed
> to be needed for new things like the TWL4030 4 channel mode and the
> existing boards were apparently OK in 2.6.29.  Do you think it's urgent
> enough to pull over to 2.6.30 (I've not pushed to Takashi yet)?

Well, the DSP_B mode was broken for OMAP, the osk5912 with DSP_B mode was a=
lso =

broken in 2.6.29. I think the reason that we have not heard any screams =

regarding to broken DSP_B mode, that no one actually used osk5912 with 2.6.=
29?

>
> I've applied both Peter's patches - thanks.

-- =

P=E9ter
