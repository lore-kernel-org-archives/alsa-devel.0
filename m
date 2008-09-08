From: Liam Girdwood <lrg@kernel.org>
Subject: Re: Asoc and alsa utils regarded
Date: Mon, 08 Sep 2008 10:57:02 +0100
Message-ID: <1220867822.17091.101.camel@odin>
References: <b5c34db00809072150w4928030t34a660bfd158d4eb@mail.gmail.com>
	<1220862418.17091.61.camel@odin>
	<b5c34db00809080232j639f1f62g7b4d779da224542a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E6D02103846
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:57:06 +0200 (CEST)
In-Reply-To: <b5c34db00809080232j639f1f62g7b4d779da224542a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: umeshyv <umeshyv@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 15:02 +0530, umeshyv wrote:
> Hi Sir,
> Thanks for your reply.I downloaded asoc patch for au1x but some files
> are missing like board setup files and exm32.h,exm1200.h.

au1x is in mainline now. There is probably no need for a patch. Please
use an up to date kernel.

> And where did you define the frequency controller details.Can I get
> the complete patch of au1x.I dont have a exact patch recently I used
> another patch there psc-i2s.c is modified a bit little.I am working on
> Au1200 to it tsc2301 is interfaced and Au1200 acts as master and MCLK
> is generated using Au1200 frequency controller,my question is where I
> am supposed define it.

You will need to write a small machine driver to define all your
board/machine specific details. There are quite a few examples under
sound/soc/

> One more query is that for example consider the following code, 
> 
>  SOC_ENUM_SINGLE(CS4251X_VOLTRANSCTL, 4, 4,cs_vol_transition)
> 
>  SOC_DOUBLE_R("Channel 4 Playback Volume", CS4251X_L4VOL, CS4251X_R4VOL, 0, 255, 1).
> 
> 
> It tries to control volume transition and secondly volume
> adjustment .Generally register access to codec is done using SPI or
> I2C .So special functions like cs4251x_write(codec,<reg>,<value>) been
> developed for register access.When using SOC_DOUBLE_R or SOC_SINGLE
> etc how it access special functions to write to those specific codec
> registers  can get explanation.

They ultimately call either i2C_write or spi_write. Please read the
documentation in Documentation/sound/alsa/soc/

> Can you provide me Asoc driver for DbAu1200 board.And following is the
> way i compiled libs and utils and I use buildroot to compile the libs
> and utils
> 
> Libs compilation
> -------------------------------
> $PATH to  buildroot
> $./configure --host=mipsel-linux --prefix=/home/audio
> --enable-shared=no --enable-static=yes
> $make
> $make install
> 
> Utils Compilation
> ---------------------------------
> $export ALSA_CFLAGS=-I/home/audio/include
> $export ALSA_LIBS="-L/home/audio/lib -lasound -lm -ldl -lpthread"
> $./configure --host=mipsel-linux --prefix=/home/audio
> --with-alsa-prefix=/home/audio/lib
> --with-alsa-inc-prefix=/home/audio/include
> $make
> $make install
> 
> All my installed libs and utils goes to /home/audio .Is there anything
> missing in configurtion and after compilation I copy /bin,/sbin,/lib
> to rootfs and then /share to /usr/share.I am going wrong
> anywhere.Waiting for your valuable reply.

This looks like it may be either a buildroot problem or you are missing
some other buildroot alsa packages containing the conf files.

Liam
