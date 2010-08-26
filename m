From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Thu, 26 Aug 2010 13:47:57 +0100
Message-ID: <20100826124757.GC5721@sirena.org.uk>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BC571037F5
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 14:47:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
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
Cc: Mike Frysinger <vapier@gentoo.org>, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:47:13PM -0400, Adam Rosenberg wrote:
> I am trying to write a driver for the Blackfin BF537 processor on a custom
> board that has two CS42448 CODECs connected to SPORT0.  I am using TDM and

CCing in the Blackfin guys - this looks like a CPU specific issue.
However, see below...

> there are 8 channels per frame on each data line (primary and secondary).
> My DMA buffer must interleave the data for the two data lines (for a total
> of 16 channels of data per frame).  I have completed all of this and the
> driver will sometimes work properly but I am having underrun problems.  I
> would like to use snd_async_add_pcm_handler as it is used in the /test/pcm.c
> example but it seems as though an underrun occurs at regular intervals
> causing the PCM prepare function to be called again (this results in a tone
> that sounds good but only for a short time before it stops and then starts
> again).
> 
> There is plenty of time for the data to be transferred.  I feel as though
> the driver is not calling snd_pcm_period_elapsed fast enough.  At the
> moment, I call snd_pcm_period_elapsed from within a callback function that
> occurs every time a DMA period elapse occurs.  I have been working on this
> for quite a while now.  Is there someone who can look at the driver code for
> me or provide detailed information on when ALSA expects to have
> snd_pcm_period_elapsed get called to avoid an underrun?
> 
> The other thing that is strange is that I have to explicitly set the period
> size for aplay to work.  For example:
> aplay --period-size=1024 test.wav
> which gives me a period time of 21333 but when I use this period time with
> the /test/pcm.c sample that is provided the tone still does not sound right
> (although it does seem to improve)

If you're needing to set the period size explicitly this probably
indicates a problem with the way the constraints are being exposed to
applicatiohns - normally the constraints would force an appropriate
configuration to be selected.

> I am about ready to bypass ALSA entirely but I hate the idea of breaking
> from standards (not to mention having to rewrite an entire audio
> interface).  Any help would be greatly appreciated!
> 
> You can check out the driver here:
> http://www.alcorn.com/ftp/swap/ami_cs42448.zip

Please post code to the list if you want people to review it.  Looking
at the code there it looks like you've implemented your own custom
driver entirely outside the standard ASoC framework and Blackfin
drivers.  It will be much easier to get community support with the
standard kernel code, if you're not reusing any of the existing CPU
support you're much more on your own.
