From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [uclinux-dist-devel] [PATCH 1/4] Blackfin: Use
 8bit spi transfers for the ad1836
Date: Fri, 06 May 2011 14:28:32 +0200
Message-ID: <4DC3E970.2030207@metafoo.de>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
	<BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 78522103AA7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 14:29:06 +0200 (CEST)
In-Reply-To: <BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/06/2011 12:56 AM, Mike Frysinger wrote:
> On Thu, May 5, 2011 at 13:52, Lars-Peter Clausen wrote:
>> Currently there is a special case for the ad1836 in the ASoC generic spi write
>> functions, which swaps the upper and the lower byte for 4/12 transfers.
>> This was done, because the 4/12 spi write function was added for the ad1836
>> for which all of the users are configured to use use 16-bit transfers.
>> In order to be able to get rid of this special casing switch all users of
>> ad1836 to 8-bit transfers.
> 
> 16bit spi transfers are inherently less overhead than 8bit transfers.
> so if the codec supports it, we should use it rather than drop 16bit
> support everywhere because 8bit is simpler.  am i missing something
> obvious ?
> -mike

At some point the codec driver used u16 for the type of the data to be
transferred, so 16bit transfers where fine then.
But at some point the driver was updated to use the snd_soc_cache
infrastructure, which uses a u8[2] array for the data to be transferred.

The snd_soc_cache infrastructure has several helper functions for writing spi
on a spi bus. The one used by the ad1836 was specifically added for the ad1836
and is special compared to the other spi helper functions in the regard that it
swaps the upper and the lower byte of the to be transferred data.
While this works on blackfin which is litte-endian this scheme will obviously
fail on big-endian machines. Also this might not work for other codecs which
want to reuse the same helper function.

And furthermore it disallows more generalization of the spi write functions in
snd_soc_cache, which is done in the follow-up patches.

If we wanted to use 16-bit spi transfers we would have to add something generic
to the do_spi_write function, which swaps the upper and the lower byte of each
short to be transferred if the host is little-endian.

- Lars
