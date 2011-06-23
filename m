From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix Blackfin I2S _pointer()
 implementation return in bounds values
Date: Thu, 23 Jun 2011 20:21:50 +0100
Message-ID: <20110623192149.GC24328@opensource.wolfsonmicro.com>
References: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E038FA7.40509@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B8B7103803
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 21:21:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E038FA7.40509@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 09:10:31PM +0200, Lars-Peter Clausen wrote:
> On 06/23/2011 09:02 PM, Mark Brown wrote:
> > [...]
> > +	if (diff == snd_pcm_lib_buffer_bytes(substream))
> > +		diff = 0;
> > +	}

> stray closing bracket

Hrm, so there is.  Fixed locally, I guess there's no point in reposting
just for that.

> > +	frames = bytes_to_frames(substream->runtime, diff);
> > +
> >  	return frames;

> Could be 'return bytes_to_frames(substream->runtime, diff);' directly

Does no harm either way, though.  I don't always find doing the return
directly quite so parsable, but I think here I wrote it this way because
it makes the diff a bit more obvious.
