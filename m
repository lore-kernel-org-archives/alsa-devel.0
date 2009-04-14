From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the
	DSP_B	mode
Date: Tue, 14 Apr 2009 13:01:48 +0100
Message-ID: <20090414120148.GG12678@sirena.org.uk>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
	<200904141456.49897.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 337FA10383E
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:01:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904141456.49897.peter.ujfalusi@nokia.com>
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

On Tue, Apr 14, 2009 at 02:56:49PM +0300, Peter Ujfalusi wrote:

> Is it so that it is:
> inverted bclk:
> 	sample is driven on the rising edge, sampled on the falling edge
> normal bclk:
> 	sample is driven on the falling edge, sampled on the rising edge

Yes.

> inverted frm:
> 	FS is active high
> normal frm:
> 	FS is active low

Ish.  For DSP mode normal frame means that things are synced of the
rising edge of the frame clock so inverted frame should mean the falling
edge.  Frame clock is allowed to be longer than one BCLK cycle, though
it is not normally and some things may need the low limit.
