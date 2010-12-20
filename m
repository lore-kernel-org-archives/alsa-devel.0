From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC cache code (looking toward 2.6.38 merge
	window)
Date: Mon, 20 Dec 2010 15:27:09 +0000
Message-ID: <20101220152709.GJ26706@rakim.wolfsonmicro.main>
References: <s5hei9czeep.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7AC243E6
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 16:27:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hei9czeep.wl%tiwai@suse.de>
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

On Mon, Dec 20, 2010 at 03:50:54PM +0100, Takashi Iwai wrote:

> It's pretty easy to do some cleanups.  After 5 minutes rewrite, over
> 300 LOC reduced.  But I remember you wanted to work on it for
> portability, e.g. endianness.  The same problem seems still remaining,

It wasn't portability, it was specifically the fact that some drivers
want to do block operations which means they depend very strongly on the
exact memory layout of the cache (obviously this only works for
uncompressed caches).

> for example, snd_socc_16_16_read_i2c() has cpu_to_be16() while no
> others have such.  Any progress on this?  Or should I post you patchesf
> first?

I don't think anyone's working on it, I'm not aware of it actually
bothering anyone - the code is repetitive obviously but it's also very
simple.  I've you've got patches please go ahead and post them but bear
in mind the thing with the memory layout.

> Also, for now, the new nice cache compression support is always
> built-in although the additional code size isn't so negligible and its
> user is just only one.  Wouldn't it be better to give new Kconfig for
> them?  I'm also no big fan for small Kconfigs, but in this case, I see
> no better resolution.

I don't see this as a particularly urgent issue, especially in the
context of the overall ASoC code size and memory usage.

There's more potential users than currently have it enabled, it's just
that the WM8994 driver is the only driver that turns it on by default
right now (several other CODEC drivers should but need testing just to
confirm that it's OK).  It's only a few kilobytes and Kconfig really
isn't good at supporting this sort of selection, I'd worry about the
usability issues.
