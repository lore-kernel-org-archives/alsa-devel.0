From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for
	DSP	mode
Date: Thu, 16 Apr 2009 10:48:47 +0100
Message-ID: <20090416094847.GC16318@sirena.org.uk>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
	<20090416093121.GB16318@sirena.org.uk>
	<200904161243.01010.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F0BC4103936
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:48:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904161243.01010.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 12:43:00PM +0300, Peter Ujfalusi wrote:

> Well, the DSP_B mode was broken for OMAP, the osk5912 with DSP_B mode was also 
> broken in 2.6.29. I think the reason that we have not heard any screams 
> regarding to broken DSP_B mode, that no one actually used osk5912 with 2.6.29?

Presumably OSK5912 has been broken since it was merged?  Either that or
the incorrectly inverted FS polarity happened to result in a setup which
gives functional audio.
