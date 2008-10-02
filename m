From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9	atmel boards.
Date: Thu, 2 Oct 2008 19:12:12 +0100
Message-ID: <20081002181211.GA3345@sirena.org.uk>
References: <48E47D42.8080306@atmel.com> <20081002150731.GH2848@sirena.org.uk>
	<48E4F025.80907@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EFF5924179
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 20:12:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E4F025.80907@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 02, 2008 at 06:00:37PM +0200, Sedji Gaouaou wrote:

> Yes my mistake!! I will change change right now. Nevertheless I don't  
> even have a AVR compiler so I can't really test the AVR code....

Ah, right.  While I understand that the hardware is pretty much identical
are you sure that the APIs for accessing it are the same on both AVR32
and AT91?  My understanding was that there was some work required to
handle both but I've no familiarity with either architecture.

CCing in Haavard Skinnemoen for AVR32 advice: Haavard, Sedji is submitting
patches which unify the audio support for AT91 and AVR32.

> Ok, no worries. I will create:
> 	a patch that contains the atmel_ssc_dai.c and .h file,
> 	a patch for the atmel-pcm.c/.h files
> 	a patch playback_wm8510.c and sam9g20_wm8731.c files.
> 	a patch for the Makefile and the Kconfig.

> Is that ok?

That's certainly good for review.  We can always squash the patches down
when they go to git in order to try to preserve the history.  No need to
keep reposting the patch to remove the old drivers, either (unless you
switch to using git format-patch -M to show the code moving around).
