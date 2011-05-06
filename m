From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH 1/4] Blackfin:
	Use	8bit spi transfers for the ad1836
Date: Fri, 6 May 2011 13:48:59 +0100
Message-ID: <20110506124858.GA11701@sirena.org.uk>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
	<BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
	<4DC3E970.2030207@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9228824390
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 14:49:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC3E970.2030207@metafoo.de>
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

On Fri, May 06, 2011 at 02:28:32PM +0200, Lars-Peter Clausen wrote:

> The snd_soc_cache infrastructure has several helper functions for writing spi
> on a spi bus. The one used by the ad1836 was specifically added for the ad1836
> and is special compared to the other spi helper functions in the regard that it
> swaps the upper and the lower byte of the to be transferred data.
> While this works on blackfin which is litte-endian this scheme will obviously
> fail on big-endian machines. Also this might not work for other codecs which
> want to reuse the same helper function.

So clearly the cache stuff ought to be using cpu_to_be16 for this stuff.
At present we've been lazy about this as on most CPUs the swap boils
down to a noop.  If we do end up needing both swaps then we just add
this as another parameter in the cache infrastructure.
