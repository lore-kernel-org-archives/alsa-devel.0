From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Tue, 11 Jan 2011 17:33:49 +0000
Message-ID: <20110111173349.GF13429@opensource.wolfsonmicro.com>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk>
	<s5hlj2r9x52.wl%tiwai@suse.de>
	<20110111172839.GE13429@opensource.wolfsonmicro.com>
	<s5hipxv9wi7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3CB810386B
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:35:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hipxv9wi7.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 06:32:32PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > The array is ~25k so it's not a completely trivial amount of memory,
> > unfortunately.

> Hm.  But, it's same for (some) other codecs, no?
> If we do annotate something, we should mark all these at once.

In principle, though since it requires per driver checking for
references and so on it's not as simple as just going through and
annotating.  It's partly tied in with the cache stuff, things that are
fully using that can be converted over easily.  And of course many of
the devices have much smaller register maps so it's much less of an
issue.
