From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: Audio on omap3+twl4030 codec
Date: Wed, 22 Oct 2008 18:54:12 +0530
Message-ID: <ef0d8a250810220624u7396b496q7b86efa0703e7e15@mail.gmail.com>
References: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
	<20081022131036.GG7640@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id DC17D24568
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 15:24:30 +0200 (CEST)
Received: by gxk10 with SMTP id 10so7170752gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 06:24:12 -0700 (PDT)
In-Reply-To: <20081022131036.GG7640@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, Arun KS <arunks@mistralsolutions.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

I forget to add one more observation
that is i have a older omap2 and twl4030 asoc codec driver and driver/ssi
mcbsp support in a 2.6.24 kernel.

when i try to use this in my coustum board the audio is working fine all the
ways.

On Wed, Oct 22, 2008 at 6:40 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Wed, Oct 22, 2008 at 06:17:39PM +0530, naveen krishna ch wrote:
>
> > I am working on omap3430 and twl4030 combination for audio.
>
> CCing in several people who've been working on these drivers recently.

I am new so i dont have much information of the other who is working on
similar things.

>
>
> > I am wokring on 2.6.26 whre the support was not there for omap3 mcbsp.
> > so i ported some stuff from the 2.6.27 latest git tree and now audio is
> > working on omap3 evm.
> > with the very same kernel when i try with my custom board. I am unable to
> > hear audoi.
>
> > I get audio when i boot out of MMC (x-load and u-boot in mmc and fiel
> system
> > is nfs).
> > But, when i usse nand(x-load and u-boot in nand and file system is on
> nfs) i
> > dont get audio  out
> > meams aplay and arecord seems working but i dont hear any audio.
>
> With the same software in all cases?
>
I used the same x-loader, u-boot and kernel and the hardware too in all the
cases

>
> > I probe and checked the Bit clock and Word clock of the I2S which seems
> are
> > comming when
> >  i try a aplay and arecord..
>
> Is there any data at all on the data pin?  Have you checked that the
> clock rates for the two clocks are correct (if not enough bit clocks are
> generated per frame clock then the DAC will not get enough data to
> produce a full sample as output)?
>
yeah there is data seems coming all the times i have probed the clocks and
data pins.
the data seems comming out of OMAP3 but i have no point here to probe in the
twl4030.
i used a 22050hz wav format file and the i noticed approx18Khz.


I probed with the same x-load and u-boot and 2.6.24 kernel image setup also.

then also the bit clock and word clock are the same as what i am getting
with 2.6.26 kernel image



> > I am sure that hardware has no problem.
> > Can any one tell me what might be the issue and where i have to start
> > debugging the issue.
>
> > If this is not the right palce to put my question can any one tell me the
> > correct mailing list.
>
> This should be a good place to ask.
>

Can anyone refer me towards the ones who worked on this kind of audio codec
driver.


-- 
Thanks,
Neyo
