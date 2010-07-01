From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How does struct snd_pcm_hardware relate to the
	actual hardware
Date: Thu, 1 Jul 2010 19:40:33 +0100
Message-ID: <20100701184032.GH8742@rakim.wolfsonmicro.main>
References: <AANLkTimiH0xvYIM-gmxx95W3N4PmFKqa1skknvsxluY8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23852243ED
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 20:40:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimiH0xvYIM-gmxx95W3N4PmFKqa1skknvsxluY8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 30, 2010 at 05:32:41PM -0400, Adam Rosenberg wrote:

> The audio is not being placed into the DMA buffer properly.  The audio
> plays faster than it should and has a constant stutter.  I have read
> the "writing an ALSA driver" guide multiple times but it does not
> explain the relationship between struct snd_pcm_hardware,
> snd_pcm_period_elapsed, and the copy callback clearly enough for me to
> understand what I am doing wrong.

You probably want to provide a little more detail on how you're parsing
the data in your DMA driver here...  The simplest thing when debugging
problems like this is often to place obviously tracable test data into
the audio stream (eg, all but one channel zero) and then work through
where the data ends up compared to where it ought to end up.

Note also that ASoC doesn't do anything explicit to support substreams,
which aren't in themselves ASoC specific.
