From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Tue, 7 Apr 2009 10:45:59 +0100
Message-ID: <20090407094558.GA24788@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
	<20090406124520.GA14169@sirena.org.uk>
	<200904070759.19600.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AD82244BA
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 11:46:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904070759.19600.peter.ujfalusi@nokia.com>
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

On Tue, Apr 07, 2009 at 07:59:19AM +0300, Peter Ujfalusi wrote:
> On Monday 06 April 2009 15:45:21 ext Mark Brown wrote:

> > What does this mean by "enable" - I'm guessing it's powering blocks
> > within the CODEC rather than connecting any audio paths?

> The TRM calls these as Audio/Voice digital filters.
> In effect, they enable the shifting out bits from the Capture path to the bus 
> and shifting in bits on the Playback side.

Hrm, so this is a routing thing then - from your description I'm a bit
surprised that this can be turned on unconditionally since it sounds
like it'll give you a sidetone all the time which might not be what
people want.

> But as I said, this is not so nice thing to do, so it need to be revisited.

It needs digital routing.  In the interim another option would be to
provide switches to user space, possibly?
