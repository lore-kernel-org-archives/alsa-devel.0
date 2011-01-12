From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Wed, 12 Jan 2011 10:07:25 +0000
Message-ID: <1294826845.11031.19.camel@dplaptop.localdomain>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk> <s5hlj2r9x52.wl%tiwai@suse.de>
	<20110111172839.GE13429@opensource.wolfsonmicro.com>
	<s5hipxv9wi7.wl%tiwai@suse.de>
	<20110111173349.GF13429@opensource.wolfsonmicro.com>
	<s5hbp3n9vrl.wl%tiwai@suse.de>
	<1294826459.11031.18.camel@dplaptop.localdomain>
	<s5h4o9ea17a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51B23244C4
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 11:07:44 +0100 (CET)
In-Reply-To: <s5h4o9ea17a.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-12 at 11:03 +0100, Takashi Iwai wrote:
> At Wed, 12 Jan 2011 10:00:59 +0000,
> Dimitris Papastamos wrote:
> > 
> > On Tue, 2011-01-11 at 18:48 +0100, Takashi Iwai wrote:
> > > At Tue, 11 Jan 2011 17:33:49 +0000,
> > > Mark Brown wrote:
> > > > 
> > > > On Tue, Jan 11, 2011 at 06:32:32PM +0100, Takashi Iwai wrote:
> > > > > Mark Brown wrote:
> > > > 
> > > > > > The array is ~25k so it's not a completely trivial amount of memory,
> > > > > > unfortunately.
> > > > 
> > > > > Hm.  But, it's same for (some) other codecs, no?
> > > > > If we do annotate something, we should mark all these at once.
> > > > 
> > > > In principle, though since it requires per driver checking for
> > > > references and so on it's not as simple as just going through and
> > > > annotating.  It's partly tied in with the cache stuff, things that are
> > > > fully using that can be converted over easily.  And of course many of
> > > > the devices have much smaller register maps so it's much less of an
> > > > issue.
> > > 
> > > IMO, such a data should be uniquely handled -- either init-only or
> > > not.  Through a quick look, snd_soc_cache_sync() may still refer to
> > > reg_cache_default.  So, it's still risky to blindly set
> > > __devinitconst.  (Yeah, I know it's not used right now, though ;)
> > > 
> > > That is, the data that shall be deleted shouldn't be kept in a
> > > structure that might be referred later from other places.
> > 
> > For the LZO and the rbtree compression, a copy of the defaults cache is
> > kept and that is used in the syncing functionality.  Only the flat cache
> > is using reg_cache_default directly which is never marked as
> > __devinitconst.
> 
> But in theory, the cache method can fall back to flat if no
> corresponding compression is available.  Thus no strong-type check is
> possible in such a case.

Aw, yes that was added in a patch recently.  I will prepare a patch that
handles that.

Thanks,
Dimitris
