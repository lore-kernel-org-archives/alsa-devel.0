From: Daniel Mack <daniel@zonque.org>
Subject: Re: Non-I2C/SPI ASoC codec
Date: Thu, 03 Jul 2014 13:28:05 +0200
Message-ID: <53B53E45.9070402@zonque.org>
References: <CAOr_jfL+fMBVi82RaLBAcnygNFhVXPoRoyFMGTp4HOEZecSyMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 008F6265848
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 13:28:07 +0200 (CEST)
In-Reply-To: <CAOr_jfL+fMBVi82RaLBAcnygNFhVXPoRoyFMGTp4HOEZecSyMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthew Bucknall <matthew.bucknall@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2014 01:14 PM, Matthew Bucknall wrote:
> I'm trying to get audio support for a custom ARM board to work and have
> written codec and machine drivers - The platform driver already existed
> (atmel_ssc_dai). The codec I am supporting is extremely simple and has no
> SPI/I2C interface for configuration and just accepts fixed format/fixed
> rate I2S.
> 
> Previously, when I've gotten ASoC support for another board working, the
> codec it used (TLV320AIC32) had an I2C interface. Declaring I2C_BOARD_INFO
> for this in my board file seemed sufficient to get the machine driver to
> probe and initialize. For this new board, I have no SPI/I2C device to
> declare in the board file and its associated machine driver is not probing.
> All I get from the kernel is 'No soundcards found.'
> 
> My driver modules are getting compiled and are linked statically. What do I
> need to do to get the machine driver going?

You need to

a) get the driver compiled into your kernel (statically or as module),

and

b) instantiate the driver, from either DTB or a platform_device struct.

There are plenty of good examples in the mainline kernel for both ways,
but note that board-file driven (non-DTB) boards are considered legacy.

FWIW, A very simple ASoC codec that doesn't have any control bus such as
I2C/SPI is already present in sound/soc/codecs/ak5386.c.


Daniel
