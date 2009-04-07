From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Help for writting an ASoC driver
Date: Tue, 7 Apr 2009 23:19:35 +0100
Message-ID: <20090407221935.GB8465@sirena.org.uk>
References: <fb44c3530904071018o542cb622k6ab9b939b3144c78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 443F3243A6
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 00:19:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fb44c3530904071018o542cb622k6ab9b939b3144c78@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 07, 2009 at 12:18:25PM -0500, Ernesto Torres wrote:

> Hi, i'm new to alsa and i would like some advice on where to get information
> about writing an ASoC driver it would be for the beagle board, since is the
> board i have available. I have already made some progress initializing and

There is already a drier for the Beagle board in the kernel - see the
omap3beagle driver.

> I still don't know the exact way for playing via pcm with aplay or the order
> of the callbacks. I have checked the web for info but not much about ASoC,
> just the documentation with the linux kernel.

ASoC jsust presents a standard sound card so applications such as aplay
work as they normally do.  The callbacks are all called in the same
order as the standard ALSA equivalents are, you can check how exactly
things are mapped from the standard ALSA callbacks into ASoC in
soc-core.c.

> My driver actually tries to play with aplay, but gets stuck in : omap-pcm.c:
> omap_pcm_pointer
> It just won't send the frames.

At a guess you've not got the clocking set up properly - either the pins
for the clock signals are not configured in the appropriate mode or an
inappropriate clock configuration has been set up in your machine
driver.
