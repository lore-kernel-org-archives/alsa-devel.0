From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for
	DSP	mode
Date: Thu, 16 Apr 2009 11:07:01 +0100
Message-ID: <20090416100701.GH16318@sirena.org.uk>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090416120750.f3cf99ed.jarkko.nikula@nokia.com>
	<20090416093121.GB16318@sirena.org.uk>
	<20090416125642.bc76035e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1422C10396F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:07:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090416125642.bc76035e.jarkko.nikula@nokia.com>
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

On Thu, Apr 16, 2009 at 12:56:42PM +0300, Jarkko Nikula wrote:

> I also believe that quite many developers may be using linux-omap tree
> only for developing e.g. new machine or codec driver and there is a
> risk that then error might populate into those drivers as well and we
> don't catch it when patches are based on topic/asoc and sent here for
> review.

*sigh*, that's true - a lot of the OMAP folks don't seem to want to move
outside of linux-omap so I'd expect a lot of stuff wouldn't get pushed
here at all.  I've pulled the changes over.
