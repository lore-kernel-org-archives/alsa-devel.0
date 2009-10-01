From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1 - try2] ASoC: add support for multiple
 cards/codecs in debugfs
Date: Thu, 1 Oct 2009 12:09:19 +0100
Message-ID: <20091001110919.GC19998@rakim.wolfsonmicro.main>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254382367-27948-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091001105107.GB19998@rakim.wolfsonmicro.main>
	<200910011402.04406.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34E821038F2
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 13:09:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910011402.04406.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 02:02:04PM +0300, Peter Ujfalusi wrote:
> On Thursday 01 October 2009 13:51:07 ext Mark Brown wrote:

> > I'd rather use dev_name() for the CODEC itself if possible, that is more
> > likely to be stable going forward and one of the immediate aims with the
> > API refactoring is to remove socdev entirely at runtime.

> At this point the codec->dev was NULL, that is why I have used the socdev->dev 
> instead.

Right, your CODEC driver needs updating to current APIs.  Omitting the
device name is a good fallback here since you won't be able to have more
than one of the same device anyway if a device isn't provided.

> > >  		ret = snd_pcm_hw_constraint_minmax(substream->runtime,

> > but this doesn't seem to accomplish that goal?  I can't actually spot
> > the difference either, I'm assuming it's just whitespace?  If so I'll
> > apply as-is.

> It is my editor, which removed the tailing space from that line, I have 
> mentioned it in the intro mail.

Oh, right.  Like I was saying yesterday it's better to not use a
separate cover letter for single patches.
