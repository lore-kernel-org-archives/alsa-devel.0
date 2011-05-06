From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH 1/4] Blackfin: Use
 8bit spi transfers for the ad1836
Date: Fri, 6 May 2011 14:26:08 +0100
Message-ID: <20110506132608.GO23729@opensource.wolfsonmicro.com>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
	<BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
	<4DC3E970.2030207@metafoo.de>
	<20110506124858.GA11701@sirena.org.uk>
	<4DC3F577.2040206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13D7F243E3
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:26:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC3F577.2040206@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 03:19:51PM +0200, Lars-Peter Clausen wrote:
> On 05/06/2011 02:48 PM, Mark Brown wrote:

> > So clearly the cache stuff ought to be using cpu_to_be16 for this stuff.
> > At present we've been lazy about this as on most CPUs the swap boils
> > down to a noop.  If we do end up needing both swaps then we just add
> > this as another parameter in the cache infrastructure.

> Currently everything is stored as big endian.

What do you mean?  The cache is CPU native.

> The easiest way to support 16-bit spi writes on little endian systems, would be
> to add a do_spi_write16 which would be used for those devices. On big-endian
> systems it would be an alias to do_spi_write, on litte-endian systems it would
> perform a byte swap on the buffer.

> An alternative would be to provide litte-endian versions of snd_soc_x_y_write.
> This would amount to more code, but less runtime overhead since we can store it
> in litte-endian format right away instead of having to swap the bytes.

This would also support bulk operations direct from cache.

Either of these would be an example of using cpu_to_() as I suggested.
