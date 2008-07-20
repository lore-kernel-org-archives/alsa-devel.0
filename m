From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 11:51:12 -0400
Message-ID: <9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E29124444
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 17:51:13 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so375682ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2008 08:51:12 -0700 (PDT)
In-Reply-To: <20080720125639.GB27546@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Another problem is the crossbar mixer. It is a full 8x4 crossbar with
28 bit gain controls on each path. There are four 32 byte registers,
each register holds 8 32 bit wide gain fields. There are several more
mixers with 28 bit gain controls.

28 bit gain fields are all on all of the bass/loudness/etc control.

On 7/20/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 19, 2008 at 10:18:55PM -0400, Jon Smirl wrote:
>
>  > How do I define a volume control that is the bottom 12 bits of a 32
>  > bit register?
>
>  > #define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
>  >       ((shift) << 12) | ((max) << 16) | ((invert) << 24))
>
>  > This looks like it only support an 8 bit max. Is there another way to do it?
>
>
> SOC_SINGLE() (or SOC_SINGLE_TLV() if you've got dB scale information for
>  the volume control, which is likely?) is the way to do it but like you
>  say it's not able to cope currently.  Since invert is a boolean so there
>  should actually be enough space to store a 12 bit max so it shouldn't be
>  such a major job to adjust for this unless I'm missing something, I've
>  only had a brief look.
>
>  Also note that the core currently has assumptions in it that registers
>  aren't bigger than 16 bits - the main thing is that it uses unsigned
>  shorts for passing them around.  Someone posted in the past week about
>  fixing this.
>
>  If you don't want to do core changes then either write a custom control
>  or (if the stuff in the upper bits will allow it) adjust the shift to
>  ignore the bottom 4 bits of the control.  The ASoC control macros all
>  boil down to standard ALSA controls types and you can mix in regular ALSA
>  controls without problems if required - the macros just save having to
>  implement standard register accesses by hand.
>


-- 
Jon Smirl
jonsmirl@gmail.com
