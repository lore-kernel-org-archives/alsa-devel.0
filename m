From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: about the array to cache registers
Date: Fri, 24 Jul 2009 10:18:13 +0100
Message-ID: <20090724091813.GA27429@rakim.wolfsonmicro.main>
References: <4A695D83.8060202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE31103A7B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 11:18:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A695D83.8060202@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 24, 2009 at 04:06:43PM +0900, Joonyoung Shim wrote:

> Many ASoC codec drivers have an array to cache registers.
> The array is not used any longer after memcpy to codec->reg_cache.
> I think that memcpy is unnecessary, and it a waste of the memory.

> How about continue using the array instead of memcpy?

There's two reasons we keep the data around at the minute.  One is that
in future we'd like to be able to have more than one CODEC, including
more tha one of the same type.  Obviously there's some devices are more
likely to be used in such a configuration than others but you do see
some unusual hardware designs.

The other is that the default values can be used to reduce the amount of
data that needs to be written back to the CODEC to restore the registers
at resume time by only writing non-default values.  This can speed up
resume, especially on larger devices and where the control bus is
contended, but it's not been widely implemented.

For the devices that don't do the resume operation we should at least
mark the arrays as __devinitdata so they can be discarded.
