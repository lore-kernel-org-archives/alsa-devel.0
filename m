From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 08/11] ASoc: DaVinci: i2s,
 Improve underrun, support mono
Date: Sun, 5 Jul 2009 13:12:05 +0100
Message-ID: <20090705121205.GC5334@sirena.org.uk>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CDE9243A0
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 14:12:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 04, 2009 at 07:29:58PM -0700, Troy Kisky wrote:
> This patch will reduce the number of underruns by
> shifting out 32 bit values instead of 16 bit. It also
> adds mono support.

> +	if (channels == 2) {
> +		/* Combining both channels into 1 element can allow x10 the
> +		 * amount of time between servicing the dma channel, increase
> +		 * effiency, and reduce the chance of overrun/underrun. But,
> +		 * it will result in the left & right channels being swapped.
> +		 * So, you may want to let the codec know to swap them back.

This seems dodgy.  The end resule sounds like a win but if it's going to
introduce a L/R swap then that's going to catch people out and not all
CODECs will have the ability to revert the swap.  On the other hand, the 
efficiency wins sound worthwhile from your description.  Is it possible
to make this behaviour optional?

I'm going to be doing some work on digital routing and mixing soon, it
may make sense to hold off on this change and see if it can be
integrated with those changes - it sounds like the sort of thing that we
ought to be able to represent better.  There's a bunch of other stuff
which could be done with better core support in that area.

> +		 *
> +		 * It may be x10 instead of x2 because the clock from the codec
> +		 * may run at mclk speed (ie. tlvaic23b), independent of the
> +		 * sample rate. So, having an entire frame at once means it can
> +		 * be serviced at the sample rate instead of the mclk speed.

I'm also having a really hard time following this bit of the comment,
mostly I think because I'm not sure what clock you're talking about
here.
