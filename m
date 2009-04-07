From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Tue, 7 Apr 2009 22:02:42 +0100
Message-ID: <20090407210242.GA5262@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904070759.19600.peter.ujfalusi@nokia.com>
	<20090407094558.GA24788@sirena.org.uk>
	<200904071330.22727.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 26F0D2434D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 23:02:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904071330.22727.peter.ujfalusi@nokia.com>
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

On Tue, Apr 07, 2009 at 01:30:22PM +0300, Peter Ujfalusi wrote:
> On Tuesday 07 April 2009 12:45:59 ext Mark Brown wrote:

> > Hrm, so this is a routing thing then - from your description I'm a bit
> > surprised that this can be turned on unconditionally since it sounds
> > like it'll give you a sidetone all the time which might not be what
> > people want.

> Not quite. The sidetone/loopback can be turned off inside of twl4030 with the
> 'Left Digital Loopback' and 'Right Digital Loopback' set to 0.

Ah, so there's a separate control to enable the path.

> I think the twl4030 codec still holds some interesting 'features'...

It certainly seems that way.
