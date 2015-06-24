From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
	of	WM510205 codec via ACPI (resend)
Date: Wed, 24 Jun 2015 09:23:41 +0100
Message-ID: <20150624082341.GA6321@opensource.wolfsonmicro.com>
References: <CAKor6TeUOa6GdcscTWziw_q3GXj4wNh=8jnQigQfS7Se8iL+Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CF6926052B
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 10:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKor6TeUOa6GdcscTWziw_q3GXj4wNh=8jnQigQfS7Se8iL+Nw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Hartmann <cornogle@googlemail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2015 at 01:16:54PM +0200, Christian Hartmann wrote:
> Hello,
> 
> I have one patch that enables the spi initialization of the WM510205 audio codec
> Without the patch, this message indicates that the codec chip fails
> with the current chipselect number in spi-pxa2xx:
> 
> 
> [ 0.296256] pxa2xx-spi 80860F0E:00: cs1 >= max 1
> [ 0.296270] spi_master spi32766: failed to add SPI device
> WM510205:00 from ACPI
> 
> So raise num_chipselect by one to enable the codec. The WM510202 is on
> chipselect = 1.
> 
> With the patch applied I got in dmesg now:
> 
> [    6.056829] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
> [    6.067035] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
> [    6.067214] spi spi-WM510205:00: 8333333 Hz actual, PIO
> [    6.067221] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
> [    6.067287] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
> 
> Signed-off-by: Christian Hartmann <cornogle@googlemail.com>
> ---

You need to send the patch to the right people, you definitely
need to send the patch to Mark Brown as he is maintainer for the
SPI subsystem so will be the person who applies your patch.

Additionally, you probably want to try to look for if there are
any active people on this particular spi driver and include them.
The script get_maintainer.pl is a good starting point although it
often includes too few people without the git option and too many
with the git option.

Thanks,
Charles
