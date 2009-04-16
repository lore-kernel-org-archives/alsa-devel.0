From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for
	DSP	mode
Date: Thu, 16 Apr 2009 10:31:21 +0100
Message-ID: <20090416093121.GB16318@sirena.org.uk>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4929F10392A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:31:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 12:07:50PM +0300, Jarkko Nikula wrote:

> I did a little bit of hacking and testing with this to see are can this
> even be a fix on top of my DSP_B fix for 2.6.30 but looks like there is

Hrm.  I'd merged your DSP_B fix for 2.6.31 not 2.6.30 since it seemed
to be needed for new things like the TWL4030 4 channel mode and the
existing boards were apparently OK in 2.6.29.  Do you think it's urgent
enough to pull over to 2.6.30 (I've not pushed to Takashi yet)?

I've applied both Peter's patches - thanks.
