From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Tue, 11 Jan 2011 18:14:11 +0000
Message-ID: <20110111181411.GG13429@opensource.wolfsonmicro.com>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk>
	<s5hlj2r9x52.wl%tiwai@suse.de>
	<20110111172839.GE13429@opensource.wolfsonmicro.com>
	<s5hipxv9wi7.wl%tiwai@suse.de>
	<20110111173349.GF13429@opensource.wolfsonmicro.com>
	<s5hbp3n9vrl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64549103895
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:16:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbp3n9vrl.wl%tiwai@suse.de>
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

On Tue, Jan 11, 2011 at 06:48:30PM +0100, Takashi Iwai wrote:

> IMO, such a data should be uniquely handled -- either init-only or
> not.  Through a quick look, snd_soc_cache_sync() may still refer to
> reg_cache_default.  So, it's still risky to blindly set
> __devinitconst.  (Yeah, I know it's not used right now, though ;)

That's a bug in the flat cache, it should be stashing a copy of it in
the codec instance.  Though it only really makes a difference for
devices where you'd want to use a compressed cache anyway.

> That is, the data that shall be deleted shouldn't be kept in a
> structure that might be referred later from other places.

On the other hand you don't want to make stuff too much of a song and
dance to use.
