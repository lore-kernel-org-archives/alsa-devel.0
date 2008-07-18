From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [boot crash,
	bisected] in 9f240a55 "ALSA: opti93x: use cs4231	lib"
Date: Fri, 18 Jul 2008 10:44:47 +0200
Message-ID: <20080718084447.GK6875@elte.hu>
References: <Pine.LNX.4.61.0807141105150.7676@tm8103-a.perex-int.cz>
	<20080717170657.GA14593@elte.hu> <s5h3am8jqvy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 43AD424455
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 10:44:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3am8jqvy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org


* Takashi Iwai <tiwai@suse.de> wrote:

> > Can send more info about the system in question - it has ISA (it's 
> > an old Pentium-3-Coppermine based laptop) but otherwise it doesnt 
> > have opti93x hw so the crash should be reproducible elsewhere as 
> > well.
> 
> Could you try the patch below?

yeah, looks like it should fix the issue. Please consider this bug:

  Tested-by: Ingo Molnar <mingo@elte.hu>
  Acked-by: Ingo Molnar <mingo@elte.hu>

unless i mail about a new crash in the next 24 hours. I've queued up 
your fix for testing. (and have removed the revert from the test setup)

	Ingo
