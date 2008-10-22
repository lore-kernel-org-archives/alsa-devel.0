From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Audio on omap3+twl4030 codec
Date: Wed, 22 Oct 2008 14:10:36 +0100
Message-ID: <20081022131036.GG7640@sirena.org.uk>
References: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E429224557
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 15:10:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: sakoman@gmail.com, Arun KS <arunks@mistralsolutions.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 06:17:39PM +0530, naveen krishna ch wrote:

> I am working on omap3430 and twl4030 combination for audio.

CCing in several people who've been working on these drivers recently.

> I am wokring on 2.6.26 whre the support was not there for omap3 mcbsp.
> so i ported some stuff from the 2.6.27 latest git tree and now audio is
> working on omap3 evm.
> with the very same kernel when i try with my custom board. I am unable to
> hear audoi.

> I get audio when i boot out of MMC (x-load and u-boot in mmc and fiel system
> is nfs).
> But, when i usse nand(x-load and u-boot in nand and file system is on nfs) i
> dont get audio  out
> meams aplay and arecord seems working but i dont hear any audio.

With the same software in all cases?

> I probe and checked the Bit clock and Word clock of the I2S which seems are
> comming when
>  i try a aplay and arecord..

Is there any data at all on the data pin?  Have you checked that the
clock rates for the two clocks are correct (if not enough bit clocks are
generated per frame clock then the DAC will not get enough data to
produce a full sample as output)?

> I am sure that hardware has no problem.
> Can any one tell me what might be the issue and where i have to start
> debugging the issue.

> If this is not the right palce to put my question can any one tell me the
> correct mailing list.

This should be a good place to ask.
