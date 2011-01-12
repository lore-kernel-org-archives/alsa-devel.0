From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Wed, 12 Jan 2011 09:58:10 +0000
Message-ID: <1294826290.11031.15.camel@dplaptop.localdomain>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk> <s5hlj2r9x52.wl%tiwai@suse.de>
	<20110111172839.GE13429@opensource.wolfsonmicro.com>
	<s5hipxv9wi7.wl%tiwai@suse.de>
	<20110111173349.GF13429@opensource.wolfsonmicro.com>
	<s5hbp3n9vrl.wl%tiwai@suse.de>
	<20110111181411.GG13429@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E3A8244B5
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:58:31 +0100 (CET)
In-Reply-To: <20110111181411.GG13429@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 18:14 +0000, Mark Brown wrote:
> On Tue, Jan 11, 2011 at 06:48:30PM +0100, Takashi Iwai wrote:
> 
> > IMO, such a data should be uniquely handled -- either init-only or
> > not.  Through a quick look, snd_soc_cache_sync() may still refer to
> > reg_cache_default.  So, it's still risky to blindly set
> > __devinitconst.  (Yeah, I know it's not used right now, though ;)
> 
> That's a bug in the flat cache, it should be stashing a copy of it in
> the codec instance.  Though it only really makes a difference for
> devices where you'd want to use a compressed cache anyway.

The flat cache is intentionally *not* making a copy of the defaults
cache as it makes no difference in terms of memory usage.  The flat
cache has codec->reg_def_copy = NULL; and can work with either NULL
default caches or filled in.

Thanks,
Dimitris
