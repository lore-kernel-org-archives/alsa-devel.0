From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Wed, 8 Apr 2009 10:30:31 +0100
Message-ID: <20090408093031.GB20122@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904070819.12019.peter.ujfalusi@nokia.com>
	<20090407221404.GA8465@sirena.org.uk>
	<200904080901.18705.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E70321037E3
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 11:30:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904080901.18705.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 09:01:18AM +0300, Peter Ujfalusi wrote:

> Does it means that the DSP_A addition is also correct? I have it drawn to 
> paper, how the configuration in omap-mcbsp used by the beagle in 4 channel 
> mode would look like, and it does look 100% as the TDM mode described in the 
> twl datasheet...

I don't know what the OMAP itself is doing, I'm not familiar with that
processor at all.  The reason I had a concern was that DSP A and DSP B
differ so there's no way you should be able to set both up with the same
case statement.  This means that either your addition is incorrect or
the existing code is incorrect - I don't know which.
