From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem compiling soc - imx31 and wm8753
Date: Wed, 11 Mar 2009 15:36:06 +0000
Message-ID: <20090311153554.GB15629@sirena.org.uk>
References: <49B7CEFD.1080006@tecnequip.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C878D10387E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 16:51:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49B7CEFD.1080006@tecnequip.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marcelo Utikawa da Fonseca <marcelo.fonseca@tecnequip.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 11:47:25AM -0300, Marcelo Utikawa da Fonseca wrote:

> I am facing a problem while compiling the sound support for imx31ads board.
> I got the kernel from wolfsonmicro using the following command:

> git clone git://opensource.wolfsonmicro.com/linux-2.6-asoc linux-2.6-asoc

> After this I just copy the arch/arm/configs/mx31ads_defconfig to .config 
> and run:

> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- menuconfig

> I did not change nothing, just configure and compile...
> My gcc version is 4.1.2 from Freescale.
> What can be wrong? Could be this version of gcc a problem?
> I already tried to correct the missing include files but the other 
> errors are still there after the corrections...

The i.MX31 support that is present in ASoC git depends on underlying
support for the CPU which is not present in any mainline tree (which is
why this code has not been contributed to mainline yet).

Probably the easiest thing to do is to start from the BSP provided by
Freescale - I believe that most versions of that contain the CPU audio
drivers already, probably including a version of the WM8731 driver.  It
should be much easier to merge that driver (by itself, just wm8731.c and
wm8731.h) into the Freescale BSP than to merge the i.MX31 support into
the standard kernel.
