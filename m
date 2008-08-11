From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] wm8750: add missing VREF output
Date: Mon, 11 Aug 2008 12:01:00 +0100
Message-ID: <20080811110046.GD5560@sirena.org.uk>
References: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
	<1218444346-19153-2-git-send-email-dbaryshkov@gmail.com>
	<20080811091119.GC9668@rakim.wolfsonmicro.main>
	<48A0025C.6000903@gmail.com> <20080811101939.GB5560@sirena.org.uk>
	<s5h8wv3q1l2.wl%tiwai@suse.de>
	<20080811104204.GC5560@sirena.org.uk>
	<s5h63q7q183.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AD4310383D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 13:23:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63q7q183.wl%tiwai@suse.de>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2008 at 12:45:32PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The long description is exactly what's broken - the names are wrong or
> > undeclared and since DAPM works based on the control names this causes
> > the drivers to fail to initialise DAPM for the device concerned. 

> Exactly such a text should appear in the changelog.

Sure, my intention was to provide some appropriate text.

> > It's
> > pretty much equivalent to C code referencing an undeclared variable.

> Everyone knows C syntax but not ASoC implementation details.
> If the patch is pushed to stable tree, it should be described well so
> that other reviewers can understand it well.

Sorry, there may have been a miscommunication here - this should only
*need* to go to 2.6.27 since the bulk registration functions are more
careful about checking error values than the hand rolled loops tended to
be.  For earlier kernels people will either not notice or have already
have local patches so the bugs are not quite so serious.

Obviously, it'd be good to fix for the earlier kernels but it's not
clear it is critical enough for them.
