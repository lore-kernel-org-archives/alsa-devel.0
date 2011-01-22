From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix codec device id format used by
	some dai_links
Date: Sun, 23 Jan 2011 00:59:22 +0100
Message-ID: <4D3B6F5A.2020309@metafoo.de>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
	<20110122233309.GA22799@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 3521C1037F9
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 00:59:40 +0100 (CET)
In-Reply-To: <20110122233309.GA22799@opensource.wolfsonmicro.com>
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
Cc: "for 2.6.37" <stable@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

On 01/23/2011 12:33 AM, Mark Brown wrote:
> > On Sat, Jan 22, 2011 at 11:38:07PM +0100, Lars-Peter Clausen wrote:
> >
>> >>  sound/soc/imx/wm1133-ev1.c                     |    2 +-
Ok. I simply assumed that all of them were I2C devices since platform and SPI devices
use a completely different naming scheme.

I just went through the whole list and the wm8994 codec is a platform driver as well.
And on the jive board the wm8750 is connected through SPI.

> >
> > This at least is definitely wrong, the WM835x CODEC here is registered
> > as a platform device.  Please also check current kernels, a bunch of
> > these are already fixed.
The patch is based on your for-next branch.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk07b1oACgkQBX4mSR26RiN3rQCeKvFG0eyVdxPh68vy3pasiKcv
iUUAn3lSz8cvKA95QI4Y9iRnyVk/bbWg
=0HnX
-----END PGP SIGNATURE-----
