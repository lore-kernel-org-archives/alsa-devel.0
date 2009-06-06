From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio driver for dbAu1250 Development board
Date: Sat, 6 Jun 2009 11:36:30 +0100
Message-ID: <20090606103623.GA10169@sirena.org.uk>
References: <4A2793A6.9090800@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6367C244B8
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 12:36:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A2793A6.9090800@tataelxsi.co.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manjunath A M <manjunatham@tataelxsi.co.in>
Cc: alsa-devel@alsa-project.org, nitinm76@yahoo.com, Manuel Lauss <mano@roarinelk.homelinux.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 02:58:06PM +0530, Manjunath A M wrote:

> sound/soc/au1x/exmmb-ac97.c:24:38: error: asm/mach-exm1200/exm1200.h: No 
> such file or directory
> sound/soc/au1x/exmmb-ac97.c:26:25: error: linux/exm32.h: No such file or 
> directory

Looks like the code relies on some underlying porting work which may
have either changed since the code was written or may not have been
merged into mainline.

> before applying the patch the board was working but the audio was not 
> working..
> can you suggest me which kernel source you used and how you got the 
> audio working for your board.

This code was contributed against a much older kernel, and may well have
relied on other patches.  I've CCed in Manuel Lass, who contributed the
code and should have a better idea what the MIPS status is.

> can you send me the sample kernel image "vmlinux.srec" image for testing..

You'd be better off asking the MIPS community for this.
