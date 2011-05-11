From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: Remove byte swap in 4x12 SPI
	write
Date: Wed, 11 May 2011 10:35:37 -0700
Message-ID: <4DCAC8E9.2060605@metafoo.de>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 594ED247CF
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:36:09 +0200 (CEST)
In-Reply-To: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/11/2011 04:53 AM, Mark Brown wrote:
> snd_soc_4_12_spi_write() contains a byte swap. Since this code was written
> for an Analog CODEC on a Blackfin reference board it appears that this is
> done because while Blackfin is little endian the CODEC is big endian (as
> are most CODECs).
> 
I've probably not properly explained the problem in my previous patch.
The problem is not due to the codec being big endian and the cpu being little
endian.
The problem is due to how 16-bit SPI transfers work on linux and how
snd_soc_cache stores the data which is going to be send.

To quote from include/linux/spi/spi.h
 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len = 2N) and hold N sixteen bit words in CPU byte order.

So when we work with a 16-bit transfer size, the data which is going to be
transfer has to be a u16 array in _native_ endianes.

ASoC though uses a u8 array. So when this array is interpreted as a u16 array
instead the values will be in big-endian. As a result using 16-bit spi
transfers on a little-endian machine will send out the data byte-swapped.
Your patch does not change since.

>  sound/soc/soc-cache.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 6e5e30a..73907e5 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -101,12 +101,11 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
>  static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
>  			      unsigned int value)
>  {
> -	u8 data[2];
> +	u16 data;
>  
> -	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
> -	data[1] = value & 0x00ff;
Since this is basically an open-coded cpu_to_be16 ...

> +	data = cpu_to_be16((reg << 12) | (value & 0xffffff));
... with this the result will be the same as before. Both on big- nor
little-endian. (Except for that the mask is wrong and should rather be 0xfff)

>  
> -	return do_hw_write(codec, reg, value, data, 2);
> +	return do_hw_write(codec, reg, value, &data, 2);
>  }
