From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC cache code (looking toward 2.6.38
	merge	window)
Date: Mon, 20 Dec 2010 16:58:18 +0000
Message-ID: <20101220165818.GF14986@sirena.org.uk>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de>
	<20101220163435.GK26706@rakim.wolfsonmicro.main>
	<s5hr5dcxu8m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FED8103906
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 17:58:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr5dcxu8m.wl%tiwai@suse.de>
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

On Mon, Dec 20, 2010 at 05:51:53PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > >  config SND_SOC_WM8994
> > >         tristate
> > > +       select SND_SOC_RBTREE_CACHE

> > Except the machine driver can override this...

> Hmm, I thought the codec is always selected not depended?
> Can it be overridden?

The CODEC support is selected (it's a physical property of the machine)
but the machine driver can override the cache type - the CODEC driver is
only providing a defualt.
