From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.33
Date: Sat, 19 Dec 2009 11:26:47 +0000
Message-ID: <20091219112647.GB2937@sirena.org.uk>
References: <20091218131621.GA30425@rakim.wolfsonmicro.main>
	<s5heims76zn.wl%tiwai@suse.de>
	<20091218133928.GA9630@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C247C243FA
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 12:26:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091218133928.GA9630@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2009 at 01:39:28PM +0000, Mark Brown wrote:
> On Fri, Dec 18, 2009 at 02:21:32PM +0100, Takashi Iwai wrote:

> > BTW, feel free to proceed your branch to 2.6.33-rc.
> > Some fixes went in from others.

> I was holding off since there would have been a merge commit due to
> there being a couple of commits that didn't hit Linus' tree yet.  If
> you're OK with the merge commit I'll do the merge up & build tests over
> the weekend.

Actually I'll hold off for at least -rc2.  There's a build issue in -rc1
which stops all ARMv6 platforms building which isn't terribly helpful
for development.
