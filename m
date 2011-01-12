From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Wed, 12 Jan 2011 10:46:25 +0000
Message-ID: <20110112104624.GA20911@opensource.wolfsonmicro.com>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk>
	<s5hlj2r9x52.wl%tiwai@suse.de>
	<20110111172839.GE13429@opensource.wolfsonmicro.com>
	<s5hipxv9wi7.wl%tiwai@suse.de>
	<20110111173349.GF13429@opensource.wolfsonmicro.com>
	<s5hbp3n9vrl.wl%tiwai@suse.de>
	<20110111181411.GG13429@opensource.wolfsonmicro.com>
	<1294826290.11031.15.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16595244F0
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 11:48:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294826290.11031.15.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 09:58:10AM +0000, Dimitris Papastamos wrote:
> On Tue, 2011-01-11 at 18:14 +0000, Mark Brown wrote:

> > That's a bug in the flat cache, it should be stashing a copy of it in
> > the codec instance.  Though it only really makes a difference for
> > devices where you'd want to use a compressed cache anyway.

> The flat cache is intentionally *not* making a copy of the defaults
> cache as it makes no difference in terms of memory usage.  The flat
> cache has codec->reg_def_copy = NULL; and can work with either NULL
> default caches or filled in.

It can make a difference to memory usage - if multiple CODEC drivers are
built in but only one is in use then if we take a copy all the defaults
can be discared, meaning that we don't need to keep the defaults for the
unused drivers and only keep the defaults for the one that's in use
instead of keeping the defaults for all drivers.
