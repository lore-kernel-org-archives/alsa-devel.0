From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 13:56:39 +0100
Message-ID: <20080720125639.GB27546@sirena.org.uk>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 71A5B24390
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 14:56:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 19, 2008 at 10:18:55PM -0400, Jon Smirl wrote:

> How do I define a volume control that is the bottom 12 bits of a 32
> bit register?

> #define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
> 	((shift) << 12) | ((max) << 16) | ((invert) << 24))

> This looks like it only support an 8 bit max. Is there another way to do it?

SOC_SINGLE() (or SOC_SINGLE_TLV() if you've got dB scale information for
the volume control, which is likely?) is the way to do it but like you
say it's not able to cope currently.  Since invert is a boolean so there
should actually be enough space to store a 12 bit max so it shouldn't be
such a major job to adjust for this unless I'm missing something, I've
only had a brief look.

Also note that the core currently has assumptions in it that registers
aren't bigger than 16 bits - the main thing is that it uses unsigned
shorts for passing them around.  Someone posted in the past week about
fixing this.

If you don't want to do core changes then either write a custom control
or (if the stuff in the upper bits will allow it) adjust the shift to
ignore the bottom 4 bits of the control.  The ASoC control macros all
boil down to standard ALSA controls types and you can mix in regular ALSA
controls without problems if required - the macros just save having to
implement standard register accesses by hand.
