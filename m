From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: let suspend/resume not called if
 the card is not instantiated
Date: Fri, 13 Nov 2009 15:02:24 +0000
Message-ID: <20091113150224.GA23607@rakim.wolfsonmicro.main>
References: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
	<20091113133824.GD21516@rakim.wolfsonmicro.main>
	<3c17e3570911130656v662dccej7d6c67e7eaa65b65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82B1624362
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 16:02:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911130656v662dccej7d6c67e7eaa65b65@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 13, 2009 at 10:56:13PM +0800, Barry Song wrote:

> This patch is to solve a completely different problem with the last
> one I sent. Its meaning is very simple actually.  While

No, I get that it's fixing a different problem but it's in a similar
areas and similar issues apply.  Like I say, tweaking the ordering of
suspend and resume will actually fix the TDM problem anyway.

> card->instantiated is not 1, it means the card(cpu dai/codec dai and
> related stuff) and the whole links are not built successfully at all.
> So devices are not even initialized at all. And the audio system
> doesn't start to work. Since so, suspend/resume should be not needed
> for the whole system.

That's not the case unfortunately - some or all of the devices may have
initialised themselves prior to registering with the SoC core and will
be expecting the SoC core to give them a callback so that they can
suspend and resume.  At the minute there's basically an assumption that
the card is going to come up completely and all we're doing here is
avoiding race conditions during startup (which is realistic for
production systems, partially constructed cards aren't likely there
without broken hardware).

With pm_link we'll be able to move some or all of this ordering stuff
out of the ASoC core and into the device model which will allow things
to happen either way without two code paths.
